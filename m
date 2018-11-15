Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B64C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126D02146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126D02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbeKOUsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:48:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35966 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOUsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:48:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AC01720746; Thu, 15 Nov 2018 11:41:27 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74B532039F;
        Thu, 15 Nov 2018 11:41:17 +0100 (CET)
Date:   Thu, 15 Nov 2018 11:41:16 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] i3c: master: Remove set but not used variable
 'old_i3c_scl_lim'
Message-ID: <20181115114116.3059e317@bbrezillon>
In-Reply-To: <1542175847-49517-1-git-send-email-yuehaibing@huawei.com>
References: <1542175847-49517-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 06:10:47 +0000
YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/i3c/master/i3c-master-cdns.c: In function 'cdns_i3c_master_do_daa':
> drivers/i3c/master/i3c-master-cdns.c:1137:16: warning:
>  variable 'old_i3c_scl_lim' set but not used [-Wunused-but-set-variable]
> 
> It never used since introdution in commit
>   acfab7d324b2 ("i3c: master: Add driver for Cadence IP")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.

Thanks,

Boris

> ---
>  drivers/i3c/master/i3c-master-cdns.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index ad40162..e828921 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -1133,7 +1133,6 @@ static void cdns_i3c_master_upd_i3c_scl_lim(struct cdns_i3c_master *master)
>  static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
>  {
>  	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
> -	unsigned long old_i3c_scl_lim;
>  	u32 olddevs, newdevs;
>  	int ret, slot;
>  	u8 addrs[MAX_DEVS] = { };
> @@ -1165,9 +1164,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
>  	newdevs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
>  	newdevs &= ~olddevs;
>  
> -	/* Save the old limitation before add devices. */
> -	old_i3c_scl_lim = master->i3c_scl_lim;
> -
>  	/*
>  	 * Clear all retaining registers filled during DAA. We already
>  	 * have the addressed assigned to them in the addrs array.
> 
> 
> 

