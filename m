Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FB420856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FB420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeJZE2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:28:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41113 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZE2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:28:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id c32so10335725otb.8;
        Thu, 25 Oct 2018 12:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5gR+kpYJXbZIX9AKI2xk/T7ic8kX7kaegrUdVVAe6I=;
        b=fT6OeTMm2hvksTNUAy3jkvuzLSHJ8i6XjSyuufQrRWo92pAjr/WiWDsIz9DbV51A/d
         MuE+kjq/Ki4wrDrUV+oV/rS3wZiuIwvEWt8TeeU/G31M8VZFG5q4gMjVGrksnyhaIj25
         S1n/tGnE98fn97AxHDnX9z2KlGghOdSw3auxrW8IP5beiG0ZfITbBraziEKCZ6VTZrp+
         gHjaOTa0zrsjWASDMf93FDY4iK6db24xwtca4TIySIPhmg8/1cgWDl8qCmoBhL4qKkak
         eqa3YcAWhRij6ISCasYOCmZ0Cm4/gdkxREPYuF/POTkakEceiT57JCmiQILZm1Ch+vLU
         5F7Q==
X-Gm-Message-State: AGRZ1gLYE+Vmxnlk4/rLb7pTwqPrKdFCpb4jnaW3Y79NM4UOOzxxOS1m
        wVC8OUUHMTcu4r5PCDRgfA==
X-Google-Smtp-Source: AJdET5dp0Zr7tyLFD7YQPLY384MIlo4WERP8prWksXzWyPxjp5KE30JMM0EQd18JtHiri913Ft275w==
X-Received: by 2002:a9d:11cc:: with SMTP id y12mr363950oty.241.1540497286224;
        Thu, 25 Oct 2018 12:54:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o11sm2882241otj.18.2018.10.25.12.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:54:45 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:54:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181025195444.GA12737@bogus>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
 <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
 <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:27:18PM +0200, Jacek Anaszewski wrote:
> On 10/25/2018 08:07 PM, Dan Murphy wrote:
> > Rob
> > 
> > On 10/24/2018 09:54 AM, Rob Herring wrote:
> >> On Wed, Oct 24, 2018 at 07:07:57AM -0500, Dan Murphy wrote:
> >>> Pavel
> >>>
> >>> On 10/24/2018 04:04 AM, Pavel Machek wrote:
> >>>> Hi!
> >>>>
> >>>>> The LM3697 is a single function LED driver. The single function LED
> >>>>> driver needs to reside in the LED directory as a dedicated LED driver
> >>>>> and not as a MFD device.  The device does have common brightness and ramp
> >>>>
> >>>> So it is single function LED driver. That does not mean it can not
> >>>> share bindings with the rest. Where the bindings live is not imporant.
> >>>>
> >>>
> >>> It can share bindings that are correctly done, not ones that are incomplete and incorrect.
> >>>
> >>> Where bindings live is important to new Linux kernel developers and product 
> >>> developers looking for the proper documentation on the H/W bindings.
> >>>
> >>>>> reside in the Documentation/devicetree/bindings/leds directory and follow the
> >>>>> current LED and general bindings guidelines.
> >>>>
> >>>> What you forgot to tell us in the changelog:
> >>>
> >>> I can add this to the changelog.
> >>>
> >>>>
> >>>>> +Optional child properties:
> >>>>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
> >>>>> +				the a higher brightness level.
> >>>>> +				Range from 2048 us - 117.44 s
> >>>>
> >>>> The other binding uses "ramp-up-msec". Tell us why you are changing this, or
> >>>> better don't change things needlessly.
> >>>>
> >>>> We don't want to be using "runtime-ramp-up-msec" for one device and
> >>>> "ramp-up-msec" for the other.
> >>>
> >>> This is another example of how the original bindings were incorrect and misleading.
> >>>
> >>> The LM3697 have 2 ramp implementations that can be used.
> >>>
> >>> Startup/Shutdown ramp and Runtime Ramp.  Same Ramp rates different registers and
> >>> different end user experience.
> >>>
> >>> So having a single node call ramp-up-msec is misleading and it does not
> >>> indicate what the H/W will do.
> >>
> >> The existing ones aren't documented (present in the example is not 
> >> documented). This seems like something that should be common rather than 
> >> TI specific. Though it also seems more like something the user would 
> >> want to control (i.e. sysfs) rather than fixed in DT.
> >>
> > 
> > Changing the runtime ramping or startup/shutdown ramping could also be done via sysfs.
> > I am not dedicated to having it in the DT file I was following prior art.
> > 
> > Jacek
> > 
> > Do you have an opinion on this?
> 
> This is this problem with the Device Tree's scope of responsibility.
> It is defined as a means for "describing the hardware", but often
> this rule is abused by the properties that fall into "configuration"
> category. E.g. default-state, retain-state-suspended from leds-gpio.txt
> or linux-default-trigger from common LED bindings.
> 
> In some cases this is justified. The question is whether it is something
> that necessarily needs to be configured on driver probing? If not, then
> I'd go for sysfs interface.

Yes. I'd also add it should be along the lines of for a given 
board it's always configured in that way or is it something you'd want 
in the BIOS of your PC.

Rob
