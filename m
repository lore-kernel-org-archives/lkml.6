Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5209C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6962F2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qo+XbdCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6962F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeJLR5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:57:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44381 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeJLR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:57:02 -0400
Received: by mail-io1-f67.google.com with SMTP id x26-v6so8841114iog.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hOmkp6nxpb2GFJrbo44QR9f/eZgILoKGR0zOClkbSBU=;
        b=Qo+XbdCD7CLI+gL1svhgU3yRraIBVNKxIqHVUHsaB0RcSLE/0pvSZf/98lruUQcrGV
         Wyrpe1Au2PA/Pu8RGro324tmvfrizI7jyogNaFnQrtK7nM5DTeK/Fm9OjusVnt2+aSUD
         oIC92GpHXciCrdoyXatDmH7dS4rN0UxFPHKsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hOmkp6nxpb2GFJrbo44QR9f/eZgILoKGR0zOClkbSBU=;
        b=dPB1DxaD6coF+jC8d7HsIKdkKDjqHENeYSAtDGsKT2K5/v4TYG4L1YMWWgvRJOThCN
         HUralSPEKQyIhR/3yzjJg5CH2BKyqYIJPzhfBkAIejB+hrB+Sxkio3byHNcGhGrqm35f
         uwAYFJRYUrSjEDQnB3tG4/9C9Gs1BzFIka1ewx+3RO6Oi2J8y3/jvZzjKd4oIqCX/s0C
         bYtVqpLUvaeO0m9vexLh5wyhCWI3YljATZtRiHN5dM+CV0oqg9kg41YMT5cGQSOIY7Qr
         5bgxPUXpsvYCLUtn/dFHrv58W8RoVTrpb6fXn50MSFum+A4si3uKqndUG76kWYBCmLFb
         Fq/w==
X-Gm-Message-State: ABuFfojD5XRx1PEAXRvvLwfM9L1rJ/alUbCdldk2DciXxj1hfkUuvoM1
        zLto7z2YTmJqmFQg2Phuf60kTW4ps9KJmQW0fmeJvw==
X-Google-Smtp-Source: ACcGV62NZBad6pgkuJ13VqtTLH4hFiJwWh01lUnD+6t3GkoHmzS4no1luNwf/0OyxNOZPuO/abgIsjLLbzPD979X8VE=
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr3667961iou.218.1539339918382;
 Fri, 12 Oct 2018 03:25:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 03:24:37
 -0700 (PDT)
In-Reply-To: <20181012101330.GA31003@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org> <20181010150312.GA4844@e107155-lin>
 <CAPDyKFqP3wbd+5rvLcscNf1LUSZDROLqafsLq0Kyh0KziRJrZQ@mail.gmail.com>
 <20181011164126.GD28583@e107155-lin> <CAPDyKFq3=E=qDkozsu-MupEL_Efpdq62Z3aMWwGQWc+OdzPq8w@mail.gmail.com>
 <20181012101330.GA31003@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 12:24:37 +0200
Message-ID: <CAPDyKFq3k0o=cMyLy0YpcRtJZYpadrmwvU+zBDYRPoS+MOz+ug@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 12:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Oct 12, 2018 at 11:43:11AM +0200, Ulf Hansson wrote:
>> On 11 October 2018 at 18:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
> [...]
>
>> > Yes, nearly there. Just thought good to add a note that the representation
>> > has no affinity towards any PSCI idle state mechanism(PC or OSI). So
>> > that it's never assumed or misunderstood.
>>
>> I understand your point. However, I think the following sentence still
>> makes sense (exist in the suggest change above).
>>
>> "In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order
>> to use it, the hierarchical representation must be used."
>>
>> How about if I add: "For the default platform-coordinated mode, both
>> representations are viable options."
>>
> I would also add couple of things, how about this order:
>
> In PSCI firmware v1.0, the OS-Initiated mode is introduced. However the
> flattened vs hierarchical DT representation of power domains is orthogonal
> to OS-Initiated vs platform-coordinated PSCI CPU suspend modes and
> should be considered independent of each other.
>
> The hierarchical representation helps and makes it easy to implement
> OSI mode and OS implementations may choose to mandate it.
>
> For the default platform-coordinated mode, both representations are
> viable options.

This looks great! I am adding it to the next version, thanks!

Kind regards
Uffe
