Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B951420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B951420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeK1TH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:07:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40181 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeK1TH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:07:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7160E207B0; Wed, 28 Nov 2018 09:06:41 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31F9B20726;
        Wed, 28 Nov 2018 09:06:31 +0100 (CET)
Date:   Wed, 28 Nov 2018 09:06:30 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubi: do not drop UBI device reference before using
Message-ID: <20181128090631.1a99f995@bbrezillon>
In-Reply-To: <1543375203-97876-1-git-send-email-bianpan2016@163.com>
References: <1543375203-97876-1-git-send-email-bianpan2016@163.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 11:20:03 +0800
Pan Bian <bianpan2016@163.com> wrote:

> The UBI device reference is dropped but then the device is used as a
> parameter of ubi_err. The bug is introduced in changing ubi_err's 
> behavior. The old ubi_err does not require a UBI device as its first 
> parameter, but the new one does.
> 
> Fixes: 32608703310 ("UBI: Extend UBI layer debug/messaging capabilities")
> 

Unnecessary blank line here.

> Signed-off-by: Pan Bian <bianpan2016@163.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/ubi/kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> index e9e9ecb..0b8f0c4 100644
> --- a/drivers/mtd/ubi/kapi.c
> +++ b/drivers/mtd/ubi/kapi.c
> @@ -227,9 +227,9 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
>  out_free:
>  	kfree(desc);
>  out_put_ubi:
> -	ubi_put_device(ubi);
>  	ubi_err(ubi, "cannot open device %d, volume %d, error %d",
>  		ubi_num, vol_id, err);
> +	ubi_put_device(ubi);
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(ubi_open_volume);

