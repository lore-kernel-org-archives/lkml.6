Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26BD2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26BD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJQE1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:27:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:17686 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQE1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:27:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 13:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="241852545"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 16 Oct 2018 13:35:41 -0700
Date:   Tue, 16 Oct 2018 13:32:15 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Message-ID: <20181016203215.GA39177@romley-ivt3.sc.intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Moger, Babu [mailto:Babu.Moger@amd.com] 
> On 10/16/2018 11:56 AM, Fenghua Yu wrote:
> > With more and more resctrl features are being added by Intel, AMD and 
> > ARM, a test tool is becoming more and more useful to validate that 
> > both hardware and software functionalities work as expected.
> 
> I like the initiative here. It is always good to have a single code base.
> 
> One question. I see that there is a tool at https://github.com/intel/intel-cmt-cat to test and verify the functionality of resctrl feature. I also see some of the distros have this tool already.
> Is this tool going to replace intel-cmt-cat? I have not looked at the
> patches closely yet.

No, the selftest in this patch set will not replace intel-cmt-cat or
vice versa.

The selftest in this patch set has a different purpose from intel-cmt-cat:
the selftest is a test tool which validates resctrl functionalities while
intel-cmt-cat is mainly a utility that provides base library for higher
level applications including performance analysis tools, benchmark measurement
tools, and potential resctrl tests. For example, running MBA test in the
selftests tells MBA working or not working (fail/pass) right way. The
intel-cmt-cat doesn't have this testing capability unless we extend the
tool.

And intel-cmt-cat is maintained and developed by Intel. I don't think it's
easy to extend it to AMD and ARM features. The selftest will be maintained
and developed by the community and will hopefully cover all architectures.

We have seen a few issues recently in resctrl and may see more issues
while expending the features. A convevient selftest may be useful to help
identify and fix those potential issues.

Thanks.

-Fenghua 
 
