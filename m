Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA2AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AB21524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1AB21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbeHGTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:35:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38459 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbeHGTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:35:50 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so24023495itb.3;
        Tue, 07 Aug 2018 10:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSDzrZf5QmFJJFNFweIetr0TXrEXWQDiDEQQsAi2E50=;
        b=i/o3KNcw/0fCT7DJtuY8g5uIUek4hXj+sReQYYTsgcgC0vejb0u5XgNS2a75YpPkHf
         10sDvjQZOMEsIVkjrbIO7Nfb4JQUyRZIx1+RWcAGPRddgEewQx0vM8GllWveVytbUBV9
         l1pNLMgEvw9ioAtEhRrDoSfN4OMq+onWcgVkEVqppzNW5mIzLi8AatscCsfYjiTLn7eS
         Q9TfimoXc16bl0Vkw8QQKEDTgwinOjBWx4PA9csV5gN9gO2EiYWunlVb7mY5mU8kKNmz
         xxLxF3r4HVfiPjPRIyKvf+ODpQdkJgNKjZeFjo/S4K8K+H8cBUZ5js8Hp95Z6friGaU4
         pMsw==
X-Gm-Message-State: AOUpUlE8zjDurrchdADTjjenlv+yFhXwlC4x0ZV91y5vI7UpOa3eqSsT
        a/KDe80zC+d80LrwGjzK/g==
X-Google-Smtp-Source: AA+uWPy1StMd3aarroFP/l+kG8I1IEzXyDTk4BgGT7B9Vy8lA39i0H2g14YooZqunk+OraOTKgPyTA==
X-Received: by 2002:a24:118f:: with SMTP id 137-v6mr2758877itf.30.1533662429957;
        Tue, 07 Aug 2018 10:20:29 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id r12-v6sm529328iog.13.2018.08.07.10.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:20:29 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:20:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20180807172028.GA10650@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
 <20180803001900.25371-7-masneyb@onstation.org>
 <20180803225123.137d15ac@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803225123.137d15ac@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:51:23PM +0100, Jonathan Cameron wrote:
> On Thu,  2 Aug 2018 20:18:57 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch adds device tree bindings to the tsl2772 driver for the
> > regulator framework.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> I suspect Rob will tell you this should really have been in the same
> patch as the earlier bindings.   There is no need for us to wait
> for the driver support as the binding describes what is there, not
> what we do with it.

Yep.

> 
> Otherwise it's fine and if nothing else comes up I can merge them ;)
> 
> Jonathan
> 
> > ---
> >  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > index 6f33169344f2..4e7d98627cbf 100644
> > --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > @@ -21,6 +21,8 @@ Optional properties:
> >                                 are the only valid values.
> >    - led-max-microamp - current for the proximity LED. Must be 100000, 50000,
> >                         25000, or 13000.
> > +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> > +  - vddio-supply: phandle to the regulator that provides power to the bus.
> >    - interrupts: the sole interrupt generated by the device
> >  
> >    Refer to interrupt-controller/interrupts.txt for generic interrupt client
> > @@ -32,6 +34,8 @@ tsl2772@39 {
> >  	compatible = "amstaos,tsl2772";
> >  	reg = <0x39>;
> >  	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> > +	vdd-supply = <&pm8941_l17>;
> > +	vddio-supply = <&pm8941_lvs1>;
> >  	amstaos,proximity-diodes = <0>;
> >  	led-max-microamp = <100000>;
> >  };
> 
