Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD53F208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD53F208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966281AbeFOQeL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:34:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:58213 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966051AbeFOQeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:34:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 09:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="49298585"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2018 09:34:06 -0700
Date:   Fri, 15 Jun 2018 09:34:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
Message-ID: <20180615163406.GA8775@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
 <20180607174337.GA22594@agluck-desk>
 <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
 <20180607202445.GC20936@zn.tnic>
 <20180614215754.GA26090@agluck-desk>
 <20180615114517.GB24132@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615114517.GB24132@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:45:18PM +0200, Borislav Petkov wrote:
> On Thu, Jun 14, 2018 at 02:57:54PM -0700, Luck, Tony wrote:
> > On Thu, Jun 07, 2018 at 10:24:46PM +0200, Borislav Petkov wrote:
> > > tglx just took 1 and 3, 2/3 had a minor issue but the merge window
> > > happened so I'll send it later. It is nice to have anyway.
> > 
> > Did you fix up part 2/3?
> 
> You said "Parts 1 & 2 are nice-to-have" and we have merge window now. So
> what exactly do you mean?
> 
> > I see 1 & 3 were staged by Thomas in TIP ras/urgent and
> > ras-urgent-for-linus but haven't gone into Linus' tree yet.
> 
> Merge window ain't over yet :)

"send it later" could be read a couple of ways.

I was just worried that Thomas is holding off asking Linus to pull
because he's waiting for part 2/3, while you might be planning to
hold onto part 2/3 for the next merge (and add the other cleanups
you RFC'd).

I'm OK either way on part 2/3 (it just makes for better error messages,
it doesn't fix any bugs).

-Tony
