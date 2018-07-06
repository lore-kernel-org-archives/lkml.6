Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033AD24098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033AD24098
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbeGFHvK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:51:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:19468 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932300AbeGFHvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:51:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 00:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,315,1526367600"; 
   d="gz'50?scan'50,208,50";a="55547519"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2018 00:51:03 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fbLWB-000S3F-4j; Fri, 06 Jul 2018 15:51:03 +0800
Date:   Fri, 6 Jul 2018 15:50:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 03/14] bpf: pass a pointer to a cgroup
 storage using pcpu variable
Message-ID: <201807061419.VGs3WwSs%fengguang.wu@intel.com>
References: <20180705205139.3462-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20180705205139.3462-4-guro@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/bpf-cgroup.h:6:0,
                    from kernel/bpf/local_storage.c:2:
   include/linux/percpu-defs.h:49:34: error: 'PER_CPU_BASE_SECTION' undeclared here (not in a function); did you mean 'PER_CPU_FIRST_SECTION'?
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                     ^
   include/linux/percpu-defs.h:101:9: note: in expansion of macro '__PCPU_ATTRS'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
            ^~~~~~~~~~~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:113:38: error: expected ')' before string constant
     DECLARE_PER_CPU_SECTION(type, name, "")
                                         ^
   include/linux/percpu-defs.h:49:55: note: in definition of macro '__PCPU_ATTRS'
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                                          ^~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:49:59: error: expected identifier or '(' before ')' token
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                                              ^
   include/linux/percpu-defs.h:101:9: note: in expansion of macro '__PCPU_ATTRS'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
            ^~~~~~~~~~~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h: In function 'bpf_cgroup_storage_set':
>> include/linux/bpf-cgroup.h:110:17: error: 'bpf_cgroup_storage' undeclared (first use in this function)
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
                    ^
   include/linux/percpu-defs.h:221:47: note: in definition of macro '__verify_pcpu_ptr'
     const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
                                                  ^~~
   include/linux/percpu-defs.h:510:34: note: in expansion of macro '__pcpu_size_call'
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                     ^~~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:110:17: note: each undeclared identifier is reported only once for each function it appears in
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
                    ^
   include/linux/percpu-defs.h:221:47: note: in definition of macro '__verify_pcpu_ptr'
     const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL; \
                                                  ^~~
   include/linux/percpu-defs.h:510:34: note: in expansion of macro '__pcpu_size_call'
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                     ^~~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_1'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:379:11: note: in definition of macro '__pcpu_size_call'
      case 1: stem##1(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_2'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:380:11: note: in definition of macro '__pcpu_size_call'
      case 2: stem##2(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_4'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:381:11: note: in definition of macro '__pcpu_size_call'
      case 4: stem##4(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_8'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:382:11: note: in definition of macro '__pcpu_size_call'
      case 8: stem##8(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/bpf_cgroup_storage +110 include/linux/bpf-cgroup.h

    23	
  > 24	DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    25	
    26	struct bpf_cgroup_storage_map;
    27	
    28	struct bpf_storage_buffer {
    29		struct rcu_head rcu;
    30		char data[0];
    31	};
    32	
    33	struct bpf_cgroup_storage {
    34		struct bpf_storage_buffer *buf;
    35		struct bpf_cgroup_storage_map *map;
    36		struct bpf_cgroup_storage_key key;
    37		struct list_head list;
    38		struct rb_node node;
    39		struct rcu_head rcu;
    40	};
    41	
    42	struct bpf_prog_list {
    43		struct list_head node;
    44		struct bpf_prog *prog;
    45	};
    46	
    47	struct bpf_prog_array;
    48	
    49	struct cgroup_bpf {
    50		/* array of effective progs in this cgroup */
    51		struct bpf_prog_array __rcu *effective[MAX_BPF_ATTACH_TYPE];
    52	
    53		/* attached progs to this cgroup and attach flags
    54		 * when flags == 0 or BPF_F_ALLOW_OVERRIDE the progs list will
    55		 * have either zero or one element
    56		 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
    57		 */
    58		struct list_head progs[MAX_BPF_ATTACH_TYPE];
    59		u32 flags[MAX_BPF_ATTACH_TYPE];
    60	
    61		/* temp storage for effective prog array used by prog_attach/detach */
    62		struct bpf_prog_array __rcu *inactive;
    63	};
    64	
    65	void cgroup_bpf_put(struct cgroup *cgrp);
    66	int cgroup_bpf_inherit(struct cgroup *cgrp);
    67	
    68	int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
    69				enum bpf_attach_type type, u32 flags);
    70	int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
    71				enum bpf_attach_type type, u32 flags);
    72	int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
    73			       union bpf_attr __user *uattr);
    74	
    75	/* Wrapper for __cgroup_bpf_*() protected by cgroup_mutex */
    76	int cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
    77			      enum bpf_attach_type type, u32 flags);
    78	int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
    79			      enum bpf_attach_type type, u32 flags);
    80	int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
    81			     union bpf_attr __user *uattr);
    82	
    83	int __cgroup_bpf_run_filter_skb(struct sock *sk,
    84					struct sk_buff *skb,
    85					enum bpf_attach_type type);
    86	
    87	int __cgroup_bpf_run_filter_sk(struct sock *sk,
    88				       enum bpf_attach_type type);
    89	
    90	int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
    91					      struct sockaddr *uaddr,
    92					      enum bpf_attach_type type,
    93					      void *t_ctx);
    94	
    95	int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
    96					     struct bpf_sock_ops_kern *sock_ops,
    97					     enum bpf_attach_type type);
    98	
    99	int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
   100					      short access, enum bpf_attach_type type);
   101	
   102	static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
   103	{
   104		struct bpf_storage_buffer *buf;
   105	
   106		if (!storage)
   107			return;
   108	
   109		buf = rcu_dereference(storage->buf);
 > 110		this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
   111	}
   112	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qMm9M+Fa2AknHoGS--
