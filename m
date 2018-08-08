Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3325AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB5321A32
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB5321A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHHTMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:12:31 -0400
Received: from verein.lst.de ([213.95.11.211]:38902 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeHHTMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:12:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8101868D60; Wed,  8 Aug 2018 18:57:29 +0200 (CEST)
Date:   Wed, 8 Aug 2018 18:57:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atish.patra@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180808165729.GA6079@lst.de>
References: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com> <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4> <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com> <20180808150938.GA32274@lst.de> <bb671fe1-6c43-3218-0096-7c5280ffb6b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb671fe1-6c43-3218-0096-7c5280ffb6b5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 05:47:40PM +0100, Marc Zyngier wrote:
> The original GIC driver deals with 2.5 revisions of the architecture
> (yes, there was something pre-GICv1...), and implementers have been
> creative to the extreme. Still, we could have done without most of these
> compat strings. Hindsight and all that jazz.
> 
> GICv3 is a much more controlled architecture, and although people have
> come up with a number of turds masquerading as implementations, it has
> never been bad enough to mandate a different set of compat strings.
> Also, you cannot describe that kind of stuff in ACPI, and we need to
> support both, so we've come up with different ways of handling this.

So the claim from SiFive is that all their current plic blocks are
the same.  Based on that I'd be really tempted to just match for
sifive,plic (or sifive,plic1 as suggested by them), but also require
each device to actually provide a board specific compatible string,
just in case that something goes wrong.  Which I suspect is what you
are doing with GICv3, right?
