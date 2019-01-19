Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD1C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABEB2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0FSd/546"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfASTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:06:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35965 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfASTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:06:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so11617501oix.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 11:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llQRCvwaWKBhSH8sHg3O+d2zSwQNN26i1rTGF2LKlD8=;
        b=0FSd/546svh+P9nqrUEQq8IXh41wP8YbaHogNxFj+BWTkFT/9KtEFsyQSJ1j52ZlnP
         VCbidY1o+hDvVz8xNrtia36ZyBKOfjaz3eYr8rxYqHtKz2kEFTRJRvC/Ylwb50y+jGFQ
         8pf52z37Tcbwvlv0L3pnmv73ALC9HHGEt+TAF2kitNsXZtXnkf+JHxAEoQayWOlmT2ij
         z6A2Xy8REU/eRsb3NyPDdCcEg4S66YXlLqo4KMLk9YrBAzfm1QomifwGmtp48esqWiBq
         LA4l5Ga1wjooggaPeP/mAZ2gm/Y7+Od8cKNCn8V6JSTMvyct0A5/WdULu5pW3CHEO0e7
         x/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llQRCvwaWKBhSH8sHg3O+d2zSwQNN26i1rTGF2LKlD8=;
        b=aoq/XubAlv5l9b0sNpOxwwmB39P61p5ciIeAPUUrnfrhh/UigXSWNDlvueK8sXJNKs
         +CCCOKWGv9Z0bExemoLpeEzJ6mQ4umGruQhHsoapotNYDLhXoGFDKpnOAV4URZC2tNqI
         70k3qQwWG9iiqCnJLsEKgURFansN4A3PU+r07DNliCGGCzPizvXz+Tcf6t5DXXKYCDgE
         1QKCgPD60Ua5lqRr/AGYzjjBRfta83j/EwJDc5JrfShE2iUhABrw4ooVXPirw4Yrx4Ah
         74c07UHplhMxAmfrS146thmnNfvm1oGR651o+6UMkL+gbApLaGu+B7XRO9oxb6tPfcRk
         wDgg==
X-Gm-Message-State: AJcUukfETYf+3Gk69khguAFhpgRTGX+8SHcpZEP0YYMAETY9E7eyFdFx
        Dy0HwXQZUAaSAdch02MRcQZ3O9kBQrtPF0mIvD/9RA==
X-Google-Smtp-Source: ALg8bN60qTcwWwIX4+1FOQVV0m7kSJJhZp+a5x7qcHpRS2K7X+8vDi/Zb9cg+WnZTtR6yz1tV224m1WWXil+g8wo5XI=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr1620719oih.244.1547924808265;
 Sat, 19 Jan 2019 11:06:48 -0800 (PST)
MIME-Version: 1.0
References: <154759163682.1953028.16995572958827750312.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154759164721.1953028.2457688855956808647.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154759164721.1953028.2457688855956808647.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 19 Jan 2019 11:06:31 -0800
Message-ID: <CAPcyv4ixzBb_=6P4Vq39YArmxgUcdm+u2QK+CpTDHCTOa7DT1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] acpi/nfit: Fix command-supported detection
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     stable <stable@vger.kernel.org>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 2:46 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The _DSM function number validation only happens to succeed when the
> generic Linux command number translation corresponds with a
> DSM-family-specific function number. This breaks NVDIMM-N
> implementations that correctly implement _LSR, _LSW, and _LSI, but do
> not happen to publish support for DSM function numbers 4, 5, and 6.
>
> Recall that the support for _LS{I,R,W} family of methods results in the
> DIMM being marked as supporting those command numbers at
> acpi_nfit_register_dimms() time. The DSM function mask is only used for
> ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
> Cc: <stable@vger.kernel.org>
> Link: https://github.com/pmem/ndctl/issues/78
> Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> Tested-by: Sujith Pandel <sujith_pandel@dell.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c |   52 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 73281b19d3dd..9c95b82e5e5d 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -409,6 +409,32 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
>         return true;
>  }
>
> +static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
> +               struct nd_cmd_pkg *call_pkg)
> +{
> +       if (cmd == ND_CMD_CALL) {
> +               int i;
> +
> +               if (call_pkg && nfit_mem->family != call_pkg->nd_family)
> +                       return -ENOTTY;
> +
> +               for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
> +                       if (call_pkg->nd_reserved2[i])
> +                               return -EINVAL;
> +               return call_pkg->nd_command;
> +       }
> +
> +       /* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
> +       if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
> +               return cmd;
> +
> +       /*
> +        * Force function number validation to fail since 0 is never
> +        * published as a valid function in dsm_mask.
> +        */
> +       return 0;
> +}
> +
>  int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>                 unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
>  {
> @@ -422,30 +448,21 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>         unsigned long cmd_mask, dsm_mask;
>         u32 offset, fw_status = 0;
>         acpi_handle handle;
> -       unsigned int func;
>         const guid_t *guid;
> -       int rc, i;
> +       int func, rc, i;
>
>         if (cmd_rc)
>                 *cmd_rc = -EINVAL;
> -       func = cmd;
> -       if (cmd == ND_CMD_CALL) {
> -               call_pkg = buf;

This breaks ND_CMD_CALL because now call_pkg is NULL for the rest of
this routine. v4 inbound, as well as a backlog item to add an
ND_CMD_CALL test-case to nfit_ctl_test(). The incremental fix is:

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 9c95b82e5e5d..71d03a4004fb 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -412,10 +412,10 @@ static bool payload_dumpable(struct nvdimm
*nvdimm, unsigned int func)
 static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
                struct nd_cmd_pkg *call_pkg)
 {
-       if (cmd == ND_CMD_CALL) {
+       if (call_pkg) {
                int i;

-               if (call_pkg && nfit_mem->family != call_pkg->nd_family)
+               if (nfit_mem->family != call_pkg->nd_family)
                        return -ENOTTY;

                for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
@@ -460,7 +460,9 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
*nd_desc, struct nvdimm *nvdimm,
                if (!adev)
                        return -ENOTTY;

-               func = cmd_to_func(nfit_mem, cmd, buf);
+               if (cmd == ND_CMD_CALL)
+                       call_pkg = buf;
+               func = cmd_to_func(nfit_mem, cmd, call_pkg);
                if (func < 0)
                        return func;
                dimm_name = nvdimm_name(nvdimm);
