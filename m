Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0244CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B566B208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHWFcSDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B566B208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbeGKPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:19:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53863 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388953AbeGKPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:19:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so2788493wme.3;
        Wed, 11 Jul 2018 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYoLNZo2FdVhn4RC/4BZfswOvACbYRoiAgtGyVBlQb0=;
        b=hHWFcSDcT51t8AUZw0s2OJYBomH3ugiSUIQzld8vspHs5Gh1HVdG1zY2ZFbBE5M6NS
         mq8kcwkqjCne4LXZM0wT/Yee2+0Nk+w+t8NuPVuW0rtPHspBDtZO3OB+m9JO/zLwQW7y
         I1QbKbqD0tsuzAglWNehnEVdwNqywDFANMP9YGmEn6hm5fhh8Z1pCFOoQDigT4lctdWs
         h7r795UK7QKVKoHiSSaaTtPoTJfYHCgcr/TF1g/2IKG+UeDbilaePiOj/UNWsD2gL/Ik
         2GPPNRopUJaH1XtlPxPqugsNLuuXDL1A5g/TfPZpLOjPBbXxpf7iTv/SahqMaFvw9ex/
         XlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYoLNZo2FdVhn4RC/4BZfswOvACbYRoiAgtGyVBlQb0=;
        b=VzqOeSUWY/Xg9YN3SJ0LpQio8E7jGFR/y+ksMzsrzgSb259WBY/I9hbUGf2wtPPP5k
         0o+U9WL8k12VwhN2M1HR+CWnbl3VtQ3bFw0psB7+ujZoyv4hoC2UXhVM9QxBvA5E+M1L
         SV3CPde+I1DKI89PhIb3kdl3k+tbedyUdbxH7gFU+Me+9FI2AS0Opxv6xoOkyYuHsTV/
         JSxnlb53/urtA4vWDfPWJpus6cANCRJY8ieaL3VcOKlaaKUU1vPjHb1I/qIEQpOQUH8K
         m2Y5BIrOk0dpg9EwwFMafjnPhFPpmmYP5fYnDSwPX7MerGHVebrA8jih1nbN2bydLm+w
         rY7Q==
X-Gm-Message-State: APt69E36moxPTA1psLIwAh6uiChyhTmwuRSuSB0bW/JwL9dgBEuRAa9g
        S6e93KgwhJkYyUWsB5V09VQ=
X-Google-Smtp-Source: AAOMgpdk4cuH9ZQ/xG1m2r9+YBeWYBaOmqGlG6jEAlaKVqHYkbS+jgcB6XJ6uJ2p1cSoOA9XHwJn3g==
X-Received: by 2002:a1c:ce0a:: with SMTP id e10-v6mr16407065wmg.135.1531322062768;
        Wed, 11 Jul 2018 08:14:22 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id w24-v6sm2523896wmc.15.2018.07.11.08.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:14:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
Date:   Wed, 11 Jul 2018 17:14:19 +0200
Message-ID: <3039364.lZKhBVCAIj@jernej-laptop>
In-Reply-To: <20180711150532.6gzm7krouriddreh@flea>
References: <20180711132233.42301-1-icenowy@aosc.io> <20180711132233.42301-2-icenowy@aosc.io> <20180711150532.6gzm7krouriddreh@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 11. julij 2018 ob 17:05:32 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> > Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> > controller of Allwinner H3 SoC.
> > 
> > Enable the HDMI output in Banana Pi M2 Zero device tree.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > 
> >  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts index
> > 7d01f9322658..eb61dcf32797 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > @@ -26,6 +26,17 @@
> > 
> >  		stdout-path = "serial0:115200n8";
> >  	
> >  	};
> > 
> > +	hdmi-connector {
> > +		compatible = "hdmi-connector";
> > +		type = "c";
> 
> This is not one of the connector type declared in DRM, how is it
> exposed to the userspace?

DT binding allows it:

HDMI Connector
==============

Required properties:
- compatible: "hdmi-connector"
- type: the HDMI connector type: "a", "b", "c", "d" or "e"

but DW HDMI bridge driver hardcodes it to type A. Actually, kernel has defines 
only for type A and B.

Actually, many HDMI drivers have type A hardcoded...

Best regards,
Jernej



