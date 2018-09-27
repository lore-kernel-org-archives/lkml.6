Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8E21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8E21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeI1ACU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:02:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39363 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI1ACU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:02:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so2913662oia.6;
        Thu, 27 Sep 2018 10:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6d+A0Vv/nUcoBcJgB2dAUxIRKszMsUmC1lmMSWxwrU=;
        b=Oz+Ny8OC04NrbjiUCbFKAx0prxsaMexiLvhAwupuY7jXSZHPTQ5mzybH8KqnG3ctOH
         DAY7pDz7iB1V4wnutrdx8H4JoPZ3UEWohFmBv5DJGN2gsiKfJlw/R8eCEqjCgUZWXy43
         Q1MmxWAtkNCfa0sxfA1ZvxmMuLHgdQVFRPfd+AKtEZb+gZ2ZsN7MHbsMeiy7mubzpeQm
         /dvIYmyQIeW7Nd42XUEMoTp3HSXwJFnswkq904Zt6WVtcEEqrf8nURDGamA85SsqMvRS
         IJke6xR+fKPFh3QajIYAryyjvb5R4JSGdtLu/hIx1wwYgCbWnZi3zPEsIGliTHCT3qcu
         UX0Q==
X-Gm-Message-State: ABuFfog7vI4CPxHM+Vz7ksRAQOU8XFURHR/Bkc6StVsBwtvqcOdwvClD
        gKCvtp4JbF6rClbmzRMefA==
X-Google-Smtp-Source: ACcGV63Ta0cnnjSFSVEVROKO7NV0iBPoUjGfKwjU3KDyECgej/6SDB+ucKP+XrbAKtiEt/y/qbqgYw==
X-Received: by 2002:aca:5108:: with SMTP id f8-v6mr3811935oib.272.1538070176911;
        Thu, 27 Sep 2018 10:42:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n30-v6sm1176935otb.73.2018.09.27.10.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:42:56 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:42:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        mark.rutland@arm.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180927174255.GA7587@bogus>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
 <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 06:52:29PM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On 09/25/2018 03:59 PM, Nicolin Chen wrote:
> > Texas Instruments INA3221 is a triple-channel shunt and bus
> > voltage monitor. This patch adds a DT binding doc for it.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > Changelog
> > v4->v5:
> >   * Replaced "input-id" with "reg" and added address-cells and size-cells
> >   * Replaced "input-label" with "label"
> >   * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
> > v3->v4:
> >   * Removed the attempt of putting labels in the node names
> >   * Added a new optional label property in the child node
> >   * Updated examples accordingly
> > v2->v3:
> >   * Added a simple subject in the line 1
> >   * Fixed the shunt resistor value in the example
> > v1->v2:
> >   * Dropped channel name properties
> >   * Added child node definitions.
> >   * * Added shunt resistor property in the child node
> >   * * Added status property to indicate connection status
> >   * * Changed to use child node name as the label of input source
> > 
> >   .../devicetree/bindings/hwmon/ina3221.txt     | 49 +++++++++++++++++++
> >   1 file changed, 49 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> > new file mode 100644
> > index 000000000000..e17a897f4803
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> > @@ -0,0 +1,49 @@
> > +Texas Instruments INA3221 Device Tree Bindings
> > +
> > +1) ina3221 node
> > +  Required properties:
> > +  - compatible: Must be "ti,ina3221"
> > +  - reg: I2C address
> > +
> > +  Optional properties:
> > +  = The node contains optional child nodes for three channels =
> > +  = Each child node describes the information of input source =
> > +
> > +  - #address-cells: Required only if a child node is present. Must be 1.
> > +  - #size-cells: Required only if a child node is present. Must be 0.
> > +
> > +  Example:
> > +
> > +  ina3221@40 {
> > +          compatible = "ti,ina3221";
> > +          reg = <0x40>;
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          [ child node definitions... ]
> > +  };
> > +
> > +2) child nodes
> > +  Required properties:
> > +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> > +
> > +  Optional properties:
> > +  - label: Name of the input source
> > +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> > +  - status: Should be "disabled" if no input source
> > +
> > +  Example:
> > +
> > +  input@0 {
> > +          reg = <0x0>;
> > +          status = "disabled";
> 
> I kind of feel embarrassed that I asked for the reg change ... especially while
> saying at the same time that I would like to see this work for other chips
> as well.
> 
> Other chips have different kinds of sensors. Voltage, current, power, temperature,
> and others. Whatever we come up with should support that.
> 
> I see two possibilities right now. We can stick with reg and add a "type" property,
> or we can make the index something like
> 	{voltage,current,power,temperature,humidity}-{id,index}
> 
> I personally prefer "type", but I don't really have a strong opinion.
> What do you think ? Or maybe we should really wait for feedback from Rob.

reg and 'type' is my preference though just 'type' may be too vague. For 
this case I don't think we need it if there's only one possible type as 
the driver should know that.

Rob
