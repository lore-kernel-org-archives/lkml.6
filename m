Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D9218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bexk2lQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfBAR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:29:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46333 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfBAR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:29:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so6623911otm.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eggK3FuKM9E1dxUDM0qROiytkJIW4PgBwYAb7mj7JsY=;
        b=bexk2lQx1hmgGR7uI0Ke0d7AcoVfc4lRMXRbw511cQ+yxztdXs/es6fRdCf+K5NyGM
         tVLzLcz9JsO7Bui6gkp+vEVJWJqmrjcRzIPASLC/zCGNUUkv8JIJc+H2pcMIcm1zgI63
         9JJZMBpx1HBncr5lfYCXyZQdFTq20/SS8PIWqopr/Xe0GO9mkhxaQjtSjSThq3W3cHbV
         k3IiAyggV49ErJJtv7I7Uf5XhMCBES7LvwI+YLvGL98ZYaFaNagA5MMYilZtW9o3OaDG
         2lidLE6rNTdUsNYYhJt9A44Nc9H1EZfjIUFYA00XPrCtgnik+ZKKSi/coMIqKcyLft57
         GH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eggK3FuKM9E1dxUDM0qROiytkJIW4PgBwYAb7mj7JsY=;
        b=HIFAV77zX5mmSmIZWVBCRwZQdVjxndgQ1Ilxsg//GpTOxTJIPfN1PKnAZpKwuV5HOe
         QXI3eq8OFg/ritx4yYkcNXpR1TphHMnE4mGqWjAqU95Bsl4BOwDSEPcL0EbDq2SfCB0j
         CnMxyshdZ+95z4U637qTXAGcFZGpM6eqWSyBud5WMpXd3Lpr3LyTfhxZSNXcnxjcB9a/
         zo+/eHSvuw7MK+c9wedgTRVovRSUqVExnZgjs5wE4/giEiXADl+e9wkC3cAyUlMLLOdC
         J/qYBVzyWJ8wIE3fr414S/obrJMqxN9vRvWKNPKNVwlI0CX1TpiHRBfT+it9b3robyX0
         Z6yw==
X-Gm-Message-State: AJcUukfM6wIxHejJiFxDwC0cJ6KAKsKhlwvurpChKI5gpfERPEtKEr3u
        /knNY2RPc6oFhvDa38B7dQSDfSJ1JG6HcUt+6ht2bA==
X-Google-Smtp-Source: ALg8bN6vWqGBMaklDzaF2UuoRwf3ScEih1BDQJsMiIPz27JxNlhq7r2O18YLyxThnYUifITT0APcwy/FJCsVZFGi+Wo=
X-Received: by 2002:a9d:394:: with SMTP id f20mr28051635otf.98.1549042178139;
 Fri, 01 Feb 2019 09:29:38 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com> <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Feb 2019 09:29:27 -0800
Message-ID: <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
Subject: Re: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 9:14 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Tuesday, January 29, 2019 10:24 PM
> > On Mon, Jan 28, 2019 at 4:56 PM Dexuan Cui <decui@microsoft.com> wrote:
> > >
> > >
> > > Add the Hyper-V _DSM command set to the white list of NVDIMM command
> > > sets.
> > >
> > > Thanks Dan Williams <dan.j.williams@intel.com> for writing the
> > > comment change.
> > > ---
> > > Changes in v2:
> > >     Updated the comment and changelog (Thanks, Dan!)
> > >     Rebased to the tag libnvdimm-fixes-5.0-rc4 of the nvdimm tree.
> >
> > Thanks for the re-spin, applied.
>
> Hi Dan,
> Unluckily it looks this commit causes a regression on
> https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending
>
> With the patch, "ndctl list" shows nothing, and /dev/pmem0 can't appear.
> If I revert the patch, it will be back to normal.
>
> I attached the config/logs. In the bad case, "dmesg" shows a line
> [    5.259017] nd_pmem namespace0.0: 0x0000000000000000, too small must be at least 0x1000
>
> Any idea why this happens? I'm digging into the details and I appreciate your insights.

Looks like it is working as expected. The regression you are seeing is
the fact that the patch enables the kernel to enable
nvdimm-namespace-label reads. Those reads find a namespace index block
and a label. Unfortunately the label has the LOCAL flag set and Linux
explicitly ignores pmem namespace labels with that bit set. The reason
for that is due to the fact that the original definition of the LOCAL
bit from v1.1 of the namespace label implementation [1] explicitly
limited the LOCAL flag to "block aperture" regions. If you clear that
LOCAL flag I expect it will work. To my knowledge Windows pretends
that the v1.1 definition never existed.

The UEFI 2.7 specification for v1.2 labels states that setting the
LOCAL flag is optional when "nlabel", number of labels in the set, is
1. Linux makes that mandatory as LOCAL is redundant when nlabel is 1.

That said, the Robustness Principle makes a case that Linux should
tolerate the bit being set. However, it's just a non-trivial amount of
work to unwind the ingrained block-aperture assumptions of that bit.

[1]: http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
