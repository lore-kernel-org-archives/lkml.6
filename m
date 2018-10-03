Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF60C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9620652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIJQkXWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCNK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:10:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42944 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:10:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so3963119lje.9;
        Tue, 02 Oct 2018 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cZVfVofriWFxD9uNKwHCQCrWn6uLl0K9NmlAANG6Ns=;
        b=QIJQkXWX2KV3FBgwSMJXh/Ykwie9By9gxNbrinqxRsJlA8H34yokG/ZdazQdw3Xc56
         0pPCTDMofpa5vyrb+Y3nopXwT28+MJ4sbS7BG+vTHkbg7TvIwy5vF8Jqmnx7I20VXrV2
         PICtK+A1JJ4mMdnnqC2Bh4VHqGF6rdkd2pXmB3dgXo216ptHTW2zGhJvL3XOraLf8HMl
         6nozotOE+cMW6Oc+ibLwY+QLE06mBYfbuOqH/KfWP0P+Maci5VrR/ZI29pPq/8Hp4rmf
         uWzeHJS1T/F734gUa3gxKmDVbptpu0quMHIe3AtPZanfDHLlUdxt4UMy63TxtkN95m/k
         0nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cZVfVofriWFxD9uNKwHCQCrWn6uLl0K9NmlAANG6Ns=;
        b=Mti1gLUSnsDKgm9ASdcu7xXqb3vWNVA0Xwl0+m1riWESQdu/5iW6N05nwVF38dMPzm
         v+VZ6f1SgGrr2rQXxZvAXwCw5wVARgTFZMbfRYQuG2Ft69QCCuUbbBgSHOw7MNOC5pNA
         BekLrpjGMtXIqAoXQhLk3cS5GtFPO8yi8f6w5eMApe4zgyYLadCs9ikpeEGSmhwQOh77
         Y8sucvwPphhtzd94pCR0ufAcG/Qms9Qn0mIZhGt1GuxPTNiLw7skqM2wkUFfYgo0mjcr
         fYYZ0AA6N2CSJBvqUSIwSvlpE4HAM0ivte1cw3IAW6I7bzUf/Q3rNsLMJAF4T0RtweJq
         npEw==
X-Gm-Message-State: ABuFfoi+/GiR+fr/zlG60lNeQcXbMuUQ1FK3anspfLD7GJWws8B/9mnD
        wF2pR35Uhbpkzdy+PLqxzHX9/KIJ7DyXktQ3wQA=
X-Google-Smtp-Source: ACcGV61D0PnS5lLCuoq9K9b94dfoBfZ6LAnACEuX9VXURRcfsk+YdhEIZ+VLCGmAVNN8cTGx7g5G+O9h2H1KZo/0+QE=
X-Received: by 2002:a2e:8919:: with SMTP id d25-v6mr12634361lji.69.1538547839863;
 Tue, 02 Oct 2018 23:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181002140515.16299-1-ricardo.ribalda@gmail.com> <4555006.y1GbRfQLCO@avalon>
In-Reply-To: <4555006.y1GbRfQLCO@avalon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 3 Oct 2018 08:23:43 +0200
Message-ID: <CAPybu_02_hMAVWO2r1-t+S60HPaqEtnQzgF-Moxg7Zx+-PGj6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] [media] imx214: device tree binding
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>, jacopo@jmondi.org,
        phdm@macq.eu, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent
On Tue, Oct 2, 2018 at 10:06 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tuesday, 2 October 2018 17:05:15 EEST Ricardo Ribalda Delgado wrote:
> > Document bindings for imx214 camera sensor
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > Changelog from v3:
> >
> > Sakari Ailus:
> > -s/should/shall/
> > -remove clock-lanes
> >
> > Philippe De Muyter:
> > -s/imx274/imx214/
> >
> > Laurent Pinchart:
> > -s/to to/to/
> > -Better description of lanes
> > -clock-names: Shall be "xclk"
> > -Drop clock-freq
> >
> >  .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt
> > b/Documentation/devicetree/bindings/media/i2c/imx214.txt new file mode
> > 100644
> > index 000000000000..421a019ab7f9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> > @@ -0,0 +1,53 @@
> > +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> > +
> > +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor
> > with +an active array size of 4224H x 3200V. It is programmable through an
> > I2C +interface. The I2C address can be configured to 0x1a or 0x10,
> > depending on +how the hardware is wired.
> > +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> > +throughput of 1.2Gbps/lane.
> > +
> > +
> > +Required Properties:
> > +- compatible: value should be "sony,imx214" for imx214 sensor
> > +- reg: I2C bus address of the device
> > +- enable-gpios: GPIO descriptor for the enable pin.
> > +- vdddo-supply: Chip digital IO regulator (1.8V).
> > +- vdda-supply: Chip analog regulator (2.7V).
> > +- vddd-supply: Chip digital core regulator (1.12V).
> > +- clocks: Reference to the xclk clock.
> > +- clock-names:  Shall be "xclk".
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
>
> As I suppose you got access to the datasheet which doesn't appear to be
> public, I'll take this as an opportunity to fish for information :-) Does the
> sensor support remapping data lanes ? Could you please document that here ?
>
> You should also state that only the 2 lanes and 4 lanes options are valid, and
> what lanes can be used in those cases. I assume that would be <1 2> and <1 2 3
> 4>, but if other options are possible, it would be useful to document that.

I wish I had. This is the best documentation that I got access to,
after a lot of googling:
http://www.ahdsensor.com/downloadRepository/3acdda8d-b531-4a76-a27d-9dd09be980ee.pdf

I never understood this secrecy around datasheets. How the f*&& are we
going to buy chips and make desings around them if we cannot get
information?! Sorry that was my daily vent

The 2 and 4 lane option was obtained from the functional description
of the chip (page 1). The obvious order would be <1 2>, but I have
also seen <1 3> in other chips, so I rather not mention it on the
devicetree doc.

Thanks a lot for your review :)

>
> With this updated,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +- link-frequencies: check ../video-interfaces.txt
> > +- remote-endpoint: check ../video-interfaces.txt
> > +
> > +Example:
> > +
> > +     camera_rear@1a {
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
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>


-- 
Ricardo Ribalda
