Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CF4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675942177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfBCVhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:37:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:44062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfBCVhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 16:37:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 13:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,557,1539673200"; 
   d="scan'208";a="119701376"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2019 13:37:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D4944301247; Sun,  3 Feb 2019 13:37:06 -0800 (PST)
Date:   Sun, 3 Feb 2019 13:37:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        SchauflerCasey <casey.schaufler@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3.16 045/305] x86/speculation: Apply IBPB more strictly
 to avoid cross-process data leak
Message-ID: <20190203213706.GA31598@tassilo.jf.intel.com>
References: <lsq.1549201508.524404500@decadent.org.uk>
 <nycvar.YFH.7.76.1902032005040.11598@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1902032005040.11598@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 08:05:53PM +0100, Jiri Kosina wrote:
> On Sun, 3 Feb 2019, Ben Hutchings wrote:
> 
> > 3.16.63-rc1 review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jiri Kosina <jkosina@suse.cz>
> > 
> > commit dbfe2953f63c640463c630746cd5d9de8b2f63ae upstream.
> 
> You really want the whole IBPB+STIBP revamp from upstream, otherwise 
> you're going to get noticeable performance penalties on some workloads 
> with some microcodes.

Yes, we would need the opt-in/opt-out support too.

Please don't merge it just as is.

-Andi
