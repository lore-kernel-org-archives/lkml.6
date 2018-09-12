Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A621C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D0620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D0620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeILK5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:57:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:52921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeILK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:57:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 22:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="gz'50?scan'50,208,50";a="89257694"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2018 22:50:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzy2s-00053p-OM; Wed, 12 Sep 2018 13:50:34 +0800
Date:   Wed, 12 Sep 2018 13:49:35 +0800
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
Message-ID: <201809121330.ka521I9Z%fengguang.wu@intel.com>
References: <060c5fa0a1f227e6119841b3b617c3f0cc9d5da1.1536685533.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <060c5fa0a1f227e6119841b3b617c3f0cc9d5da1.1536685533.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Reinette,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v4.19-rc3 next-20180911]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Reinette-Chatre/perf-core-and-x86-intel_rdt-Fix-lack-of-coordination-with-perf/20180912-101526
config: i386-randconfig-x001-201836 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Reinette-Chatre/perf-core-and-x86-intel_rdt-Fix-lack-of-coordination-with-perf/20180912-101526 HEAD b684b8727deb9e3cf635badb292b3314904d17b2 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:927:15: error: variable 'perf_miss_attr' has initializer but incomplete type
    static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
                  ^~~~~~~~~~~~~~~
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:928:3: error: 'struct perf_event_attr' has no member named 'type'
     .type  = PERF_TYPE_RAW,
      ^~~~
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:928:11: error: 'PERF_TYPE_RAW' undeclared here (not in a function); did you mean 'PIDTYPE_MAX'?
     .type  = PERF_TYPE_RAW,
              ^~~~~~~~~~~~~
              PIDTYPE_MAX
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:928:11: warning: excess elements in struct initializer
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:928:11: note: (near initialization for 'perf_miss_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:929:3: error: 'struct perf_event_attr' has no member named 'size'
     .size  = sizeof(struct perf_event_attr),
      ^~~~
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:929:18: error: invalid application of 'sizeof' to incomplete type 'struct perf_event_attr'
     .size  = sizeof(struct perf_event_attr),
                     ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:929:11: warning: excess elements in struct initializer
     .size  = sizeof(struct perf_event_attr),
              ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:929:11: note: (near initialization for 'perf_miss_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:930:3: error: 'struct perf_event_attr' has no member named 'pinned'
     .pinned  = 1,
      ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:930:13: warning: excess elements in struct initializer
     .pinned  = 1,
                ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:930:13: note: (near initialization for 'perf_miss_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:931:3: error: 'struct perf_event_attr' has no member named 'disabled'
     .disabled = 0,
      ^~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:931:14: warning: excess elements in struct initializer
     .disabled = 0,
                 ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:931:14: note: (near initialization for 'perf_miss_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:932:3: error: 'struct perf_event_attr' has no member named 'exclude_user'
     .exclude_user = 1,
      ^~~~~~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:932:18: warning: excess elements in struct initializer
     .exclude_user = 1,
                     ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:932:18: note: (near initialization for 'perf_miss_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:935:15: error: variable 'perf_hit_attr' has initializer but incomplete type
    static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
                  ^~~~~~~~~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:936:3: error: 'struct perf_event_attr' has no member named 'type'
     .type  = PERF_TYPE_RAW,
      ^~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:936:11: warning: excess elements in struct initializer
     .type  = PERF_TYPE_RAW,
              ^~~~~~~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:936:11: note: (near initialization for 'perf_hit_attr')
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:937:3: error: 'struct perf_event_attr' has no member named 'size'
     .size  = sizeof(struct perf_event_attr),
      ^~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:937:18: error: invalid application of 'sizeof' to incomplete type 'struct perf_event_attr'
     .size  = sizeof(struct perf_event_attr),
                     ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:937:11: warning: excess elements in struct initializer
     .size  = sizeof(struct perf_event_attr),
              ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:937:11: note: (near initialization for 'perf_hit_attr')
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:938:3: error: 'struct perf_event_attr' has no member named 'pinned'
     .pinned  = 1,
      ^~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:938:13: warning: excess elements in struct initializer
     .pinned  = 1,
                ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:938:13: note: (near initialization for 'perf_hit_attr')
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:939:3: error: 'struct perf_event_attr' has no member named 'disabled'
     .disabled = 0,
      ^~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:939:14: warning: excess elements in struct initializer
     .disabled = 0,
                 ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:939:14: note: (near initialization for 'perf_hit_attr')
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:940:3: error: 'struct perf_event_attr' has no member named 'exclude_user'
     .exclude_user = 1,
      ^~~~~~~~~~~~
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:940:18: warning: excess elements in struct initializer
     .exclude_user = 1,
                     ^
   arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:940:18: note: (near initialization for 'perf_hit_attr')
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:927:55: error: storage size of 'perf_miss_attr' isn't known
    static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
                                                          ^~~~~~~~~~~~~~
>> arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c:935:55: error: storage size of 'perf_hit_attr' isn't known
    static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
                                                          ^~~~~~~~~~~~~

vim +/perf_miss_attr +927 arch/x86//kernel/cpu/intel_rdt_pseudo_lock.c

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
 > 935	static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
   936		.type		= PERF_TYPE_RAW,
   937		.size		= sizeof(struct perf_event_attr),
   938		.pinned		= 1,
 > 939		.disabled	= 0,
 > 940		.exclude_user	= 1,
   941	};
   942	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PEIAKu/WMn1b1Hv9--
