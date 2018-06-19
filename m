Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5062C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DB320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DB320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFSWch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:32:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58458 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeFSWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:32:34 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVPAc-0004iO-Ov; Wed, 20 Jun 2018 00:32:14 +0200
Date:   Wed, 20 Jun 2018 00:32:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
In-Reply-To: <20180619213644.GC112652@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806200031370.10546@nanos.tec.linutronix.de>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com> <1529118375-90191-2-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806191057210.1692@nanos.tec.linutronix.de> <20180619213644.GC112652@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Fenghua Yu wrote:

> On Tue, Jun 19, 2018 at 10:57:44AM +0200, Thomas Gleixner wrote:
> > On Fri, 15 Jun 2018, Fenghua Yu wrote:
> > 
> > > MOVDIRI moves doubleword or quadword from register to memory through
> > > direct store which is implemented by using write combining (WC) for
> > > writing data directly into memory without caching the data.
> > 
> > And that is useful for what?
> 
> Programmable agents can handle streaming offload (e.g. high speed packet
> processing in network). Hardware implements a doorbell (tail pointer)
> register that is updated by software when adding new work-elements to
> the streaming offload work-queue.
> 
> MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
> uncachable write to MMIO. MOVDIRI has lower overhead than other ways
> to write the doorbell.
> 
> In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
> work descriptors (and data in some cases) to device-hosted work-queues
> with atomicity.

Makes sense, but why is this not part of the changelog ?

Thanks,

	tglx
