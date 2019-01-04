Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3723AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626721871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWC+u4cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfADOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:20:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36942 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:20:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so17515055plr.4;
        Fri, 04 Jan 2019 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IacLwmm/oMlG6zdGuy3u8YtKSQ7Iw+aSYb+u3XbNzVo=;
        b=RWC+u4czUdQFGENOpNdwjhXB6a4rxiRXrFP3f60K1fse4+bLx5mnQ5NTSXLsj2ZVnf
         gekzRlNa+1fFCwPODcaVZBwPcWKAgmiX+KLr5cxglaWVnMvcdM1iwXMhmXm90eZhPvxD
         7Yy8fOk+TbQVO8kMYhQcBqKdAH31B6PSemq5pE2D8kUGK52bGjCZT9HOS5Ec9so6nKDv
         OFKay6PDzfp/vPf/kqPgHyiquhOeavT62OMPLOIa2aSBIXLsVQ1ikQ3e7p+vDY2GBkqa
         n6KmyoWkY/TWwi2U5wspEqReX8nIsGGaXRpfQ6OCzmJoG9asN1OmuzXuNMt/N9YjoTNq
         Ir1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IacLwmm/oMlG6zdGuy3u8YtKSQ7Iw+aSYb+u3XbNzVo=;
        b=pe9WLllSwfX75dARAZUzJoqQUoIpyUG8W+NHTupItUvhXO9i/4P2KYriiNhOoTKdSp
         sr5wvOLDuxr1B8AZIiFE9Z4xKv6UD2OpJZlymCUUvTQm0+VgOtUCCJNk0RWrP7Bd6ww5
         SN2OO3OMgw5ac6wCL/uQ30kyigjSlb4V8kilYyEE43YtKYUntXPjpP1RZJ5o+pnWmP7w
         Aaj8W7ry18zQeAOMo1Imtq0PTUBOGKzzTAbGv+C2FSmHjdhBxDR1MULJocywa22Im09v
         bM47fairEOWNygyKmJfDGgTcWmyFIHctz+DR79PocmBBrpcTRxY8FnntTZgmERRkdLzD
         5Beg==
X-Gm-Message-State: AJcUukep6OhbHxGz9A8H6Nht8L1u0mGCo4wCxucVUWkj/pofB5ptubne
        0MDY71RWyI4rS0Km2XiCbRuOdTLeerKBpOhA79D3abDQ
X-Google-Smtp-Source: ALg8bN44vDZl4fv9tiEo8/sUpEWSBobN2+n0Zij9mEMHztNeRt+0+0XjHrCzj+7RIMDfHcJ3ztbSjst59Q0bS//zK5k=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr51974557pld.87.1546611611913;
 Fri, 04 Jan 2019 06:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-6-okaya@kernel.org>
In-Reply-To: <20190102181038.4418-6-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Jan 2019 16:20:00 +0200
Message-ID: <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kupuswamy@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Code relies on PCI for execution. Specify this
> in the Kconfig.
>

Unfortunately, this is not how it should be fixed.

First of all, we (Heikki, Sathya, me =E2=80=94  all in Cc list) that this
driver should be refactored and unified with intel_scu_ipc.
Then, it has two drivers inside and PCI is just a glue for it which is
optional. Thus, needs to be split accordingly.

> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PC=
I set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b36ea14b41ad..7afb96cb1cd6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
>
>  config INTEL_PMC_IPC
>         tristate "Intel PMC IPC Driver"
> -       depends on ACPI
> +       depends on ACPI && PCI
>         ---help---
>         This driver provides support for PMC control on some Intel platfo=
rms.
>         The PMC is an ARC processor which defines IPC commands for commun=
ication
> --
> 2.19.0
>


--=20
With Best Regards,
Andy Shevchenko
