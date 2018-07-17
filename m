Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2127ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75425208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75425208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeGQF1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:27:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:56317 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeGQF1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:27:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6H4uLKh017502;
        Mon, 16 Jul 2018 23:56:22 -0500
Message-ID: <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 17 Jul 2018 14:56:21 +1000
In-Reply-To: <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
         <20180711053122.30773-2-andrew@aj.id.au>
         <20180711200450.GB17291@rob-hp-laptop>
         <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
         <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
         <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
         <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
         <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> If that data is one set per SoC, then i'm not that concerned having
> platform-specific data in the driver. That doesn't mean the driver is
> not "generic". It's still not clear to me in this thread, how much of
> this is board specific, but given that you've placed all the data in
> an SoC dtsi file it seems to be all per SoC.

So Rob, I think that's precisely where the disconnect is.

I think we all (well hopefully) agree that those few tunables don't fit
in any existing subystem and aren't likely to ever do (famous last
words...).

Where we disagree is we want to make this parametrized via the DT, and
you want us to hard wire the list in some kind of SoC driver for a
given SoC family/version.

The reason I think hard wiring the list in the driver is not a great
solution is that that list in itself is prone to variations, possibly
fairly often, between boards, vendors, versions of boards, etc...

We can't know for sure every SoC tunable (out of the gazillions in
those chips) are going to be needed for a given system. We know which
ones we do use for ours, and that's a couple of handfuls, but it could
be that Dell need a slightly different set, and so might Yadro, or so
might our next board revision for that matter.

Now, updating the device-tree in the board flash with whatever vendor
specific information is needed is a LOT easier than getting the kernel
driver constantly updated. The device-tree after all is there to
reflect among other things system specific ways in which the SoC is
wired and configured. This is rather close...

Cheers,
Ben.

