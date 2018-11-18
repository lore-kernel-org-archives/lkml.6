Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A854C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FC120869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FC120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKSKUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 05:20:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:47221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeKSKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 05:20:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 15:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,250,1539673200"; 
   d="scan'208";a="87445254"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2018 15:58:32 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C6115301015; Sun, 18 Nov 2018 15:58:32 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:58:32 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
Message-ID: <20181118235832.GA13936@tassilo.jf.intel.com>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
 <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
 <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
 <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
 <32d00fb2-7187-ed6f-ab1e-287151e82b3a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d00fb2-7187-ed6f-ab1e-287151e82b3a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So my patchset and Jiri's patchset should probably be merged together, so the
> users have a choice of the behavior.

... or delay Jiri's patchkit until the scheduler can actually check
properly for the cases when it is really needed. 

-Andi
