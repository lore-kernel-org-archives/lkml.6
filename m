Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FC3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933DF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546018863;
	bh=91pubcS2yfOViRDqv2dDu8CrrFkjGijS+uXdfol8sRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y7Q8QDl64XI2y1aIJIYtdKoUAjrhfo8GY5mO0s2jqgZw1Ly0NyJnZoHS8UL1EqOql
	 ymgJBSvtYK5x0NiiM+COxHMUK9FglsxWG/tMDGjoxjQh6NXQfRW3uLQo11CZ7D/9rR
	 Lfa5GVadCtJfxNK7JXl0S2dnA6ji33PUnk0sIvDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeL1RlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbeL1RlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:41:00 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461B5214C6;
        Fri, 28 Dec 2018 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546018859;
        bh=91pubcS2yfOViRDqv2dDu8CrrFkjGijS+uXdfol8sRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1CM8Tiz9cktLHChPs43kzwr2E4sNADsv2xe86+LGlxKwNbvf+08Ojv991D2+6HL2d
         SJKCV85J7LTH2WG9Y08KyWIIsFKT5GXQeHqLIMo6nuREd+WareO8P2V0iQSHudPtFX
         JjrUmse68tvbDCx0aQr2+dtcsCMZbb2YX5T+uqGo=
Received: by mail-qt1-f175.google.com with SMTP id d19so23988214qtq.9;
        Fri, 28 Dec 2018 09:40:59 -0800 (PST)
X-Gm-Message-State: AJcUukf60fQGTu1RnX7JC1Fg9oO+pel9NbNsW5IMgoylQXrWUJuNMgOk
        PSV6y2t0YRimbyg1Ifeg7DzjLp4xEVhZDBNKpg==
X-Google-Smtp-Source: ALg8bN6wUc5YRIIHGdHBrAhC8261f2zLJgUroCbFboUM31wf7mhm0G1ADKTH/EuNOsSUMYlgBqrG7XxYpNh3shQcI/E=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr27562353qvk.106.1546018858387;
 Fri, 28 Dec 2018 09:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20181219130449.31641-1-peda@lysator.liu.se> <20181219130449.31641-2-peda@lysator.liu.se>
 <20181227212727.GA26893@bogus> <35e85643-b23c-4958-bb8c-f9536bc8d864@axentia.se>
In-Reply-To: <35e85643-b23c-4958-bb8c-f9536bc8d864@axentia.se>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Dec 2018 11:40:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgJ-+NpOJkEAYhjF-3_vaX+y1fO6Q5CPQRe9ptzfuMQA@mail.gmail.com>
Message-ID: <CAL_JsqJgJ-+NpOJkEAYhjF-3_vaX+y1fO6Q5CPQRe9ptzfuMQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: bridge: fork out ti,ds90c185
 from lvds-transmitter
To:     Peter Rosin <peda@axentia.se>
Cc:     Peter Rosin <peda@lysator.liu.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 4:54 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-12-27 22:27, Rob Herring wrote:
> > On Wed, Dec 19, 2018 at 02:04:47PM +0100, Peter Rosin wrote:
> >> From: Peter Rosin <peda@axentia.se>
> >>
> >> DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
> >> binding, which is meant to be generic.
> >>
> >> The sister chip DS90C187 is similar to DS90C185, describe it here as well.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 +---
> >>  .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
> >>  2 files changed, 56 insertions(+), 7 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> index 50220190c203..fd39ad34c383 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> @@ -22,13 +22,7 @@ among others.
> >>
> >>  Required properties:
> >>
> >> -- compatible: Must be one or more of the following
> >> -  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
> >> -  - "lvds-encoder" for a generic LVDS encoder device
> >> -
> >> -  When compatible with the generic version, nodes must list the
> >> -  device-specific version corresponding to the device first
> >> -  followed by the generic version.
> >> +- compatible: Must be "lvds-encoder"
> >>
> >>  Required nodes:
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> >> new file mode 100644
> >> index 000000000000..a13e778503e6
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> >> @@ -0,0 +1,55 @@
> >> +Texas Instruments FPD-Link (LVDS) Serializer
> >> +--------------------------------------------
> >> +
> >> +The DS90C185 and DS90C187 are low-power serializers for portable
> >> +battery-powered applications that reduces the size of the RGB
> >> +interface between the host GPU and the display.
> >> +
> >> +Required properties:
> >> +
> >> +- compatible: Should be
> >> +  "ti,ds90c185", "lvds-encoder"  for the TI DS90C185 FPD-Link Serializer
> >> +  "ti,ds90c187", "lvds-encoder"  for the TI DS90C187 FPD-Link Serializer
> >> +
> >> +Optional properties:
> >> +
> >> +- pwdn-gpios: Power down control GPIO (the PDB pin, active-low)
> >
> > powerdown-gpios is the standard name.
>
> The lvds-encoder driver handles this binding, and that driver incidentally
> also implements the thine,thc63lvdm83d binding which already has a
> pwdn-gpios property. Should the thine,thc63lvdm83d binding be updated and
> the driver be made to support both properties?
>
> Since the lvds-encoder driver never had support for the pwdn-gpios (at least
> not upstream) I suppose there is also the option to simply go with
> powerdown-gpios as you suggest and not bother with support for the
> pwdn-gpios property.

It is probably safe to just change it given it is not used in any dts
nor supported in the driver.

Rob
