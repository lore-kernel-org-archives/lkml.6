Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE75C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE40E21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sfnRNTN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392630AbfBMQTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:19:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40926 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:19:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so5112183oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6cgydVzEMe2hY+xvoZbvAXaDHt8Fvtz1odtZkVMvLmU=;
        b=sfnRNTN67G5hJbWbDrOvTOiV7JaDoiYNtomEZeOJ2Cg4RlKrQAEZMEE8GCPO7UvHLj
         GPR1r1bWUfYVEaEFMOnYaAhZI6P89ivWehuRk8b/h3lxf0FMXyQus6ly/WmBXLgZ7FKK
         nZf9v/JUojwBuy+JU1zQG9561ufog6r5xqzb49IyJ9eeCQYclpkzOy4k1rk6vfBCgWKI
         LRqtSKqS+C2zF4D/l40stip5td6J68ixu8Rdkni6LBIMJ2cxPeCwpsJFKuQX/o7UppsS
         w246TVXJ0ZPjWFXpjH397vBDcGrhTS+1jBO9ulGUL8ph3D2poHRcI1JqC51oXpX3n/8u
         Viog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6cgydVzEMe2hY+xvoZbvAXaDHt8Fvtz1odtZkVMvLmU=;
        b=KkVzyatABtZtSLaBNfFQsevlP4SPA6ngB55hVpHzkJMyYiLUAnyxcz22zdZJLwWEay
         eTdza3/HKr+DaWjsi+PTL7a3BqtKTg0+z6sV3sihWv0z6ZUxB8SBz+P4jDHHlU44twJ/
         EE93wR/bWYsDhsGgc2mL98DmIftbhxhPrsS76677iTilacDYHsYAZLeSse7FwQFo9EK6
         sOydcZkdGR+BQDLAz8ls0CrVVd2FygWuYR+UklQkipxK6L1J4m3ZH//T9FkLIB8RoXLt
         U32LjO/h1TF5Ee8DLIuadrMuPhpX72sL9pBFKpRvNxC9EK1d5BXnNmvKQNAAmr04EkuG
         QHmA==
X-Gm-Message-State: AHQUAuZlnpc4kUOqcTXcdmWuK3OkqF3E/Dz6OSWGyx49bmW1+FqmLifP
        AasU1AwWFio4gsxnH8oinnXfB4VaeDMBFGejr3/Z/Q==
X-Google-Smtp-Source: AHgI3IZ9CIAGGslUXr2nx86tN/Mvd9GJImhvz5Oimwf9LiErsS9Mz+SJ8i51KWePKhVC3iZgZBWXQIlfh48mI/s6BKo=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr748863ota.229.1550074757434;
 Wed, 13 Feb 2019 08:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <c4c6aca8-6ee8-be10-65ae-4cbe0aa03bfb@inria.fr> <26ac36f4-7391-5321-217b-50d67e2119d7@intel.com>
 <453f13cd-a7fe-33eb-9a27-8490825ca29c@inria.fr> <CAPcyv4jF7ZyKaFDw7nb04UvWkVWGJdLGkZDQ1g=X7i+kdu7JRg@mail.gmail.com>
 <a3bfe739-228e-26fe-90f7-4a4f8ceb3a9a@inria.fr> <CAPcyv4jJ=C7ZEsJqBxzBMsQWz4+C8BZmWuk7OkztOebprd2rMg@mail.gmail.com>
 <057ad938-e745-02f7-edce-e19bd326da6a@inria.fr> <eb58cb96-1f61-2dd2-b1ab-5a7d4df78297@inria.fr>
In-Reply-To: <eb58cb96-1f61-2dd2-b1ab-5a7d4df78297@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Feb 2019 08:19:05 -0800
Message-ID: <CAPcyv4iAex_rgPXfhsjWjbvKX79s0ZoieE2NeX14_F56WoQ_7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal RAM
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:07 AM Brice Goglin <Brice.Goglin@inria.fr> wrote:
>
>
> Le 13/02/2019 =C3=A0 09:43, Brice Goglin a =C3=A9crit :
> > Le 13/02/2019 =C3=A0 09:24, Dan Williams a =C3=A9crit :
> >> On Wed, Feb 13, 2019 at 12:12 AM Brice Goglin <Brice.Goglin@inria.fr> =
wrote:
> >>> Le 13/02/2019 =C3=A0 01:30, Dan Williams a =C3=A9crit :
> >>>> On Tue, Feb 12, 2019 at 11:59 AM Brice Goglin <Brice.Goglin@inria.fr=
> wrote:
> >>>>> # ndctl disable-region all
> >>>>> # ndctl zero-labels all
> >>>>> # ndctl enable-region region0
> >>>>> # ndctl create-namespace -r region0 -t pmem -m devdax
> >>>>> {
> >>>>>   "dev":"namespace0.0",
> >>>>>   "mode":"devdax",
> >>>>>   "map":"dev",
> >>>>>   "size":"1488.37 GiB (1598.13 GB)",
> >>>>>   "uuid":"ad0096d7-3fe7-4402-b529-ad64ed0bf789",
> >>>>>   "daxregion":{
> >>>>>     "id":0,
> >>>>>     "size":"1488.37 GiB (1598.13 GB)",
> >>>>>     "align":2097152,
> >>>>>     "devices":[
> >>>>>       {
> >>>>>         "chardev":"dax0.0",
> >>>>>         "size":"1488.37 GiB (1598.13 GB)"
> >>>>>       }
> >>>>>     ]
> >>>>>   },
> >>>>>   "align":2097152
> >>>>> }
> >>>>> # ndctl enable-namespace namespace0.0
> >>>>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> >>>>> <hang>
> >>>>>
> >>>>> I tried with and without dax_pmem_compat loaded, but it doesn't hel=
p.
> >>>> I think this is due to:
> >>>>
> >>>>   a9f1ffdb6a20 device-dax: Auto-bind device after successful new_id
> >>>>
> >>>> I missed that this path is also called in the remove_id path. Thanks
> >>>> for the bug report! I'll get this fixed up.
> >>> Now that remove_id is fixed, things fails later in Dave's procedure:
> >>>
> >>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> >>> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> >>> # echo -n dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> >> In the current version of the code the bind is not necessary, so the
> >> lack of error messages here means the bind succeeded.
>
>
> It looks like "unbind" is required to make the PMEM appear as a new
> node. If I remove_id from devdax and new_id to kmem without "unbind" in
> the middle, nothing appears.
>
> Writing to "kmem/bind" didn't seem necessary.

Yes, in short:

device_dax/remove_id: not required, this driver attaches to any and
all device-dax devices by default
device_dax/unbind: required, nothing else will free the device for
kmem to attach
kmem/new_id: required, it will attach if the device is currently
unbound otherwise the device must be unbound before proceeding
kmem/bind: only required if the device was busy / attached to
device_dax when new_id was written.
