Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEB32081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEB32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeKJANf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:13:35 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:48419 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728002AbeKJANe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:13:34 -0500
Received: from [IPv6:2001:420:44c1:2579:64ae:ee5d:da4d:25e4] ([IPv6:2001:420:44c1:2579:64ae:ee5d:da4d:25e4])
        by smtp-cloud7.xs4all.net with ESMTPA
        id L7ptgYqcHw2L8L7pwgoVzD; Fri, 09 Nov 2018 15:32:42 +0100
Subject: Re: [PATCH] media: staging: tegra-vde: print long unsigned using %lu
 format specifier
To:     Colin King <colin.king@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108110224.1916-1-colin.king@canonical.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0b3bf728-7b7e-7250-40eb-0827f8fe955b@xs4all.nl>
Date:   Fri, 9 Nov 2018 15:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181108110224.1916-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMZVQ1c8TK9Fcynb42CungNxxjPKMfn8bMmy6krd4RJ6g5Uw8ZHopvWv8ATrFfU9RjBWR1SP43gKlfzk4RpphWnl2+Ekmq4SJd2hAzqH3nomAUhrfttW
 Y2L87Nz28uZO9cfEtz4YaH5yV6BAVblsSYKKVJcKPS0c1+IOI+yO96D1cMQM63nIQcyWx1UgNLLWy7F1p3KWhZjngYkpYO7Q7Fzq7iE9nwiZmhF4NQ9Mz0lj
 Lkzt0DPeKD0A35ECshj9ghj/4MGbZbZxLmrn9fqIDge/oEsxOeAHYcuWKailrPqXtT+858451mmZU0DG9J5T35xMRPOOAFOmC+VUg/KCNoXbZ8TeS4joJ1Ag
 8opFHoaZvRLj8HuHWffBnRxMhujCSOK3XDMqkn0v63DGSxRm1JXavrByPx27n+Du4OPjGATQYrWB4tf4t+3xe0OR1VSklhB58Yjdvg69sYC/DeW0dtzDrCzf
 AUzxlQtK9UirzRmSI/mrhlmdMfVlql+AnzI9uaO55NHjak7pYw9EroaB14nNtCPLfFfu+QVndBOWo6aoaicx2XFCl2VY3ZdjVys/BrdSzvk+Daalh/LEVAQW
 jSfutVK/wVx/HXbBSMxoEnH2IDxJBQOaH0ZQ9vIeBZS6/QcJNjg3Uijg4F3oNbwIWig=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/18 12:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The frame.flags & FLAG_B_FRAME is promoted to a long unsigned because
> of the use of the BIT() macro when defining FLAG_B_FRAME and causing a
> build warning. Fix this by using the %lu format specifer.
> 
> Cleans up warning:
> drivers/staging/media/tegra-vde/tegra-vde.c:267:5: warning: format
> specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/tegra-vde/tegra-vde.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
> index 6f06061a40d9..66cf14212c14 100644
> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
> @@ -262,7 +262,7 @@ static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
>  			value |= frame->frame_num;
>  
>  			dev_dbg(vde->miscdev.parent,
> -				"\tFrame %d: frame_num = %d B_frame = %d\n",
> +				"\tFrame %d: frame_num = %d B_frame = %lu\n",
>  				i + 1, frame->frame_num,
>  				(frame->flags & FLAG_B_FRAME));
>  		} else {
> 

Compiling for i686 gives:

In file included from /home/hans/work/build/media-git/include/linux/printk.h:336,
                 from /home/hans/work/build/media-git/include/linux/kernel.h:14,
                 from /home/hans/work/build/media-git/include/linux/clk.h:16,
                 from /home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:12:
/home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c: In function 'tegra_vde_setup_iram_tables':
/home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:265:5: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'u32' {aka 'unsigned int'} [-Wformat=]
     "\tFrame %d: frame_num = %d B_frame = %lu\n",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/hans/work/build/media-git/include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                       ^~~
/home/hans/work/build/media-git/include/linux/device.h:1463:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
/home/hans/work/build/media-git/drivers/staging/media/tegra-vde/tegra-vde.c:264:4: note: in expansion of macro 'dev_dbg'
    dev_dbg(vde->miscdev.parent,
    ^~~~~~~

Should it be %zu?

Regards,

	Hans
