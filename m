Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2307BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186A218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIVBClvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfADOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:12:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46975 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfADOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:12:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so17546242pgp.13;
        Fri, 04 Jan 2019 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uROm6CRFmDlv5kWzxbXn98SqJtss6LueCCdQVx79wcQ=;
        b=oIVBClvpsb6uGaZJzBM/ORJ7Flgr3ukjWGpThcQJLDYC3uVDDKzt19vDxr0eUlOLym
         JpOcBjgngvf5ZgCPOBSiFJaqXX3i1/ALoMHRcpkkHjwBPCKLSyQyu63qHp8tAntnd548
         6L26Dc0YgJIYHFJ+GIJi8nIlf5+PAtQeVtdlYS/oY1hMM7WxMRpH2yoSvL4XVuXW4778
         qm2AtPZmQ6xtSrPQmh6jwOa4F4nitK/jBfZVrVOmT0CoELeqIKDLkvB0lKhr+wON1vS+
         9nwiPHcTHkgyN51ywSEV3X/fd2HkR+n2VW59xJm6s3ubh5omh0QBx3s/OjSPMm6CmIHI
         +ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uROm6CRFmDlv5kWzxbXn98SqJtss6LueCCdQVx79wcQ=;
        b=R+Mh+4FuFgYzle1T6N7B9ny8Qb66Qu9GhJHpAMFhjzVKWiVayntFJHuj62Z6VflUVM
         jzXWNS0KoWgo5chnIZ33WtltGrkl/Aj2+RDZFvsi8W5iQ2TU81T+PAaCJxUZw5y1KgLM
         snPD08MMBsHC8VH1EE8HT8S/R0yyscLYNMyS6MCuCjhftMGeNWpNjFA3fAR/gI36WyVY
         6Ec3CldIgukgTT3/kgn7PEruYmE4qUyPWTSo9n/cXtj0tmOUjUWTkU5jYpYyQ6rrmQoH
         duBAbbnCJil/N6JtEeX/r+1ZIhHNzdfU/IovpElff8BO7ayriTu81PUKqbcNrlVU/dr3
         4CVA==
X-Gm-Message-State: AA+aEWa9n0gccTCpnYMsooSktdC83/64v55Q77K+6loId7onR45Q8qcq
        oBpRtJ8FPYmUD8s0EZ+sOQ/7n1YYF3ro0GY1ZGQ=
X-Google-Smtp-Source: ALg8bN4TZVN/teIHlLxwvMSi9COVRtJXfMF54+LVSUCl2YO+vocQBFBbY479uCq2exl3k6KQZbwxWhG37EZHzgmZflY=
X-Received: by 2002:a62:c711:: with SMTP id w17mr52975197pfg.50.1546611152873;
 Fri, 04 Jan 2019 06:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-7-okaya@kernel.org>
In-Reply-To: <20190102181038.4418-7-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Jan 2019 16:12:20 +0200
Message-ID: <CAHp75Ve0Ex245yt1efqSUS7tUuh6RnUdTowLebvJr-CtKkQSZA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This driver depends on the PCI infrastructure but
> the dependency has not been explicitly called out.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7afb96cb1cd6..89f4b86244a7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
>  config APPLE_GMUX
>         tristate "Apple Gmux Driver"

>         depends on ACPI
> +       depends on PCI

Can you stick with the same pattern you have used for the rest in this series?
I.e.
         depends on ACPI && PCI


>         depends on PNP
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
