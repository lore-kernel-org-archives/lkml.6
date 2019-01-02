Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E8FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B173221871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Kn92jKvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfABH2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:28:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfABH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:28:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so29661085wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 23:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qICQsh5VAPg4kdhIYzET95RLLKviXzDGEovN9xKw6w0=;
        b=Kn92jKvusuObw1G7EiahcRNRomQNQ7japOIdEU0HpkGVQQm8vun0lfLVUfFIvGr0d7
         gcykFvJCgC2wJ/B1GEciDEtor7kSNSrLeynucFHjhY3C+CzjaRGsXW8yTKc19DjDe8gR
         XaXlZsE2B8tCGKMH5oyYRW7dlDcyV0dE9zGOLQlHST3Sfe0O28mM50zv3UvR3LprNa/9
         9B3G3ieGY+DFlLNt3sETsgI5/jNYMxNPeEZftciFdASpU524RLUJ70BqbWBZiA6rsF0O
         wyEP42RGOjVMEOtvB60eSoUs7BgJru5AdEmoDla3NP44SuiBYxDI5qLvaVsvNjndXiHZ
         xq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qICQsh5VAPg4kdhIYzET95RLLKviXzDGEovN9xKw6w0=;
        b=G5rmeWWjyl7EHv6vnmOJ1KLDqtrZEFf2JzEmxGvn6DWUwY9/H+rmT9j+NOhUmn9lRO
         dnqsgN2ijnCq7v1TLb9zkWL1kDAJA7hfk2TAFUX223XleQ2xeXe0xjsIc2MCEPleoYAc
         VfhfBTInt/lPTv21XoOlM1sOtM9aFqMdiL7KMGM9UuZSDr8ZKgzpDtIfpAS6tSltG3em
         kYz6oTYQYucWiDaxVCu/iyd/dATCRj5OjXiogp9U9PVu3MPkTKIVkv5Oq0MZDiE8xdZR
         NcRvxsagFySJbdVWLGzD6KaXdADp+h6YixAUfT/woSz01yKBhNasV3M8MJj551Wpcd7i
         MZDw==
X-Gm-Message-State: AJcUukeYttScRs484WxL21gVAunkfdpP8TKp4nrfRD8wU9XEFKG2BBSB
        VqhDXu3GIipSZpVS4fpwXIhafEqmajfZBsjqTo/HL1X7nmA=
X-Google-Smtp-Source: ALg8bN5i2vXSGExdeehq2fBW+2k88OMAd6EuCVmo7HsxEwRQVkDxOjJDyBTR6hXOYD8uoYI65BR7IW1cS++vwHwypaM=
X-Received: by 2002:a5d:454f:: with SMTP id p15mr39645845wrr.39.1546414082393;
 Tue, 01 Jan 2019 23:28:02 -0800 (PST)
MIME-Version: 1.0
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr> <1546185195-25676-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546185195-25676-7-git-send-email-Julia.Lawall@lip6.fr>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 2 Jan 2019 08:27:50 +0100
Message-ID: <CAMGffEkWoK_tgndeEa-TYFy+wbFyKW4B_rBcqC=HTB+FcV=Sjw@mail.gmail.com>
Subject: Re: [PATCH 6/8] scsi: pm80xx: reduce indentation
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>,
        kernel-janitors@vger.kernel.org, lindar_liu <lindar_liu@usish.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 5:29 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Delete tab aligning a statement with the right hand side of a
> preceding assignment rather than the left hand side.
>
> Found with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Thanks, Julia.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index b3be49d41375..44b630aceb12 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -657,7 +657,7 @@ static int pm8001_dev_found_notify(struct domain_device *dev)
>                 if (dev->dev_type == SAS_SATA_DEV) {
>                         pm8001_device->attached_phy =
>                                 dev->rphy->identify.phy_identifier;
> -                               flag = 1; /* directly sata*/
> +                       flag = 1; /* directly sata*/
>                 }
>         } /*register this device to HBA*/
>         PM8001_DISC_DBG(pm8001_ha, pm8001_printk("Found device\n"));
>


-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet
