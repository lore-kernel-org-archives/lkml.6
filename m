Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F37C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76E21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76E21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeHHIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:40:09 -0400
Received: from verein.lst.de ([213.95.11.211]:36274 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbeHHIkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:40:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 318BB68D60; Wed,  8 Aug 2018 08:27:25 +0200 (CEST)
Date:   Wed, 8 Aug 2018 08:27:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     robh+dt@kernel.org, Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: simplified RISC-V interrupt and clocksource handling v3
Message-ID: <20180808062725.GA15636@lst.de>
References: <20180804082319.5711-1-hch@lst.de> <mhng-d7c67842-dff7-4200-bc2e-c3eed1a0a7bf@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d7c67842-dff7-4200-bc2e-c3eed1a0a7bf@palmer-si-x1c4>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[attention Rob: Palmer said he is going to pull it in, and I'd really
 like to have your ACK on the DT bindings, can you chime in if
 everything is ok for you?]

On Tue, Aug 07, 2018 at 07:23:19PM -0700, Palmer Dabbelt wrote:
> Thanks!  Modulo the one device tree issue I replied to in patch 3 this 
> looks great!  We've already gotten the ACKs to take this through the RISC-V 
> tree, so I'm going to put this along with the queued RISC-V patches on our 
> for-next branch, including my proposed change for "sifive,plic-1.0" but 
> leaving the device tree bindings with #{address,size}-cells=1.

Note that I saw a branch that only has the actual driver patch, this
needs to be in the documentation as well of couse.  I don't really
care which name we settle on as long we agree on it, and document it
properly.
