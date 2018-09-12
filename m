Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6685C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E9B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E9B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeILMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:24:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:50393 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeILMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:24:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 00:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="gz'50?scan'50,208,50";a="72294857"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2018 00:21:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzzSk-0001cm-Dt; Wed, 12 Sep 2018 15:21:22 +0800
Date:   Wed, 12 Sep 2018 15:20:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, fenghua.yu@intel.com,
        tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH V3 4/6] x86/intel_rdt: Create required perf event
 attributes
Message-ID: <201809121543.CXJ3t9f1%fengguang.wu@intel.com>
References: <060c5fa0a1f227e6119841b3b617c3f0cc9d5da1.1536685533.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <060c5fa0a1f227e6119841b3b617c3f0cc9d5da1.1536685533.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Reinette,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v4.19-rc3 next-20180911]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Reinette-Chatre/perf-core-and-x86-intel_rdt-Fix-lack-of-coordination-with-perf/20180912-101526
config: i386-randconfig-x0-09121359 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Reinette-Chatre/perf-core-and-x86-intel_rdt-Fix-lack-of-coordination-with-perf/20180912-101526 HEAD b684b8727deb9e3cf635badb292b3314904d17b2 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:927:15: error: variable 'perf_miss_attr' has initializer but incomplete type
    static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
                  ^
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:928:2: error: unknown field 'type' specified in initializer
     .type  = PERF_TYPE_RAW,
     ^
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:928:11: error: 'PERF_TYPE_RAW' undeclared here (not in a function)
     .type  = PERF_TYPE_RAW,
              ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:928:11: warning: excess elements in struct initializer
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:928:11: note: (near initialization for 'perf_miss_attr')
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:929:2: error: unknown field 'size' specified in initializer
     .size  = sizeof(struct perf_event_attr),
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:929:18: error: invalid application of 'sizeof' to incomplete type 'struct perf_event_attr'
     .size  = sizeof(struct perf_event_attr),
                     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:929:11: warning: excess elements in struct initializer
     .size  = sizeof(struct perf_event_attr),
              ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:929:11: note: (near initialization for 'perf_miss_attr')
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:930:2: error: unknown field 'pinned' specified in initializer
     .pinned  = 1,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:930:13: warning: excess elements in struct initializer
     .pinned  = 1,
                ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:930:13: note: (near initialization for 'perf_miss_attr')
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:931:2: error: unknown field 'disabled' specified in initializer
     .disabled = 0,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:931:14: warning: excess elements in struct initializer
     .disabled = 0,
                 ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:931:14: note: (near initialization for 'perf_miss_attr')
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:932:2: error: unknown field 'exclude_user' specified in initializer
     .exclude_user = 1,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:932:18: warning: excess elements in struct initializer
     .exclude_user = 1,
                     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:932:18: note: (near initialization for 'perf_miss_attr')
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:935:15: error: variable 'perf_hit_attr' has initializer but incomplete type
    static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
                  ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:936:2: error: unknown field 'type' specified in initializer
     .type  = PERF_TYPE_RAW,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:936:11: warning: excess elements in struct initializer
     .type  = PERF_TYPE_RAW,
              ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:936:11: note: (near initialization for 'perf_hit_attr')
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:937:2: error: unknown field 'size' specified in initializer
     .size  = sizeof(struct perf_event_attr),
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:937:18: error: invalid application of 'sizeof' to incomplete type 'struct perf_event_attr'
     .size  = sizeof(struct perf_event_attr),
                     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:937:11: warning: excess elements in struct initializer
     .size  = sizeof(struct perf_event_attr),
              ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:937:11: note: (near initialization for 'perf_hit_attr')
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:938:2: error: unknown field 'pinned' specified in initializer
     .pinned  = 1,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:938:13: warning: excess elements in struct initializer
     .pinned  = 1,
                ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:938:13: note: (near initialization for 'perf_hit_attr')
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:939:2: error: unknown field 'disabled' specified in initializer
     .disabled = 0,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:939:14: warning: excess elements in struct initializer
     .disabled = 0,
                 ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:939:14: note: (near initialization for 'perf_hit_attr')
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:940:2: error: unknown field 'exclude_user' specified in initializer
     .exclude_user = 1,
     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:940:18: warning: excess elements in struct initializer
     .exclude_user = 1,
                     ^
   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:940:18: note: (near initialization for 'perf_hit_attr')

vim +/type +928 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c

   917	
   918	/*
   919	 * Create a perf_event_attr for the hit and miss perf events that will
   920	 * be used during the performance measurement. A perf_event maintains
   921	 * a pointer to its perf_event_attr so a unique attribute structure is
   922	 * created for each perf_event.
   923	 *
   924	 * The actual configuration of the event is set right before use in order
   925	 * to use the X86_CONFIG macro.
   926	 */
 > 927	static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
 > 928		.type		= PERF_TYPE_RAW,
 > 929		.size		= sizeof(struct perf_event_attr),
 > 930		.pinned		= 1,
 > 931		.disabled	= 0,
 > 932		.exclude_user	= 1,
   933	};
   934	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--a8Wt8u1KmwUX3Y2C--
