Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC59520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC59520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbeHAI4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:56:19 -0400
Received: from verein.lst.de ([213.95.11.211]:32869 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733082AbeHAI4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:56:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 636B4DE937; Wed,  1 Aug 2018 09:16:35 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:16:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        palmer@sifive.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180801071635.GC20224@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-7-hch@lst.de> <20180731224630.GB12168@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731224630.GB12168@rob-hp-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:46:30PM -0600, Rob Herring wrote:
> Perhaps this should be 'sifive,plic0'

Excepet for the fact this the old name has already been in shipping
hardware and release of qemu and other emulators it should.

> Normally this would have an SoC specific compatible too. Sometimes we 
> can get away without, but it doesn't seem like the PLIC is very tightly 
> specified nor has common implementations.

It is a giant f***cking mess to be honest.  Adding a highlevel spec
to the ISA but not a register layout is completely idotic, but if you
look at the current riscv-sw list this decision is still defended by
SiFive / the RISC-V foundation.  The whole stale of the RISC-V platform
Ecosystem is rather pathetic unfortunately, and people don't seem to
be willing to learn from past good practice nor mistakes in ARM land.
