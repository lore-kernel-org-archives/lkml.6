Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB79C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEM26sqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E4F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbeK1CyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:54:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43032 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbeK1CyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:54:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so22250588qtj.10;
        Tue, 27 Nov 2018 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKCyZbrEKYXwHldI0WnOYTOElwRij8LUCoCfbS5+TGc=;
        b=DEM26sqyroVfWml80N+dkKLx4YfqsO+h+BnyC2G3lJ9nStm13JXzcZfLeZG/jm+EXl
         IjyB/5gSKALcVXbD+LqB/p5wWi/KO2ZT0PMsb6lGw+ya3wOmpALTvxi7Dtfmyrkq8GeR
         kCk8ocLX/3WOMDL077YtYj8o8PiflGwofUkkC6wa3UmuzEtQa9qVO/jPQ9DbME7sLTGO
         MLf4HxE3gZINqPRmqz4f+Cx3aznlpFT16qgv+ogAZOo1ejncFPR4kvNrWY85uV/svgMK
         Znz87w/kgLOW8y+i3clkxEKmGFV9R9yihm5kf11OOjcUh8KKDwubUUGrm7FfMPJYGue+
         yYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKCyZbrEKYXwHldI0WnOYTOElwRij8LUCoCfbS5+TGc=;
        b=hIzWSLID1Gk4JSrhCf5cHN56LxeSXROrzEIu6pkp5MtYq+NdUcVuXazfNStayq4oKS
         Aq5bgqEPum8KwOGqeTawRn3sOV+YbV5JGdlbXBaFbZq0dzeqabBxFXyEm1UOwroMe5XD
         ecbzvxGT2zYNNHOocHKcdDcJXzFVPMwXwTtOJcz/mlIlLltIGerEnyGOizCeOPjyNkuD
         3w8U5AxYLBIr0vE5YXggyoavHbQFhRgDw/mODbG6Cxa/gU9SNQ2lWpKxD75b6u3FKHoi
         CIx+Jx2ZFlbJEiLkS00hoa1s2HuGzZICxbXD+FU6Eju668SXwT3LtWaI0g3I+aEh9eBU
         N6eg==
X-Gm-Message-State: AGRZ1gIxjrLdykNIXer7ENR9pUoQAnNsxSsOq2uJ4IQdROJTUeRBZ5/i
        FlwgEyos/c0U9KaSCzFPU12dt/TtznQODTG5RmCuoNlZ
X-Google-Smtp-Source: AFSGD/UaNzovc//Ja5PX9pWfQz+ugBvSVL1wudscN0agRRZS1+B1kioPoEZVZXyjFomTa4hrZgocQBWg1TSLNbreM6s=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr30346595qtj.327.1543334160430;
 Tue, 27 Nov 2018 07:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20181114212843.16954-1-bp@alien8.de> <20181114212843.16954-4-bp@alien8.de>
In-Reply-To: <20181114212843.16954-4-bp@alien8.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Nov 2018 17:55:49 +0200
Message-ID: <CAHp75Vca7Vn5To5GWb_EtZ1ZKyzWnL2Wv3M3wrKVX=X8qmxUfw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/cpuid: Make cpuinfo_x86.x86_model_id global
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:29 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... and __ro_after_init. Since the brand string is being read earlier
> now, in early_identify_cpu(), get_model_name() needs to read out the
> extended CPUID level for the brand string. This is temporary only, until
> the full CPUID read out has been added.

>  drivers/platform/x86/intel_ips.c     |  6 +++---
>  15 files changed, 35 insertions(+), 35 deletions(-)



> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a1b09e..4309f198cbad 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1367,11 +1367,11 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
>         else
>                 ips->turbo_toggle_allowed = false;
>
> -       if (strstr(boot_cpu_data.x86_model_id, "CPU       M"))
> +       if (strstr(x86_model_id, "CPU       M"))
>                 limits = &ips_sv_limits;
> -       else if (strstr(boot_cpu_data.x86_model_id, "CPU       L"))
> +       else if (strstr(x86_model_id, "CPU       L"))
>                 limits = &ips_lv_limits;
> -       else if (strstr(boot_cpu_data.x86_model_id, "CPU       U"))
> +       else if (strstr(x86_model_id, "CPU       U"))
>                 limits = &ips_ulv_limits;
>         else {
>                 dev_info(ips->dev, "No CPUID match found.\n");

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for PDx86 bits

--
With Best Regards,
Andy Shevchenko
