Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116EE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeFSWfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:35:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:21625 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeFSWft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:35:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 15:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="scan'208";a="64630896"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 15:35:48 -0700
Date:   Tue, 19 Jun 2018 15:35:23 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
Message-ID: <20180619223522.GA114883@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191057210.1692@nanos.tec.linutronix.de>
 <20180619213644.GC112652@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806200031370.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806200031370.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:32:14AM +0200, Thomas Gleixner wrote:
> On Tue, 19 Jun 2018, Fenghua Yu wrote:
> 
> > On Tue, Jun 19, 2018 at 10:57:44AM +0200, Thomas Gleixner wrote:
> > > On Fri, 15 Jun 2018, Fenghua Yu wrote:
> > > 
> > > > MOVDIRI moves doubleword or quadword from register to memory through
> > > > direct store which is implemented by using write combining (WC) for
> > > > writing data directly into memory without caching the data.
> > > 
> > > And that is useful for what?
> > 
> > Programmable agents can handle streaming offload (e.g. high speed packet
> > processing in network). Hardware implements a doorbell (tail pointer)
> > register that is updated by software when adding new work-elements to
> > the streaming offload work-queue.
> > 
> > MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
> > uncachable write to MMIO. MOVDIRI has lower overhead than other ways
> > to write the doorbell.
> > 
> > In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
> > work descriptors (and data in some cases) to device-hosted work-queues
> > with atomicity.
> 
> Makes sense, but why is this not part of the changelog ?

Sorry. I forgot to put the usage info in the commit description. I will
add it in the next version.

> 
> Thanks,
> 
> 	tglx

Thanks.

-Fenghua
