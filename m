Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3428667-1520192792-2-14434788724619215995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520192791; b=UoV5lS1L20trV0+idcs7dGz04dL8P1pSX4jRtpbLaRmbaPp
    FTCx0a9pFo9lw8rWsFIDwyKeoSuoQxlUp4HIcqfXm9/ZFiwTepUtB5TIobQy9ieU
    tBf9MmlUCcRpQ4dvKOSOYUezORdkJUlp/tr925gyEzM24EVGLNlycygGZvgmgVdF
    19G7bfUnp7bWVMaPbdtwUnMjIy3c5BGLSmGSZuvQ/WxdrSiSgv7NdQ7sE0na6HqZ
    0xLIq2Z/Ykzx2ITSQH4a+TtRTQdV7C19m5UAms1kZHYopgMUq12su6R8ERMJLH0j
    0ts11XFShDBzvE4N0TvZtPLItMwkW5kYD2vG6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520192791; bh=HOwCiTzRPl/eyq/xemkhP+ZAdLRjTVW51xroZ+59kIA=; b=U
    dTpcxCDmk3ufKwZGgf5FWSzsQbyYUy5Q9R9xJn9kiom45n9mIbb0Wa04vWYP/wXn
    H4GfJlDPVsblP2VlL1BwpINlOVB1blFUm9Ba5e3dpIoAtG0nw3iz5TdF2uh1LOgv
    LVD05fy+f3UzEPaX0XogkWSiKiBUEBxrOEPhHZvgn0ozv/hdntTSGipngQmxOsjs
    0jGsUQRTsjf0Zyu7Y+D8t34WjpGOHcrOmups1kVoZByKHUMoayW2pmh3/wY1SaNt
    hjMx4Gz+Mu1Q2EG9ElIQScBgesQE1Wf10AjfoV/8FrzDMgyA+nRYpEGF6B080/43
    lG1reyytu9NBbf47Krkng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCDTq3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 14:46:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42101 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752134AbeCDTq1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 4 Mar 2018 14:46:27 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        mail.free-electrons.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Sun, 4 Mar 2018 20:46:25 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, dedekind1@gmail.com, tharvey@gateworks.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180304204625.5f7da30f@bbrezillon>
In-Reply-To: <20180303104554.5958-1-richard@nod.at>
References: <20180303104554.5958-1-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat,  3 Mar 2018 11:45:54 +0100
Richard Weinberger <richard@nod.at> wrote:

> While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> most likely lose all your data upon a power-cut or due to read/write
> disturb.
> In order to protect users from bad surprises, refuse to attach to MLC
> NAND.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/ubi/build.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index e941395de3ae..753494e042d5 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -854,6 +854,17 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
> +	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
> +	 * will die soon and you will lose all your data.
> +	 */
> +	if (mtd->type == MTD_MLCNANDFLASH) {
> +		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
> +			mtd->index);
> +		return -EINVAL;
> +	}
> +
>  	if (ubi_num == UBI_DEV_NUM_AUTO) {
>  		/* Search for an empty slot in the @ubi_devices array */
>  		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
