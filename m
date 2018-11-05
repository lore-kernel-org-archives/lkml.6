Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B22085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5B22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeKFDlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:41:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:19868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387561AbeKFDlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:41:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 10:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="278512728"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2018 10:20:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9291630508C; Mon,  5 Nov 2018 10:20:15 -0800 (PST)
Date:   Mon, 5 Nov 2018 10:20:15 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Message-ID: <20181105182015.GP6218@tassilo.jf.intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
 <20181101145257.GD3178@hirez.programming.kicks-ass.net>
 <5BDC140F.6060303@intel.com>
 <20181105093413.GO3178@hirez.programming.kicks-ass.net>
 <5BE02725.3010707@intel.com>
 <20181105121413.GC22431@hirez.programming.kicks-ass.net>
 <286AC319A985734F985F78AFA26841F73DE3AC8B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73DE3AC8B@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I ran into a similar problem with my PEBS virtualization patchkit.

My solution was: basically schedule as normal, but tell the scheduler to
force allocate a counter on a specific index.  It can be done
only with a few lines of change in the scheduler code.

-Andi




