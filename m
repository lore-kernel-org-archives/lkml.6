Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCD1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D152173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546883539;
	bh=dkrgwVDulzh61UryTYo3vyP2dP7JOF3DFrYmriX/G7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Myl1f9FGdh5UUBJaUjiMyTkiX41MwmFmJh2N405VXLoMa4zhKiKif/nk4mF/+6zlp
	 Dt3TwmTDqIq3ka1d+3Mba2gN+7Bs6JsNLI3m7/G11+k2OjybswbCOpT6vS3vW6tox0
	 Jaz9yUnKnJMhkPn2/UFqrGQI/8+nqYp5MNrFdOmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfAGRwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:52:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42084 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAGRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:52:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so1025439oiw.9;
        Mon, 07 Jan 2019 09:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwN+jM6jCPn4PEoBjO7c0OyfsynFC9kCw7thHiCAkaM=;
        b=Po6QW4HfZKhoFgAmEQYMPbaMmfAUs2t3GxJ3/GKi+fYNOsKFHaX497upBClCzx2oaX
         2ZHutWQdtEsJhhTzWP0X4V6Yngo8PcKzaEEtax55wCzAGfkQIsRw+WyqS0VggAvjIbcp
         4mB7QBJKEfEg5FJTn5L08PYWkd8xQL2DtknwM+f76L5aiQ055SbDDS7M83qkxNrX54lC
         iCPWMlp4M+S+Qpi8F6BrFBbDA6HytR93YJF9U3YVWXBiQlaJoII3TTrrkafpUpkyHjzW
         VJ+rEZQKFzwGlrk2rDmot7j1vjQTo1aztATu6GD4Fo6F/JrS9jTDANQvHLYowNb+Ne3F
         UBAg==
X-Gm-Message-State: AJcUukdzagUEQVfUcTjLaYIV7qn5Ecol0MimeSlZeKzkHwUFpsAm94Ax
        xjiMGGLNUD4lA/mxs7hC4JBC585edn5HNdMIB+Q=
X-Google-Smtp-Source: ALg8bN5I2WbVUh8WanRlf4X0qrzPLOpmPwdnQ5zM25sH48bvi8CjFWCX8UVwn+sYVj5cKxBsdcyYuIUKHbhrJM6o/kE=
X-Received: by 2002:aca:e715:: with SMTP id e21mr25568983oih.76.1546883537365;
 Mon, 07 Jan 2019 09:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-3-okaya@kernel.org>
 <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
 <CGME20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4@eucas1p1.samsung.com>
 <7d6b9323-7760-944d-daa4-6fc663a32481@samsung.com> <aa5ecfd1-fbb5-1f7a-500b-9eaee1cd8e0a@kernel.dk>
In-Reply-To: <aa5ecfd1-fbb5-1f7a-500b-9eaee1cd8e0a@kernel.dk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 18:52:05 +0100
Message-ID: <CAJZ5v0i60n1Fp0dJ5kbHgpKuB+Www3ZCOX2GuLnzzhpGCZ1jMA@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency explicit
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/7/19 7:17 AM, Bartlomiej Zolnierkiewicz wrote:
> >
> > On 01/07/2019 12:12 PM, Rafael J. Wysocki wrote:
> >> On Wed, Jan 2, 2019 at 7:11 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>>
> >>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> >>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> >>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> >>> specified directly. PATA_ACPI is a PCI device driver but the PCI
> >>> dependency has not been explicitly called out.
> >>>
> >>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> >>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >>> ---
> >>>  drivers/ata/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >>> index 4ca7a6b4eaae..8218db17ebdb 100644
> >>> --- a/drivers/ata/Kconfig
> >>> +++ b/drivers/ata/Kconfig
> >>> @@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
> >>>
> >>>  config PATA_ACPI
> >>>         tristate "ACPI firmware driver for PATA"
> >>> -       depends on ATA_ACPI && ATA_BMDMA
> >>> +       depends on ATA_ACPI && ATA_BMDMA && PCI
> >>>         help
> >>>           This option enables an ACPI method driver which drives
> >>>           motherboard PATA controller interfaces through the ACPI
> >>> --
> >>
> >> Any objections against this one from anyone?
> >
> > Patch looks correct to me (pata_acpi is indeed a PCI driver):
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >
> > but it is best to wait for Jens' ACK if you want to merge it
> > through ACPI tree..
>
> You can add my:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>
> if you want to merge it through the ACPI tree.

I will do that, thanks!
