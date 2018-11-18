Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BFB20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LfhG+Bqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BFB20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeKSElz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:41:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51459 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeKSElz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:41:55 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so5035525itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hyxNNRHZAQk2YKmGWiMDL3h9FJqTwTHuD1bXW1J0LI=;
        b=LfhG+BqjQQosGHy+3I2BryDZ47H2LwTlkUWV20Piubw94dOEhwHXhAwcxsHd1RobtU
         RRuUIKxbE95SoVWmwCnClbi+p2cUtRKNTCsQj8m70DF6ND9ryp/Xv9EuENjE9d6AO7SN
         kNCb1YPZnuDQDUkrtPNR7HFj+q8f5CSrySZ38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hyxNNRHZAQk2YKmGWiMDL3h9FJqTwTHuD1bXW1J0LI=;
        b=qYXbpr+TOdGNFgoT4rTwXzsrw2QNHE887HvyfqlNWBfZ5n1QpVq2LGEa0oEBFR+nU3
         VLSUHPxkFizjtpgn/Q5WGIVGKL9JbB7eV4VA7XqLTdkma5CvSpWzdlN13/EAOeSzEmQX
         375EkyJWWTVYjpVmwKc5F5/1/C+wnZd4/CyE80B+3ldtqtDrCn5394egOb4Iko9U2r+G
         so/X3gZEj6mLtJ/DEvKj0C1V0mbYImKCn+GpGBfIYjJiD+KZ6LvSRG1asQwakz7f/nJa
         khg5lqD3MdmriwNGOxQ8d6boacYdHswesh/DdezRh1rw/IVSVT+B8JKxa3C9YcnQiSy2
         0teg==
X-Gm-Message-State: AGRZ1gJqhJ+fDkKhkg+CR4H9DmpNxgD52tfHDsAuoaNwvT2Scp8bzKH0
        IV7pEsIF8ib9rKAJbtXKEUpwUDKKA+uzOGtw2PU/+g==
X-Google-Smtp-Source: AJdET5fHhUlslK/5UrXl/CwQOFXJqaRuJ38Z+sdRzmOqrl74secu+k/zmvi5BPg5DtOB6z5oSan7mwhTXXhu7lO7TqE=
X-Received: by 2002:a24:2710:: with SMTP id g16-v6mr5864130ita.107.1542565256573;
 Sun, 18 Nov 2018 10:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com> <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
 <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com> <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
 <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com> <CAMty3ZDTAiW=Lx2H4WvdsdJRYsVe1CpCJx7D0f7yANx7Lx25PA@mail.gmail.com>
 <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
In-Reply-To: <eb23f0f8-0270-d4fa-2cac-5b65ee4af42c@samsung.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 18 Nov 2018 23:50:45 +0530
Message-ID: <CAMty3ZD8wOyKJ32-itxshXmNbPs-_yf-S4_AmKcV4YuVX_gHGQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     a.hajda@samsung.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 1:26 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 10.11.2018 08:32, Jagan Teki wrote:
> > On Wed, Nov 7, 2018 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> On 06.11.2018 19:08, Jagan Teki wrote:
> >>> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
> >>>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>>>> On 26.10.2018 16:43, Jagan Teki wrote:
> >>>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> >>>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
> >>>>>>>
> >>>>>>> So, this patch adds DSI specific binding details on existing
> >>>>>>> dt-bindings file.
> >>>>>>>
> >>>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >>>>>>> ---
> >>>>>>> Changes for v3:
> >>>>>>> - Use existing binding doc and update dsi details
> >>>>>>> Changes for v2:
> >>>>>>> - none
> >>>>>>>
> >>>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> >>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> index 35bc0c839f49..b7855dc7c66f 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>>>> @@ -1,12 +1,39 @@
> >>>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> >>>>>>>
> >>>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> >>>>>>> +
> >>>>>>> +Depending on the variant, the PCB attached to the panel module either
> >>>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> >>>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> >>>>>>> +itself
> >>>>>> As I understand this is display board, which contains 'pure' RGB panel
> >>>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> >>>>>> These are separate devices, just connected by vendor to simplify its
> >>>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
> >>>>>> panel driver for S070WV20-CT16 - it looks more generic.
> >>>>>> Then you can describe both in dts and voila.
> >>>>>> Creating drivers for every combo of devices (panel + bridge), just
> >>>>>> because some vendor sells them together seems incorrect - we have
> >>>>>> devicetree for it.
> >>>>> Rob suggested this, and also the opposite: using the same
> >>>>> "bananapi,s070wv20-ct16"
> >>>>> compatible string for both types of connections, and have the driver deal with
> >>>>> detecting the bus type.
> >>>>>
> >>>>> The thing about the bridge chip is that there's no available datasheet that
> >>>>> describes all the parts of the init sequence, in fact none at all. I managed
> >>>>> to work out some bits, but the others remain a mystery and must be hard-coded
> >>>>> to match the panel. That would work against having a generic bridge driver.
> >>>> But it is common for many chips - 1st version of the driver is developed
> >>>> on one platform and it supports only one configuration, if next platform
> >>>> with the same cheap appears the driver is augmented if necessary.
> >>> At-least few of the commands from panel initialization code, the
> >>> respective opcode data values are based on panel timings and even
> >>> clock value is different in DSI. I think it look hard to try bridge
> >>> driver for these restrictions, do you have any suggestions?
> >>
> >> Where do you see an issue? Since panel is RGB it should have no
> >> initialization sequence (beside regulator/gpio power on/off), so the
> >> only thing to do is to figure out which regulators/gpios belongs to
> >> which component - with publicly available specs it should be doable.
> >>
> >> The whole initialization sequence is for the bridge, so you put it into
> >> bridge driver, for starters it can be hardcoded.
> > Yes, I understand we can move regulators/gpio setup separately and
> > though we hardcode the init sequence there is difference  in clock for
> > DSI(which I mentioned in previous mail). DSI panel can't work with
> > clock used by RGB panel-simple.
>
>
> If you mean pixel clock from timings in next patch it seems incorrect.
> Pixel clock should be always
>
> htotal * vtotal * vrefresh, in case of drm_display_mode result should be
> divided by 1000 (as .clock is in kHz).
>
> With timings provided there you have: 928*525*60 = 29232000
>
> So pixel clock should be 29232, if other timings are correct. DSI clock
> is a different thing and it is private thing of DSI bridge/panel it
> should not be exposed via drm_display_mode.

I understand your point, but in Allwinner case DSI clock which is
named in tcon block can be computed using clock value from
drm_display_mode from panel driver.

DE -> Mixer -> tcon-> MIPI <--> panel

So, for the value
- 55MHz panel clock the computed divider for DSI clock in tcon [1] is
6 which is proper and working divider
- 30MHz panel clock the computed divider for DSI clock in tcon [2] is
11 which can't work for this specific panel.

I have verified other panels, the divider value work similar to this
computation and those panels work accordingly.  but this panel case
the divider computation look weird, so we have used working and know
clock. I'm thinking since this panel is of DSI to RGB bridge, so it
may require some higher frequency to work but I've no document to
confirm the same.

Hope this information help, let me know if you have any inputs.

[1] https://paste.ubuntu.com/p/drvzfHFMtY/
[2] https://paste.ubuntu.com/p/hz29CTJY2J/
