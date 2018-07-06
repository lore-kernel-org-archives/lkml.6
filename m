Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADBDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51A23F40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C51A23F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeGFJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:26:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:14610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753609AbeGFJZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:25:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 02:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,315,1526367600"; 
   d="gz'50?scan'50,208,50";a="243460419"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2018 02:25:23 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fbMzS-000Qz3-Lb; Fri, 06 Jul 2018 17:25:22 +0800
Date:   Fri, 6 Jul 2018 17:25:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 03/14] bpf: pass a pointer to a cgroup
 storage using pcpu variable
Message-ID: <201807061536.Zg45zo8k%fengguang.wu@intel.com>
References: <20180705205139.3462-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
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


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/bpf-cgroup.h:6:0,
                    from kernel/bpf/local_storage.c:2:
>> include/linux/percpu-defs.h:49:34: error: 'PER_CPU_BASE_SECTION' undeclared here (not in a function); did you mean 'PER_CPU_FIRST_SECTION'?
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                     ^
>> include/linux/percpu-defs.h:87:9: note: in expansion of macro '__PCPU_ATTRS'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
            ^~~~~~~~~~~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:113:38: error: expected ')' before string constant
     DECLARE_PER_CPU_SECTION(type, name, "")
                                         ^
   include/linux/percpu-defs.h:49:55: note: in definition of macro '__PCPU_ATTRS'
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                                          ^~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:49:59: error: expected identifier or '(' before ')' token
     __percpu __attribute__((section(PER_CPU_BASE_SECTION sec))) \
                                                              ^
>> include/linux/percpu-defs.h:87:9: note: in expansion of macro '__PCPU_ATTRS'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
            ^~~~~~~~~~~~
   include/linux/percpu-defs.h:113:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "")
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bpf-cgroup.h:24:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(void*, bpf_cgroup_storage);
    ^~~~~~~~~~~~~~~
   include/linux/bpf-cgroup.h: In function 'bpf_cgroup_storage_set':
   include/linux/bpf-cgroup.h:110:17: error: 'bpf_cgroup_storage' undeclared (first use in this function)
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
>> include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_1'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:379:11: note: in definition of macro '__pcpu_size_call'
      case 1: stem##1(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_2'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:380:11: note: in definition of macro '__pcpu_size_call'
      case 2: stem##2(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_4'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:381:11: note: in definition of macro '__pcpu_size_call'
      case 4: stem##4(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:510:51: error: implicit declaration of function 'this_cpu_write_8'; did you mean 'this_cpu_write'? [-Werror=implicit-function-declaration]
    #define this_cpu_write(pcp, val) __pcpu_size_call(this_cpu_write_, pcp, val)
                                                      ^
   include/linux/percpu-defs.h:382:11: note: in definition of macro '__pcpu_size_call'
      case 8: stem##8(variable, __VA_ARGS__);break;  \
              ^~~~
   include/linux/bpf-cgroup.h:110:2: note: in expansion of macro 'this_cpu_write'
     this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +49 include/linux/percpu-defs.h

