Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D930C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733420672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DPUjT9ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2733420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeLKGDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:03:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35050 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeLKGDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:03:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so12963330otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAFD67T1bQTHyMT2fYa4K5uz3QdtHC7VrPCD/cp84b4=;
        b=DPUjT9llzzo/SU7Hjl+tJqcJQDgjeLEonBvmhByw4RO2qzLHA6dl+cPKomDce+wYMM
         jvNfvT01n7fZyhlx6wSIIIHNc1xmlcCh8ta3aAqIB1gCkygSJpCbQ3urU7Lz46pRAV4s
         ydPOtP5pQhluXVHVfilt3R/GN5xNVY2rorS3+BYlg6rSxtCZbagLhyz3/tTC041tglC3
         JkL0QWQsaLMF4qrb0CsR7td8k5MJGyDBxylPEjJMucI/gmGrUc5kw5b4PuxEVfpy7phT
         r2CkJuOD41FWPZQRX7hFBlQ3CskA3faQvVE/bxAW9C7085pfs0pHGD4Wv7xWDrBOLqyG
         dj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAFD67T1bQTHyMT2fYa4K5uz3QdtHC7VrPCD/cp84b4=;
        b=qPSEPWr9hTB2P1PiShWS/TKyaqClKq7dMn3rppM5o+V343MC06GkQMP4VizqIwlmwO
         Qtva+cA59VxE4cXeemnYPttEmVwXXJvbpdndMzAJSiO40sgmLFxGvguIHuuJImtUL6f6
         kxfygv+43+lJIH+tAgesL46AN8auFA3fnH/L7CBd5VMKgFeS6u1tr4WmUaHmXwisnMWp
         zHvrGrY5snduUIg61zBPAFz5qy9+m9Y0xYrai/EL2+DjL5sqK4Ct4aPX8F5LGoljn52b
         Vl+z2ywJ0yKiJeinjsqpYnFLKJxeBchxGY+2joEV5CeMCcw43H1Hk6mAqpy7UTOOuBpq
         Te8g==
X-Gm-Message-State: AA+aEWYWVUq+9psLHziURfaVeDZDvlZYA57PjLMixU/1nE9thmvDZiDn
        yw8rZNPAu7d6J/i8JeeK59z3gZP7ubECPqb32YNJmA==
X-Google-Smtp-Source: AFSGD/XQTd7QOna6yaV3IS/46BxiJMLtBjBXinp3h/Ud4mx7V27KTjsg5TlI++nJPhzDrh3aqmbioL0RVZgki1CTQAI=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr10153168otq.353.1544508231906;
 Mon, 10 Dec 2018 22:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-3-keith.busch@intel.com>
In-Reply-To: <20181211010310.8551-3-keith.busch@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 22:03:40 -0800
Message-ID: <CAPcyv4gEpxigPqc0PgDE0YCL3Ot+wPfvChAZqUTtdYR2WDxaJg@mail.gmail.com>
Subject: Re: [PATCHv2 02/12] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:05 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Systems may provide different memory types and export this information
> in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> tables provided by the platform and report the memory access and caching
> attributes.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/Kconfig  |   8 +++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/hmat.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c |   9 +++
>  include/linux/acpi.h  |   1 +
>  5 files changed, 211 insertions(+)
>  create mode 100644 drivers/acpi/hmat.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7cea769c37df..9a05af3a18cf 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -327,6 +327,14 @@ config ACPI_NUMA
>         depends on (X86 || IA64 || ARM64)
>         default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
>
> +config ACPI_HMAT
> +       bool "ACPI Heterogeneous Memory Attribute Table Support"
> +       depends on ACPI_NUMA
> +       help
> +        Parses representation of the ACPI Heterogeneous Memory Attributes
> +        Table (HMAT) and set the memory node relationships and access
> +        attributes.
> +
>  config ACPI_CUSTOM_DSDT_FILE
>         string "Custom DSDT Table file to include"
>         default ""
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index edc039313cd6..b5e13499f88b 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -55,6 +55,7 @@ acpi-$(CONFIG_X86)            += x86/apple.o
>  acpi-$(CONFIG_X86)             += x86/utils.o
>  acpi-$(CONFIG_DEBUG_FS)                += debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)       += numa.o
> +acpi-$(CONFIG_ACPI_HMAT)       += hmat.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y                         += acpi_lpat.o
>  acpi-$(CONFIG_ACPI_LPIT)       += acpi_lpit.o
> diff --git a/drivers/acpi/hmat.c b/drivers/acpi/hmat.c
> new file mode 100644
> index 000000000000..ef3881f0f370
> --- /dev/null
> +++ b/drivers/acpi/hmat.c
[..]
> +static __init int hmat_init(void)
> +{
> +       struct acpi_subtable_proc subtable_proc;
> +       struct acpi_table_header *tbl;
> +       enum acpi_hmat_type i;
> +       acpi_status status;
> +
> +       if (srat_disabled())
> +               return 0;
> +
> +       status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       if (acpi_table_parse(ACPI_SIG_HMAT, parse_noop))
> +               goto out_put;
> +
> +       memset(&subtable_proc, 0, sizeof(subtable_proc));
> +       subtable_proc.handler = hmat_parse_subtable;
> +       for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
> +               subtable_proc.id = i;
> +               if (acpi_table_parse_entries_array(ACPI_SIG_HMAT,
> +                                       sizeof(struct acpi_table_hmat),
> +                                       &subtable_proc, 1, 0) < 0)
> +                       goto out_put;
> +       }
> + out_put:
> +       acpi_put_table(tbl);
> +       return 0;
> +}
> +subsys_initcall(hmat_init);

I have a use case to detect the presence of a memory-side-cache early
at init time [1]. To me this means that hmat_init() needs to happen as
a part of acpi_numa_init(). Subsequently I think that also means that
the sysfs portion needs to be broken out to its own init path that can
probably run at module_init() priority.

Perhaps we should split this patch set into two? The table parsing
with an in-kernel user is a bit easier to reason about and can go in
first. Towards that end can I steal / refllow patches 1 & 2 into the
memory randomization series? Other ideas how to handle this?

[1]: https://lkml.org/lkml/2018/10/12/309
