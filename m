Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDFF2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDFF2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeHCOZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:25:16 -0400
Received: from verein.lst.de ([213.95.11.211]:44179 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeHCOZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:25:15 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 37BFD68D40; Fri,  3 Aug 2018 14:33:57 +0200 (CEST)
Date:   Fri, 3 Aug 2018 14:33:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 09/11] RISC-V: Support per-hart timebase-frequency
Message-ID: <20180803123357.GC18301@lst.de>
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-10-hch@lst.de> <fef973e1-6efc-0eff-2789-4a4b5b01900b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef973e1-6efc-0eff-2789-4a4b5b01900b@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:19:49PM -0700, Atish Patra wrote:
> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>> From: Palmer Dabbelt <palmer@sifive.com>
>>
>> Follow the updated DT specs and read the timebase-frequency from the
>> CPU 0 node.
>>
>
> However, the DT in the HighFive Unleashed has the entry at the wrong place.
>
> Even the example in github also at wrong place.
> https://github.com/riscv/riscv-device-tree-doc/pull/8/commits/2461d481329c55005fcbe684f0d6bdb3b7f0a432
>
> DT should be consistent between Documentation and the one in the hardware. 
> I can fix them in bbl & submit a bbl patch. But I am not sure if that's an 
> acceptable way to do it.

I'll need to have comments from Palmer and/or someone else at SiFive
here.  Personally I really don't care where we document the timebase,
as this patch supports both locations anywhere.  For now I'll just update
the commit log to state that more explicitly.
