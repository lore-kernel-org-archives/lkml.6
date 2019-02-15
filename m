Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7349021924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405469AbfBOKAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:00:32 -0500
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:54072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbfBOKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:00:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1B64C182CED2A;
        Fri, 15 Feb 2019 10:00:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light30_78a067c49ec5e
X-Filterd-Recvd-Size: 2159
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Feb 2019 10:00:28 +0000 (UTC)
Message-ID: <6b0d55253ce61f1b7a068689ae9db597aaf5d30a.camel@perches.com>
Subject: Re: [PATCH] video: fbdev: vesafb: fix indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 02:00:27 -0800
In-Reply-To: <20190212132905.7307-1-colin.king@canonical.com>
References: <20190212132905.7307-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 13:29 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of statements that are indented too deeply, fix
> this by removing tabs. Also add a space after a comma to clean up
> a cppcheck warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/vesafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index 528fe917dd49..b7388e25aa2a 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -336,8 +336,8 @@ static int vesafb_probe(struct platform_device *dev)
>  		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
>  		if (pmi_base[3]) {
>  			printk(KERN_INFO "vesafb: pmi: ports = ");
> -				for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
> -					printk("%x ",pmi_base[i]);
> +			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
> +				printk("%x ", pmi_base[i]);
>  			printk("\n");
>  			if (pmi_base[i] != 0xffff) {
>  				/*

Perhaps you could also use pr_cont too because otherwise this
emits each printk on separate lines.




