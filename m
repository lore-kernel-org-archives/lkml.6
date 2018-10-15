Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29BEC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B0205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbn3jR9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395B0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeJOHsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 03:48:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53205 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeJOHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 03:48:39 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so26328325itz.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+SURIXrgCllyAoswgdbR8qczhLpaio0wewJrHEIJtc=;
        b=Dbn3jR9/P3SN+ChigwT7lRyo0IBXgFwgoUIsEsGa8ODqEyl1EIVS76dCUfWUxWqgHc
         1fc+4Bq0cm7uj38EkGN20Iqa2QkPiTn1gBUWrwRNA+cS+Rde7xlSX4cy4c9viHRRukjS
         Nd9fV6iKeG2yPOczL0axspUqFdiW3J6lLVGiz363HqEVW0QuQgGvYXFSLvoXq3QiIEwa
         XG/SuzMvy9DOlZYFurnOuB4tvscY/KroideG4iKHgEtRRdVQ7pnk3KjsVdWvNqiuJllt
         183Qn0TgPDOxYye9XNYHRD5XHd8/ylt1rxdAO+R0pE8gifC97CyWVjK/ow/FC4ebQPXp
         m0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+SURIXrgCllyAoswgdbR8qczhLpaio0wewJrHEIJtc=;
        b=shShO51JxEwMcq+tc6YIixzFtLHBbdr7j2/EFdQbh9mBBxjkJWrA4k6FJtc4ePlVaL
         jWNquPTXUofeaDf8lBHoFY4zz5LlWxX38ToNVNGBFBGmAmXhRxCGMxzY6JHYkLHDuYnB
         t0bwjTTf8DfCtDIxx4jOOThDrtfxmXXG5ONOBj6mIvdlXNklUqruu6/3KmYkaiZcuhTm
         E9CH4ttUj4mjFEoF9xvJMuFPmi6Wr+GwbhPJnIKytKf9E1aBHMF9oeP2lHpGYze1NZi0
         vjHZXrIckli8WjwLQgxFIkri6rA+y2EyvJEaPS5vj2Sg7kFvQWa0PL3K7FhCrX95k3p9
         n3vQ==
X-Gm-Message-State: ABuFfojF86Ed/dIxjCU4cJPea0kDEEXss8ClKqHmBf5LzWOUugtgWyFs
        9zSMi+o4otzQec+ezVKgaxkI4KtpZ/iabfWA3DA=
X-Google-Smtp-Source: ACcGV60yiIpF6/9kpZjxeZDxtsD536NgRpNZ6vDMYjLV48kg5BOIkjMXFuc4YrEy1ttbYDZ3Gb8yu687Mxy5ILAibk8=
X-Received: by 2002:a24:3d12:: with SMTP id n18-v6mr10417690itn.131.1539561955092;
 Sun, 14 Oct 2018 17:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <153944784534.1508664.6365625408163933467.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153944784534.1508664.6365625408163933467.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Oliver <oohall@gmail.com>
Date:   Mon, 15 Oct 2018 11:05:44 +1100
Message-ID: <CAOSf1CF5zn3SJJm7J38qMcsdVhxWi_SPoHOBHt-YBg+RzjS8Bg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Provide a simplified nvdimm_create() for
 non-security enabled DIMMs
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 3:35 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Do not require libnvdimm provider implementations to include security
> parameters if the bus / dimm-devices do not have that support.
>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c   |    2 +-
>  drivers/nvdimm/dimm_devs.c |    4 ++--
>  include/linux/libnvdimm.h  |   11 ++++++++++-
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index a287a773012b..a0dfbcf8220d 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1992,7 +1992,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
>
>                 flush = nfit_mem->nfit_flush ? nfit_mem->nfit_flush->flush
>                         : NULL;
> -               nvdimm = nvdimm_create(acpi_desc->nvdimm_bus, nfit_mem,
> +               nvdimm = __nvdimm_create(acpi_desc->nvdimm_bus, nfit_mem,
>                                 acpi_nfit_dimm_attribute_groups,
>                                 flags, cmd_mask, flush ? flush->hint_count : 0,
>                                 nfit_mem->flush_wpq, &nfit_mem->id[0],
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index d1bfb8975b07..5d34251c4f3b 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -459,7 +459,7 @@ struct attribute_group nvdimm_attribute_group = {
>  };
>  EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
>
> -struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
> +struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
>                 const struct attribute_group **groups, unsigned long flags,
>                 unsigned long cmd_mask, int num_flush,
>                 struct resource *flush_wpq, const char *dimm_id,
> @@ -496,7 +496,7 @@ struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
>
>         return nvdimm;
>  }
> -EXPORT_SYMBOL_GPL(nvdimm_create);
> +EXPORT_SYMBOL_GPL(__nvdimm_create);
>
>  int alias_dpa_busy(struct device *dev, void *data)
>  {
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index c352b8195675..1071fe12081b 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -207,11 +207,20 @@ const char *nvdimm_name(struct nvdimm *nvdimm);
>  struct kobject *nvdimm_kobj(struct nvdimm *nvdimm);
>  unsigned long nvdimm_cmd_mask(struct nvdimm *nvdimm);
>  void *nvdimm_provider_data(struct nvdimm *nvdimm);
> -struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
> +struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
>                 const struct attribute_group **groups, unsigned long flags,
>                 unsigned long cmd_mask, int num_flush,
>                 struct resource *flush_wpq, const char *dimm_id,
>                 const struct nvdimm_security_ops *sec_ops);
> +static inline struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus,
> +               void *provider_data, const struct attribute_group **groups,
> +               unsigned long flags, unsigned long cmd_mask, int num_flush,
> +               struct resource *flush_wpq)
> +{
> +       return __nvdimm_create(nvdimm_bus, provider_data, groups, flags,
> +                       cmd_mask, num_flush, flush_wpq, NULL, NULL);
> +}
> +
>  const struct nd_cmd_desc *nd_cmd_dimm_desc(int cmd);
>  const struct nd_cmd_desc *nd_cmd_bus_desc(int cmd);
>  u32 nd_cmd_in_size(struct nvdimm *nvdimm, int cmd,

Acked-by: Oliver O'Halloran <oohall@gmail.com>
