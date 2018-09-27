Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E43215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E43215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeI1BT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:19:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38217 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:19:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id u197-v6so3140457oif.5;
        Thu, 27 Sep 2018 11:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05F9Jxk6N7hR49jNWtj/OQvJWH5h6X95KO/1U8GKvjU=;
        b=JJHFJcl7CT3fxc0ybWSYFa/NVI4uLweUM+5Gxx1sF1o6es4+uCoaG1/jURcUp2XbbZ
         dlBohha5oZdBI2MGquA2NyRTUK84HQp+dsIVmwpzRztvbzjByAGDRIPaNfkPGXjEm04X
         vqg32n6pqHd2C2hVaT7f4AYNoB0XwnLPYCcEeIFPgS0Lf3sk4oswpDKhegcqqs0MtJqA
         dHW0r5cWdQ+oWGtunZdLQZ6DbaVzNz5GYtIvnIpzvflovJA+NuH11+QG6mgtt9asRi6y
         hQQ6vAScR8+ef2Pk/ULaj6+oZGk0+yHHTVMD4POZ42kFCjsc4bqO7Rogsgy7i9SFxOV6
         uJIw==
X-Gm-Message-State: ABuFfohq5pU+cfVqSRnx6eRRXlKFLh7MJyLtfJ0QejPy0imcSbtl1oBx
        vqF5lgxc4Z6trhaRk5UhMg==
X-Google-Smtp-Source: ACcGV62kerD4we229IoaVU5fENCOU96zyDW/M/Z/eswLhtFzsIuhi8nFZCmPQtyosy7SPzshTeeQUA==
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr3552523oih.31.1538074784370;
        Thu, 27 Sep 2018 11:59:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z33-v6sm1075427otz.71.2018.09.27.11.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:59:43 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:59:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20180927185943.GA31385@bogus>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
 <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
 <20180927172758.GA17761@bogus>
 <b1099893-f704-8ca6-a945-2711d6945a0f@gmail.com>
 <f20afabc-e712-8f35-8dd6-d42b9a0131f0@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20afabc-e712-8f35-8dd6-d42b9a0131f0@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:00:33AM -0700, Scott Branden wrote:
> 
> 
> On 18-09-27 10:31 AM, Florian Fainelli wrote:
> > On 09/27/2018 10:27 AM, Rob Herring wrote:
> > > On Thu, Sep 27, 2018 at 09:06:41PM +0530, Srinath Mannam wrote:
> > > > From: Pramod Kumar <pramod.kumar@broadcom.com>
> > > > 
> > > > Add binding document for supported thermal implementation
> > > > in Stingray.
> > > > 
> > > > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> > > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > ---
> > > >   .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
> > > >   1 file changed, 25 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > > new file mode 100644
> > > > index 0000000..717617b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > > > @@ -0,0 +1,25 @@
> > > > +* Broadcom Stingray Thermal
> > > > +
> > > > +This binding describes thermal sensors that is part of Stingray SoCs.
> > > > +
> > > > +Required properties:
> > > > +- compatible : Must be "brcm,sr-thermal"
> > > > +- reg : memory where tmon data will be available.
> > > > +- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
> > > > +                  Each bit represents single TMON source.
> > > > +- brcm,max-crit-temp: Maximum supported critical temperature.
> > > We already have a defined binding for setting trip points.
> > Indeed, and if you have multiple TMONs, they would in premise possibly
> > each have a different critical trip point.
> Which may be a good reason to go back to our original bindings which were
> generic and had each sensor in its own node?

Perhaps. I wouldn't call it going back to your original, but rather 
defining a complete binding. Of course, if you don't need different trip 
points, then again that is just unnecessary bloat. But I can't argue 
whether you do or don't.

Rob
