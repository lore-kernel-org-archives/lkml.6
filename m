Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F262172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBLWGn72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F262172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbeHNR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbeHNR0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:26:40 -0400
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141852172C;
        Tue, 14 Aug 2018 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534257553;
        bh=pIG03ONIQkbE5YUsGEE+aXbI99tWFZUW7xCWlowMtQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WBLWGn72WZF3k+bWjbzvtrX3re/crNAz/lM0BVGFykUxYm9Mjalye88cuQvkTguhS
         tmCXkNeNcOslVs37RMDFTd6CpuJtrF3jNl/Ds4Q+Tirv0oeRwV1vHejMiTrTGojOuJ
         /mVoqlGjYw0nzz7WpYFjC2f0EzlxhQgpAlnVcMak=
Received: by mail-qk0-f182.google.com with SMTP id b5-v6so13525778qkg.6;
        Tue, 14 Aug 2018 07:39:13 -0700 (PDT)
X-Gm-Message-State: AOUpUlEqPkrHAtHjMoZvLUwDnSgLWCsFv/CqKmt/M1rG2PluAE/boSST
        D0hQbtsMZONCTE6vl/oYK0y5xlZYBkh9AUqeLg==
X-Google-Smtp-Source: AA+uWPyXwnQUHJn/oBkm7Ch1P2xEF+ZikIWMu/8A5BFikJkpcLF9FA2CmLxxGpQPu7fnFWv8Wfz9mM1Wba5GaSBy0Qs=
X-Received: by 2002:ae9:c112:: with SMTP id z18-v6mr19584111qki.96.1534257552270;
 Tue, 14 Aug 2018 07:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-3-maxi.jourdan@wanadoo.fr> <20180813190721.GA27621@rob-hp-laptop>
 <CAHStOZ5i_SzamBsWk-b+X2n_gxdNJUPCHL1U0M-d6rdJgXkzrg@mail.gmail.com>
In-Reply-To: <CAHStOZ5i_SzamBsWk-b+X2n_gxdNJUPCHL1U0M-d6rdJgXkzrg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Aug 2018 08:39:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFmhKpcSKGfym+YtVAP24sPi1VLkM5EuRoJ-rkBG6EsA@mail.gmail.com>
Message-ID: <CAL_JsqJFmhKpcSKGfym+YtVAP24sPi1VLkM5EuRoJ-rkBG6EsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas documentation
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 8:42 PM Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
>
> 2018-08-13 21:07 GMT+02:00 Rob Herring <robh@kernel.org>:
> > On Wed, Aug 08, 2018 at 12:00:09AM +0200, Maxime Jourdan wrote:
> >> DT bindings doc for amlogic,meson-canvas
> >>
> >> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> >> ---
> >>  .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> >> new file mode 100644
> >> index 000000000000..5f0351717bee
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
> >> @@ -0,0 +1,36 @@
> >> +Amlogic Canvas
> >> +================================
> >> +
> >> +A canvas is a collection of metadata that describes a pixel buffer.
> >> +Those metadata include: width, height, phyaddr, wrapping, block mode
> >> +and endianness.
> >> +
> >> +Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
> >> +rather than use the phy addresses directly. For instance, this is the case for
> >> +the video decoders and the display.
> >> +
> >> +Amlogic SoCs have 256 canvas.
> >> +
> >> +Device Tree Bindings:
> >> +---------------------
> >> +
> >> +Canvas Provider
> >> +--------------------------
> >> +
> >> +Required properties:
> >> +- compatible: "amlogic,canvas"
> >> +
> >> +Parent node should have the following properties :
> >> +- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"
> >
> > Is this documented somewhere? One child function is not a reason for an
> > MFD and child nodes. And child nodes like this with no resources are
> > unnecessary.
> >
>
> Hi Rob, this was done to follow the same path as other buses on the
> platform that have sysctrls in order to provide regmaps to the
> devices.
>
> I can see how it's not really necessary here though, would it be okay
> with you if I turned "canvas" into a simple bus subnode, using __iomem
> in the device ?

That's a driver issue that has little to do with the binding. You can
create a regmap for any node, "syscon" just does that automagically
for you.

Rob
