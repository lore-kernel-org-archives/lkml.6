Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FF72073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FF72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIFCTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:19:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:7133 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeIFCTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:19:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 14:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="67844584"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2018 14:47:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AB0EA300B65; Wed,  5 Sep 2018 14:47:07 -0700 (PDT)
Date:   Wed, 5 Sep 2018 14:47:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180905214707.GM27886@tassilo.jf.intel.com>
References: <20180823150732.11249-1-eduval@amazon.com>
 <20180905085212.GS24124@hirez.programming.kicks-ass.net>
 <20180905155317.GA20320@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905155317.GA20320@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:53:17AM -0700, Eduardo Valentin wrote:
> On Wed, Sep 05, 2018 at 10:52:12AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> > > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > > and with a model not known by family PMU drivers,
> > > user gets a kernel message log like the following:
> > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > > 
> > > The "unsupported .. CPU" part may be confusing for some
> > > users leading to wrong understanding that the kernel
> > > does not support the CPU model.
> > 
> > Send them back to first grade, such that they might learn to read?
> > 
> 
> :-)

I think it's a valid concern, I guess Eduardo actually has real people
who got confused.

-Andi
