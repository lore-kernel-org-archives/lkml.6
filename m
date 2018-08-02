Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F02214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F02214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeHBLlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:41:11 -0400
Received: from verein.lst.de ([213.95.11.211]:38890 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeHBLlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:41:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C93DA68D64; Thu,  2 Aug 2018 11:55:27 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:55:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC
        documentation
Message-ID: <20180802095527.GD14203@lst.de>
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-7-hch@lst.de> <20180731224630.GB12168@rob-hp-laptop> <20180801071635.GC20224@lst.de> <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:26:31PM -0600, Rob Herring wrote:
> Not really my problem that they didn't follow the process and upstream
> their binding first. But this alone is just a string identifier, so I
> don't really care that much. If things are really a mess, then the
> next implementations will have to have better compatible strings. More
> likely, I'll just see folks trying to add various properties to deal
> with all the differences.
> 
> You could always define a better compatible and leave 'riscv,plic0' as
> a fallback to avoid breaking things.

Is there any better way to define a compatible other than having
duplicate IRQCHIP_DECLARE() statements?
