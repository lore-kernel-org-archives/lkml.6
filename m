Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C632184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CupanXzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfACVTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:19:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35788 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfACVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:19:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so16424297plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=xVgIvqBLxtUuAr9V9fm1GjndM8iSA6uw8jisBjx+3Xs=;
        b=CupanXzSWpE4ukFfspPLI3CpraEG49S19t0LLFt9FzRVAfMl5J39695HowN9GUEFUg
         F/UGn8Xh/My+MN3jfWTdEXwO/qvoE8Ykym5jUxXwBcSgNX+FgWjwMdYh1IMVlrtki4OJ
         mQggz5QSZ8/ogZdmiONlRX55mDx9hMBfK4780=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=xVgIvqBLxtUuAr9V9fm1GjndM8iSA6uw8jisBjx+3Xs=;
        b=KEHE9B/vOVc6oJ0rc6QdaOVl6OHI6XU6m1GVHffgyRIsBxEVaD9PxEp3gluOvXmROG
         EsfJ+5FpXVfACE7dGqT5Bpirgqg48ILdnGq+9uzHFtDVxxbj+uR6DKQt6UYE4I3rkxtQ
         zqhAKCsy9IAlF65XzcWV9258Q+cfMd8FRYalGhbe1gKvjsqCF9ZQH4aj1Qtl7qBgdLoX
         azTblEY6IqSqInid2bZjWix91673U4ZlXaP2sFndhdlgNwkQqJj1U1PtJmrb+OxTopDU
         IrQjlRbI6gwdLjJrp4ebfQZQ3CZvmEpDIPzZIu6qVkZEKMBSUVssERpT/eNOPj8IbjLb
         /XjQ==
X-Gm-Message-State: AJcUukdDtW2E2otwmhSyN7Ka7JxmmOuQaJa6y9wrBYuFkWcEOFNXfFHD
        YLADJQdGGCQ63lBPY8LdRPkofw==
X-Google-Smtp-Source: ALg8bN6RGw4l6+1tWm+FCG6pwfZEjT3ISR0sX05GZnK7OtvMDF3LqufijEwvyc9VPL8x6L6/5BskCQ==
X-Received: by 2002:a17:902:a83:: with SMTP id 3mr45750604plp.276.1546550373863;
        Thu, 03 Jan 2019 13:19:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g26sm73563691pfh.61.2019.01.03.13.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:19:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
In-Reply-To: <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org> <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com> <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
Message-ID: <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 13:19:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P L S S S N (2019-01-03 04:22:58)
>=20
> On 12/29/2018 3:08 AM, Stephen Boyd wrote:
> > Quoting Raju P L S S S N (2018-12-26 01:44:43)
> >>
> >> There are two RSC devices in SoC one for application processor subsyst=
em
> >> & other display subsystem. Both RSC contain registers for PDC timers
> >> (one for each subsystem).
> >=20
> > When is the timer programmed on the display subsystem's RSC? It's hard
> > to give advice without all the information.
>=20
> For display subsystem RSC, hardware sleep solver takes care of timer=20
> programming for wakeup when the subsystem goes to Power collapse.

So the display subsystem doesn't need to program their PDC in their RSC
from software?

> >=20
> > I would think that it would make sense for the application processor's
> > RSC timer to be programmed from the broadcast timer mechanism in the
> > kernel so that timers during idle work and suspend turns off the timer
> > appropriately with a shutdown hook. I guess the PDC can't tell you the
> > time though? It looks like a shadow (and limited) version of the ARM
> > architected MMIO timer that we already program for the broadcast timer
> > mechanism. Is that because even the MMIO timer can't wakeup the system
> > in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
> > always be used as the system wide broadcast mechanism because we need to
> > augment it with the PDC timer to get the actual wakeup.
> >=20
>=20
> Yes. this is correct.
>=20
> > Maybe we should be adding hooks into the broadcast timer mechanism to
> > program this wakeup event hardware in addition to the ARM MMIO timer. Or
> > we should stop using the ARM MMIO timer on these systems and read the
> > system register based physical time in the RSC timer driver and register
> > this 64-bit PDC register as the broadcast timer. So the time reading
> > would be through sysreg and the wakeup programming would be done by
> > writing the PDC timer. The assumption would be that we have access to
> > the physical time registers (which sounds like the assumption we have to
> > make).
>=20
> There are no physical timer registers available in RSC for this purpose.
>=20
> >=20
> > Do we get an interrupt somewhere from the RSC hardware when the timer
> > fires? Or does that just cause a system wakeup event without any pending
> > irq and then another irq (like the ARM architected timer) just happens
> > to be pending around the same time? If we get an interrupt somehow then
> > I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
> > timer approach.
>=20
> There is no interrupt for PDC timeout. It just causes system wakeup=20
> without a pending irq. ARM MMIO is necessary for irq.

Does that system wakeup cause the CPUs to be enabled? So the sysreg
based timer in the CPU would start working? Or does it only make the
system come out of a deep enough idle state to make an always on domain
work that only contains the MMIO based ARM architected timer?

I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
we can use the sysreg based timers and ignore the MMIO based timers
here. This isn't a very important distinction to make though, so if you
have to use the MMIO timers then it just means some extra DT things need
to be done to relate the MMIO timers with the RSC that has the timer
that needs to be programmed too.

Either way we would need a way to either hook the ARM architected timer
driver in the kernel, or reimplement the bit of code needed to implement
the clockevent based on the ARM architected timer that programs the ARM
timer and the PDC timer together.

>=20
> >=20
> > How the RSC is used in general by other devices, like display, is not
> > clear to me. We don't have a "wakeup event" framework in the kernel that
> > device drivers like the display driver can grab a reference to and
> > program some system wide wakeup for. That sounds like something new that
> > could be handled entirely in the display driver with direct register
> > writes, or it could be some qcom specific API/framework that eventually
> > calls down into the same RSC driver that knows what offsets to write
> > into in the display RSC's register space, or it could be an entirely
> > generic framework like clk or regulator frameworks that could be used by
> > anything. BTW, are we using the display RSC yet?
> >=20
>=20
> Only display subsystem RSC is programmed along with CPU RSC in Linux.=20
> display RSC instance is not present in upstream but it is present in=20
> downstream and used for resource communication purpose only.

From the comment above it sounds like the display RSC handles the wakeup
programming in hardware? So there isn't a need to add a 'wakeup event'
framework or anything like that. Please correct me if I'm wrong.

