Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FDFC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F1C21772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F1C21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeHHRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:24:12 -0400
Received: from verein.lst.de ([213.95.11.211]:38326 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHRYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:24:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6137D68D64; Wed,  8 Aug 2018 17:09:38 +0200 (CEST)
Date:   Wed, 8 Aug 2018 17:09:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atish.patra@wdc.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180808150938.GA32274@lst.de>
References: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com> <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4> <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:16:14AM -0600, Rob Herring wrote:
> Is 1.0 an actual version number corresponding to an exact, revision
> controlled version of the IP or just something you made up? Looks like
> the latter to me and I'm not a fan of s/w folks making up version
> numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
> unless you have good reason to deviate (IP for FPGAs where version
> numbers are exposed to customers is one example).
> 
> And defining a version 2 when you find a quirk doesn't work. You've
> already shipped the DT. You need to be able to fix issues with just an
> OS update. This is why you are supposed to define a compatible string
> for each and every SoC (and use a fallback when they are "the
> same"TM).

Can you point to some existing examples of the multiple offered
compatible strings and what is actually matched for something that
largely hasn't changed?

For example the documentation for the arm GICv3 binding seems to just
match for arm,gic-v3.  On the other hand the GIC driver seems to match
for a lot of different strings.
