Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7AB2175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7AB2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeHCPVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:21:34 -0400
Received: from verein.lst.de ([213.95.11.211]:44413 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbeHCPVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:21:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5463F68D40; Fri,  3 Aug 2018 15:30:01 +0200 (CEST)
Date:   Fri, 3 Aug 2018 15:30:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180803133001.GA23900@lst.de>
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-4-hch@lst.de> <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:08:15PM -0700, Atish Patra wrote:
> The one in the real device tree has two entries.
> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>
> Is it intentional or just incorrect entry left over from earlier days?

I'll need to SiFive folks to comment on that.  The driver itself uses
of_iomap, which as far as I can tell only needs two entries.
