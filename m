Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4920673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC4920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeGTFnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:43:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:49461 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeGTFnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:43:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6K4uDrj014252;
        Thu, 19 Jul 2018 23:56:15 -0500
Message-ID: <483b76bac7cb8043d9d780d5ffa5e43438279887.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh@kernel.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 20 Jul 2018 14:56:13 +1000
In-Reply-To: <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
         <20180711053122.30773-2-andrew@aj.id.au>
         <20180711200450.GB17291@rob-hp-laptop>
         <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
         <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
         <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
         <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
         <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
         <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
         <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
         <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
         <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
         <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
         <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 09:37 +0930, Andrew Jeffery wrote:
> > 
> > Andrew, can you start with a list that shows what you expect us to need
> > on our systems ?
> > 
> 
> Okay, our Witherspoon and Romulus platforms containing the ASPEED AST2500 currently need the following tuneables exposed:
> 
> > From the SCU:
> 
> - Debug UART enable
> - VGA DAC mux
> - VGA scratch registers 0-7
> - LPC SuperIO decode enable
> - VGA MMIO decode enable
> 
> > From the LPC controller:
> 
> - iLPC2AHB enable
> - SuperIO scratch registers 0x20-0x2f
> 
> (The LPC controller is just as much of a collection of random bits as the SCU)
> 
> Lastly, our Palmetto platform uses an AST2400 which has fewer features compared to the AST2500. Its tuneable list is the same as the above with the exception of "Debug UART enable".
> 
> Tuneables that we may need to expose in the future include:
> 
> > From the SCU:
> 
> - PCI VID/DID for the BMC PCIe device
> - VGA device enable (may need to be disabled if the platform contains a discrete graphics processor)

Additionally there's a bunch of resigters controlling the mapping of
various MMIO regions of the BMC PCIe device to portions of the BMC
address space. I'm not sure what's the best way to handle that.

This specific set might require a dedicated device as a subnode of
the SCU in the DT that contains all the mappings as properties... 

That or we consider them static enough and just whack it in u-boot.

> > From the LPC controller:
> 
> - UART mux
> 
> Alexander, Eugene, can you chime in with your platforms' needs?
> 
> Cheers,
> 
> Andrew
