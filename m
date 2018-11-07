Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D9DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576392089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576392089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeKHHFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:05:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47582 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeKHHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:05:38 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gKVRp-0008Df-1X; Wed, 07 Nov 2018 22:33:13 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: tmp108: add optional interrupts and #thermal-sensor-cells
Date:   Wed, 07 Nov 2018 22:33:12 +0100
Message-ID: <5910167.PXNgySJWA7@diego>
In-Reply-To: <20181107183958.GB5468@roeck-us.net>
References: <20181107154708.422-1-heiko@sntech.de> <20181107183958.GB5468@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am Mittwoch, 7. November 2018, 19:39:58 CET schrieb Guenter Roeck:
> On Wed, Nov 07, 2018 at 04:47:08PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@bq.com>
> > 
> > The tmp108 does have an alert output that can be used as interrupt source
> > and can of course also be used as part of a thermal sensor setup for
> > things
> > like thermal-based cpu frequencies, so document the necessary properties.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> Do you also plan to actually implement interrupt support in the driver ?

Not right now but I'm hoping down the road.

The main argument for including this standard property is that
the dt-binding is of course a description of the hardware and not the
state of the linux driver and the tmp108 obviously has that alert output
pin, hence I'd really like to already have it in the new board-dts I'm
currently working on so it simply magically works once the driver can
use it :-) .


Heiko

> > ---
> > 
> >  Documentation/devicetree/bindings/hwmon/tmp108.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > b/Documentation/devicetree/bindings/hwmon/tmp108.txt index
> > 8c4b10df86d9..54d4beed4ee5 100644
> > --- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > 
> > @@ -7,6 +7,10 @@ Requires node properties:
> >  - compatible : "ti,tmp108"
> >  - reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
> > 
> > +Optional properties:
> > +- interrupts: Reference to the TMP108 alert interrupt.
> > +- #thermal-sensor-cells: should be set to 0.
> > +
> > 
> >  Example:
> >  	tmp108@48 {
> >  	
> >  		compatible = "ti,tmp108";




