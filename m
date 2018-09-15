Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C755CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1D3208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1D3208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeIOWCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 18:02:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:9507 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbeIOWCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 18:02:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 09:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,377,1531810800"; 
   d="scan'208";a="90778029"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2018 09:42:35 -0700
Date:   Sun, 16 Sep 2018 00:47:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180915164731.3zrdxijuwkgdi25p@shbuild888>
References: <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
 <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
 <20180831133659.pkmscqpudjnkujbg@shbuild888>
 <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
 <20180910093938.ka732apzy3d3a5ip@shbuild888>
 <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
 <20180911061413.redy4oxia3hqifkh@shbuild888>
 <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Sep 15, 2018 at 12:29:50PM +0200, Thomas Gleixner wrote:
> On Tue, 11 Sep 2018, Feng Tang wrote:
> > Thanks for the suggestion, and I have 2 patches: one adds a build warning,   
> > the other prepares fixmap page table on demand and doesn't need warning.
> 
> The latter please.

Okay.

> 
> > But I met a problem, that the "__end_of_permanent_fixed_addresses" is
> > defined in fixmap.h, which is protected by #ifndef __ASSEMBLY__, also
> > fixmap.h reference many other header file, which makes it harder to
> > extract the definition out. Any suggestion on this? thanks!
> 
> What prevents you from moving the enum out of the __ASSEMBLY__ protected
> section aside of a bit of careful work?

I have tried to change some header files incluing fixmap.h/apicdef.h/
vsyscall.h, and most of the .c files compile fine now, but I can not
use the "__end_of_permanent_fixed_addresses" in head_64.S as it is a 
enum type, and could not be recognized by assembly code.

Thanks,
Feng

> 
> Thanks,
> 
> 	tglx
