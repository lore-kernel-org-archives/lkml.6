Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D71C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088F21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VSrcaV/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAUWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:34:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36437 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfAUWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:34:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so21950224otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rL8USB9BBkpFKFp8oWAAG6gZe7QWP4SiGavMpn/OiQU=;
        b=VSrcaV/Jon7gPbTW9jg4tRNqMSUaZT6a1ClNX1n42YvPapOBmk8TGsvlMzLKw2k0I8
         2h4guMZUY4+XAlPhGAyFfJB/uhAdBiv+vNaSRFG4NJgQ4SNRhnJbhNUP8n7rtItjsX+9
         kP00IQH49Gdm8MElmoCk3/5SIrsADUB/Dsv5KU1YLKgy6oPK4qPASqsO4i1UH2O4K/9g
         WwpIuCIkb/Ly9foHnUt3t51OPm0idJyXmrHX47FEMyYLz6oGyP4N9uSzJIqdPk7hsdiI
         uYcDqqAexq4yXdN7NTI0lbHORH1b/1eeAsDbXQQE3o/LNZZH6AvaBZ5ccCBdZhKAhEXU
         uqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rL8USB9BBkpFKFp8oWAAG6gZe7QWP4SiGavMpn/OiQU=;
        b=hDmMOwDmMbOC8Jz/eS/UqxSVsnM2ymFvl/qwBzx441xpDNkO8C1mZJdT6aa8O1jr6A
         dah0CXaoraYPchCRqQ5SA/23kjw/nvA18x0TQFOVvChr4aks9+ERglu3+mWMvtFRWcyh
         e0Kt6V1mPSzbMBwiMPHNWHvWWJUOWZkLbREQoNFcfDeieeIcqhkr68HwJYU+HuHfFfLQ
         d2YsnaBoI+drdjHcOoNTafg+5SxZKYLv2/zOe+f+5069fm3QhvwgfMS43XDU+V03zW+V
         2ZLb/by4c2LEezY8BLs9oO9yK9xgukcMrtynllaDVcy3Y2T4I5xvT1eYrPnX97tyG2da
         fC0w==
X-Gm-Message-State: AJcUukd9prRGkQ8QikXfEjpbXdPQtDCiO/4lRKASVpm7ZPXdb1uXkDfe
        AaJztQgwLOpbyrohN7DNFVb6TCzmIWS9dg6dFnItWg==
X-Google-Smtp-Source: ALg8bN5Q/qWfRPA7NNBRpljR4JFXVSlrbsIRTmpYP3XXcFn9M18RTlQmozX4sreVSOkOXrrhVFFywQ8hbguY5JkbxBA=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr19917774otq.353.1548110058526;
 Mon, 21 Jan 2019 14:34:18 -0800 (PST)
MIME-Version: 1.0
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard> <CAPcyv4iGZdEw-agURohZdC7hkjrDp74M_gVdSbCB5DP-bk5YYw@mail.gmail.com>
 <20190121205713.vai2oor3saopcja7@master>
In-Reply-To: <20190121205713.vai2oor3saopcja7@master>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Jan 2019 14:34:06 -0800
Message-ID: <CAPcyv4g7hR34mNSQOLARTrX--UFpgg68thfg75hZOzq5AaBw5A@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:57 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Mon, Jan 21, 2019 at 10:04:40AM -0800, Dan Williams wrote:
> >On Sun, Jan 20, 2019 at 11:51 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
> >[..]
> >> Also, I have one confusion about your saying: two probes.
> >>
> >> If the two probes are:
> >>
> >>     * for dax%d.%d: 1. nd_dax_probe 2. dax_pmem_probe
> >>     * for pfn%d.%d: 1. nd_pfn_probe 2. nd_pmem_probe
> >>
> >> Then, if the first probe fails, the device itself would be destroyed. How the
> >> second probe do its job?
> >>
> >> >       rc = nd_pfn_validate(nd_pfn, sig);
> >> >       if (rc != -ENODEV)
> >> >               return rc;
> >
> >Here is an example path for a device-dax instance:
> >
> >    /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.1/dax0.0
> >
> >In this case the order of events is:
> >
> >1/ region0 discovers it contains a pmem namespace and registers namespace0.0
> >2/ The pmem namespace driver calls nd_dax_probe() to check for the
> >presence of a device-dax configuration
> >3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
> >registers the dax0.1 device (this is a libnvdimm 'personality device).
> >4/ When nd_pmem_probe() sees nd_dax_probe() return 0 it in turn fails
> >the probe of namespace0.0 with -ENXIO. All devm allocations during the
> >probe of namespace0.0 are released.
>
> I may have another opinion here.
>
> The probe return error means the device will not attach to this driver.
> But the device itself it not released.
>
> We allocate devm on one device and those memory will be released when
> the device is destroyed. If I am correct.
>
> This means at this point, pfn_sb's memory still exists in the system.
> Even finally we will release it, when namespace0.0 is destroyed.

No, that's not the way devm works. Memory allocated by devm is
released at ->probe() failure, or after ->remove()

See the devres_release_all() call in drivers/base/dd.c::really_probe()
