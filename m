Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA897C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BCF2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYMn7YCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BCF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeHXTwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXTwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:52:00 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97202147A;
        Fri, 24 Aug 2018 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127400;
        bh=4VguAd5EYbqM9JUbN1sPYM7lQjjjLL3RD77X4X+MH5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYMn7YCiaLUnkt3YzewpXG3WK6dHneKLkg1pZGW9bTzrwfsw5TufhGdhmzxjGrc8e
         5S2/hu3M3Mo1OGImtNqF/DixT2PhQsVQGLHadZXUaMK2TiFdRZLQRkpyCk3MvVMrZh
         MFVNkmCcqvdyZJg7fvuvUEnAY6+Dj8SSYznJUSP0=
Received: by mail-qt0-f174.google.com with SMTP id g44-v6so10034476qtb.12;
        Fri, 24 Aug 2018 09:16:40 -0700 (PDT)
X-Gm-Message-State: APzg51AizEBWGpys3BY40WHPfMCCmQSSZ13sqvBKbEkHyl1x1UQo5wD4
        d2LWDZVdioZ6FdCtynRmP6dgKTnBOxPElVaQ2g==
X-Google-Smtp-Source: ANB0Vdbba/i2GDNbVGWhngeVU4Jws4AtmL6jH8LBVemo8av2mlQEHX/NuIKXVCT1K658BdkwxeaIiZQDtVbjpflUHPk=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr2513100qto.188.1535127399902;
 Fri, 24 Aug 2018 09:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com> <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Aug 2018 11:16:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+QrDR_YyZ+icftUrwOoMZcSCMkmj8cR=bqEJ-q+pdntg@mail.gmail.com>
Message-ID: <CAL_Jsq+QrDR_YyZ+icftUrwOoMZcSCMkmj8cR=bqEJ-q+pdntg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
To:     vabhav.sharma@nxp.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>, V.Sethi@nxp.com,
        Udit Kumar <udit.kumar@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:08 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:

[...]

> > > +               i2c@3 {
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +                       reg = <0x3>;
> > > +
> > > +                       sa56004@4c {
> >
> > temperature-sensor@4c
> Ok, temperature-sensor-1@4c

No, that's not what I said. You don't need the '-1' because the
unit-address makes the node name unique. Node names are supposed to be
generic based on the class/type of device. See the DT spec.

> >
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4c>;
> > > +                       };
> > > +
> > > +                       sa56004@4d {
> Ok,temperature-sensor-2@4d
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4d>;
> > > +                       };
> > > +               };
> > > +       };
> > > +};
> > > +
> > > +&i2c4 {
> > > +       status = "okay";
> > > +
> > > +       rtc@51 {
> > > +               compatible = "nxp,pcf2129";
> > > +               reg = <0x51>;
> > > +               // IRQ10_B
> > > +               interrupts = <0 150 0x4>;
> > > +               };
> > > +
> > > +};
> > > +
> > > +&usb0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&usb1 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&crypto {
> > > +       status = "okay";
> > > +};
> > > --
> > > 2.7.4
> > >
