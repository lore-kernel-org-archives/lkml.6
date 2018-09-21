Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDDCECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8BD20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JoaeGqto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8BD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbeIUQ4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:56:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44144 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeIUQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:56:48 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 744DD1275;
        Fri, 21 Sep 2018 13:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537528103;
        bh=M30/R9YG3QLOOGIWJPaFn16GzKoRxQRIRdL15pruqhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoaeGqtopa9dF+57VcJiZeJXa2dB5139r2SMbwa1XA8iAscnSBZfDW171Tft+HXBm
         8GZtAbHQn0V452ok//rtntYDEcnOloZOjcMtEclS8pZt5v1VuCdvJz3rfuL/perWSc
         3c1/RUeKA9l0esbZrmx9Y1+Uhaj4e8JmbWo7IsAI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [media] imx214: device tree binding
Date:   Fri, 21 Sep 2018 14:08:36 +0300
Message-ID: <1691180.OMaHrQMLfR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAPybu_2TyUrUpy1fnFu7bCs6TT0Xot88w=KUhPiAYC+YtjLVVQ@mail.gmail.com>
References: <20180921100920.8656-1-ricardo.ribalda@gmail.com> <6279061.hCdAfSGG5i@avalon> <CAPybu_2TyUrUpy1fnFu7bCs6TT0Xot88w=KUhPiAYC+YtjLVVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Friday, 21 September 2018 14:01:44 EEST Ricardo Ribalda Delgado wrote:
> On Fri, Sep 21, 2018 at 12:38 PM Laurent Pinchart wrote:
> > On Friday, 21 September 2018 13:09:19 EEST Ricardo Ribalda Delgado wrote:
> >> Document bindings for imx214 v4l2 driver.
> > 
> > Those are bindings for the IMX214 camera sensor, not for its V4L2 driver.
> > 
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> >> ---
> >> 
> >>  .../devicetree/bindings/media/i2c/imx214.txt  | 51 +++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>  create mode 100644
> >>  Documentation/devicetree/bindings/media/i2c/imx214.txt
> >> 
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt
> >> b/Documentation/devicetree/bindings/media/i2c/imx214.txt new file mode
> >> 100644
> >> index 000000000000..4ff76d96332e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> >> @@ -0,0 +1,51 @@
> >> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> >> +
> >> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor
> >> with +an active array size of 4224H x 3176V. It is programmable through
> >> I2C
> >> +interface.
> > 
> > s/I2C interface/an I2C interface/
> > 
> >> The I2C address can be configured to to 0x1a or 0x10, depending
> >> on +how is wired.
> > 
> > Maybe "depending on how the hardware is wired" ?
> > 
> >> +Image data is sent through MIPI CSI-2, which is configured as 4 lanes
> >> +at 1440 Mbps.
> > 
> > Can the sensor use less lanes than 4, or is it fixed ?
> > 
> >> +Required Properties:
> >> +- compatible: value should be "sony,imx214" for imx214 sensor
> >> +- reg: I2C bus address of the device
> >> +- enable-gpios: Sensor enable GPIO
> > 
> > Maybe "GPIO descriptor for the enable pin" ?
> > 
> >> +- vdddo-supply: Chip digital IO regulator (1.8V).
> >> +- vdda-supply: Chip analog regulator (2.7V).
> >> +- vddd-supply: Chip digital core regulator (1.12V).
> >> +- clocks = Reference to the xclk clock.
> >> +- clock-names = Should be "xclk".
> > 
> > If there's a single clock, is the name mandatory ?
> 
> The drivers is checking for that name.  I am removing that constrain
> from the driver and fixing the doc
> 
> > > +- clock-frequency = Frequency of the xclk clock. Should be <24000000>;
> > 
> > The frequency of the clock can be queried at runtime. If you want to
> > hardcode a specific frequency in DT, you should use the
> > assigned-clock-rates property.
> 
> With the current register_tables I only support that input clock.

That's a software constraint then. You can get the programmed clock rate in 
the driver and return an error at probe time if it doesn't match what you 
support. Let's not hardcode it in the bindings.

> >> +Optional Properties:
> >> +- flash-leds: See ../video-interfaces.txt
> >> +- lens-focus: See ../video-interfaces.txt
> >> +
> >> +The imx274 device node should contain one 'port' child node with
> >> +an 'endpoint' subnode. For further reading on port node refer to
> >> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> >> +
> >> +Example:
> >> +
> >> +     camera_rear@1a {
> >> +             status = "okay";
> > 
> > Isn't that the default ?
> > 
> >> +             compatible = "sony,imx214";
> >> +             reg = <0x1a>;
> >> +             vdddo-supply = <&pm8994_lvs1>;
> >> +             vddd-supply = <&camera_vddd_1v12>;
> >> +             vdda-supply = <&pm8994_l17>;
> >> +             lens-focus = <&ad5820>;
> >> +             enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> >> +             clocks = <&mmcc CAMSS_MCLK0_CLK>;
> >> +             clock-names = "xclk";
> >> +             clock-frequency = <24000000>;
> >> +             port {
> >> +                             imx214_ep: endpoint {
> > 
> > Incorrect indentation ?
> > 
> >> +                             clock-lanes = <1>;
> >> +                             data-lanes = <0 2 3 4>;
> > 
> > Those properties are not documented. The data-lanes value is peculiar,
> > does the sensor support lanes remapping ?
> 
> I do not believe that the sensor supports lanes remapping
> 
> That is the configuration used on the db820c. Sensors with two CSI lanes
> have:
> 
>                              clock-lanes = <1>;
>                              data-lanes = <0 2>;
> 
> I just extended it to 4 lanes... but I just tried < 1 2 3 4 > and also
> works fine... so I will fix that.

Let's go for clock-lanes = <0> and data-lanes = <1 2 3 4>; then.

> >> +                             remote-endpoint = <&csiphy0_ep>;
> >> +                     };
> >> +             };
> >> +     };
> 
> I am adding all your fixes to my github tree
> 
> https://github.com/ribalda/linux/commits/imx214-v3
> 
> After people had time to give their reviews I will send v3 to the list
> (do not want to spam again the list) :P

-- 
Regards,

Laurent Pinchart



