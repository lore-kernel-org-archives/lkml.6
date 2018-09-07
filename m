Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ADB2087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ADB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeIGSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:51:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:23201 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeIGSv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:51:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="261570819"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2018 07:10:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8928E300B65; Fri,  7 Sep 2018 07:10:51 -0700 (PDT)
Date:   Fri, 7 Sep 2018 07:10:51 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr
 stack save/restore
Message-ID: <20180907141051.GP27886@tassilo.jf.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
 <20180907032707.GN27886@tassilo.jf.intel.com>
 <5B920B96.6080803@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B920B96.6080803@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This could achieve the above #1, but how would it solve #2 above? That is,
> after the guest uses the lbr feature for a while, the lbr stack has been
> passed through, then the guest doesn't use lbr any more, but the vCPU will
> still save/restore on switching?

If nothing accesses the MSR LBRs after a context switch in the guest
nothing gets saved/restored due to:

> > Also when the LBRs haven't been set to direct access the state doesn't
> > need to be saved.


-Andi
