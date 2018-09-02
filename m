Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56380C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000712077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000712077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeIBMjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 08:39:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:39249 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 08:39:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2018 01:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,319,1531810800"; 
   d="scan'208";a="77370694"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2018 01:24:03 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwNft-0006Bx-7K; Sun, 02 Sep 2018 16:24:01 +0800
Date:   Sun, 2 Sep 2018 16:24:01 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, Peng DongX <dongx.peng@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/5] introduce /proc/PID/idle_bitmap
Message-ID: <20180902082401.jaz3dcumtxekwide@wfg-t540p.sh.intel.com>
References: <20180901112818.126790961@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180901112818.126790961@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the diffstat:

 arch/x86/kvm/Kconfig    |   11 +
 arch/x86/kvm/Makefile   |    4
 arch/x86/kvm/ept_idle.c |  329 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/ept_idle.h |   79 +++++++++
 fs/proc/base.c          |    2
 fs/proc/internal.h      |    1
 fs/proc/task_mmu.c      |   63 +++++++
 include/linux/sched.h   |   10 +
 virt/kvm/kvm_main.c     |    1
 9 files changed, 500 insertions(+)

Regards,
Fengguang

