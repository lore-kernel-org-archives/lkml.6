Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7372C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8296020861
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMLKpvwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeL1Via (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:38:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40366 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeL1Via (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:38:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so10924573pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:message-id:references
         :subject:cc:from:user-agent:in-reply-to:date;
        bh=NLDRg8d3P3g0015PxnCaL0q7vIF2U2AakIDHRtQEgcM=;
        b=WMLKpvwMb+vkyQWUm24xoSbGH6GsvRBrNeY4IZ8EJnN2uD4d6jYbV0pfLa57wmO5m5
         hG7vbl8fPOBZbg5fRrysph0bLPC4Gp5js9hpXb/A4KaLiIF/hi/3Z1/mE+fIq3XUoGWz
         RMKaVKDFdRWhVbWYtndw8uO0AJ4SmdVw7/2c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :message-id:references:subject:cc:from:user-agent:in-reply-to:date;
        bh=NLDRg8d3P3g0015PxnCaL0q7vIF2U2AakIDHRtQEgcM=;
        b=dI3BopC91zACtZfRah43fEqRYUhv2QRReEPsdx85Sjmymn7iCeDy9EUlZWXXGTtIEa
         8Ak1CjcGYcmHdl2O2qjKDaUsOaJoilyayyxZ5OWGfZ885V0xd0zuHrUtvyD4qTvUP3yl
         yzji/RQemX6aTWWeUhcbWg2lGlKg6l3dpCT3fazwcgg4xSMLpUrS6RsjGvD7pqFpu2qz
         72va1R/yJ2kDwOKYcKxoot3SJbTdwRsxKIcibLyimzO9GrasuzIsu/cGijXYVQ08Jp6U
         jIQfOtX4tW1Z9IgSREj7ghKn+pxUxcc2GAtpq72Ei5jgZwdcMKmLkhczM5rJPkLM3Stz
         NNUw==
X-Gm-Message-State: AA+aEWYGrs7Gr1BFAn37F1Xbq1vYYf+YBx1K+xMFBX7xJKORG1P7uncQ
        bLGl146OKH/CBbA9AEJ7jk5ceA==
X-Google-Smtp-Source: AFSGD/XqPjsUb/JfrS+qCKtXNHaLkd+ERTq3bD6qUBzo0Fh7aqQvuKQ+qt2qm3y/fftdftZw605qJw==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr29863361pfd.90.1546033109141;
        Fri, 28 Dec 2018 13:38:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s9sm57225203pgl.88.2018.12.28.13.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 13:38:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Message-ID: <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
In-Reply-To: <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
Date:   Fri, 28 Dec 2018 13:38:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P L S S S N (2018-12-26 01:44:43)
>=20
>=20
> On 12/22/2018 1:09 PM, Stephen Boyd wrote:
> >> +If an RSC needs to program next wake-up in the PDC timer, it must spe=
cify the
> >> +binding as child node with the following properties:
> >> +
> >> +Properties:
> >> +- compatible:
> >> +    Usage: required
> >> +       Value type: <string>
> >> +       Definition: must be "qcom,pdc-timer".
> >> +
> >> +- reg:
> >> +    Usage: required
> >> +       Value type: <prop-encoded-array>
> >> +       Definition: Specifies the offset of the control register.
> >> +
> >>   Example 1:
> >>  =20
> >>   For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id=
 of 2, the
> >> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
> >>                        <0x179d0000 0x10000>,
> >>                        <0x179e0000 0x10000>;
> >>                  reg-names =3D "drv-0", "drv-1", "drv-2";
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <1>;
> >> +               ranges;
> >>                  interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> >>                               <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> >>                               <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
> >>                                    <SLEEP_TCS   3>,
> >>                                    <WAKE_TCS    3>,
> >>                                    <CONTROL_TCS 1>;
> >> +
> >> +               pdc_timer@38 {
> >> +                       compatible =3D "qcom,pdc-timer";
> >> +                       reg =3D <0x38 0x1>,
> >> +                             <0x40 0x1>;
> > I don't understand this whole binding. Why can't the pdc timer be
> > programmed within the rpmh driver? This looks like a node is being added
> > as a child just to make a platform driver and device match up in the
> > linux kernel. And that in turn causes a regmap to need to be created?
> > Sorry, it just looks really bad.
>=20
>=20
> There are two RSC devices in SoC one for application processor subsystem =

> & other display subsystem. Both RSC contain registers for PDC timers=20
> (one for each subsystem).

When is the timer programmed on the display subsystem's RSC? It's hard
to give advice without all the information.

> But only for application processor the PDC=20
> timer needs to be programmed when application processor enters=20
> sleep/suspend. As the driver is common between both RSC devices, this=20
> approach is taken. Do you have any other suggestions to distinguish=20
> between the two? Perhaps, by additional compatible string?
>=20

Maybe compatible? I sort of doubt it though. Do all RSCs have a PDC
timer?

I would think that it would make sense for the application processor's
RSC timer to be programmed from the broadcast timer mechanism in the
kernel so that timers during idle work and suspend turns off the timer
appropriately with a shutdown hook. I guess the PDC can't tell you the
time though? It looks like a shadow (and limited) version of the ARM
architected MMIO timer that we already program for the broadcast timer
mechanism. Is that because even the MMIO timer can't wakeup the system
in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
always be used as the system wide broadcast mechanism because we need to
augment it with the PDC timer to get the actual wakeup.

Maybe we should be adding hooks into the broadcast timer mechanism to
program this wakeup event hardware in addition to the ARM MMIO timer. Or
we should stop using the ARM MMIO timer on these systems and read the
system register based physical time in the RSC timer driver and register
this 64-bit PDC register as the broadcast timer. So the time reading
would be through sysreg and the wakeup programming would be done by
writing the PDC timer. The assumption would be that we have access to
the physical time registers (which sounds like the assumption we have to
make).

Do we get an interrupt somewhere from the RSC hardware when the timer
fires? Or does that just cause a system wakeup event without any pending
irq and then another irq (like the ARM architected timer) just happens
to be pending around the same time? If we get an interrupt somehow then
I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
timer approach.

How the RSC is used in general by other devices, like display, is not
clear to me. We don't have a "wakeup event" framework in the kernel that
device drivers like the display driver can grab a reference to and
program some system wide wakeup for. That sounds like something new that
could be handled entirely in the display driver with direct register
writes, or it could be some qcom specific API/framework that eventually
calls down into the same RSC driver that knows what offsets to write
into in the display RSC's register space, or it could be an entirely
generic framework like clk or regulator frameworks that could be used by
anything. BTW, are we using the display RSC yet?
