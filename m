Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487EC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FEE20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCJUD5La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FEE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKCTrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeKCTrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:47:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D830B2081F;
        Sat,  3 Nov 2018 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541241383;
        bh=ZhoVBX/bIWNfL4OER2O1im/MwIONPmifXGKrRTRrOiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TCJUD5LaOAD1/VdeVBbnYBmsLRmxip1vY48/fxURG03HRGzIUEMFzA3qwfU4B9isy
         hZNMEezywrBBWFRsNB3rgZv4KUOgpaqw4gvWbfozQyEjOZWqAQFWSrlcCR4LIDNqkO
         RyRHR9u/oqmDcpskzdNpJFi1bi2Q/JmCAozvVFag=
Date:   Sat, 3 Nov 2018 10:36:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Iglesias <carlos.iglesias@emutex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: Add support for
 Honeywell HSC SPI sensors
Message-ID: <20181103103619.7c4addd3@archlinux>
In-Reply-To: <0dbb2254-8035-b498-6302-26bc3a2219ca@emutex.com>
References: <20181026181406.14545-1-carlos.iglesias@emutex.com>
        <20181026181406.14545-2-carlos.iglesias@emutex.com>
        <20181028173842.580ba1d4@archlinux>
        <0dbb2254-8035-b498-6302-26bc3a2219ca@emutex.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, just to draw your attention, some discussion around
spi-max-frequency that you might want to look at below.


On Tue, 30 Oct 2018 15:56:58 +0000
Carlos Iglesias <carlos.iglesias@emutex.com> wrote:

> Please see comments inline below.
Hi Carlos,

Please try to use an email client (or configure yours to do it)
that adds indentation to each level of reply.  It's somewhat
fiddly to separate the different parts of the conversation!

> 
> On 10/28/18 5:38 PM, Jonathan Cameron wrote:
> 
> On Fri, 26 Oct 2018 18:14:36 +0000
> Carlos Iglesias <carlos.iglesias@emutex.com><mailto:carlos.iglesias@emutex.com> wrote:
> 
> 
> 
> Add device tree bindings for the HSC pressure sensors.
> 
> Signed-off-by: Carlos Iglesias <carlos.iglesias@emutex.com><mailto:carlos.iglesias@emutex.com>
> ---
>  .../bindings/iio/pressure/hsc_spi.txt         | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt b/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> new file mode 100644
> index 000000000000..2302d6eef7c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
> @@ -0,0 +1,85 @@
> +Honeywell HSC Series of Pressure Sensors
> +
> +Pressure sensors from Honeywell with analog, I2C and SPI interfaces
> +
> +Required properties:
> +- compatible: selects the sensor model; must be one of the following
> +       "honeywell,hsc001baa"
> +       "honeywell,hsc001bab"
> +       "honeywell,hsc001bac"
> +       "honeywell,hsc001baf"
> +       "honeywell,hsc1_6baa"
> +       "honeywell,hsc1_6bab"
> +       "honeywell,hsc1_6bac"
> +       "honeywell,hsc1_6baf"
> +       "honeywell,hsc2_5baa"
> +       "honeywell,hsc2_5bab"
> +       "honeywell,hsc2_5bac"
> +       "honeywell,hsc2_5baf"
> +       "honeywell,hsc004baa"
> +       "honeywell,hsc004bab"
> +       "honeywell,hsc004bac"
> +       "honeywell,hsc004baf"
> +       "honeywell,hsc006baa"
> +       "honeywell,hsc006bab"
> +       "honeywell,hsc006bac"
> +       "honeywell,hsc006baf"
> +       "honeywell,hsc010baa"
> +       "honeywell,hsc010bab"
> +       "honeywell,hsc010bac"
> +       "honeywell,hsc010baf"
> +       "honeywell,hsc100kaa"
> +       "honeywell,hsc100kab"
> +       "honeywell,hsc100kac"
> +       "honeywell,hsc100kaf"
> +       "honeywell,hsc160kaa"
> +       "honeywell,hsc160kab"
> +       "honeywell,hsc160kac"
> +       "honeywell,hsc160kaf"
> +       "honeywell,hsc250kaa"
> +       "honeywell,hsc250kab"
> +       "honeywell,hsc250kac"
> +       "honeywell,hsc250kaf"
> +       "honeywell,hsc400kaa"
> +       "honeywell,hsc400kab"
> +       "honeywell,hsc400kac"
> +       "honeywell,hsc400kaf"
> +       "honeywell,hsc600kaa"
> +       "honeywell,hsc600kab"
> +       "honeywell,hsc600kac"
> +       "honeywell,hsc600kaf"
> +       "honeywell,hsc001gaa"
> +       "honeywell,hsc001gab"
> +       "honeywell,hsc001gac"
> +       "honeywell,hsc001gaf"
> +       "honeywell,hsc015paa"
> +       "honeywell,hsc015pab"
> +       "honeywell,hsc015pac"
> +       "honeywell,hsc015paf"
> +       "honeywell,hsc030paa"
> +       "honeywell,hsc030pab"
> +       "honeywell,hsc030pac"
> +       "honeywell,hsc030paf"
> +       "honeywell,hsc060paa"
> +       "honeywell,hsc060pab"
> +       "honeywell,hsc060pac"
> +       "honeywell,hsc060paf"
> +       "honeywell,hsc100paa"
> +       "honeywell,hsc100pab"
> +       "honeywell,hsc100pac"
> +       "honeywell,hsc100paf"
> +       "honeywell,hsc150paa"
> +       "honeywell,hsc150pab"
> +       "honeywell,hsc150pac"
> +       "honeywell,hsc150paf"
> +- reg: the SPI chip select number used by the sensor.
> +- spi-max-frequency: maximum clock frequency (Hz) used for the SPI bus.
> +  The maximum value supported by the sensors is 400000.
> 
> 
> As Rob pointed out in a few reviews this week, the devicetree binding
> for this should only be applying a tighter bound than either the
> device or the bus master. So something introduced by the board
> layout for example, or a level convertor..
> 
> Jonathan
> 
> Checking the devicetree bindings files of other spi sensors I see a frequent approach is to include a reference to Documentation/devicetree/bindings/spi/spi-bus.txt, for example:
> 
> Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt apply. In particular, "reg" and "spi-max-frequency" properties must be given.
The point is that spi-max-frequency doesn't actually need to be given.  If the
fine with which ever is lower of that supported by the device and that supported
by the master then it will use that without spi-max-frequency being provided.

I agree this wasn't previously my understanding but it does make sense. No
obvious reason why this value would need providing by DT unless there is
a board issue that neither of the 'ends' can see.

We might want to look at cleaning this up in general through the bindings
(and making sure device drivers apply there own maximums).  Rob
is this a worthwhile cleanup?

> 
> Maybe it would be a better option to place such a note instead of the "reg" and "spi-max-frequency" points. What do you think?
> 
> Sorry, I was not aware of Rob Herring's previous comments on this topic, I am not subscribed to the LKML.

Sure, I wasn't aware of them until that day anyway ;)

Thanks,

Jonathan

> 
> 
> 
> 
> +
> +Example:
> +
> +       hsc_spi0: hsc@0 {
> +               compatible = "honeywell,hsc010baa";
> +               reg = <0>;
> +               spi-max-frequency = <400000>;
> +       };
> 
> 
> 
> 

