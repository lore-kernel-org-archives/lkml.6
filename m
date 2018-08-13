Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D4CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B986F21834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgddT8rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986F21834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeHMKpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:45:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38249 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:44:59 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so25754515oie.5;
        Mon, 13 Aug 2018 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3AscIwq+SNp9YZtQLUT3E4ut0FhJpLGjDYw/Eu5Ys0=;
        b=XgddT8rzmXprA0h5Ubcv+/ztfhs6M6is4EoUTk8vyZEa7rjG/kvwb6we0rckZAyn3j
         czW6wYz8X07XVYdE7DrVV5XgfOZGQ6yFhTm2VweQnmzwjGx3X9bvbPZpEP6HUOKFcFRB
         1kjvaLkYSyON062gYTK4aJ6eunmeYUu/CSh30ItG3RUQzRn7RoWcRyQNPej7PvCk4OC4
         cj98IL6o1zvHqktwISMzu+tv58MHAFOpq9Nw1xjWk5MO/mjWijI4BbfO3LOLeGZDMA4K
         f+SB8RJ5Jt0P3EYYxSkxzp8OqEOkraLjLcw6znZJ7vtfboskPHrmt1e19s5eCBlNfvs3
         bCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3AscIwq+SNp9YZtQLUT3E4ut0FhJpLGjDYw/Eu5Ys0=;
        b=XWGs8fuSa17esDQvBmq+SjsbUgId8g1tZcxS1j83dR0StwIbDw6PHdOeUG5ZGVUPW/
         SJOgPxiieWPGF9HVVqDdmx86xdT/KLc1Qxk8DDGuLdbNqtmVvp+DX4lD8AljGSmQ/yiF
         y4IcerBMRwQvIGzdoEc6NbpQ9OTbH5MB9hDme1QJflSHqRhKnajqBgy91ONDYBwZ24Jq
         8J3wzPATokuKOrO2LfyRyAVXwWAmtsFyzGIHXrP9NfSK2ZLLmWlBu+xLm6m0FqodOFaD
         31p4JrfMtyJBmP6k06Vi98KRvuMfyUeyN6ayF5+hWfyPHb9GgSwEKHFSMc/fzwnv2UEF
         /omA==
X-Gm-Message-State: AOUpUlENav6PsAbXaf03cY3BDlLLZrTVjfeWvEczKl03Y0GrPLgwNPN7
        /JQExQzZnhk764rsxxqYKOlguST5rHczc0Kc2JQdGRou
X-Google-Smtp-Source: AA+uWPxcNvOR8FPe2O9CD2P5bmcWE2sNZk9xt6ZPgfh9EAbfxRDtGc67r5OEh40OinShrzm68liXeKcOjzVBp/B8xH4=
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr18101750oih.56.1534147431490;
 Mon, 13 Aug 2018 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180806160933.6578-1-krzk@kernel.org> <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
 <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
 <CANAwSgQBthsKMKBBnKBnCJdKwKOMm0XKRn5r=gnpdbC6Eu9=ag@mail.gmail.com> <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
In-Reply-To: <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 13 Aug 2018 13:33:41 +0530
Message-ID: <CANAwSgRJEcm8LLODKk=K_NsGjRUEXseCK-XXkNCTMoS7znQ9-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,
On Mon, 13 Aug 2018 at 12:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13 August 2018 at 08:37, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Krzysztof,
> >
> > On Sun, 12 Aug 2018 at 18:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 11 August 2018 at 08:39, Anand Moon <linux.amoon@gmail.com> wrote:
> >> > Hi Krzysztof,
> >> >
> >> > These patches should also be ported to u-boot to enable PMIC.
> >> >
> >> > I was just looking into S2MPS11B data sheet
> >> > According to the 1.2 Key Features of  S2MPS11
> >> >
> >> > BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
> >> > BUCK5 have (0.65 V to 2.0 V) min /max range.
> >> > BUCK7 have (1.2 V to 1.5 V) min / max range.
> >> > BUCK8 have (1.8 V to 2.1 V) min / max range.
> >> > BUCK10 have (0.75 V to 1.4 V) min / max range.
> >> >
> >> > BUCKBOST9 (3.0 V to 3.75 V) min / max range.
> >> >
> >> > LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range
> >> >
> >> > LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
> >> > LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
> >> > LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
> >> > (0.8 V to 3.95 V) min / max range
> >> >
> >> > I am aware off we have configures the min/max range as per board schematics.
> >> > but each regulator support dynamic voltage scale and have different
> >> > turn on/off voltage and current rating.
> >> >
> >> > So why are we not setting the regulator-min-microvolt /
> >> > regulator-max-microvolt as per datasheets.
> >> > Please correct me if I am wrong.
> >>
> >> Which regulators are not configured as in datasheet?
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Almost all the regulator have some miss default match of min/max setting.
> > I have tried to adjust the setting on top your above patches.
> >
> > I am attaching my patch diff for testing.
> > I have have perform some stress testing and found no issue at my end.
>
> All the regulators you touched in this patch have proper setting of
> min and max values. They are configured to the values required by
> hardware, as in schematics.
>
> Best regards,
> Krzysztof

Yes I am aware of that. Those voltage range setting from schematics
are for *default on* and *default off* of regulator state.

As per the datasheet description.

*Buck Convertors*
Each buck provides a wide range of output and Buck1, 2,3,4,6 voltage
controlled by Dynamic Voltage scale
(DVS) function through I2C control, Buck1, Buck2, Buck3, Buck4 and
Buck6 have controllable output voltage
range from 0.65 V to 1.6 V, Buck5 has controllable output voltage
range from 0.65V to 2.0V, Buck7, Buck8 and
Buck10 have controllable output voltage range from 0.75 V to 3.55 V
and BuckBoost9 has controllable output
voltage range from 3.0 V to 3.75 V. Ramp slope can be controlled from
6.25 mV/us to 50 mV/us using 2 bits.

*LDOs*
Thirty eight consisted of 31 PLDOs (PMOS-type LDo) and 7 NLDOs
(NMOS-type LDO) and integrated into
S2MPS11. PLDOs are mainly used for higher output volage rangeing from
0.8 V to 3.95 V with 5OmV step.
Their maximum output current driving capacities are 150 mA, 300 mA and 450 mA.

Best Regards
-Anand
