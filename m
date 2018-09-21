Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8615BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ADE2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgh/KdBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ADE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbeIUQu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:50:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37478 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389651AbeIUQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:50:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so11243694ljk.4;
        Fri, 21 Sep 2018 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQUYTN6fz7eJZscI4UeqpqBq4bczcqn8WSsIoeA5x9Y=;
        b=sgh/KdBmFqOJKAXY3Iya2qRh90UnPcSz7JfJMiILLG8y/Ad4nUXJYRBpGvSUK5bSWe
         A9C2735POHFdbOO3kQZTOhAhcsW8H2qg9lsmTyUugXRvtoYQ81qebipFNrHVmhZ+j4s/
         F/OnrmvpTMlFTUFfNmxmHDfvizEM48CRM7NAVrIajGw4t+9k1KO8l/9r6DzyN7LPGgHa
         kcbIWmk0PQXZ80DpXTAxI5CBqkCHLEprTafDF35mvYgzl5hf8z5h6I3XOiGpcSKKBRNI
         iVvB3Rbt+QG8hh1+WxIPPD25JEpErbra9rCYxmWnIZJG01g8++PoZp7OWVusqjsli9xv
         l92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQUYTN6fz7eJZscI4UeqpqBq4bczcqn8WSsIoeA5x9Y=;
        b=d6iyOJIVPjRkKeJECqfXDH51vwrRnLBfuys/a40FOCsNLGC+3Ux3E7EI8tlhYR5OE9
         PycS7OPZZ4cfVKFTGIxMb//JkFOtDyG2HUo06DhUkkfeYxM0MKIqxevrCGkxQG+VEVi/
         7FYkPP4o1z6XqYOv+UWKhPS3BxbMalk9D99X4O1LAT4LNTd978N15QPUPQSgv4h+kVIi
         rXmtormiWPPeQ4wdiRRk2VUHLrOPPPytRRA9Iu5J28+0TG0qnstc8DfXuXULWIGkP3iN
         nmIb+1WiyqmtKDRtZ57YW9hgW1dYFh/Sog/2n4R4plMVAoAIXhV1N7lED5Xh1YWEDPWl
         UU7g==
X-Gm-Message-State: ABuFfoiTqzM0Olcl+g9IxFve6bfiuwpak5n/X2pJ3MlKTndzyfzKmsVl
        5v1QK0h+sVebWWLBntLMrCbaVzM2O1Dz/S8phrIQW4NX/Rc=
X-Google-Smtp-Source: ANB0VdbCCnqnNW//ENRCLWP5B62xTjR+nCV4KKqbTo1G8Zq4IcUpM2z4ANYmZ/1GeXo/ArW4Gh1l6bvrfyY+X5VoPus=
X-Received: by 2002:a2e:2025:: with SMTP id g37-v6mr1504064ljg.40.1537527721950;
 Fri, 21 Sep 2018 04:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180921100920.8656-1-ricardo.ribalda@gmail.com> <6279061.hCdAfSGG5i@avalon>
In-Reply-To: <6279061.hCdAfSGG5i@avalon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 21 Sep 2018 13:01:44 +0200
Message-ID: <CAPybu_2TyUrUpy1fnFu7bCs6TT0Xot88w=KUhPiAYC+YtjLVVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] [media] imx214: device tree binding
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Thanks for your review!
On Fri, Sep 21, 2018 at 12:38 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Friday, 21 September 2018 13:09:19 EEST Ricardo Ribalda Delgado wrote:
> > Document bindings for imx214 v4l2 driver.
>
> Those are bindings for the IMX214 camera sensor, not for its V4L2 driver.
>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  .../devicetree/bindings/media/i2c/imx214.txt  | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt
> > b/Documentation/devicetree/bindings/media/i2c/imx214.txt new file mode
> > 100644
> > index 000000000000..4ff76d96332e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> > @@ -0,0 +1,51 @@
> > +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> > +
> > +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor
> > with +an active array size of 4224H x 3176V. It is programmable through I2C
> > +interface.
>
> s/I2C interface/an I2C interface/
>
> > The I2C address can be configured to to 0x1a or 0x10, depending
> > on +how is wired.
>
> Maybe "depending on how the hardware is wired" ?
>
> > +Image data is sent through MIPI CSI-2, which is configured as 4 lanes
> > +at 1440 Mbps.
>
> Can the sensor use less lanes than 4, or is it fixed ?
>
> > +Required Properties:
> > +- compatible: value should be "sony,imx214" for imx214 sensor
> > +- reg: I2C bus address of the device
> > +- enable-gpios: Sensor enable GPIO
>
> Maybe "GPIO descriptor for the enable pin" ?
>
> > +- vdddo-supply: Chip digital IO regulator (1.8V).
> > +- vdda-supply: Chip analog regulator (2.7V).
> > +- vddd-supply: Chip digital core regulator (1.12V).
> > +- clocks = Reference to the xclk clock.
> > +- clock-names = Should be "xclk".
>
> If there's a single clock, is the name mandatory ?

The drivers is checking for that name.  I am removing that constrain
from the driver and fixing the doc

>
> > +- clock-frequency = Frequency of the xclk clock. Should be <24000000>;
>
> The frequency of the clock can be queried at runtime. If you want to hardcode
> a specific frequency in DT, you should use the assigned-clock-rates property.

With the current register_tables I only support that input clock.

>
> > +Optional Properties:
> > +- flash-leds: See ../video-interfaces.txt
> > +- lens-focus: See ../video-interfaces.txt
> > +
> > +The imx274 device node should contain one 'port' child node with
> > +an 'endpoint' subnode. For further reading on port node refer to
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Example:
> > +
> > +     camera_rear@1a {
> > +             status = "okay";
>
> Isn't that the default ?
>
> > +             compatible = "sony,imx214";
> > +             reg = <0x1a>;
> > +             vdddo-supply = <&pm8994_lvs1>;
> > +             vddd-supply = <&camera_vddd_1v12>;
> > +             vdda-supply = <&pm8994_l17>;
> > +             lens-focus = <&ad5820>;
> > +             enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> > +             clocks = <&mmcc CAMSS_MCLK0_CLK>;
> > +             clock-names = "xclk";
> > +             clock-frequency = <24000000>;
> > +             port {
> > +                             imx214_ep: endpoint {
>
> Incorrect indentation ?
>
> > +                             clock-lanes = <1>;
> > +                             data-lanes = <0 2 3 4>;
>
> Those properties are not documented. The data-lanes value is peculiar, does
> the sensor support lanes remapping ?

I do not believe that the sensor supports lanes remapping

That is the configuration used on the db820c. Sensors with two CSI lanes have:

                             clock-lanes = <1>;
                             data-lanes = <0 2>;

I just extended it to 4 lanes... but I just tried < 1 2 3 4 > and also
works fine... so I will fix that.

>
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

I am adding all your fixes to my github tree


https://github.com/ribalda/linux/commits/imx214-v3

After people had time to give their reviews I will send v3 to the list
(do not want to spam again the list) :P

Thanks again

-- 
Ricardo Ribalda
