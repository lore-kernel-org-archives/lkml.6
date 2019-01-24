Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65872184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ns8ID2vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfAXGWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:22:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34653 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAXGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:22:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so2437065plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 22:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:references
         :user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=71P07PYPD7gMv3gkFeZB5gMBwQrgeUtIdV0bw/aTj/Y=;
        b=Ns8ID2vok6/3LKtUW0NtmNZ/MJenF+4MCV0YrELz7f1ink7r3YYDRtm73qTotxFvTA
         pydAuVKLQuL/3wpYRGA6BjPmjgL0AEyn6I7h7mMCzTao8xkmGWtQ3gOYrWXvRTgQCo+9
         UHOOmbg1CTH4+zjb2+dlgGHR/q3TQWAOXhjd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :references:user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=71P07PYPD7gMv3gkFeZB5gMBwQrgeUtIdV0bw/aTj/Y=;
        b=GAXn9H8ILV7dlrO94yzB2lHqgeOfh/ydrvuKREZInyhyQM2c8u9cVduETFts8+7DQw
         rwa8Vz8QkxOuzS3T1dzgRGWcLazKbtq3tN+e38DKN71jWV6DpHBI4cL+rm99zN3MytW+
         23ohm2JDmzAZ/DkvHkSTeLS6VMf2sylY0Ja3sxGHJW53vQOGdZ4cwayrscVX6frryDH0
         SKYuPJ64sJaoxujJK2sNmEjTJTFu//zhiaUtnRSvq3I8bduknK4yKpFX4tPgYi42DtC0
         Cvh5f1VcH2rb1QrguCqNTnEBns09CDHo66hOMjQ9xRrX0JKiU6GZksWOpr8MHd74i3Tr
         TQkQ==
X-Gm-Message-State: AJcUukeYGwbF5BKXelMablw29s/MAA543IIklHWb9SiUr1zO6LVGq6Sy
        ZNVOc6Oq0OzsSnQT0kyfoLR1WA==
X-Google-Smtp-Source: ALg8bN6LHjz+tohPJpZdg609xP4CUdW9uNyelQ6jJM2IDS7wmwyQ6C8yB86p4ShY6t5eGyc9TO5HVg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr5163078plz.174.1548310935498;
        Wed, 23 Jan 2019 22:22:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s79sm40449206pgs.50.2019.01.23.22.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 22:22:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-4-bjorn.andersson@linaro.org> <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com> <20190123002610.GE31919@minitux> <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com> <20190123010930.GI31919@minitux> <CAD=FV=Vf+3dAo9pZ=AJ6mrMuYL0f=dBNdk3XLV+tORG0c8hbDg@mail.gmail.com>
User-Agent: alot/0.8
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=Vf+3dAo9pZ=AJ6mrMuYL0f=dBNdk3XLV+tORG0c8hbDg@mail.gmail.com>
Message-ID: <154831093382.136743.12475255729244767722@swboyd.mtv.corp.google.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Jan 2019 22:22:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2019-01-23 15:24:36)
> Hi,
>=20
> On Tue, Jan 22, 2019 at 5:09 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 22 Jan 16:40 PST 2019, Doug Anderson wrote:
> >
> > > Hi,
> > >
> > > On Tue, Jan 22, 2019 at 4:26 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > > > +               clocks =3D <&xo_board>;
> > > > > > +               clock-names =3D "xo";
> > > > >
> > > > > I've found that nearly all the places that refer to xo_board are =
wrong
> > > > > and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe you=
rs
> > > > > should too?
> > > > >
> > > >
> > > > Yes, xo_board is a fake clock representing the 19.2MHz clock feedin=
g the
> > > > cxo (or cxo2) pad of the SoC. So you're definitely right in that th=
is
> > > > should be referencing the actual 19.2MHz clock.
> > > >
> > > > We've kept referring to this as xo_board, as we don't handle probe
> > > > deferral when gcc will probe earlier than rpmcc in the boot and for
> > > > other non-clock drivers the fear of actually hitting 0 on the refco=
unter
> > > > for this (you don't want to disable the cxo while running the syste=
m).
> > >
> > > Note that, as defined in the device tree, "xo_board" is actually 38.4.
> > > IIUC that is not actually a fake/bogus clock but represents the actual
> > > crystal on the board.  There's a divide by 2 in the CPU though so most
> > > peripherals consider "xo" as 19.2.
> > >
> >
> > There's the 38.4MHz XO connected to the PMIC, but the signal going into
> > the CXO_IN pad of the SoC is supposed to come from LNBBCLK1 and be
> > 19.2MHz.
>=20
> Ah, thanks for pointing me to the right clock!  :-)
>=20
> OK, so something is definitely wonky then.  "xo_board" is definitely
> 38.4 currently in the device tree.  That's my fault due to commit
> 5ea3939cf51f ("arm64: dts: sdm845: Fix xo_board clock name and
> speed").  ...but, in my defense:
>=20
> A) The hardcoded "divide by 2" for "bi_tcxo" in "clk-rpmh.c" came from Qu=
alcomm.
>=20
> B) The parent of "bi_tcxo" has always been "xo_board"
>=20
> C) Children of "bi_tcxo" have always been only correct if "bi_tcxo" was 1=
9.2
>=20
>=20
> ...so if "cxo" is really 19.2 then we need to update clk-rpmh to get
> rid of the hardcoded divide by 2 I think?
>=20

It looks OK to me the way it is. Here's why. xo_board is the crystal on
the board. That is 38.4 MHz. The lnbbclk1 signal is 19.2MHz (really? I
thought it was still 38.4 and there was a divider on the CXO pin inside
the SoC). The RPMh driver design to do a div-by-2 on the parent clk is
there to model how the PMIC or the SoC is dividing down that crystal
frequency to be 19.2 MHz for the CXO that the rest of the clk tree in
the SoC sees. So if devices still want to use something that isn't the
rpmh 'bi_tcxo' clk, they should be referencing something like lnbbclk1
as their input clk, and that lnbbclk1 should be a new fixed factor clk
specified in DT that takes the xo_board and creates the lnbbclk1
frequency out of it. Or if we want to get really fancy we can populate
that from the PMIC clk div module itself and then show how the PMIC is
doing the division from the buffer. I don't know if anyone really cares
about this level of detail though.

The reason that certain devices may not want to specify the RPMh clk
'bi_tcxo' is because they may not want the RPM to keep the XO buffer
enabled across low power modes. I don't think this is very common, but
it may be that there isn't any need to do anything besides calculate
some frequency based on the CXO frequency at the SoC's pin and thus
specifying the "raw" XO clk works just as well. I have no idea if that's
the case here.

