Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90746C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B021568
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6B021568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeHGUxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:53:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:47475 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388625AbeHGUxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:53:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 11:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="246939768"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2018 11:37:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E9C0B3013C5; Tue,  7 Aug 2018 11:37:36 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:37:36 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180807183736.GR4238@tassilo.jf.intel.com>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
 <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 07:48:51PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 07, 2018 at 10:35:42AM -0700, Dave Hansen wrote:
> > On 08/07/2018 10:17 AM, kan.liang@linux.intel.com wrote:
> > > Denverton and Gemini Lake are platform names and should not be used for
> > > Processor Family stuff. The microarchitecture codename should be used.
> > 
> > Why?
> > 
> > Denverton is the platform.  "Goldmont" is literally the
> > microarchitecture, and you are suggesting moving *to* the
> > microarchitecture name, which contradicts the description.
> 
> All the other (big core) are uarch names. Atom is weird in that it mixes
> uarch with platform names.

On most big core the platform/SOC just happens to have the same name as the 
uarch. But the identifiers really have to be per SOC because that 
is how Intel model numbers work.

It should be always the SOC.

-Andi
