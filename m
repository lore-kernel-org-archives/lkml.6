Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583AFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137AD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TsW68N7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137AD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeKGOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:21:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39965 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbeKGOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:21:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so18702001qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 20:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66iO6eqnNSy8JBU5cn5dTMpThpzQ1gx8xxWfeIvk2gk=;
        b=TsW68N7KD7q79tDD4V53hxqL8zxIjL/+H7dWvGWzGoC3kSjvBkMxkr2sfx7RaTD0WJ
         KZjHOFvfmMC3ugv5xtff+oLpuM9ki3ow+/WKReQBuwW9RN73wGlYe4OkZ3CIgJ/Cjlvq
         Ok+DYsd7NI8/yYtj+GsnB9YdO0gS4tXRjQM8rHBDkmRDiQDya6AdE3Gva73VTg911gP9
         On3QEyHoK8sMWH6n55FaTim1PssuXWXMKpNM1tM4k1x5jSCSBSqszALFhJeVrpmg/LGi
         XPwnU6Zh+B1pHUFHELtR2Y76XSZLjDHwpBe9QD2uhLozZBBjXZyZkui0qo9/uKPynTvn
         144g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66iO6eqnNSy8JBU5cn5dTMpThpzQ1gx8xxWfeIvk2gk=;
        b=ttMufxiVLJxr/TPJRianFIxNYhFjZyHvgB3pNaHhtGGSCpEuM0ws5rW/jenQTprrj1
         kQkaMQP7ccm3Mx3heuJCoQqZR70bvib82068orWCPk4+YK3a8XABAdF99OclmM5t460Z
         re1Yg4I5eTyreqEjpwsybQJKDj5mhWA3l5oXZbu8XG7Qy7AHY5FB2FN219hf2iMOQo0w
         k/6KbfpFIXEIHYiFSPAlXOAhlEGrMoKIFzleNYV84sN49JwbTJcQUmmFXb1fDhYtk2Js
         Uqf6AF2xBtoEdZQO7XUpxO2+zcwl9NTVWjW1fuFIeYAYuMmWktKAJKFYN4ngElb2DYq7
         8z6Q==
X-Gm-Message-State: AGRZ1gJU68JLWmDHxIK5H7c//7O0wHIRCGZtUk3CjUjk9TGHLasZ5zjK
        9qaQs/BnGml6TzqFVEqFVtLh6gFNxHj+RKjpF3B5PQ==
X-Google-Smtp-Source: AJdET5fKlDzZps5RcJmlECR/jJWzS3eHqwXE6Z+kvPuKj2bVjlecFO981JB+u/G9EDnkeKA48ORvFVU5oJtMOE++gO0=
X-Received: by 2002:a37:b881:: with SMTP id i123-v6mr338562qkf.290.1541566394941;
 Tue, 06 Nov 2018 20:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
In-Reply-To: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 7 Nov 2018 12:53:03 +0800
Message-ID: <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     pavel@ucw.cz, Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        sebastian.reichel@collabora.co.uk,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessm.com,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> Plus, I don't think "100% charge" is right test for "battery full". At
> least on thinkpads, there's configuration option, and it is common
> _not_ to charge batterry above 95% or so (to increase its lifetime).

Hans also touched on this area in his response:

> As for this kernel-side fix I do not believe that fixing thus in
> the kernel is the right thing to do. We try to stay away from
> heuristics using full_charge_capacity in the kernel since that
> is not really reliable / deterministic.

I'm not fully convinced by this argument though.

The ACPI spec is not very clear on what conditions you should apply to
decide when the battery is full. Instead, ACPI seems to provide a
pretty decent amount of data, and the decision about whether to
interpret that as "battery full" is left for consumers.

The best that the ACPI spec offers here is the _BIF/_BIX "Last Full
Charge Capacity" field (known as full_charge_capacity in this driver),
and it does appear to consider the "only charge to 95%" consideration,
although it is only documented as a prediction. There is also a sample
calculation (section 3.9.3) of how to calculate the Remaining Battery
Percentage which uses "Last Full Charge Capacity" too.

Without a crystal clear definition of battery full, it seems up to the
consumers of the data to decide when the battery is full via some form
of heuristic. And this is exactly what acpi-battery already does in
acpi_battery_is_charged() - and the main aspect is looking at
full_charge_capacity. The result of this is then sent to userspace.

So it does not seem fair to say that "you can't use basic heuristics
around full_charge_capacity" because the kernel already does (and this
is what the ACPI spec encourages), although JP's patch could be
improved to more clearly and more completely follow the logic in
acpi_battery_is_charged().

The question of whether we would want to interpret the numbers in this
way when DISCHARGING is set is a good one though. The ACPI spec
doesn't shine much light on this, but the calculations related to
battery percentage and battery life in section 3.9.3 at least do not
seem to consider charging/discharging status.

Thanks
Daniel
