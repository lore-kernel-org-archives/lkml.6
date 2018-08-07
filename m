Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB71C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D394E2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D394E2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbeHGUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:32:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33918 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:32:36 -0400
Received: by mail-it0-f67.google.com with SMTP id d70-v6so16077997ith.1;
        Tue, 07 Aug 2018 11:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkQ5kghvGv+MJE8EGF4dFgEFoJTFxSA9efH2ybJqCPA=;
        b=AMGqOyDyCHQ1xUBFDPgm5yEyDdCDqjBiQ+ZBKD91IUe4ZE9F3KV27bBNOYzvryB4gH
         43jI7rOl7dbBTtYIqSpPyzztNMXimSWNKvf4fJ8F55sEvDHKaUwq/XE4RaEilB98+xxq
         SgWNhy6UsgVULKuiqeMZRnkInJegD7F7f21Gz3LfCCkG2nPXDJRw5Hs/r3e1zeEVwL3L
         hgrs8rsgvTbvCeyIBYPz/XG8Kfso163/JvDmJt1sTjcrPVSAn2Q/ADhRXu9qzRN8vSjZ
         kEp1+pQjhDiS8BSXAK3nf6XRX0pFb9XeKwcB9IrqE5WlGXCGKqT4yF6A1MoYm38PEe+v
         y8gg==
X-Gm-Message-State: AOUpUlE/AK8/sibSRnO0LQjP/4/hQDbM3FTAYL92rMFm78nACF2AO5TU
        BFL/GpJdW4lBkE1bjYBiK19IbfU=
X-Google-Smtp-Source: AAOMgpc63j/9WaTpgTQdbG5/UCZ3tvzeIQewMQcebdH+MEJMZLYh8sqPffyj2hx4JKbRnWTOdNRJ+w==
X-Received: by 2002:a02:910d:: with SMTP id a13-v6mr18004578jag.14.1533665821019;
        Tue, 07 Aug 2018 11:17:01 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u24-v6sm559512iol.49.2018.08.07.11.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:17:00 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:16:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi S <sibis@codeaurora.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        ilina@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
Message-ID: <20180807181659.GA20659@rob-hp-laptop>
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <1533026547.3444.4.camel@pengutronix.de>
 <28f34ddf-03b2-0baa-c04f-15e546ef3f75@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f34ddf-03b2-0baa-c04f-15e546ef3f75@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:27:24PM +0530, Sibi S wrote:
> Hi Philipp,
> Thanks for the review!
> 
> On 07/31/2018 02:12 PM, Philipp Zabel wrote:
> > Hi Sibi,
> > 
> > On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
> > > Add SDM845 PDC (Power Domain Controller) reset controller binding
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >   .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
> > >   include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
> > >   2 files changed, 72 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > >   create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > > new file mode 100644
> > > index 000000000000..85e159962e08
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > > @@ -0,0 +1,52 @@
> > > +PDC Reset Controller
> > > +======================================
> > > +
> > > +This binding describes a reset-controller found on PDC-Global(Power Domain
> > > +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> > > +
> > > +Required properties:
> > > +- compatible:
> > > +	Usage: required
> > > +	Value type: <string>
> > > +	Definition: must be:
> > > +		    "qcom,sdm845-pdc-global"
> > > +
> > > +- reg:
> > > +	Usage: required
> > > +	Value type: <prop-encoded-array>
> > > +	Definition: must specify the base address and size of the register
> > > +	            space.
> > > +
> > > +- #reset-cells:
> > > +	Usage: required
> > > +	Value type: <uint>
> > > +	Definition: must be 1; cell entry represents the reset index.
> > > +
> > > +Example:
> > > +
> > > +pdc_reset: reset-controller@b2e0000 {
> > 
> > Is this really just a reset controller?
> > 
> > The name makes it sound like a driver binding to this should also
> > provide pm_genpd and the binding should probably call this a power-
> > controller: Documentation/devicetree/bindings/power/power_domain.txt.
> > 
> 
> The PDC-global reg space which is a part of PDC-wrapper reg space seems
> to be only used for the reset lines.
> 
> Couple of other drivers use other parts of the PDC-wrapper reg space:
> https://patchwork.kernel.org/patch/10223701/ (PDC-Interrupt controller)
> https://patchwork.kernel.org/patch/10255767/ (GMU-PDC incorrectly tries
> to occupy the entire pdc-wrapper reg space)
> 
> since it couldn't be logically mapped into pdc-interrupt driver, it had
> to be included as a separate reset driver.

You can't have overlapping regions in DT (well, you can because we have 
to work-around existing DTs that do, but you shouldn't).

A single node can be multiple providers such as interrupt controller and 
reset controller. It's an OS problem to split that into multiple 
drivers.
 
> > > +	compatible = "qcom,sdm845-pdc-global";
> > > +	reg = <0xb2e0000 0x20000>;
> > 
> > This looks like this is the register space of the complete PDC, not just
> > the reset register?
> > 
> 
> The entire register space was chosen because it is only used for its
> reset lines (had a good look at the downstream kernel and had a conversation
> with Lina) and to ensure break backward compatibility for
> the for the dt entry if the reg-space was used for other purposes in
> the future.

Why do you want to ensure breaking backwards compatibility?

Rob
