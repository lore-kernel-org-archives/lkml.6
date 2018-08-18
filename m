Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A214CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0D21710
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFCyq9yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0D21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeHRUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRUL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:11:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6690421570;
        Sat, 18 Aug 2018 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534611785;
        bh=DCSZu/+Hyw9mANfiR1dU3Hu2no6oaZ7dn2OTp9Filxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFCyq9yGkZaOFtcEOcTqZKMNKD9wmnxSX/Gzh+3wzBYhxyTJrmuj8QY7IVGRPShWe
         IY9WFJlvj2uUYJn9zk53HdSoaCrSpv+uYr9/0XtBVFzCdN7CICF5AD4UDBxb/RyvEN
         FzrHZ/RrxQN6H4FB5UVtNoImANh/xXaGn1gHHInM=
Date:   Sat, 18 Aug 2018 18:02:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 6/9] dt-bindings: iio: tsl2772: add bindings for
 regulator framework
Message-ID: <20180818180259.7138d7da@archlinux>
In-Reply-To: <20180807172028.GA10650@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-7-masneyb@onstation.org>
        <20180803225123.137d15ac@archlinux>
        <20180807172028.GA10650@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 11:20:28 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Aug 03, 2018 at 10:51:23PM +0100, Jonathan Cameron wrote:
> > On Thu,  2 Aug 2018 20:18:57 -0400
> > Brian Masney <masneyb@onstation.org> wrote:
> >   
> > > This patch adds device tree bindings to the tsl2772 driver for the
> > > regulator framework.
> > > 
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>  
> > I suspect Rob will tell you this should really have been in the same
> > patch as the earlier bindings.   There is no need for us to wait
> > for the driver support as the binding describes what is there, not
> > what we do with it.  
> 
> Yep.
> 
> > 
> > Otherwise it's fine and if nothing else comes up I can merge them ;)

I merged them.

Jonathan
> > 
> > Jonathan
> >   
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > index 6f33169344f2..4e7d98627cbf 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > @@ -21,6 +21,8 @@ Optional properties:
> > >                                 are the only valid values.
> > >    - led-max-microamp - current for the proximity LED. Must be 100000, 50000,
> > >                         25000, or 13000.
> > > +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> > > +  - vddio-supply: phandle to the regulator that provides power to the bus.
> > >    - interrupts: the sole interrupt generated by the device
> > >  
> > >    Refer to interrupt-controller/interrupts.txt for generic interrupt client
> > > @@ -32,6 +34,8 @@ tsl2772@39 {
> > >  	compatible = "amstaos,tsl2772";
> > >  	reg = <0x39>;
> > >  	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> > > +	vdd-supply = <&pm8941_l17>;
> > > +	vddio-supply = <&pm8941_lvs1>;
> > >  	amstaos,proximity-diodes = <0>;
> > >  	led-max-microamp = <100000>;
> > >  };  
> >   

