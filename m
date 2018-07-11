Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E35C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A64820864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX11QY1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A64820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeGKLDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:03:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44613 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732568AbeGKLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:03:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so48429546oih.11;
        Wed, 11 Jul 2018 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9RbvnIfsNpNCRJraShjFi/kCxZDAxi/fnL29ZTIgm3U=;
        b=PX11QY1OTzS7ZqQSVIy5j7VwplY/pjmkZpgRypq9gexnHzqswitqBRLQA/8j+8ZskY
         OpjNxDqU/jhnyM53lB9qcsfxbov/yQjH08JxKG+OmUO3zP7plV2zvpMk4MN7fLUzHHHN
         iXZF/1xC2GuLKl19NWpHWvCf7Y1dyvkxvYmchWmgcrRkPyqLSHNt6X8gZD7R+68VUHhQ
         xODT/7ommdg3wtw3hsr1s0OJqA3xQFcVasSjDqiWr7C+noeIjJE343tL6Lbk4gQwPcAB
         SK/J7vGJtRmP1TtLTL7InQwBYlixga2GVTV2lWISSJYU5VNyn3OPC3Z4ZDZkxONiKG0h
         VKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9RbvnIfsNpNCRJraShjFi/kCxZDAxi/fnL29ZTIgm3U=;
        b=J67BIwF2sS5r6fq3Bw55Wpa4EqsliU6JWilZqcPmAjfT8UrF/ZD02GdSHHGM5LWtlP
         OyDX3CZ520VjMRZBm6N8P9oLCMvR9s4LJCM31JPvT+lH1OU2jWcpNP1+E7qsA1p/aysX
         r6CwSlNWeaUazJnGjxEZlbEExPuSQNRzF9Tn4Plfn+yijsJ6OnU8qPQ6AL0oFGkoZ6dG
         XBwLRL3FPdM4gdPw/XILnt8qs/LycKCWXIqtFbve0FSAVySdC5zLjX7/LBGN8I2EkZWR
         KZqIqCq7PUdhILeGwGrPPkxwyyQIgF7RNRtaD7iZuSakLEF/679ct+qqYXgRQ+U1zXU+
         l95w==
X-Gm-Message-State: APt69E09R+ePk0RxOhuxDla2KmMdH3B8DOpj+zSD5hvddHcOTVb6FV+p
        YFgsyESBPJ8Jk6EgW8xtLZdDTA1hD6nkdz5gqpI=
X-Google-Smtp-Source: AAOMgpeKqRnyUr7eqeXbK6zTt8AUOMKKKGKEtS+iP5wrOC6lNOLTO8aHeJchJCjTYUk5DzTZGprKPUHiFBPdXpcGOA0=
X-Received: by 2002:aca:ef44:: with SMTP id n65-v6mr30060830oih.120.1531306777801;
 Wed, 11 Jul 2018 03:59:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 03:59:37
 -0700 (PDT)
In-Reply-To: <CAAFQd5COVfXRBuq2ofHoOvNb+cMVmAFDaekh5KM4DBB1ZEf5pA@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-3-vivek.gautam@codeaurora.org> <1694664.FhRBrgajmF@aspire.rjw.lan>
 <CAAFQd5COVfXRBuq2ofHoOvNb+cMVmAFDaekh5KM4DBB1ZEf5pA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jul 2018 12:59:37 +0200
X-Google-Sender-Auth: vRBUtqWz_ABZG4zPY4EtEGS9gkM
Message-ID: <CAJZ5v0hMQJQ0Z-H2OLaeCdT+-MW_eSWmg7saVzkpDqJ-=i3DnQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:05 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Rafael,
>
> Thanks for review.
>
> On Wed, Jul 11, 2018 at 6:53 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Sunday, July 8, 2018 7:34:11 PM CEST Vivek Gautam wrote:
>> > From: Sricharan R <sricharan@codeaurora.org>
>> >
>> > The smmu device probe/remove and add/remove master device callbacks
>> > gets called when the smmu is not linked to its master, that is without
>> > the context of the master device. So calling runtime apis in those places
>> > separately.
>> >
>> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> > [vivek: Cleanup pm runtime calls]
>> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> > ---
>> >
>> >  - Change since v11
>> >    * Replaced pm_runtime_disable() with pm_runtime_force_suspend()
>> >      to avoid warning about " Unpreparing enabled clock".
>> >      Full warning text mentioned in cover patch.
>> >
>> >  drivers/iommu/arm-smmu.c | 92 +++++++++++++++++++++++++++++++++++++++++++-----
>> >  1 file changed, 84 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> > index a01d0dde21dd..09265e206e2d 100644
>> > --- a/drivers/iommu/arm-smmu.c
>> > +++ b/drivers/iommu/arm-smmu.c
>> > @@ -268,6 +268,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>> >       { 0, NULL},
>> >  };
>> >
>> > +static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>> > +{
>> > +     if (pm_runtime_enabled(smmu->dev))
>>
>> Why do you need the pm_runtime_enabled() checks here and below?
>>
>> pm_runtime_get_sync() and pm_runtime_put() should work just fine if
>> runtime PM is not enabled.
>
> Because pm_runtime_get_sync() acquires a spin lock, even if only for
> the short time of checking if runtime PM is enabled and SMMU driver
> maintainers didn't want any spin locks in certain IOMMU API code paths
> on hardware implementations that don't need runtime PM, while we still
> need to be able to control runtime PM there on hardware
> implementations that need so.

OK, so it is an optimization.  It would be good to put a comment in
there to that effect.
