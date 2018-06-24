Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DFC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 01:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B523624D71
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 01:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B523624D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeFXBSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 21:18:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:59164 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbeFXBSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 21:18:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2018 18:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,263,1526367600"; 
   d="scan'208";a="239731667"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2018 18:18:10 -0700
Date:   Sat, 23 Jun 2018 18:17:38 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180624011738.GI18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
 <20180623042033.GF18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de>
 <20180623150521.GG18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806240245160.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806240245160.8650@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 02:55:08AM +0200, Thomas Gleixner wrote:
> On Sat, 23 Jun 2018, Fenghua Yu wrote:
> > On Sat, Jun 23, 2018 at 11:17:03AM +0200, Thomas Gleixner wrote:
> > > On Fri, 22 Jun 2018, Fenghua Yu wrote:
> It's not treated as failure. The firmware simply does not have an handler
> for #AC installed and dies. I hope you yelled at the firmware people
> already.

I think firmware does handle the split lock in its #AC handler because
firmware shows the following log and system hangs:

!!!! IA32 Exception Type - 11(#AC - Alignment Check)  CPU Apic ID - 00000014!
!
ExceptionData - 00000000
EIP  - 6A9DB6C3, CS  - 00000010, EFLAGS - 00010006
...

> If that is a real wide spread issue in practice, then we might have to go
> for some ugly workarounds, but we won't find out when we add them
> upfront. So testing will show what's wrong in firmware land and we can
> handle it from there. It's a completely orthogonal issue and has nothing to
> do with the core functionality.

Sure

Thanks.

-Fenghua
