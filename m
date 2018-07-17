Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06AF208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06AF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGQCPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:15:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:41929 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeGQCPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:15:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 18:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="57033687"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2018 18:45:21 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1ffF3I-000Bsq-Mt; Tue, 17 Jul 2018 09:45:20 +0800
Date:   Tue, 17 Jul 2018 09:44:52 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH rcu] rcutorture: err_segs_recorded can be static
Message-ID: <20180717014452.GA49087@lkp-g5>
References: <201807170920.MbzzhD0j%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807170920.MbzzhD0j%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 07809ecaa895 ("rcutorture: Dump reader protection sequence if failures or close calls")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 rcutorture.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ef85bde..a7a947e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -209,9 +209,9 @@ struct rt_read_seg {
 	unsigned long rt_delay_us;
 	bool rt_preempted;
 };
-int err_segs_recorded;
-struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
-int rt_read_nsegs;
+static int err_segs_recorded;
+static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
+static int rt_read_nsegs;
 
 static const char *rcu_torture_writer_state_getname(void)
 {
