Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5174C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gK6o7oae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbfAOQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:48:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39248 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfAOQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:48:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so3084005otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+H9Jfq/e7VR5o3C3e8XlOS1Z/C+bcadR42ul22UhZk=;
        b=gK6o7oaeCBrhJcuBkvI3WhYWY+3SosBfQ5iBL26V1/dMkH/p/Ao3+wCI9NPLpwaufQ
         51NAk5hnlDsOVtensDG7z8Ly5YKFSvxB6LKjyvM9zxt4Jlv9/Q4CmTaNOg6FhzVpiyrY
         07BJpf7bCmy/EwdS3nPUsYK17iryyIQNMWoJ4CxEGx76qLM5as0Muz9Nde94uWgBZLqD
         +4eKZNgCm7KJABrvAL1SNpLxaNcXmv5286gucu1SkgIeLvT3BeTiHuS46k54XDJC5Jg1
         d5BgjAMPsvBVBYsh4h+KJ8PrsjDCPqoGWtMYXykI3PV+1HazidodPFqnQrmFZI3oovnW
         gktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+H9Jfq/e7VR5o3C3e8XlOS1Z/C+bcadR42ul22UhZk=;
        b=Iee0JH1lEAlbnU0EXjpx+pfzfB1WDTPgXDqWANQvObhfl5RFPagGxggYhduNrsNWEM
         S1nQEEI8atYbS6AR8RAJmGWeKsTT1ojsa4YtQBfymYDLuVU4QpXy1Pw5h3oIMeF13X/r
         TKN/9aOBXVln7xIZsA3/KZrb1l71LIqs9iFCATF31rMb5xGCsxQkWQ4TrfqQPhjHYyZs
         F9PHgrgoKhDF0L8+yedEjnEJnL9bMp8klf/7s7rlaqjVg/tjPIBj1V2vlnPCB4fbwsrw
         v+ClDZCuHCSesN7vCgYaF0Os5H6LKmM6r7sw6Sbk6Qsga/5F53SRK/tKhIrAk97kZVml
         QmQw==
X-Gm-Message-State: AJcUukeUaP3+v6Jq9uF30lMfFRTHS6maRS1l/gBI/zGmjYDWqM7KD4pq
        NAhWuWxCqtyJ79UpPk6oJ5+8YZ8qi2x02o6nPXZmPg==
X-Google-Smtp-Source: ALg8bN6JgtZLaVHvgCRUYcz+m1W2vr84QdQVIBGxZ+ieqaE7n52KPGH/cuKcaPr2pZ0Y54AE1TtgIkUZbcNkda9vBKA=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr2933302otn.214.1547570910140;
 Tue, 15 Jan 2019 08:48:30 -0800 (PST)
MIME-Version: 1.0
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49tvia80r0.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49tvia80r0.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jan 2019 08:48:18 -0800
Message-ID: <CAPcyv4htfew=7D_B1QDGTwSkMTx7BK2BZ+Gq+9UL1NTtqtL9FQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] acpi/nfit: Fix command-supported detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 6:16 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Changes since v1 [1]:
> > * Include another patch make sure that function-number zero can be
> >   safely used as an invalid function number (Jeff)
> > * Add a comment clarifying why zero is an invalid function number (Jeff)
> > * Pass nfit_mem to cmd_to_func() (Jeff)
> > * Collect a Tested-by from Sujith
> > [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019435.html
>
> For the series:
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
> Thanks, Dan!

Thanks, although I just realized one more change. The ND_CMD_CALL case
should zero out command after the function translation, otherwise
userspace can call functions that the kernel is blocking in the
dsm_mask.

Holler if this invalidates your "Reviewed-by".

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 87e02f281e51..d7747aceb7ab 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -463,6 +463,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
*nd_desc, struct nvdimm *nvdimm,
                func = cmd_to_func(nfit_mem, cmd, buf);
                if (func < 0)
                        return func;
+               /*
+                * In the ND_CMD_CALL case we're now dependent on 'func'
+                * being validated by the dimm's dsm_mask
+                */
+               if (cmd == ND_CMD_CALL)
+                       cmd = 0;
                dimm_name = nvdimm_name(nvdimm);
                cmd_name = nvdimm_cmd_name(cmd);
                cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -477,8 +483,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor
*nd_desc, struct nvdimm *nvdimm,
                cmd_name = nvdimm_bus_cmd_name(cmd);
                cmd_mask = nd_desc->cmd_mask;
                dsm_mask = cmd_mask;
-               if (cmd == ND_CMD_CALL)
+               if (cmd == ND_CMD_CALL) {
                        dsm_mask = nd_desc->bus_dsm_mask;
+                       cmd = 0;
+               }
                desc = nd_cmd_bus_desc(cmd);
                guid = to_nfit_uuid(NFIT_DEV_BUS);
                handle = adev->handle;
