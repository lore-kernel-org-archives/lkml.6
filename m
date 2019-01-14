Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26031C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F413C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfANVkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:40:42 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.179]:11439 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfANVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:40:42 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EC8599C02
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:40:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9yLgEnGRYTGMj9yLgyzho; Mon, 14 Jan 2019 15:40:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=51442 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9yL-000tss-1i; Mon, 14 Jan 2019 15:40:41 -0600
Subject: Re: [PATCH] nvram: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190114204415.22296-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <59962ef4-d349-e5ac-3dab-e1c70409f8ff@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:40:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114204415.22296-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gj9yL-000tss-1i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:51442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:44 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>    drivers/char/generic_nvram.c:83:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/char/generic_nvram.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> index ff5394f47587..53123c110f7b 100644
> --- a/drivers/char/generic_nvram.c
> +++ b/drivers/char/generic_nvram.c
> @@ -81,6 +81,7 @@ static int nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   #ifdef CONFIG_PPC_PMAC
>   	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
>   		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");

Here you could use the pr_warn() macro instead of the obsolete printk KERN_WARNING, but that'd
be another patch.

Anyway:

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks
--
Gustavo

> +		/* fall through */
>   	case IOC_NVRAM_GET_OFFSET: {
>   		int part, offset;
>   
> 
