Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42817C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014B620656
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaOvwmvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAIRqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:46:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfAIRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:46:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so4008393pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=qZGotQEuburxq/caVANwpowPOBrrJpBXItg5fTWcVUM=;
        b=BaOvwmvlpeNxfJl/gcNzBk0UdXwX4IT5BPd+/j4XyfXL3BOrCkbgG0hYvoItLxmvSS
         +svk8DUmqTS8hDeF6wOuUI3/DO3nwYRz1HgyXUKUHz82H3JwIACmunag8RBzom8YIRMP
         WfvHvO5qe3OIkMwJ2qiiUgf/IqmAzsE7b4GVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=qZGotQEuburxq/caVANwpowPOBrrJpBXItg5fTWcVUM=;
        b=BfHl1coThtTiszLLtYLF63NBQ6UKpNS8lzwg0BB0IrpNxsdk3usDahYBtm8UPstu6O
         Xz2mneGT+xhofmZb/yQ5PjFj8R4AHWTw8XABgJZPxSJGFiPdiPKTQX97UK7JrCxlE4kE
         ArC0LtkcaWyrqDxqruAm50p/IofR5DQENKoIIalEBLkmi3BZUvpnb64UU7O/oq6qq/Q0
         4u+FCnN8Hkixo94lR9op6fo667GXysnVoo+VV3dRx5po5+fhTaixwLCdeT6MjvZgRfJE
         prjKuXrpRCs0rsSDT3nHIxExfsUo6ECcMDQ0BsSEnT1AdHAZaW1bs6wJI+nO305LfCub
         eK+g==
X-Gm-Message-State: AJcUukfOZOH2aioI8bEWSgzREkgDxIwQz2iVBtHoiUvczxRvbLYIYVn/
        KtBdj0iHPg2/EOyHmUe65rr4vg==
X-Google-Smtp-Source: ALg8bN5s5NPz/QOem5vtfETjDtU2kjVoF6MJpAiYyfZUjiRY4yDFaVsmQC5OhMKf4T06+gib54+SPg==
X-Received: by 2002:a62:5910:: with SMTP id n16mr6803283pfb.128.1547056006435;
        Wed, 09 Jan 2019 09:46:46 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d3sm93120756pgl.64.2019.01.09.09.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 09:46:45 -0800 (PST)
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
In-Reply-To: <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org> <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com> <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org> <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com> <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org> <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
Message-ID: <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 09:46:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P L S S S N (2019-01-08 21:34:32)
>=20
>=20
> On 1/7/2019 9:47 PM, Raju P L S S S N wrote:
> >=20
> >=20
> > On 1/4/2019 2:49 AM, Stephen Boyd wrote:
> >>
> >> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so th=
at
> >> we can use the sysreg based timers and ignore the MMIO based timers
> >> here. This isn't a very important distinction to make though, so if you
> >> have to use the MMIO timers then it just means some extra DT things ne=
ed
> >> to be done to relate the MMIO timers with the RSC that has the timer
> >> that needs to be programmed too.
> >=20
> >>
> >> Either way we would need a way to either hook the ARM architected timer
> >> driver in the kernel, or reimplement the bit of code needed to impleme=
nt
> >> the clockevent based on the ARM architected timer that programs the ARM
> >> timer and the PDC timer together.
> >>
> >=20
> > Could you please provide some more details on the implementation?
>=20
> Hi Stephen,
>=20
> Regardless of implementation options about application processor=20
> subsytem PDC timer, I think there is a need to differentiate the fact=20
> that for application processor subsystem PDC timer programming is done=20
> by SW but not for display processor subsystem as HW sleep solver takes=20
> care of PDC timer during sleep entry/exit. How about having a dt=20
> property like qcom,pdc-timer-mode =3D "solver"/"sw" ? The current patch=20
> introduced client based model using regmap to achieve this=20
> differentiation between these two subsystems. By using the dt property,=20
> once rpmh-src driver instance for application subsystem can have PDC=20
> timer programing implemented. Let me know if there is another way.
>=20
> For implementation of PDC timer, I see the following based on above=20
> discussion -
> 1. Take the existing cpu_pm_notify approach and move the current series=20
> approach of programing PDC timer registers to RSC driver. This wouldn't=20
> involve any changes in clock_event_framework/broadcast framework.
>=20
> 2. Add api hooks (like reading the next wake up programmed) to ARM=20
> architecture timer driver so that the value is copied to PDC timer using =

> the api with in RSC driver based on cpu_pm_notifications.
>=20
> 3. Changes in clockevent to program both ARM mem timer & PDC timer=20
> together. Could you please share some more details on this?
>=20
>=20
> Please let me know if the first approach is ok.
>=20

The first approach requires that we expose internals of the clockevent
and broadcast timer information to drivers. From my perspective it looks
like a weird kludge to workaround the fact that the broadcast timer
doesn't actually work on this platform. That's why I'm suggesting that
you fix the broadcast timer on your platform to actually work, and do
that within the clockevent/broadcast layers instead of indirecting that
through cpu_pm notifiers.

That could be done by making a PDC clockevent that has some DT binding
of a property pointing to an MMIO timer frame and then reimplementing
the MMIO timer code in the PDC driver on top of the frame/register
region it pulls out of there. Or it could be written in reverse by
having the generic MMIO timer driver point to the PDC somehow and
implement some platform specific API to pass that information to the
real wakeup programming part in PDC.

I'm leaning toward the first approach where PDC is the clockevent and
that uses the MMIO timer on the backend to do what it needs to program a
wakeup. That way you can mandate the usage of the physical timer and
keep this quirk away from the ARM timer driver. It also makes the idea
of a qcom,pdc-timer-mode sort of useless because the PDC will have a
property that points to the timer frame and that will mean "use this for
broadcast wakeup". I'm not sure how the ARM folks feel about this
though. It would probably require some sort of ARM timer API that lets
us program the MMIO timer frame from the PDC driver. So exporting
arch_timer_reg_write() and making that always inlined to optimize hot
paths would be required.

