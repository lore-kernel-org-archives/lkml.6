Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D0FC65BBF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C6921477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp5QIyHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C6921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJFFTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:19:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35333 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbeJFFTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:19:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so12964185ljj.2;
        Fri, 05 Oct 2018 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8gwSFmYzTidruljPLeEDYSlX2i5U3kZd5o8FV3mvxs=;
        b=Dp5QIyHTZeoud+8YCSVW122gINItFl8clLERu5Kp+wkixIOgYUNn7nCcT3FwjObLA8
         YJYe6BqwMuB6NNyesdqoy+dpvn0wkFE2TNdVF1u2S6h3NQJ0xdv3luMspbVbmdVyGxRs
         38TGzG1zmfymf7P6sKP0AOT1Y7hMhXRxZiP2r1BQ89DhNxiTDAnN/faujHSJvT7twIFo
         X1lpqvHpzEkz4pAGN1z2MXHi5AW0faRRb8fSF6+RJXzJdCAKWlicd3L1KsiSm+O5CuSJ
         YBvgbTAIENreheKo5g6qbAW/AQ79CYU8csGeLTeT/1MNjxDmkTSO1zOlEOjTmC66nNgx
         zuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8gwSFmYzTidruljPLeEDYSlX2i5U3kZd5o8FV3mvxs=;
        b=laFlVYKV73Coa0LWAHvwzXNJuVWndhPqoFpvLwyGZAkpMcvYs9Zf/zuguHluz3tj7q
         dI04jVoQfw22jHCWamq/gkxSHvxC1Bo+FjZw3ycRmmvUt/aA0Cbku61t02/jr88X/jr4
         SDQGy/0dDsSsl6aLaiDUAMQ+2EuBeqcafopjnd5jBXhnNsUFb9AcrHbZiBCxqwLOPMHy
         gBwX798r7ZKFsv2dvkxafvhDCSYYObxoSJtObXjL9uIkz7U9drifw6BrSBHvKBW3BwoU
         3kSB1DtlDgo3HCH7HzY4n4UnTrf9ejAKYzZLKdFZOf0J8K244lt62J6FoQwCDGYh+6J1
         iddg==
X-Gm-Message-State: ABuFfogQpH1/cvOe49cU2CmUwzkERgoyYxNA3kHrzjeMD82TydSA3pZL
        9L5jIsmAqOur1fSygtMuPdD72j2GUAltMbjb33I=
X-Google-Smtp-Source: ACcGV62f51JD0lDTbYf1nJmB4TOeow/YRHIGDM1TdJzYavz0SUfaj5kjjkNzrh9EUdhcxUNctMQL4kbjYkmfCylo7eM=
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr9438641ljj.90.1538777924712;
 Fri, 05 Oct 2018 15:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181005215750.6047-1-ricardo.ribalda@gmail.com> <20181005220221.luriq43w3yvstmw3@valkosipuli.retiisi.org.uk>
In-Reply-To: <20181005220221.luriq43w3yvstmw3@valkosipuli.retiisi.org.uk>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Sat, 6 Oct 2018 00:18:28 +0200
Message-ID: <CAPybu_1_vDjEUN1MY2aFNX-nauEOP98WBC5K=2A+p==4SJVpRA@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] [media] imx214: device tree binding
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Rob Herring <robh@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>, jacopo@jmondi.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari
On Sat, Oct 6, 2018 at 12:02 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Fri, Oct 05, 2018 at 11:57:50PM +0200, Ricardo Ribalda Delgado wrote:
> > Document bindings for imx214 camera sensor
> >
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > Changelog from v8:
> >
> > Rob Herring:
> > -rename file
> > -Move address to reg
> > -rename name on example
> > -Patch author
> >
> > Sakari Ailus:
> > -should->shall
> >
> >  .../bindings/media/i2c/sony,imx214.txt        | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> > new file mode 100644
> > index 000000000000..2744773070c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
> > @@ -0,0 +1,53 @@
> > +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> > +
> > +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
> > +an active array size of 4224H x 3200V. It is programmable through an I2C
> > +interface.
> > +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> > +throughput of 1.2Gbps/lane.
> > +
> > +
> > +Required Properties:
> > +- compatible: Shall be "sony,imx214".
> > +- reg: I2C bus address of the device. Depending on how the sensor is wired,
> > +       it shall be <0x10> or <0x1a>;
> > +- enable-gpios: GPIO descriptor for the enable pin.
> > +- vdddo-supply: Chip digital IO regulator (1.8V).
> > +- vdda-supply: Chip analog regulator (2.7V).
> > +- vddd-supply: Chip digital core regulator (1.12V).
> > +- clocks: Reference to the xclk clock.
> > +- clock-names:  Shall be "xclk".
>
> It could be that this was already discussed earlier but I missed that ---
> clock frequency. Apologies for that. How does the driver know what to ask?
> If you expect assigned-clock-rate or such, then I think it should be
> explicitly said here.

It has becoming hard to follow, it is mainly my fault for sending 10 series :)

I think we discussed this here:
https://lkml.org/lkml/2018/10/2/1402


>
> You also have a single clock, so do you need clock-names?

Seems to be the de-facto standard Looking at:
grep xclk Documentation/devicetree/bindings/media/i2c/*

But the driver does not look for a specific name. I am going to remove the name.

>
> > +
> > +Optional Properties:
> > +- flash-leds: See ../video-interfaces.txt
> > +- lens-focus: See ../video-interfaces.txt
> > +
> > +The imx214 device node shall contain one 'port' child node with
> > +an 'endpoint' subnode. For further reading on port node refer to
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Required Properties on endpoint:
> > +- data-lanes: check ../video-interfaces.txt
> > +- link-frequencies: check ../video-interfaces.txt
> > +- remote-endpoint: check ../video-interfaces.txt
> > +
> > +Example:
> > +
> > +     camera-sensor@1a {
> > +             compatible = "sony,imx214";
> > +             reg = <0x1a>;
> > +             vdddo-supply = <&pm8994_lvs1>;
> > +             vddd-supply = <&camera_vddd_1v12>;
> > +             vdda-supply = <&pm8994_l17>;
> > +             lens-focus = <&ad5820>;
> > +             enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> > +             clocks = <&mmcc CAMSS_MCLK0_CLK>;
> > +             clock-names = "xclk";
> > +             port {
> > +                     imx214_ep: endpoint {
> > +                             data-lanes = <1 2 3 4>;
> > +                             link-frequencies = /bits/ 64 <480000000>;
> > +                             remote-endpoint = <&csiphy0_ep>;
> > +                     };
> > +             };
> > +     };
> > --
> > 2.19.0
> >
>
> --
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi



-- 
Ricardo Ribalda
