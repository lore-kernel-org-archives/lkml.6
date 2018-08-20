Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038CAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042921570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A042921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeHTVb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:31:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:56326 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbeHTVb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:31:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 11:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="67678937"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2018 11:15:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1frohs-000JB6-Cf; Tue, 21 Aug 2018 02:15:12 +0800
Date:   Tue, 21 Aug 2018 02:14:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andrew Banman <abanman@hpe.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Varsha Rao <rvarsha016@gmail.com>,
        Nicolai Stange <nstange@suse.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [tip:x86/urgent 6/6] arch/x86/platform/uv/tlb_uv.c:2209:6: sparse:
 symbol 'uv_bau_crash_shutdown' was not declared. Should it be static?
Message-ID: <201808210250.A3etcIJg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   99f3965878759d36baac944df004b4dafcc272b4
commit: 99f3965878759d36baac944df004b4dafcc272b4 [6/6] x86/platform/uv/BAU: Gracefully disable BAU during panic
reproduce:
        # apt-get install sparse
        git checkout 99f3965878759d36baac944df004b4dafcc272b4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
   include/linux/nodemask.h:271:16: sparse: expression using sizeof(void)
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:692:41: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:692:41:    expected void volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:692:41:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
>> arch/x86/platform/uv/tlb_uv.c:2209:6: sparse: symbol 'uv_bau_crash_shutdown' was not declared. Should it be static?
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:692:41: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:692:41:    expected void volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:692:41:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:687:42: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:687:42:    expected void const volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:687:42:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:692:41: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got deref] <asn:2>*addr @@
   arch/x86/include/asm/uv/uv_hub.h:692:41:    expected void volatile [noderef] <asn:2>*addr
   arch/x86/include/asm/uv/uv_hub.h:692:41:    got unsigned long *
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   arch/x86/include/asm/uv/uv_hub.h:652:16: sparse: incorrect type in return expression (different address spaces) @@    expected void volatile [noderef] <asn:2>* @@    got sn:2>* @@
   arch/x86/include/asm/uv/uv_hub.h:652:16:    expected void volatile [noderef] <asn:2>*
   arch/x86/include/asm/uv/uv_hub.h:652:16:    got void *<noident>
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
