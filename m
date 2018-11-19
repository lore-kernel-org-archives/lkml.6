Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6647EC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM07Lq44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251F3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeKTFk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTFk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:40:28 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4892089F;
        Mon, 19 Nov 2018 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542654929;
        bh=0YcczH95Cr676bLuFMfcj7NNTQwiE9T+i7tUoRWs+H4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fM07Lq445opDmecIcuWclSZ5brU+75p0RdYISyzV9SLPN/hq9790VQHAciSdHUINN
         d0z6M98/w/jhlHPM6JvLdIJTzW9xs0Wylx6Cq3AQWx94rNzaU6w6VoiWEgxa6jjGmK
         IWDBKen9g5ZM5opwDGoBoVhFEjfyHHBf5NpFnwDM=
Received: by mail-qk1-f181.google.com with SMTP id o125so50509027qkf.3;
        Mon, 19 Nov 2018 11:15:28 -0800 (PST)
X-Gm-Message-State: AGRZ1gIKsI1mcnQtEDg+Sdxd2IO1U/zKmihpz7ITqcLs6cs0/FAOWp61
        wSSWq7lJI7CFWNX/J//3jD5PT1eJXC+gLc8dkA==
X-Google-Smtp-Source: AJdET5fV4nv90b2reqgvtn5FuaXbY4wGLH6fypiJsAe9WrXmWcZS1McBtOdZdQlF8CDZCQ/oIJ7c2/UJuo8hO9kswMs=
X-Received: by 2002:ac8:173d:: with SMTP id w58mr21817850qtj.76.1542654928026;
 Mon, 19 Nov 2018 11:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org> <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
In-Reply-To: <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 13:15:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
Message-ID: <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     matthias.bgg@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 11:12 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 11/17/18 12:15 AM, Rob Herring wrote:
> > On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg@kernel.org wrote:
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> On SoCs with no publical available HW or no working graphic stack
> >> we change the devicetree binding for the mmsys clock part. This
> >> way we don't need to register a platform device explicitly in the
> >> drm driver. Instead we can create a mmsys child which invokes the
> >> clock driver.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 21 ++++++++++++-------
> >>  .../display/mediatek/mediatek,disp.txt        |  4 ++++
> >>  2 files changed, 18 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> index 4468345f8b1a..d4e205981363 100644
> >> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> @@ -1,4 +1,4 @@
> >> -Mediatek mmsys controller
> >> +Mediatek mmsys clock controller
> >>  ============================
> >>
> >>  The Mediatek mmsys controller provides various clocks to the system.
> >> @@ -6,18 +6,25 @@ The Mediatek mmsys controller provides various clocks to the system.
> >>  Required Properties:
> >>
> >>  - compatible: Should be one of:
> >> -    - "mediatek,mt2712-mmsys", "syscon"
> >> -    - "mediatek,mt6797-mmsys", "syscon"
> >> +    - "mediatek,mt2712-mmsys-clk", "syscon"
> >> +    - "mediatek,mt6797-mmsys-clk", "syscon"
> >
> > Doesn't match the example.>
> >>  - #clock-cells: Must be 1
> >>
> >> -The mmsys controller uses the common clk binding from
> >> +The mmsys clock controller uses the common clk binding from
> >>  Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> >> +It is a child of the mmsys block, see binding at:
> >> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >>
> >>  Example:
> >>
> >> -mmsys: clock-controller@14000000 {
> >> -    compatible = "mediatek,mt8173-mmsys", "syscon";
> >> +mmsys: syscon@14000000 {
> >> +    compatible = "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
> >>      reg = <0 0x14000000 0 0x1000>;
> >> -    #clock-cells = <1>;
> >> +
> >> +    mmsys_clk: clock-controller@14000000 {
> >> +            compatible = "mediatek,mt2712-mmsys-clk";
> >> +            #clock-cells = <1>;
> >
> > This goes against the general direction of not defining separate nodes
> > for providers with no resources.
> >
> > Why do you need this and what does it buy if you have to continue to
> > support the existing chips?
> >
>
> It would show explicitly that the mmsys block is used to probe two
> drivers, one for the gpu and one for the clocks. Otherwise that is
> hidden in the drm driver code. I think it is cleaner to describe that in
> the device tree.

No, that's maybe cleaner for the driver implementation in the Linux
kernel. What about other OS's or when Linux drivers and subsystems
needs change? Cleaner for DT is design bindings that reflect the h/w.
Hardware is sometimes just messy.

Rob
