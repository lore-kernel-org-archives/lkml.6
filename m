Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0833C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB4D208FC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB4D208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbeHGJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:28:13 -0400
Received: from verein.lst.de ([213.95.11.211]:59627 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732910AbeHGJ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:28:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8605B68D62; Tue,  7 Aug 2018 09:20:34 +0200 (CEST)
Date:   Tue, 7 Aug 2018 09:20:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180807072034.GA569@lst.de>
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-4-hch@lst.de> <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com> <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:59:48PM -0600, Rob Herring wrote:
> > > +Required properties:
> > > +- compatible : "sifive,plic0"
> > > +- #address-cells : should be <0>
> > > +- #interrupt-cells : should be <1>
> > > +- interrupt-controller : Identifies the node as an interrupt controller
> > > +- reg : Should contain 1 register range (address and length)
> >
> > The one in the real device tree has two entries.
> > reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
> >
> > Is it intentional or just incorrect entry left over from earlier days?
> 
> > > +             reg = <0xc000000 0x4000000>;
> 
> Looks to me like one has #size-cells and #address-cells set to 2 and
> the example is using 1.

Yes.  And it seems like the real life device tree is simply bogus.
