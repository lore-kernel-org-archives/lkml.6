Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C02C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0548820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WcTRtvFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0548820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeGYXVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:21:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40971 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbeGYXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:21:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so8750516wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nau9HgDBKCWDWQPgBRsJODFvYc8+s8iEpA+zGR1INXM=;
        b=WcTRtvFYDJoAvNYyaJcjEVTlHuWatjODLmwNWpgJeDmTAc3uk007WVV6/4SHT7pF2G
         vfVaQyZVJql4Shov59lh8OSF97aSAWkUag7fzDjVnY/4708se/au7VItCRl6xJhv3hyi
         v5vvEKB1r16hHrZENlS82xr7njZ3gmrmJDxFBioQSD4cYTG64g+xECQ+1EAMsUINoEGF
         iUO2x156O8eRRSv2JiXXG8ZwjeKq1VueCy8f0jitiskcKT3S1Xyy/QtSWt4Nb/Q0EGDG
         zlIw7B/VVYqUJ8hG1SfjHnjYMu2xXkK/9+jqxvru6uw3+CbdlGWDhjhTG5Kb0No8hRWi
         7s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nau9HgDBKCWDWQPgBRsJODFvYc8+s8iEpA+zGR1INXM=;
        b=E7DbO+p//DRxBzbYLiZyXxtAngffPUp1P+WuNtraOrBOSY43+LkWyLDi02PO7Fi1CP
         Bbrx8ql5Hxl+brWj1iLdP/0AWRZBf+RajLAfY/PNtSniGYTOrJmFgGg0POg8lj7j7Mkf
         Y3UWLZSRLDXBF7GtMtzPJPZYpJhVKWSgoeUUjPx+X1kC8Eje+NS4LrFP2cD1zfF6jD3L
         PkZg3yxfodKSP+mv6WTfDYvRLN6yfwopWOwqrAHiiB+xmEG36+LKL1oVqtemQvkdmC2Y
         Ogwi4b7f0U+V2YRxrO7JSEavmxoLRGjkn58gVrJP+W8laZysnfpmubJ7qwL/a84GL4Uz
         f3kQ==
X-Gm-Message-State: AOUpUlEuRQXSN23vzJ63ePgrEZelhBmyr0GwqsrAY2PBWAF7rYZsPDoJ
        g7caUcRJpKJcR3YpvGyHIJU+Lg==
X-Google-Smtp-Source: AAOMgpcLFi9iPbGMy6iCkKlvTvzymBtd7CaruwybbCVYtvXxFjwyLEvJW8kulAWCh0lbUDPauzD2uQ==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr15669892wrr.105.1532556443871;
        Wed, 25 Jul 2018 15:07:23 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l6-v6sm3442636wmh.41.2018.07.25.15.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:07:23 -0700 (PDT)
Message-ID: <90780f5a6b974ee9a4f9f9f2580fc83ef6bdd805.camel@baylibre.com>
Subject: Re: [PATCH 10/14] arm64: dts: meson-axg: add linein codec
From:   jbrunet@baylibre.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     khilman@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 26 Jul 2018 00:07:21 +0200
In-Reply-To: <CAFBinCAgMhVOpCipV2D_UPqX7z0bcT=qnfRXTWpO7zigzS_TAQ@mail.gmail.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
         <20180724125238.14567-11-jbrunet@baylibre.com>
         <CAFBinCAgMhVOpCipV2D_UPqX7z0bcT=qnfRXTWpO7zigzS_TAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 21:18 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Tue, Jul 24, 2018 at 3:09 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > 
> > Add the es7241 analog to digital converter which is fed by the
> > lienin jack of the s400
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > index 7489b88f27d7..fb101a1c6660 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > @@ -178,6 +178,16 @@
> >                         gpios = <&gpio_speaker 2 0>;
> >                 };
> >         };
> > +
> > +       linein: audio-codec@0 {
> 
> there is a unit-address but no reg property - I am wondering if this is allowed?
> for the regulators we're using regulator-<unique-name> instead of
> regulator@<unique number>
> 
> (this applies to other patches in this series as well)

I did that because I tried to keep node-name generic as described in the DT
spec. The idea of numbering the nodes (without a reg property) in such a way
came from :
Documentation/devicetree/bindings/sound/simple-card.txt:
=> look at the multi dai link example. I'm doing exactly the same on the axg
card's dai-links. Nothing new here.

that being said, section 2.2.1 of the DT specs says:

" If the node has no reg property, the @unit-address must be omitted and the
node-name alone differentiates the node from other nodes at the same level in
the tree "

So apparently, this is used but not ok ?
I could make 'linein' the node-name instead of the label but that wouldn't be
very generic.
We could also have dai-link-2 instead dai-link@2 (audio-codec-3 instead of 
audio-codec@3). I seems to be OK with the spec, but it also looks weird ...

Rob, do you have opinion on this ? 

> 
> > +               #sound-dai-cells = <0>;
> > +               compatible = "everest,es7241";
> > +               VDDA-supply = <&vcc_3v3>;
> > +               VDDP-supply = <&vcc_3v3>;
> > +               VDDD-supply = <&vcc_3v3>;
> > +               status = "okay";
> > +               sound-name-prefix = "Linein";
> 
> SPDIF output uses capital letters "SPDIFOUT"
> I am not familiar with the sound subsystem (thus I'm not sure where
> this shows up) so I am wondering if the naming should be consistent?

This string is used to prefix the name of the different widgets and controls
provided. It is useful when several devices provides component and control with
the same names. It happens when several instances of a component are used but
also with classic names, such as "Playback"

I don't think there is a rule regarding capitalization.
Some name are all capital in ASoC, some just have the first letter in upper
case. It doesn't change anything technically, and I personally don't care.

> 
> Regards
> Martin


