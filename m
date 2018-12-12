Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D1620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544606804;
	bh=m/0uvsrQFaOa+xxkHx5aGLqidCs5ibxIHWbVYCshamY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ucfaHKyPiN6pe/rQjJO+k+rz3jB/D9/UuPTm21grhDuPdwp95fM6+ZPhHI8eE7BPA
	 W5iSqMod/ZUQX1VKGsyK3qQesbTUCk8yNInzcXcLlKO4sGWwPIJNGVeAVOLWG3Q/9/
	 oocNeBuDBCVb693wzivkqb0/t64ZxpvoLMxvXZdk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D1620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeLLJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:26:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36356 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeLLJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:26:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so16991056otk.3;
        Wed, 12 Dec 2018 01:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEyNPwStV0LW9aLA+/9ZQzRS9ejoSlGTNLErw2YCl28=;
        b=qOTlo9H65dzE+sO0CX/CrwOWDZRPfM18q2LsVsq+HiM3JDh0S6+nbQ5i6eV0RG3YIi
         NkGwAiqU2oE9fPBJTzSJahV7R4dyXVjF8cvFssT+r9Rb+IBdCjHg9FvbIGe/W7Vo15oS
         JI4XR30g8mHDDD2QGGgsgwUBQaRhYYKYw2aHwpWk07LfNyRVUMEUgbMr3GRgpmpKg12d
         ZbHLi1pceEWrdRkxO/a1w/V5SCL2xWmnqi8Q7az+U7WHUJKCRP3BnTv04bu6qr4zdFv2
         7SCVfvJYbnNut3CmqDqlE972hLvrtXByHpm19KtLUT2F1rFMHfM0+X+sgQw1wqSC7QbO
         HWDQ==
X-Gm-Message-State: AA+aEWZWjCxirH1N7/vK4TWlKnwdNwquzlmYNLbW6minpTdowvSplwbO
        WdrmSd4LjY1l5BjhSw/03jdqHW4d+iCYRj1HdYg=
X-Google-Smtp-Source: AFSGD/XFjgR346YD8z9af+5mSCL5nLsCa+8+xiQQ9UkL/QJHr32ODA8ZdiM27VXjZh0X9kUOrUJQwDyZegNziVRntBw=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr14579064otl.343.1544606764909;
 Wed, 12 Dec 2018 01:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20181212052846.32370-1-okaya@kernel.org> <20181212052846.32370-6-okaya@kernel.org>
In-Reply-To: <20181212052846.32370-6-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Dec 2018 10:25:53 +0100
Message-ID: <CAJZ5v0gOH--BDa-ShCSJbeOicLe+QWOnUj=Rz4Tcv-aaGuyRAQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] ACPI / OSL: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
To:     okaya@kernel.org
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 6:29 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Now that we allow CONFIG_PCI to be unset, remove useless code from ACPICA
> too.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/acpica/Makefile | 2 +-
>  drivers/acpi/osl.c           | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index b14621da5413..59700433a96e 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -77,13 +77,13 @@ acpi-y +=           \
>         hwacpi.o        \
>         hwesleep.o      \
>         hwgpe.o         \
> -       hwpci.o         \
>         hwregs.o        \
>         hwsleep.o       \
>         hwvalid.o       \
>         hwxface.o       \
>         hwxfsleep.o
>
> +acpi-$(CONFIG_PCI) += hwpci.o
>  acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
>
>  acpi-y +=              \
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7b1e58f93f37..8b8eb17df3f2 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1837,3 +1837,12 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
>                                                reg_a_value, reg_b_value);
>         return status;
>  }
> +
> +#ifndef CONFIG_PCI
> +acpi_status acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
> +                     acpi_handle root_pci_device, acpi_handle pci_region)
> +{
> +       return AE_SUPPORT;
> +}
> +#endif
> +
> --

I would prefer the header to be modified instead.  Yes, it is an
ACPICA header, but then the change would complement the Makefile one
in a rather straightforward way.
