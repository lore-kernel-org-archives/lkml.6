Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09336C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD76222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qlBQx88F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfBMAa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:30:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43520 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfBMAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:30:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so1010206ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYmrRYaE5CixJaAgNDYErhzzOhW5/liHoijaul9aviw=;
        b=qlBQx88F8mFF9E24rJbJYEin8dY3+oc9LNXKt4SgBaHFE/+5LXGpr2NGXaLT0rfAcP
         LWI1vJOmJx6Bt8XPXS/MvlU6JN/OOxnlcWoSnPzNQvQsbT5RgSQeRypgwEFeZ5M2GiH+
         qm8+q7tB9DuEv7KRXpnMECYSFd/3I6jXUXvJAnKXs3/Oxn9NUBmrp9g8nt1iGjUT0rCm
         Q3gRoJ57/+4MV/FqMvF4yZ/+RQ+qMqO7TIrfj3HCRBri0f0Js3YixlJ79uw485owxWkJ
         j40CorJRjQhuXwa4FLcfSmziGfyuDLMtb/ojuS7I9+GWXloUr/A2pnQyJXlYzMNaxdzZ
         ucpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYmrRYaE5CixJaAgNDYErhzzOhW5/liHoijaul9aviw=;
        b=D/UJ+GoRHW0QFeI6y6PG6P/5xeAlPdjT0VaqOnh6lfI/kLdIqT5dbdiPri5uoSkv6P
         7Fn3fNNE/UlFNCjJTwsUvRNfebalx6lvdAkNafJ1SggI2ANnocdCXQaQKV9C7dzqOvtl
         276roBqRBFCl1KZsCmBrhYczz/hpG6yJTuM6PtRDGfkot/WKIyg5O+alYpZZecEnFvh6
         EjQMOwv7Gp1zKsrKlfSAVtLJCE8DubnkBEUjHsHhioPUv16Zs9wuQB6R0azhQ8ymP9wG
         SRkQ9ZAd8VFnxPBow8MNISseTknwi5Avx/shcUh3GD3P+DAy5UWsGFtvPMB3JCAEtH7r
         BW/A==
X-Gm-Message-State: AHQUAubFS0u/3SIEm2VGnvluTfewnKtjbvxRzpE0982S/KGjWptRqvnV
        8lp+b6CZipawzrGpsZb75t9Kfd0lCc31BUl2YTdyPg==
X-Google-Smtp-Source: AHgI3IbMA5jS8OtFCWqyGp8ecfJjb71tiHb3rLH4HaRtzb9QD/QNIHae4Qa6Lp+aSsFufw7cfmFAkoT4RxAbmEdpvmE=
X-Received: by 2002:a05:6830:16d4:: with SMTP id l20mr232222otr.32.1550017827710;
 Tue, 12 Feb 2019 16:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231448.E102D18E@viggo.jf.intel.com>
 <c4c6aca8-6ee8-be10-65ae-4cbe0aa03bfb@inria.fr> <26ac36f4-7391-5321-217b-50d67e2119d7@intel.com>
 <453f13cd-a7fe-33eb-9a27-8490825ca29c@inria.fr>
In-Reply-To: <453f13cd-a7fe-33eb-9a27-8490825ca29c@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Feb 2019 16:30:17 -0800
Message-ID: <CAPcyv4jF7ZyKaFDw7nb04UvWkVWGJdLGkZDQ1g=X7i+kdu7JRg@mail.gmail.com>
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

On Tue, Feb 12, 2019 at 11:59 AM Brice Goglin <Brice.Goglin@inria.fr> wrote=
:
>
> Le 11/02/2019 =C3=A0 17:22, Dave Hansen a =C3=A9crit :
>
> > On 2/9/19 3:00 AM, Brice Goglin wrote:
> >> I've used your patches on fake hardware (memmap=3Dxx!yy) with an older
> >> nvdimm-pending branch (without Keith's patches). It worked fine. This
> >> time I am running on real Intel hardware. Any idea where to look ?
> > I've run them on real Intel hardware too.
> >
> > Could you share the exact sequence of commands you're issuing to
> > reproduce the hang?  My guess would be that there's some odd interactio=
n
> > between Dan's latest branch and my now (slightly) stale patches.
> >
> > I'll refresh them this week and see if I can reproduce what you're seei=
ng.
>
> # ndctl disable-region all
> # ndctl zero-labels all
> # ndctl enable-region region0
> # ndctl create-namespace -r region0 -t pmem -m devdax
> {
>   "dev":"namespace0.0",
>   "mode":"devdax",
>   "map":"dev",
>   "size":"1488.37 GiB (1598.13 GB)",
>   "uuid":"ad0096d7-3fe7-4402-b529-ad64ed0bf789",
>   "daxregion":{
>     "id":0,
>     "size":"1488.37 GiB (1598.13 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"1488.37 GiB (1598.13 GB)"
>       }
>     ]
>   },
>   "align":2097152
> }
> # ndctl enable-namespace namespace0.0
> # echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> <hang>
>
> I tried with and without dax_pmem_compat loaded, but it doesn't help.

I think this is due to:

  a9f1ffdb6a20 device-dax: Auto-bind device after successful new_id

I missed that this path is also called in the remove_id path. Thanks
for the bug report! I'll get this fixed up.
