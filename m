Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29B22148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="V0eeaEsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfA1VBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:01:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42943 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfA1VBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:01:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so15936341otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsY7fWU0jAnav2iwrtKDl7ahJxHUtI91YTs0IMY/ZHw=;
        b=V0eeaEsVV6GtJiMI6v/LtR0bgPwdy9C7Jk/3eL9b1oU0PyrVr10o8zf1kWCH5gwXtj
         5OT0xjPaM0me3q0b5AY9gqUw58DB30pVKMWzDXXuvSzWNkpywHNvn4BbgBAl5Xy1Xv7n
         zDoLpqp/vxvo95TL0sS7VommpgPVq3iXt6n5zlf+DcBrdDxWPOmRhq64Qw+aRCe9sdVv
         crjqQ2Cxne/4u5kM6g156E2DuGWV4w/tc9rVu8Uq9BXy6A6ZLa25pE5XvaBJfXDIAMEn
         bNvn+0OCL6tKMpRue3eaIS8SyI6AzAlYD8phe7hMbdC8ODWTBQYUH9jKpLBVRmOdx38U
         4zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsY7fWU0jAnav2iwrtKDl7ahJxHUtI91YTs0IMY/ZHw=;
        b=KGmTpWN6QUiFRXjPb+fckKNFIITUDE7Zm3O7I5pfWjbEjHNSnZSAidQX7vqQVGwHqm
         sEz1h6VZfXiY0UZ71FoyTgkjawezuCmMQZsRY6ZJnqQjfpPty9GjY4R735rwTvb0EB5g
         dwkvMR9iatHFSEQK8apAZEZyg2DRroUVbQ4WaP47UzLiU96zKcdthUAyYd9kOVdDXdgN
         Or1re5HJ1bMax1jhP769+o1LDF4ax+C9YfV7kwToTv697fxfmQSkpBN5Hxh93oSf/jg1
         lLpOHnUEObklirKpeY6HdqPlvuf3dKvHgyPGnEyQj6Q2ejbCZ5MZhDf2lb0gqZnkAAS5
         5GrQ==
X-Gm-Message-State: AJcUukddmOi5gUbEl/W8amd4CNC8pp+lwHIo5AIVMFmQRTPMQOikzRkz
        5QWx9mwUhPD/vPKxAmUUuWXyZ++Hv4zkCn2B9Dy0Pw==
X-Google-Smtp-Source: ALg8bN4jgQbvNDdB2msKCRY6Al34ziD1lJXKrPWJ0HdKQYPTFoC9pmZKUVLCaRbt6deEPczxfFZQ3xwENdypIvYr1W0=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr16566293otl.32.1548709291057;
 Mon, 28 Jan 2019 13:01:31 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Jan 2019 13:01:19 -0800
Message-ID: <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com>
Subject: Re: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dexuan,

Looks good. Just one update request and a note below...

On Wed, Jan 23, 2019 at 12:51 PM Dexuan Cui <decui@microsoft.com> wrote:
>
>
> Add the Hyper-V _DSM command set to the white list of NVDIMM command
> sets.
>
> This command set is documented at http://www.uefi.org/RFIC_LIST
> (see the link to "Virtual NVDIMM 0x1901" on the page).
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>
> I'm going to change the user-space utility "ndctl" to support Hyper-V Virtual NVDIMM.
> This kernel patch is required first.
>
>  drivers/acpi/nfit/core.c   | 5 ++++-
>  drivers/acpi/nfit/nfit.h   | 6 +++++-
>  include/uapi/linux/ndctl.h | 1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 011d3db19c80..fb48cb17a519 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1840,7 +1840,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
>
>         /*
> -        * Until standardization materializes we need to consider 4
> +        * Until standardization materializes we need to consider 5
>          * different command sets.  Note, that checking for function0 (bit0)
>          * tells us if any commands are reachable through this GUID.
>          */

This comment is stale. This "HYPERV" family is the first example of
the "right" way to define a new NVDIMM command set. Lets update it to
mention the process and considerations for submitting new command sets
to UEFI (http://www.uefi.org/RFIC_LIST). The fact that there's now a
defined process is a step forward from when this comment was initially
written. Also, the fact that the process encourages "adopt" vs
"supersede" addresses the main concern about vendor-specific
command-set proliferation.

> @@ -1865,6 +1865,8 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>                         dsm_mask &= ~(1 << 8);
>         } else if (nfit_mem->family == NVDIMM_FAMILY_MSFT) {
>                 dsm_mask = 0xffffffff;
> +       } else if (nfit_mem->family == NVDIMM_FAMILY_HYPERV) {
> +               dsm_mask = 0x1f;

Just a note that starting with commit 5e9e38d0db1d "acpi/nfit: Block
function zero DSMs", bit0 in this mask will be cleared to ensure that
only the kernel has the ability to probe for supported DSM functions.
