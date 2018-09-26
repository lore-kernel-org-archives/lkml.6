Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE05C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBC42152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBC42152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIZWAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:00:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41535 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeIZWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:00:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so28649748oti.8;
        Wed, 26 Sep 2018 08:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lrIGf5Mhru5OG7bLuvDETiv4i7y3b/zJP8JscbrqCEw=;
        b=OSzUvqv0ILQtTalEowp9g7Uzw9Utv7JJySjbKnU4Diwzca4gGxOjy3q15NWgSerN2M
         lUItjrhuUpDHeisg8zqJ+peSYRb7s5TjGG3qSJ7V+epruMowlSYcnujz3FUHqvo6ha7I
         bg92FJvjlM+TjJCinpd43ejaCC8zXwBTaZOkp4HTtKNU6GiZBELCUJU9FHd7JlJAjyps
         mpqqJrnWFG8ev01H0F0PcT17cjeGSBDgXNklUhl1AsDjh4uGYvN7/IcAEzPbu3FjuLlh
         VVJOw4Ve5bUVtrO6J1qJANNsPzd3vCUVXzk+QDBoMgJ9AEHntpCZohsGuf/dqKauTyzk
         7x9g==
X-Gm-Message-State: ABuFfoia+YLVqavBOQCNllMHgjTFA0kS3hWhJK7bg1H/Xwx1CMu0dJpG
        CRkcDBTgic4glEB5t0hYPA==
X-Google-Smtp-Source: ACcGV61+GZERB6y1dUYEjTG8OvzJl23u6AIl4tBoWOiQfZ/eL56H9cc34i4y9wuNNlz3RFvAjjn0xQ==
X-Received: by 2002:a9d:bad:: with SMTP id 42-v6mr4288230oth.189.1537976829369;
        Wed, 26 Sep 2018 08:47:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i204-v6sm2016635oia.41.2018.09.26.08.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:47:08 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:47:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180926154708.GA3264@bogus>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913190516.GG14988@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 09:05:16PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> You can remove 'rtci-' from the subject.
> 
> On 07/09/2018 21:35:04+0200, Sam Ravnborg wrote:
> > From: Søren Andersen <san@skov.dk>
> > 
> > The NXP pcf8523 supports two different quartz loads.
> > - 7 pF (default)
> > - 12.5 pF (minimum power consumption)
> > 
> > The pcf8523 needs to know the size of the quartz load,
> > otherwise the the RTC will have a bad precision.
> > 
> > The default for the rtc (after power-on) is 7 pF.
> > Add a property that tells if the external capacitor is 12.5 pF.
> > 
> > Signed-off-by: Søren Andersen <san@skov.dk>
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 19 +++++++++++++++++++
> >  Documentation/devicetree/bindings/trivial-devices.txt |  1 -
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > new file mode 100644
> > index 000000000000..7c5e93f5077c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > @@ -0,0 +1,19 @@
> > +* NXP PCF8523 Real Time Clock
> > +
> > +NXP PCF8523 Real Time Clock
> > +
> > +Required properties:
> > +- compatible: Should contain "nxp,pcf8523".
> > +- reg: I2C address for chip.
> > +
> > +Optional property:
> > +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> > +  which differ from the default value of 7 pF
> > +
> 
> The boolean properties usually don't work well for RTCs because people
> usually want to keep any previous configuration that may have been done
> at the factory or in the bootloader so I would use:
> 
> nxp,quartz_load_fF and this would be either 7000 or 12500.

Use '-' rather than '_'.

There's already a defined unit suffix of '-picofarads'. If you need 
'-femtofarads', then please add to property-units.txt. Though I'd prefer 
not as wouldn't a value of 12 (or 13) be close enough for the needs 
here?

Rob
