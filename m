Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA10C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687A2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DCh+HD0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfBCRtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:49:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35057 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBCRtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:49:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so9792316oif.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il69hBbw1PefF0iSqsczm2kXao7knzvmA8rvZFbpyRg=;
        b=DCh+HD0wM/qvLG5B1q2VORLm2I3qFYua6Ju/jpxUXmgWok3FTiRe0X3T6ERo/oKBvY
         2iqoEJTg4+ghSwL04R7Sq4dIU2KE8wShRT1K3Ktu7Ug63ir4ya+tKU4PFeFk9iSDRExz
         ohNlBZJMsVtDX9QT5bo4pMQOq8Gc1FmayeqyALTZjjV/uTyDBnAkEY3YSHrv9GzQHvdC
         YkTERAI1cYRswA8aVvsIRxwDr5ZdKiW9J+DtINnX+wLHoXp7CZatsC6eEr13MrzJtpmW
         V9UEzT8wDxzyHT23/0QgKTcM85BKIb1ixC0lR83bvOZa2nJ4U26fU9oR/o1GVP/eCBK0
         nfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il69hBbw1PefF0iSqsczm2kXao7knzvmA8rvZFbpyRg=;
        b=gRFmyZnldv4uL8JU+CQZwgUq3w9R6Hs0Fil+T3B+fxCxA1w7RWDMru6OL4m4kFutq7
         1sN5IJTj8q7ETAz8l5dfMvF5vyjtqMx3h6rQlj2H3R33GLw9Ojhw02wrNFTNQgAkVK7g
         g2TVzUTmJIsYwYePmQohA20bKFOZdtUvl/Gw3wf//XdwCFrPRmLN+M0UBSIFGTJPIT3d
         pArUDWt1rx2M9lzLpLzaK79Xq9JEtPRPR4TY1UGbb6pafV3VdmRK4uY+ASrdZ6/MsbsT
         G8H8hd9vIxf5Iwt35XUAFym57/USXtZ9SXMHywZjPen4t6FT8o91+qz8J5VmyD/fRKgC
         WmyA==
X-Gm-Message-State: AHQUAuZgcxKqIenBnbrQFYMk2DBUp+XmDO7yCrrT1VamnR4iS5g3yr3h
        eVFmNzX/8MpmzWgRPaE2xa2IqMVegIUkWthuih9MVw==
X-Google-Smtp-Source: AHgI3IZlg4nI1LPx38XyS47/9E86AHLxfztk0FudUd7eaAotlJpd38d0xMauUNJJnhSmp/UDX1tkkRZ34AgVzsAVaIo=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr25168120oih.244.1549216161806;
 Sun, 03 Feb 2019 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 3 Feb 2019 09:49:10 -0800
Message-ID: <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 9:22 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Saturday, February 2, 2019 5:13 PM
> > ...
> > As Dexuan reports the NVDIMM_FAMILY_HYPERV platform is incompatible with
> > the existing Linux namespace implementation because it uses
> > NSLABEL_FLAG_LOCAL for x1-width PMEM interleave sets. Quirk it as an
> > platform / DIMM that does not provide BLK-aperture access. Allow the
> > libnvdimm core to assume no potential for aliasing. In case other
> > implementations make the same mistake, provide a "noblk" module
> > parameter to force-enable the quirk.
>
> Hi Dan,
> Thanks very much for the patch! With it, "ndctl list" can show the below:
>
> root@decui-gen2-u1904:~/ndctl# ndctl list
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"raw",
>     "size":137438953472,
>     "uuid":"c258aaab-f72b-e546-bfa5-be5e07761dbc",
>     "blockdev":"pmem1",
>     "name":"Microsoft Hyper-V NVDIMM 1 Label"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"raw",
>     "size":34359738368,
>     "uuid":"9f0497a7-4453-7c40-ad35-21a791e00345",
>     "blockdev":"pmem0",
>     "name":"Microsoft Hyper-V NVDIMM 0 Label"
>   }
> ]
>
> And /dev/pmem0 can appear, but /dev/pmem0p1 can not appear, and the "mode" of
> "namespace0.0" is not correct.  With the Ubuntu 19.04 4.18 kenel, I get the below:
>
> root@decui-gen2-u1904:~/ndctl# ndctl list
> [
>   {
>     "dev":"namespace1.0",
>     "mode":"raw",
>     "size":137438953472,
>     "blockdev":"pmem1"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":33820770304,
>     "uuid":"ef028c4e-2b1f-4bf8-b92a-1109d7a1c914",
>     "blockdev":"pmem0"
>   }
> ]
> and /dev/pmem0p1 can appear.
>
> It looks the namespace created by Ubuntu 19.04 (4.18) is incompatible with
> the libnvdimm-pending branch + this patch.

This is correct, the configuration switched from label-less by default
to labeled.

> It looks we need to completely disable the label usage for NVDIMM_FAMILY_HYPERV
> due to compability?

It's either going to be a quirk in Linux or a quirk in the Hyper-V
configuration. I think it's more manageable for Hyper-V to ship a
"label disable" switch than to try to ship a workaround in Linux. The
"noblk" quirk in Linux works around the LOCAL bit in the labels.
However, the namespace mode regression can only be resolved by hiding
the label capability until the administrator manually switches from
label-less to labeled operation.
