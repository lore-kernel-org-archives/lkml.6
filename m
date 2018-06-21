Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB23420846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB23420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbeFUK7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:59:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:29161 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932855AbeFUK7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:59:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 03:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,251,1526367600"; 
   d="scan'208";a="48784698"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 03:59:20 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVxJ9-000Lc7-VD; Thu, 21 Jun 2018 18:59:19 +0800
Date:   Thu, 21 Jun 2018 18:58:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix unnecessary killing of additional
 processes
Message-ID: <201806211834.NQ5KvllA%fengguang.wu@intel.com>
References: <alpine.DEB.2.21.1806201458540.14059@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201458540.14059@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc1 next-20180621]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Rientjes/mm-oom-fix-unnecessary-killing-of-additional-processes/20180621-060118
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
   include/linux/nodemask.h:271:16: sparse: expression using sizeof(void)
   include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
   include/linux/nodemask.h:271:16: sparse: expression using sizeof(void)
>> mm/oom_kill.c:656:5: sparse: symbol 'oom_free_timeout_ms' was not declared. Should it be static?
   include/linux/rcupdate.h:683:9: sparse: context imbalance in 'find_lock_task_mm' - wrong count at exit
   include/linux/sched/mm.h:141:37: sparse: dereference of noderef expression
   mm/oom_kill.c:218:28: sparse: context imbalance in 'oom_badness' - unexpected unlock
   mm/oom_kill.c:398:9: sparse: context imbalance in 'dump_tasks' - different lock contexts for basic block
   include/linux/rcupdate.h:683:9: sparse: context imbalance in 'oom_kill_process' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
