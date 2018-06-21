Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E0CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279BA20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEJjx1JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279BA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeFUNMW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:12:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44832 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeFUNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:12:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so1532927wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MszkeNOqGqLsfGyiQnXxwm7d2SNmtd1TAnEIqGGjqLc=;
        b=PEJjx1JI2R8mBciEzwDHnxkBQpZFOEWGQLetvlS1JLd4HDeE9XR61UMeH7664KO+hi
         CCniJMp0ahqfpFRKMpxVsCnLnOnZGdFF6//ZB7wsYtrNVQW9ZCpUG2V1lsFb+DEtO7qQ
         900tbs0MpTQoVvWNju7rubPHocVSfEMiaLuCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MszkeNOqGqLsfGyiQnXxwm7d2SNmtd1TAnEIqGGjqLc=;
        b=Oa5Tu8lLdDTjgP9P3yaysNxVT9eXVWCpZomQZjuM6Dtm7mA3nTyi+djwIlaDX9J6iE
         anfVoXYVFwe7fRl7C2w7QhtCjsB211zniGhZnX62bqpyFioHsnRPZULwFzGDDese9TC4
         EfwAP+EjitGo/UXZpK82yKTwy+PdmrNAG7k1MA5d9rqAbln303EtsVqsOMF3e1XIhk/w
         pPCBglP8A51WiAyGUvrwz7GIG4XbGZu6V4+bGR3TbSpTu8axmwSSgYmCHN9enZ8U6Qcl
         /G41eBqSZrdqFm3VxEXssDLQf1EYEi6/Gvfujdpjizb+U3HdwBreC6wVwDoBMQ8xyv7n
         uBIg==
X-Gm-Message-State: APt69E2bCMjPg0Qp5e5fMXm4BE5Fz8p0qhHlrNSUpMHt5GVWTzMzAabW
        dvuHsQ6XSUk5os2nTbcW9E2Deg==
X-Google-Smtp-Source: ADUXVKIFXhwHIMpjaVBhOlGCcxXVudo+u6QCirc/KrOwX6mJgJAZPG3MEvD4ABikwuc3L280No8J1A==
X-Received: by 2002:adf:c358:: with SMTP id e24-v6mr21055982wrg.257.1529586734481;
        Thu, 21 Jun 2018 06:12:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x11-v6sm1890081wrl.80.2018.06.21.06.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:12:13 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:12:11 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 1/7] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
Message-ID: <20180621131211.e3sa6m4hnq5ncund@holly.lan>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
 <20180621130559.smwwh4qsjswmrorc@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621130559.smwwh4qsjswmrorc@holly.lan>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:05:59PM +0100, Daniel Thompson wrote:
> On Tue, Jun 19, 2018 at 04:43:36PM +0530, Kiran Gunda wrote:
> > pm8941-wled.c driver is supporting the WLED peripheral
> > on pm8941. Rename it to qcom-wled.c so that it can support
> > WLED on multiple PMICs.
> > 
> > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> 
> With changes proposed for v4:

Ignore that bit... misremembered the thread to date.

It's just a plain (no caveat):
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> 
> > ---
> >  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-
> >  drivers/video/backlight/Kconfig                                   | 8 ++++----
> >  drivers/video/backlight/Makefile                                  | 2 +-
> >  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >  rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
> >  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> > similarity index 95%
> > rename from Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> > rename to Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> > index e5b294d..fb39e32 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> > @@ -1,4 +1,4 @@
> > -Binding for Qualcomm PM8941 WLED driver
> > +Binding for Qualcomm Technologies, Inc. WLED driver
> >  
> >  Required properties:
> >  - compatible: should be "qcom,pm8941-wled"
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index 4e1d2ad..8c095e3 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -299,12 +299,12 @@ config BACKLIGHT_TOSA
> >  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
> >  	  for its backlight
> >  
> > -config BACKLIGHT_PM8941_WLED
> > -	tristate "Qualcomm PM8941 WLED Driver"
> > +config BACKLIGHT_QCOM_WLED
> > +	tristate "Qualcomm PMIC WLED Driver"
> >  	select REGMAP
> >  	help
> > -	  If you have the Qualcomm PM8941, say Y to enable a driver for the
> > -	  WLED block.
> > +	  If you have the Qualcomm PMIC, say Y to enable a driver for the
> > +	  WLED block. Currently it supports PM8941 and PMI8998.
> >  
> >  config BACKLIGHT_SAHARA
> >  	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
> > diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> > index 5e28f01..6fd76ef 100644
> > --- a/drivers/video/backlight/Makefile
> > +++ b/drivers/video/backlight/Makefile
> > @@ -49,8 +49,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
> >  obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
> >  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
> >  obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
> > -obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
> >  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
> > +obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
> >  obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
> >  obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
> >  obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
> > diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/qcom-wled.c
> > similarity index 100%
> > rename from drivers/video/backlight/pm8941-wled.c
> > rename to drivers/video/backlight/qcom-wled.c
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >  a Linux Foundation Collaborative Project
> > 