62fde54123 Tejun Heo           2014-06-17   37  
5028eaa97d David Howells       2009-04-21   38  /*
5028eaa97d David Howells       2009-04-21   39   * Base implementations of per-CPU variable declarations and definitions, where
5028eaa97d David Howells       2009-04-21   40   * the section in which the variable is to be placed is provided by the
7c756e6e19 Tejun Heo           2009-06-24   41   * 'sec' argument.  This may be used to affect the parameters governing the
5028eaa97d David Howells       2009-04-21   42   * variable's storage.
5028eaa97d David Howells       2009-04-21   43   *
5028eaa97d David Howells       2009-04-21   44   * NOTE!  The sections for the DECLARE and for the DEFINE must match, lest
5028eaa97d David Howells       2009-04-21   45   * linkage errors occur due the compiler generating the wrong code to access
5028eaa97d David Howells       2009-04-21   46   * that section.
5028eaa97d David Howells       2009-04-21   47   */
7c756e6e19 Tejun Heo           2009-06-24   48  #define __PCPU_ATTRS(sec)						\
e0fdb0e050 Rusty Russell       2009-10-29  @49  	__percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))	\
7c756e6e19 Tejun Heo           2009-06-24   50  	PER_CPU_ATTRIBUTES
7c756e6e19 Tejun Heo           2009-06-24   51  
7c756e6e19 Tejun Heo           2009-06-24   52  #define __PCPU_DUMMY_ATTRS						\
7c756e6e19 Tejun Heo           2009-06-24   53  	__attribute__((section(".discard"), unused))
7c756e6e19 Tejun Heo           2009-06-24   54  
7c756e6e19 Tejun Heo           2009-06-24   55  /*
7c756e6e19 Tejun Heo           2009-06-24   56   * s390 and alpha modules require percpu variables to be defined as
7c756e6e19 Tejun Heo           2009-06-24   57   * weak to force the compiler to generate GOT based external
7c756e6e19 Tejun Heo           2009-06-24   58   * references for them.  This is necessary because percpu sections
7c756e6e19 Tejun Heo           2009-06-24   59   * will be located outside of the usually addressable area.
7c756e6e19 Tejun Heo           2009-06-24   60   *
7c756e6e19 Tejun Heo           2009-06-24   61   * This definition puts the following two extra restrictions when
7c756e6e19 Tejun Heo           2009-06-24   62   * defining percpu variables.
7c756e6e19 Tejun Heo           2009-06-24   63   *
7c756e6e19 Tejun Heo           2009-06-24   64   * 1. The symbol must be globally unique, even the static ones.
7c756e6e19 Tejun Heo           2009-06-24   65   * 2. Static percpu variables cannot be defined inside a function.
7c756e6e19 Tejun Heo           2009-06-24   66   *
7c756e6e19 Tejun Heo           2009-06-24   67   * Archs which need weak percpu definitions should define
7c756e6e19 Tejun Heo           2009-06-24   68   * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
7c756e6e19 Tejun Heo           2009-06-24   69   *
7c756e6e19 Tejun Heo           2009-06-24   70   * To ensure that the generic code observes the above two
7c756e6e19 Tejun Heo           2009-06-24   71   * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
7c756e6e19 Tejun Heo           2009-06-24   72   * definition is used for all cases.
7c756e6e19 Tejun Heo           2009-06-24   73   */
7c756e6e19 Tejun Heo           2009-06-24   74  #if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
7c756e6e19 Tejun Heo           2009-06-24   75  /*
7c756e6e19 Tejun Heo           2009-06-24   76   * __pcpu_scope_* dummy variable is used to enforce scope.  It
7c756e6e19 Tejun Heo           2009-06-24   77   * receives the static modifier when it's used in front of
7c756e6e19 Tejun Heo           2009-06-24   78   * DEFINE_PER_CPU() and will trigger build failure if
7c756e6e19 Tejun Heo           2009-06-24   79   * DECLARE_PER_CPU() is used for the same variable.
7c756e6e19 Tejun Heo           2009-06-24   80   *
7c756e6e19 Tejun Heo           2009-06-24   81   * __pcpu_unique_* dummy variable is used to enforce symbol uniqueness
7c756e6e19 Tejun Heo           2009-06-24   82   * such that hidden weak symbol collision, which will cause unrelated
7c756e6e19 Tejun Heo           2009-06-24   83   * variables to share the same address, can be detected during build.
7c756e6e19 Tejun Heo           2009-06-24   84   */
7c756e6e19 Tejun Heo           2009-06-24   85  #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
7c756e6e19 Tejun Heo           2009-06-24   86  	extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;		\
dd17c8f729 Rusty Russell       2009-10-29  @87  	extern __PCPU_ATTRS(sec) __typeof__(type) name
7c756e6e19 Tejun Heo           2009-06-24   88  
7c756e6e19 Tejun Heo           2009-06-24   89  #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
7c756e6e19 Tejun Heo           2009-06-24   90  	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
0f5e4816db Tejun Heo           2009-10-29   91  	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
7c756e6e19 Tejun Heo           2009-06-24   92  	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
b1a0fbfdde Tejun Heo           2013-12-04   93  	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
c43768cbb7 Tejun Heo           2009-07-04   94  	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
dd17c8f729 Rusty Russell       2009-10-29   95  	__typeof__(type) name
7c756e6e19 Tejun Heo           2009-06-24   96  #else
7c756e6e19 Tejun Heo           2009-06-24   97  /*
7c756e6e19 Tejun Heo           2009-06-24   98   * Normal declaration and definition macros.
7c756e6e19 Tejun Heo           2009-06-24   99   */
7c756e6e19 Tejun Heo           2009-06-24  100  #define DECLARE_PER_CPU_SECTION(type, name, sec)			\
dd17c8f729 Rusty Russell       2009-10-29  101  	extern __PCPU_ATTRS(sec) __typeof__(type) name
7c756e6e19 Tejun Heo           2009-06-24  102  
7c756e6e19 Tejun Heo           2009-06-24  103  #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
c43768cbb7 Tejun Heo           2009-07-04  104  	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES			\
dd17c8f729 Rusty Russell       2009-10-29  105  	__typeof__(type) name
7c756e6e19 Tejun Heo           2009-06-24  106  #endif
5028eaa97d David Howells       2009-04-21  107  
5028eaa97d David Howells       2009-04-21  108  /*
5028eaa97d David Howells       2009-04-21  109   * Variant on the per-CPU variable declaration/definition theme used for
5028eaa97d David Howells       2009-04-21  110   * ordinary per-CPU variables.
5028eaa97d David Howells       2009-04-21  111   */
5028eaa97d David Howells       2009-04-21  112  #define DECLARE_PER_CPU(type, name)					\
5028eaa97d David Howells       2009-04-21 @113  	DECLARE_PER_CPU_SECTION(type, name, "")
5028eaa97d David Howells       2009-04-21  114  
5028eaa97d David Howells       2009-04-21  115  #define DEFINE_PER_CPU(type, name)					\
5028eaa97d David Howells       2009-04-21  116  	DEFINE_PER_CPU_SECTION(type, name, "")
5028eaa97d David Howells       2009-04-21  117  
5028eaa97d David Howells       2009-04-21  118  /*
5028eaa97d David Howells       2009-04-21  119   * Declaration/definition used for per-CPU variables that must come first in
5028eaa97d David Howells       2009-04-21  120   * the set of variables.
5028eaa97d David Howells       2009-04-21  121   */
5028eaa97d David Howells       2009-04-21  122  #define DECLARE_PER_CPU_FIRST(type, name)				\
5028eaa97d David Howells       2009-04-21  123  	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
5028eaa97d David Howells       2009-04-21  124  
5028eaa97d David Howells       2009-04-21  125  #define DEFINE_PER_CPU_FIRST(type, name)				\
5028eaa97d David Howells       2009-04-21  126  	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
5028eaa97d David Howells       2009-04-21  127  
5028eaa97d David Howells       2009-04-21  128  /*
5028eaa97d David Howells       2009-04-21  129   * Declaration/definition used for per-CPU variables that must be cacheline
5028eaa97d David Howells       2009-04-21  130   * aligned under SMP conditions so that, whilst a particular instance of the
5028eaa97d David Howells       2009-04-21  131   * data corresponds to a particular CPU, inefficiencies due to direct access by
5028eaa97d David Howells       2009-04-21  132   * other CPUs are reduced by preventing the data from unnecessarily spanning
5028eaa97d David Howells       2009-04-21  133   * cachelines.
5028eaa97d David Howells       2009-04-21  134   *
5028eaa97d David Howells       2009-04-21  135   * An example of this would be statistical data, where each CPU's set of data
5028eaa97d David Howells       2009-04-21  136   * is updated by that CPU alone, but the data from across all CPUs is collated
5028eaa97d David Howells       2009-04-21  137   * by a CPU processing a read from a proc file.
5028eaa97d David Howells       2009-04-21  138   */
5028eaa97d David Howells       2009-04-21  139  #define DECLARE_PER_CPU_SHARED_ALIGNED(type, name)			\
5028eaa97d David Howells       2009-04-21  140  	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_SHARED_ALIGNED_SECTION) \
5028eaa97d David Howells       2009-04-21  141  	____cacheline_aligned_in_smp
5028eaa97d David Howells       2009-04-21  142  
5028eaa97d David Howells       2009-04-21  143  #define DEFINE_PER_CPU_SHARED_ALIGNED(type, name)			\
5028eaa97d David Howells       2009-04-21  144  	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_SHARED_ALIGNED_SECTION) \
5028eaa97d David Howells       2009-04-21  145  	____cacheline_aligned_in_smp
5028eaa97d David Howells       2009-04-21  146  
53f824520b Jeremy Fitzhardinge 2009-09-03  147  #define DECLARE_PER_CPU_ALIGNED(type, name)				\
53f824520b Jeremy Fitzhardinge 2009-09-03  148  	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)	\
53f824520b Jeremy Fitzhardinge 2009-09-03  149  	____cacheline_aligned
53f824520b Jeremy Fitzhardinge 2009-09-03  150  
53f824520b Jeremy Fitzhardinge 2009-09-03  151  #define DEFINE_PER_CPU_ALIGNED(type, name)				\
53f824520b Jeremy Fitzhardinge 2009-09-03  152  	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)	\
53f824520b Jeremy Fitzhardinge 2009-09-03  153  	____cacheline_aligned
53f824520b Jeremy Fitzhardinge 2009-09-03  154  
5028eaa97d David Howells       2009-04-21  155  /*
5028eaa97d David Howells       2009-04-21  156   * Declaration/definition used for per-CPU variables that must be page aligned.
5028eaa97d David Howells       2009-04-21  157   */
5028eaa97d David Howells       2009-04-21  158  #define DECLARE_PER_CPU_PAGE_ALIGNED(type, name)			\
3d9a854c2d Denys Vlasenko      2010-02-20  159  	DECLARE_PER_CPU_SECTION(type, name, "..page_aligned")		\
3e352aa8ee Tejun Heo           2009-08-03  160  	__aligned(PAGE_SIZE)
5028eaa97d David Howells       2009-04-21  161  
5028eaa97d David Howells       2009-04-21  162  #define DEFINE_PER_CPU_PAGE_ALIGNED(type, name)				\
3d9a854c2d Denys Vlasenko      2010-02-20  163  	DEFINE_PER_CPU_SECTION(type, name, "..page_aligned")		\
3e352aa8ee Tejun Heo           2009-08-03  164  	__aligned(PAGE_SIZE)
5028eaa97d David Howells       2009-04-21  165  
5028eaa97d David Howells       2009-04-21  166  /*
c957ef2c59 Shaohua Li          2010-10-20  167   * Declaration/definition used for per-CPU variables that must be read mostly.
c957ef2c59 Shaohua Li          2010-10-20  168   */
c957ef2c59 Shaohua Li          2010-10-20  169  #define DECLARE_PER_CPU_READ_MOSTLY(type, name)			\
330d282216 Zhengyu He          2014-07-01  170  	DECLARE_PER_CPU_SECTION(type, name, "..read_mostly")
c957ef2c59 Shaohua Li          2010-10-20  171  
c957ef2c59 Shaohua Li          2010-10-20  172  #define DEFINE_PER_CPU_READ_MOSTLY(type, name)				\
330d282216 Zhengyu He          2014-07-01  173  	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
c957ef2c59 Shaohua Li          2010-10-20  174  
c957ef2c59 Shaohua Li          2010-10-20  175  /*
ac26963a11 Brijesh Singh       2017-10-20  176   * Declaration/definition used for per-CPU variables that should be accessed
ac26963a11 Brijesh Singh       2017-10-20  177   * as decrypted when memory encryption is enabled in the guest.
ac26963a11 Brijesh Singh       2017-10-20  178   */
ac26963a11 Brijesh Singh       2017-10-20  179  #if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
ac26963a11 Brijesh Singh       2017-10-20  180  
ac26963a11 Brijesh Singh       2017-10-20  181  #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
ac26963a11 Brijesh Singh       2017-10-20  182  	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
ac26963a11 Brijesh Singh       2017-10-20  183  
ac26963a11 Brijesh Singh       2017-10-20  184  #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
ac26963a11 Brijesh Singh       2017-10-20  185  	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
ac26963a11 Brijesh Singh       2017-10-20  186  #else
ac26963a11 Brijesh Singh       2017-10-20  187  #define DEFINE_PER_CPU_DECRYPTED(type, name)	DEFINE_PER_CPU(type, name)
ac26963a11 Brijesh Singh       2017-10-20  188  #endif
ac26963a11 Brijesh Singh       2017-10-20  189  
ac26963a11 Brijesh Singh       2017-10-20  190  /*
545695fb41 Tejun Heo           2009-10-29  191   * Intermodule exports for per-CPU variables.  sparse forgets about
545695fb41 Tejun Heo           2009-10-29  192   * address space across EXPORT_SYMBOL(), change EXPORT_SYMBOL() to
545695fb41 Tejun Heo           2009-10-29  193   * noop if __CHECKER__.
5028eaa97d David Howells       2009-04-21  194   */
545695fb41 Tejun Heo           2009-10-29  195  #ifndef __CHECKER__
dd17c8f729 Rusty Russell       2009-10-29  196  #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var)
dd17c8f729 Rusty Russell       2009-10-29  197  #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var)
545695fb41 Tejun Heo           2009-10-29  198  #else
545695fb41 Tejun Heo           2009-10-29  199  #define EXPORT_PER_CPU_SYMBOL(var)
545695fb41 Tejun Heo           2009-10-29  200  #define EXPORT_PER_CPU_SYMBOL_GPL(var)
545695fb41 Tejun Heo           2009-10-29  201  #endif
5028eaa97d David Howells       2009-04-21  202  
62fde54123 Tejun Heo           2014-06-17  203  /*
62fde54123 Tejun Heo           2014-06-17  204   * Accessors and operations.
62fde54123 Tejun Heo           2014-06-17  205   */
62fde54123 Tejun Heo           2014-06-17  206  #ifndef __ASSEMBLY__
62fde54123 Tejun Heo           2014-06-17  207  
9c28278a24 Tejun Heo           2014-06-17  208  /*
6fbc07bbe2 Tejun Heo           2014-06-17  209   * __verify_pcpu_ptr() verifies @ptr is a percpu pointer without evaluating
6fbc07bbe2 Tejun Heo           2014-06-17  210   * @ptr and is invoked once before a percpu area is accessed by all
6fbc07bbe2 Tejun Heo           2014-06-17  211   * accessors and operations.  This is performed in the generic part of
6fbc07bbe2 Tejun Heo           2014-06-17  212   * percpu and arch overrides don't need to worry about it; however, if an
6fbc07bbe2 Tejun Heo           2014-06-17  213   * arch wants to implement an arch-specific percpu accessor or operation,
6fbc07bbe2 Tejun Heo           2014-06-17  214   * it may use __verify_pcpu_ptr() to verify the parameters.
9c28278a24 Tejun Heo           2014-06-17  215   *
9c28278a24 Tejun Heo           2014-06-17  216   * + 0 is required in order to convert the pointer type from a
9c28278a24 Tejun Heo           2014-06-17  217   * potential array type to a pointer to a single item of the array.
9c28278a24 Tejun Heo           2014-06-17  218   */
eba117889a Tejun Heo           2014-06-17  219  #define __verify_pcpu_ptr(ptr)						\
eba117889a Tejun Heo           2014-06-17  220  do {									\
9c28278a24 Tejun Heo           2014-06-17 @221  	const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;	\
9c28278a24 Tejun Heo           2014-06-17  222  	(void)__vpp_verify;						\
9c28278a24 Tejun Heo           2014-06-17  223  } while (0)
9c28278a24 Tejun Heo           2014-06-17  224  

:::::: The code at line 49 was first introduced by commit
:::::: e0fdb0e050eae331046385643618f12452aa7e73 percpu: add __percpu for sparse.

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TabmOoOpLuYgabRUivP/AMTAA7iJKQEA

--wRRV7LY7NUeQGEoC--
