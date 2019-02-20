Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6683121738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/0Pft9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfBTBWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:22:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41344 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfBTBWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:22:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so10974981pgq.8;
        Tue, 19 Feb 2019 17:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jirMJR6OXKA94AUCEPBAMxfWc0nU/EYAhogmk+ZdqyU=;
        b=E5/0Pft923Sv4s/K/P1bnkntKbS3NBVCG6f49ROCGlCak8ENVKWQkSxf6aQd50GDhc
         RNeOPbxkuKJidUtcjcjrYY4yRlrUF7R3NsljnFcxS5rWWYT/ISDtDvT5X/tcUfbsr/LU
         mWJ39cSDyPxbQMPjxof/Qe+ENgO+c8VhBqsfZQLQioec6CMtHpL7/tFbKdyM7DdvSrzx
         WewMcGuixItwZVGdqURb7CmuWngxp2Icx7w2+UP+0bxpshbM9CnmqYKsUnNO1/jCwj2F
         DMgkFNV7NqEpURz1crCvikss9vk3O5uWC0OVgaeT/DW84Q+Ojp7PtzCfz5CbWLFt1M9m
         K9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jirMJR6OXKA94AUCEPBAMxfWc0nU/EYAhogmk+ZdqyU=;
        b=ED8BQah5IuoHMZRouZ7fxyyMe9musPEyuk1Jk2BohcToU6ybvNwgWzM52ujaXJ3W0m
         zDXfvjzFLd74AKfB+Eqx/QOXqh6vNMRJTUURXVD8bs0JW0UhCU3qbegmtb/CdonRUd8j
         ACkUtRBa8jPudYJvetV/q65thcgqq1Mtv/MZ6uvZZ08xEQQ6eUue81TRqV0WMQUdDXGF
         z6cN1RKufID4gsLraidHNjrm4QwyFCizIDyMycX0PMSuEcGL6EgONoPaIYPOCOrA4aCn
         7pUZRGUsQ+Psojhx85HIJDvYQAmqAKvqL/hYEdKT9zmeDAKmFZ72bV8DZ5yFKefR/9Vl
         tQXg==
X-Gm-Message-State: AHQUAuaWC5wFp387o09yFCVr3Isvtqf7lCQgd35r7X47rJHQcDT6gIGi
        MMZiTSb6TxT3Ou8dtSQHV9o=
X-Google-Smtp-Source: AHgI3IbZIMP+0UHcWz+0SR3KjBRZ5vGJXgU0CBaF+d9lBWoZkiUW1QDwY/aZ0QnhfN8I6W8Xd2AmHg==
X-Received: by 2002:a65:410a:: with SMTP id w10mr3772063pgp.206.1550625736746;
        Tue, 19 Feb 2019 17:22:16 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id x23sm42131170pfe.0.2019.02.19.17.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:22:15 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:22:13 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, thierry.reding@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 01/12] of: Add bindings of thermtrip for Tegra soctherm
Message-ID: <20190220012212.GE2811@localhost.localdomain>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-3-git-send-email-wni@nvidia.com>
 <20181227230630.GA3659@bogus>
 <1441d2d1-acfa-7b8d-5ed8-c2ca257df05d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441d2d1-acfa-7b8d-5ed8-c2ca257df05d@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:28:42AM +0800, Wei Ni wrote:
> 
> 
> On 28/12/2018 7:06 AM, Rob Herring wrote:
> > On Tue, Dec 18, 2018 at 03:34:33PM +0800, Wei Ni wrote:
> >> Add optional property "nvidia,thermtrips".
> >> If present, these trips will be used as HW shutdown trips,
> >> and critical trips will be used as SW shutdown trips.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>  .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
> >>  1 file changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> >> index b6c0ae53d4dc..ab66d6feab4b 100644
> >> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> >> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> >> @@ -55,10 +55,21 @@ Required properties :
> >>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
> >>          See ./thermal.txt for a description of this property.
> >>  
> >> +Optional properties:
> >> +- nvidia,thermtrips : When present, this property specifies the temperature at
> >> +  which the soctherm hardware will assert the thermal trigger signal to the
> >> +  Power Management IC, which can be configured to reset or shutdown the device.
> >> +  It is an array of pairs where each pair represents a tsensor id followed by a
> >> +  temperature in milli Celcius. In the absence of this property the critical
> >> +  trip point will be used for thermtrip temperature.
> >> +
> >>  Note:
> >> -- the "critical" type trip points will be set to SOC_THERM hardware as the
> >> -shut down temperature. Once the temperature of this thermal zone is higher
> >> -than it, the system will be shutdown or reset by hardware.
> >> +- the "critical" type trip points will be used to set the temperature at which
> >> +the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
> >> +property is missing. When the thermtrips property is present, the breach of a
> >> +critical trip point is reported back to the thermal framework to implement
> >> +software shutdown.
> > 
> > This hardly seems like a NVidia specific concept. A h/w shutdown 
> > temperature... Come up with something common.
> 
> Hi Rob,
> In current thermal framework, it doesn't support to set h/w shutdown
> trips, the "critical" trip is used for s/w shutdown. I noticed that in
> rockchip-thermal driver, it also used "rockchip,hw-tshut-temp" to set
> h/w shutdown temperature.

Why a critical trip point cannot be used for your hw shutdown too?

> 
> > 
> > Also, we already have a temperature table. Why do we need temperatures 
> > in 2 places.
> 
> Sorry, what do you mean temperature table? Do you mean the trip nodes?
> 
> Thanks.
> Wei.
> 
> > 
> >> +
> >>  - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
> >>  temperature. Once the the temperature of this thermal zone is higher
> >>  than it, it will trigger the HW throttle event.
> >> @@ -79,6 +90,9 @@ Example :
> >>  
> >>  		#thermal-sensor-cells = <1>;
> >>  
> >> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
> >> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
> >> +
> >>  		throttle-cfgs {
> >>  			/*
> >>  			 * When the "heavy" cooling device triggered,
> >> -- 
> >> 2.7.4
> >>
