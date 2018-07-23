Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZo7lM6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGWMGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:06:04 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46660 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbeGWMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:06:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so334256oie.13;
        Mon, 23 Jul 2018 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ton6pKvBMzlj6Yxp4xH2NbHluH0yhZIzSva9jrGH6JE=;
        b=HZo7lM6ndYYxf3IKHzT7FiipuEQMNMc5Tl5KFsanpuuifOLdioUhuwh5K/syrqhzMm
         WZo50Jj0ha7fC/QYtGP510qLsx3PETw7LF0FHJ9D9nO9nXFnr2Ir3ltAASdFJDigs6Ep
         j3yN9qH0UTrWAMzXnrVnA69KAVBLvX/zbwLQkZomnHxYYatRoPvrH+PdBI5/HkDqCNRF
         vfFdihvg7W985tU4tOZDPup7MQqV5E901ZuJbYtNJ5030bHFVz8NpKPRofeqa+g5qrqJ
         n2DFVKzhjTqo/whcda190KWxl+z2zTBnHJUaRi8AHPT5fhO9J+xq+jcn8CTZyeogDsVx
         a4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ton6pKvBMzlj6Yxp4xH2NbHluH0yhZIzSva9jrGH6JE=;
        b=Zal3WHrsIR4kcO1aKxP9yBVXFzUhOEv3Ilm8+3/LNfUvi7C2t8kX2LWlUYNKnuPhdh
         RP34xYuQ/uNlR/RRkE+IXFXdOxRDXgEcuBZTpvJqYGoe2yA+7qKsmSZdktmNOvcADtXq
         dCd9Ks3QAWG8TooLU54++3VdZlSL98jUealGS+WXDlGvG+HkyW2Pdzv572AXjuBsI7v4
         1ZkMRIPsHGeEZ/K8Pgf820oqCZbyNn09zTHByhXM25Xw+fZZgq9apDwu/JYPvIB14d5W
         XJwJe8X1i/qMEi1K17y5AqGyq8DXTOOAiSMOR/APSSYDU49k4eLkXesYLyMDbD/n4pPu
         fPQA==
X-Gm-Message-State: AOUpUlGpRHkiJeig7C99dBxPOsYWJCyoPzgUnzyb5WjXnTbBNSmqpklx
        2HrJ+HXgn2NsNCdRA7kaSarwm68Qk8kd8Z+02/M=
X-Google-Smtp-Source: AAOMgpc8o2RJ1fODjkE2iWeLbu4gro+8TqVfBTJQcxJrFbj5ZI74jdcVmV0Cq0u9cbRBMxW2X1uAVtB/o9ry4Gcdm08=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr7602356oig.282.1532343923385;
 Mon, 23 Jul 2018 04:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 04:05:22
 -0700 (PDT)
In-Reply-To: <20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R@eucas1p1.samsung.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
 <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
 <CGME20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f@epcas1p3.samsung.com>
 <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
 <20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
 <CAJZ5v0g0NwkLmd=tJ0sT4pc8FJSRE8sEu5GRQ7KUUd+YedzjMg@mail.gmail.com> <20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R@eucas1p1.samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jul 2018 13:05:22 +0200
X-Google-Sender-Auth: kaFIJNmll-EVST0uWQJWiy6_Nmk
Message-ID: <CAJZ5v0h4FLhMJY0fg5q0vBewnNssmpvXHzADg=iDFSfq6Dg=rw@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 7:59 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Rafael,
>
> On 2018-07-11 22:36, Rafael J. Wysocki wrote:
>> On Wed, Jul 11, 2018 at 3:40 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:

[cut]

>>> Frankly, if there are no other reasons I suggest to wire system
>>> suspend/resume to pm_runtime_force_* helpers:
>>> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>                           pm_runtime_force_resume).
>> Not a good idea at all IMO.
>>
>> Use PM driver flags rather I'd say.
>
> Frankly, till now I wasn't aware of the DPM_FLAG_* in struct dev_pm_info
> 'driver_flags'.

They are a relatively recent addition.

> I've briefly checked them but I don't see the equivalent
> of using SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume): keep device suspend if it was runtime suspended
> AND really call pm_runtime_suspend if it was not runtime suspended on
> system suspend.

DPM_FLAG_SMART_SUSPEND is expected to cause that to happen.  If you
want the device to remain in suspend after the system-wide resume from
sleep (if possible), you can set DPM_FLAG_LEAVE_SUSPENDED for it too.

Currently a caveat is that genpd still doesn't support the flags.  I
have patches for that, but I haven't got to posting them yet.  If you
are interested, I can push this work forward relatively quickly, so
please let me know.

>>> This way you will have everything related to suspending and resuming in
>>> one place and you would not need to bother about all possible cases (like
>>> suspending from runtime pm active and suspending from runtime pm suspended
>>> cases as well as restoring proper device state on resume). This is
>>> especially important in recent kernel releases, where devices are
>>> system-suspended regardless their runtime pm states (in older kernels
>>> devices were first runtime resumed for system suspend, what made code
>>> simpler, but wasn't best from power consumption perspective).
>>>
>>> If you go this way, You only need to ensure that runtime resume will also
>>> restore proper device state besides enabling all the clocks. This will
>>> also prepare your driver to properly operate inside power domain, where it
>>> is possible for device to loose its internal state after runtime suspend
>>> when respective power domain has been turned off.
>> I'm not sure if you are aware of the pm_runtime_force_* limitations, though.
>
> What are those limitations?

First off, they don't work with middle-layer code implementing its own
PM callbacks that actually operate on devices (like the PCI bus type
or the generic ACPI PM domain).  This means that drivers using them
may not work on systems with ACPI, for example.

Second, pm_runtime_force_resume() will always try to leave the device
in suspend during system-wide resume from sleep which may not be
desirable.

Finally, they expect the runtime PM status to be updated by
system-wide PM callbacks of devices below the one using them (eg. its
children and their children etc) which generally is not required and
may not take place unless the drivers of those devices use
pm_runtime_force_* themselves.

So careful there.
