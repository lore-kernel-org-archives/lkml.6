Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47675C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1870E20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546859586;
	bh=uQxMDAooXzG9KZPaqi5zt4h97FchXMsGXES7MXEhSRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=flLMDrAmJ2TA3W38bAcvjmkgwj+8djp2HdQmEUN8Mwa1dddN3CUJWCWP+wlgdQmo3
	 RorMBMUTghxd8CKGizveXQojDRtn6QArwsCJqincsovWuv+xLDDqYN0enfyGTpXmdn
	 LDZdEJUzr8scYE1lHbi0PZ0QCDt6Wk8qH2ENi++A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfAGLNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:13:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35752 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfAGLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:13:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so6541oif.2;
        Mon, 07 Jan 2019 03:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6GuYsR4sU18AV8qQJnH4l91ZvkDgeod8DveufEessA=;
        b=ggdpPzuzeEfhw7lsBQ32Wufkq8EY7OEqneMbGuHj/yHYJg7X8kUC5+81vZH84+xJKR
         G9Ebb+w1RwbB820vgL5DS7P5cTryOazseMC7ilUhq6vISZc/v3uWmm72aveKOiYxo/6C
         0B+FW7mhvaK7KDusLADYyXVbtuE8nl4nvuM9GU9LNS0Vc7RVGDtQtCJ6tUbEVQ7UG3Jm
         faVCXG8vfs4eJ/4d7hTERpKYQqPAHvtdWsfgzbM9P9C0hnaUfzLfg674Ek+yewttzFyO
         8eOzsLNQakBb1T56P+N6iISdQMAsUqjX9HZ2q0d9kUJsKv5raEFv9Fqcsv4iJQIDMz5A
         REQQ==
X-Gm-Message-State: AJcUukcy27Bys5oNdGV41ZKtbHCwbYsEvs+alsGiLxddCpK0H/4lUcjG
        X0Dr6BaC8/zq4G0UxRGNKGtCGe6VAYRgtzV5QE8p+w==
X-Google-Smtp-Source: ALg8bN4J2c8WgThpD9zLJfd6Ru3p6Fi6O6mCqoLXt9PMdhUdoYMFxVmyfc8Lb0XoCsYbNBa6FBO3ySa7sdzb2gPj180=
X-Received: by 2002:aca:368a:: with SMTP id d132mr8153521oia.193.1546859582994;
 Mon, 07 Jan 2019 03:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-3-okaya@kernel.org>
In-Reply-To: <20190102181038.4418-3-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 12:12:51 +0100
Message-ID: <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:11 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. PATA_ACPI is a PCI device driver but the PCI
> dependency has not been explicitly called out.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 4ca7a6b4eaae..8218db17ebdb 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
>
>  config PATA_ACPI
>         tristate "ACPI firmware driver for PATA"
> -       depends on ATA_ACPI && ATA_BMDMA
> +       depends on ATA_ACPI && ATA_BMDMA && PCI
>         help
>           This option enables an ACPI method driver which drives
>           motherboard PATA controller interfaces through the ACPI
> --

Any objections against this one from anyone?
