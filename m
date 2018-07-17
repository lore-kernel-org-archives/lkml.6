Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7005FECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341B7208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341B7208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeGQCPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:15:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeGQCPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:15:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 18:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="58206809"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2018 18:45:21 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1ffF3I-000BtK-PO; Tue, 17 Jul 2018 09:45:20 +0800
Date:   Tue, 17 Jul 2018 09:44:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev 211/211] kernel/rcu/rcutorture.c:212:5: sparse: symbol
 'err_segs_recorded' was not declared. Should it be static?
Message-ID: <201807170920.MbzzhD0j%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
head:   07809ecaa895e92b00c28e8c0b7442bddb8a9324
commit: 07809ecaa895e92b00c28e8c0b7442bddb8a9324 [211/211] rcutorture: Dump reader protection sequence if failures or close calls
reproduce:
        # apt-get install sparse
        git checkout 07809ecaa895e92b00c28e8c0b7442bddb8a9324
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> kernel/rcu/rcutorture.c:212:5: sparse: symbol 'err_segs_recorded' was not declared. Should it be static?
>> kernel/rcu/rcutorture.c:213:20: sparse: symbol 'err_segs' was not declared. Should it be static?
>> kernel/rcu/rcutorture.c:214:5: sparse: symbol 'rt_read_nsegs' was not declared. Should it be static?
   include/linux/overflow.h:242:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:242:13: sparse: incorrect type in conditional
   include/linux/overflow.h:242:13:    got void
   include/linux/overflow.h:244:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:244:13: sparse: incorrect type in conditional
   include/linux/overflow.h:244:13:    got void
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/overflow.h:242:13: sparse: call with no type!
   include/linux/overflow.h:244:13: sparse: call with no type!
   kernel/rcu/rcutorture.c:1183:9: sparse: context imbalance in 'rcutorture_one_extend' - different lock contexts for basic block
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
