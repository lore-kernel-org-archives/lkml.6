Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D5DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775852080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vnn8UZw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775852080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKRBas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRBas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:30:48 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2827420825;
        Sat, 17 Nov 2018 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542467630;
        bh=LEHXWTTLmnYfMHUGwfsNdp/AMHvF3vpS6ufqMzrgrlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vnn8UZw52dtanEcpqsaoCxdJRQd0g4ixwMpbBLZAP2SJVOXc4Ty3ThugmB3G0pv8c
         0ek5wk9cQ6vtrtRQ7Ab0GerduELmhU89CVLEoFOSTzCU8Ghw5rc67Mz3U047J0v9/a
         zpCJ8fxwKgm/Fp23hsFrwUx0WAv+sxZDOE09MZkM=
Received: by mail-qk1-f182.google.com with SMTP id w204so42228863qka.2;
        Sat, 17 Nov 2018 07:13:50 -0800 (PST)
X-Gm-Message-State: AGRZ1gI5V6FQGzg7XaeE0M+mziyKXAOWhXV4I0Fjd/G17Z7/U3c9RQg0
        KKTPoMBuc+zcNb/7rp7q3AXLAu1ghdL6Af5TPw==
X-Google-Smtp-Source: AJdET5dbDt/34DHO05OvdECfckc+dXsBtOujJlkRGpF7Kx9f8NjirqWtKZBEWeNE7Re3Fo9BsZzkpTxsCmybe433bks=
X-Received: by 2002:a37:5686:: with SMTP id k128mr13423617qkb.29.1542467629293;
 Sat, 17 Nov 2018 07:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20181108070449.23572-1-shawn.guo@linaro.org> <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com> <20181113034200.GD20049@tiger>
In-Reply-To: <20181113034200.GD20049@tiger>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 17 Nov 2018 09:13:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com>
Message-ID: <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 9:42 PM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Hi Rob,
>
> On Mon, Nov 12, 2018 at 01:24:51PM -0600, Rob Herring wrote:
> > On Thu, Nov 08, 2018 at 03:04:48PM +0800, Shawn Guo wrote:
> > > From: Sriharsha Allenki <sallenki@codeaurora.org>
> > >
> > > It adds bindings for Synopsys 28nm femto phy controller that supports
> > > LS/FS/HS usb connectivity on Qualcomm chipsets.
> > >
> > > Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> > > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > > new file mode 100644
> > > index 000000000000..75e7a09dd558
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > > @@ -0,0 +1,101 @@
> > > +Qualcomm Synopsys 28nm Femto phy controller
> > > +===========================================
> > > +
> > > +Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
> > > +Qualcomm chipsets.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible:
> > > +    Value type: <string>
> > > +    Definition: Should contain "qcom,usb-snps-hsphy".
> >
> > SoC specific compatible?
>
> Agreed.  A SoC prefixed compatible would be more specific and scalable
> for handling different programming model of the same IP.  I will use
> "qcom,qcs404-usb-hsphy" in v3.
>
> >
> > > +
> > > +- reg:
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: USB PHY base address and length of the register map.
> > > +
> > > +- #phy-cells:
> > > +    Value type: <u32>
> > > +    Definition: Should be 0.
> > > +
> > > +- clocks:
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: See clock-bindings.txt section "consumers". List of
> > > +           three clock specifiers for reference, phy core and
> > > +           sleep clocks.
> > > +
> > > +- clock-names:
> > > +    Value type: <string>
> > > +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> > > +           property. Must contain "ref", "phy" and "sleep".
> > > +
> > > +- resets:
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: See reset.txt section "consumers". PHY reset specifiers
> > > +           for phy core and POR resets.
> > > +
> > > +- reset-names:
> > > +    Value type: <string>
> > > +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> > > +           property. Must contain "phy" and "por".
> > > +
> > > +- vdd-supply:
> > > +    Value type: <phandle>
> > > +    Definition: phandle to the regulator VDD supply node.
> > > +
> > > +- vdda1p8-supply:
> > > +    Value type: <phandle>
> > > +    Definition: phandle to the regulator 1.8V supply node.
> > > +
> > > +- vdda3p3-supply:
> > > +    Value type: <phandle>
> > > +    Definition: phandle to the regulator 3.3V supply node.
> > > +
> > > +- qcom,vdd-voltage-level:
> > > +    Value type: <prop-array>
> > > +    Definition: This is a list of three integer values <no min max> where
> > > +           each value corresponding to voltage corner in uV.
> > > +
> > > +Optional properties:
> > > +
> > > +- extcon:
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: Should contain the vbus extcon.
> >
> > Don't use extcon for new bindings. Use usb-connector binding.
>
> Okay, I just did a bit of research and found that 'extcon' is becoming
> a deprecated DT property recently and we should OF graph bindings to
> specify the connector.  Will do in v3.
>
> >
> > > +
> > > +- qcom,init-seq:
> > > +    Value type: <u32 array>
> > > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > > +                program 'value' into phy register at 'offset' with 'delay'
> > > +           in us afterwards.
> >
> > If we wanted this type of thing in DT, we'd have a generic binding (or
> > forth).
>
> Right now, this is a qualcomm usb phy specific bindings - first used in
> qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
> a so good hardware description, I'm a little hesitated to make it
> generic for other platforms to use in general.  What about we put off it
> a little bit until we see more platforms need the same thing?

I'm not saying I want it generic. Quite the opposite. I don't think we
should have it either generically or vendor specific. The main thing I
have a problem with is the timing information because then we're more
that just data. Without that we're talking about a bunch of properties
for register fields or just raw register values in DT. That becomes
more of a judgement call. There's not too much value in making a
driver translate a bunch of properties just to stuff them into
registers on init. But then just allowing any raw register value to be
in DT could be easily abused.

Rob
