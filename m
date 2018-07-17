Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77500ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52C9208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52C9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGQBYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:24:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:35786 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbeGQBYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:24:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="gz'50?scan'50,208,50";a="245787761"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2018 17:53:01 -0700
Date:   Tue, 17 Jul 2018 09:04:06 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v2 1/7] kernfs: allow creating kernfs objects
 with arbitrary uid/gid
Message-ID: <20180717010405.GG10593@intel.com>
Reply-To: internal check <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <1531497949-1766-2-git-send-email-tyhicks@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Tyler-Hicks/Make-sys-class-net-per-net-namespace-objects-belong-to-container/20180716-020459
config: x86_64-randconfig-u0-07161309 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c: In function 'rdtgroup_add_file':
>> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:149:7: error: incompatible type for argument 4 of '__kernfs_create_file'
          0, rft->kf_ops, rft, NULL, NULL);
          ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'kuid_t {aka struct <anonymous>}' but argument is of type 'int'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:149:10: error: incompatible type for argument 5 of '__kernfs_create_file'
          0, rft->kf_ops, rft, NULL, NULL);
             ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'kgid_t {aka struct <anonymous>}' but argument is of type 'struct kernfs_ops *'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:149:23: warning: passing argument 6 of '__kernfs_create_file' makes integer from pointer without a cast [-Wint-conversion]
          0, rft->kf_ops, rft, NULL, NULL);
                          ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'loff_t {aka long long int}' but argument is of type 'struct rftype *'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
>> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:148:7: error: too few arguments to function '__kernfs_create_file'
     kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
          ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: declared here
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c: In function 'mon_addfile':
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1506:51: error: incompatible type for argument 4 of '__kernfs_create_file'
     kn = __kernfs_create_file(parent_kn, name, 0444, 0,
                                                      ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'kuid_t {aka struct <anonymous>}' but argument is of type 'int'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1507:7: error: incompatible type for argument 5 of '__kernfs_create_file'
          &kf_mondata_ops, priv, NULL, NULL);
          ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'kgid_t {aka struct <anonymous>}' but argument is of type 'struct kernfs_ops *'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1507:24: warning: passing argument 6 of '__kernfs_create_file' makes integer from pointer without a cast [-Wint-conversion]
          &kf_mondata_ops, priv, NULL, NULL);
                           ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: expected 'loff_t {aka long long int}' but argument is of type 'void *'
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^
   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1506:7: error: too few arguments to function '__kernfs_create_file'
     kn = __kernfs_create_file(parent_kn, name, 0444, 0,
          ^
   In file included from include/linux/sysfs.h:16:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:23:
   include/linux/kernfs.h:333:21: note: declared here
    struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
                        ^

# https://github.com/0day-ci/linux/commit/d5f7e84e70937f0546d774162a3f9425caec5687
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d5f7e84e70937f0546d774162a3f9425caec5687
vim +/__kernfs_create_file +149 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c

5ff193fb Fenghua Yu      2016-10-28   22  
12e0110c Tony Luck       2016-10-28  @23  #include <linux/cpu.h>
5ff193fb Fenghua Yu      2016-10-28   24  #include <linux/fs.h>
5ff193fb Fenghua Yu      2016-10-28   25  #include <linux/sysfs.h>
5ff193fb Fenghua Yu      2016-10-28   26  #include <linux/kernfs.h>
9b3a7fd0 Tony Luck       2017-09-25   27  #include <linux/seq_buf.h>
4e978d06 Fenghua Yu      2016-10-28   28  #include <linux/seq_file.h>
3f07c014 Ingo Molnar     2017-02-08   29  #include <linux/sched/signal.h>
29930025 Ingo Molnar     2017-02-08   30  #include <linux/sched/task.h>
5ff193fb Fenghua Yu      2016-10-28   31  #include <linux/slab.h>
e02737d5 Fenghua Yu      2016-10-28   32  #include <linux/task_work.h>
5ff193fb Fenghua Yu      2016-10-28   33  
5ff193fb Fenghua Yu      2016-10-28   34  #include <uapi/linux/magic.h>
5ff193fb Fenghua Yu      2016-10-28   35  
05830204 Vikas Shivappa  2017-07-25   36  #include <asm/intel_rdt_sched.h>
05830204 Vikas Shivappa  2017-07-25   37  #include "intel_rdt.h"
5ff193fb Fenghua Yu      2016-10-28   38  
4af4a88e Vikas Shivappa  2017-07-25   39  DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
4af4a88e Vikas Shivappa  2017-07-25   40  DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
1b5c0b75 Vikas Shivappa  2017-07-25   41  DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
cb2200e9 Reinette Chatre 2017-07-25   42  static struct kernfs_root *rdt_root;
5ff193fb Fenghua Yu      2016-10-28   43  struct rdtgroup rdtgroup_default;
5ff193fb Fenghua Yu      2016-10-28   44  LIST_HEAD(rdt_all_groups);
5ff193fb Fenghua Yu      2016-10-28   45  
4e978d06 Fenghua Yu      2016-10-28   46  /* Kernel fs node for "info" directory under root */
4e978d06 Fenghua Yu      2016-10-28   47  static struct kernfs_node *kn_info;
4e978d06 Fenghua Yu      2016-10-28   48  
4af4a88e Vikas Shivappa  2017-07-25   49  /* Kernel fs node for "mon_groups" directory under root */
4af4a88e Vikas Shivappa  2017-07-25   50  static struct kernfs_node *kn_mongrp;
4af4a88e Vikas Shivappa  2017-07-25   51  
4af4a88e Vikas Shivappa  2017-07-25   52  /* Kernel fs node for "mon_data" directory under root */
4af4a88e Vikas Shivappa  2017-07-25   53  static struct kernfs_node *kn_mondata;
4af4a88e Vikas Shivappa  2017-07-25   54  
9b3a7fd0 Tony Luck       2017-09-25   55  static struct seq_buf last_cmd_status;
9b3a7fd0 Tony Luck       2017-09-25   56  static char last_cmd_status_buf[512];
9b3a7fd0 Tony Luck       2017-09-25   57  
9b3a7fd0 Tony Luck       2017-09-25   58  void rdt_last_cmd_clear(void)
9b3a7fd0 Tony Luck       2017-09-25   59  {
9b3a7fd0 Tony Luck       2017-09-25   60  	lockdep_assert_held(&rdtgroup_mutex);
9b3a7fd0 Tony Luck       2017-09-25   61  	seq_buf_clear(&last_cmd_status);
9b3a7fd0 Tony Luck       2017-09-25   62  }
9b3a7fd0 Tony Luck       2017-09-25   63  
9b3a7fd0 Tony Luck       2017-09-25   64  void rdt_last_cmd_puts(const char *s)
9b3a7fd0 Tony Luck       2017-09-25   65  {
9b3a7fd0 Tony Luck       2017-09-25   66  	lockdep_assert_held(&rdtgroup_mutex);
9b3a7fd0 Tony Luck       2017-09-25   67  	seq_buf_puts(&last_cmd_status, s);
9b3a7fd0 Tony Luck       2017-09-25   68  }
9b3a7fd0 Tony Luck       2017-09-25   69  
9b3a7fd0 Tony Luck       2017-09-25   70  void rdt_last_cmd_printf(const char *fmt, ...)
9b3a7fd0 Tony Luck       2017-09-25   71  {
9b3a7fd0 Tony Luck       2017-09-25   72  	va_list ap;
9b3a7fd0 Tony Luck       2017-09-25   73  
9b3a7fd0 Tony Luck       2017-09-25   74  	va_start(ap, fmt);
9b3a7fd0 Tony Luck       2017-09-25   75  	lockdep_assert_held(&rdtgroup_mutex);
9b3a7fd0 Tony Luck       2017-09-25   76  	seq_buf_vprintf(&last_cmd_status, fmt, ap);
9b3a7fd0 Tony Luck       2017-09-25   77  	va_end(ap);
9b3a7fd0 Tony Luck       2017-09-25   78  }
9b3a7fd0 Tony Luck       2017-09-25   79  
60cf5e10 Fenghua Yu      2016-10-28   80  /*
60cf5e10 Fenghua Yu      2016-10-28   81   * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
60cf5e10 Fenghua Yu      2016-10-28   82   * we can keep a bitmap of free CLOSIDs in a single integer.
60cf5e10 Fenghua Yu      2016-10-28   83   *
60cf5e10 Fenghua Yu      2016-10-28   84   * Using a global CLOSID across all resources has some advantages and
60cf5e10 Fenghua Yu      2016-10-28   85   * some drawbacks:
60cf5e10 Fenghua Yu      2016-10-28   86   * + We can simply set "current->closid" to assign a task to a resource
60cf5e10 Fenghua Yu      2016-10-28   87   *   group.
60cf5e10 Fenghua Yu      2016-10-28   88   * + Context switch code can avoid extra memory references deciding which
60cf5e10 Fenghua Yu      2016-10-28   89   *   CLOSID to load into the PQR_ASSOC MSR
60cf5e10 Fenghua Yu      2016-10-28   90   * - We give up some options in configuring resource groups across multi-socket
60cf5e10 Fenghua Yu      2016-10-28   91   *   systems.
60cf5e10 Fenghua Yu      2016-10-28   92   * - Our choices on how to configure each resource become progressively more
60cf5e10 Fenghua Yu      2016-10-28   93   *   limited as the number of resources grows.
60cf5e10 Fenghua Yu      2016-10-28   94   */
60cf5e10 Fenghua Yu      2016-10-28   95  static int closid_free_map;
60cf5e10 Fenghua Yu      2016-10-28   96  
60cf5e10 Fenghua Yu      2016-10-28   97  static void closid_init(void)
60cf5e10 Fenghua Yu      2016-10-28   98  {
60cf5e10 Fenghua Yu      2016-10-28   99  	struct rdt_resource *r;
60cf5e10 Fenghua Yu      2016-10-28  100  	int rdt_min_closid = 32;
60cf5e10 Fenghua Yu      2016-10-28  101  
60cf5e10 Fenghua Yu      2016-10-28  102  	/* Compute rdt_min_closid across all resources */
1b5c0b75 Vikas Shivappa  2017-07-25  103  	for_each_alloc_enabled_rdt_resource(r)
60cf5e10 Fenghua Yu      2016-10-28  104  		rdt_min_closid = min(rdt_min_closid, r->num_closid);
60cf5e10 Fenghua Yu      2016-10-28  105  
60cf5e10 Fenghua Yu      2016-10-28  106  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
60cf5e10 Fenghua Yu      2016-10-28  107  
60cf5e10 Fenghua Yu      2016-10-28  108  	/* CLOSID 0 is always reserved for the default group */
60cf5e10 Fenghua Yu      2016-10-28  109  	closid_free_map &= ~1;
60cf5e10 Fenghua Yu      2016-10-28  110  }
60cf5e10 Fenghua Yu      2016-10-28  111  
cb2200e9 Reinette Chatre 2017-07-25  112  static int closid_alloc(void)
60cf5e10 Fenghua Yu      2016-10-28  113  {
0734ded1 Vikas Shivappa  2017-07-25  114  	u32 closid = ffs(closid_free_map);
60cf5e10 Fenghua Yu      2016-10-28  115  
60cf5e10 Fenghua Yu      2016-10-28  116  	if (closid == 0)
60cf5e10 Fenghua Yu      2016-10-28  117  		return -ENOSPC;
60cf5e10 Fenghua Yu      2016-10-28  118  	closid--;
60cf5e10 Fenghua Yu      2016-10-28  119  	closid_free_map &= ~(1 << closid);
60cf5e10 Fenghua Yu      2016-10-28  120  
60cf5e10 Fenghua Yu      2016-10-28  121  	return closid;
60cf5e10 Fenghua Yu      2016-10-28  122  }
60cf5e10 Fenghua Yu      2016-10-28  123  
60cf5e10 Fenghua Yu      2016-10-28  124  static void closid_free(int closid)
60cf5e10 Fenghua Yu      2016-10-28  125  {
60cf5e10 Fenghua Yu      2016-10-28  126  	closid_free_map |= 1 << closid;
60cf5e10 Fenghua Yu      2016-10-28  127  }
60cf5e10 Fenghua Yu      2016-10-28  128  
4e978d06 Fenghua Yu      2016-10-28  129  /* set uid and gid of rdtgroup dirs and files to that of the creator */
4e978d06 Fenghua Yu      2016-10-28  130  static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
4e978d06 Fenghua Yu      2016-10-28  131  {
4e978d06 Fenghua Yu      2016-10-28  132  	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
4e978d06 Fenghua Yu      2016-10-28  133  				.ia_uid = current_fsuid(),
4e978d06 Fenghua Yu      2016-10-28  134  				.ia_gid = current_fsgid(), };
4e978d06 Fenghua Yu      2016-10-28  135  
4e978d06 Fenghua Yu      2016-10-28  136  	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
4e978d06 Fenghua Yu      2016-10-28  137  	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
4e978d06 Fenghua Yu      2016-10-28  138  		return 0;
4e978d06 Fenghua Yu      2016-10-28  139  
4e978d06 Fenghua Yu      2016-10-28  140  	return kernfs_setattr(kn, &iattr);
4e978d06 Fenghua Yu      2016-10-28  141  }
4e978d06 Fenghua Yu      2016-10-28  142  
4e978d06 Fenghua Yu      2016-10-28  143  static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
4e978d06 Fenghua Yu      2016-10-28  144  {
4e978d06 Fenghua Yu      2016-10-28  145  	struct kernfs_node *kn;
4e978d06 Fenghua Yu      2016-10-28  146  	int ret;
4e978d06 Fenghua Yu      2016-10-28  147  
4e978d06 Fenghua Yu      2016-10-28 @148  	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
4e978d06 Fenghua Yu      2016-10-28 @149  				  0, rft->kf_ops, rft, NULL, NULL);
4e978d06 Fenghua Yu      2016-10-28  150  	if (IS_ERR(kn))
4e978d06 Fenghua Yu      2016-10-28  151  		return PTR_ERR(kn);
4e978d06 Fenghua Yu      2016-10-28  152  
4e978d06 Fenghua Yu      2016-10-28  153  	ret = rdtgroup_kn_set_ugid(kn);
4e978d06 Fenghua Yu      2016-10-28  154  	if (ret) {
4e978d06 Fenghua Yu      2016-10-28  155  		kernfs_remove(kn);
4e978d06 Fenghua Yu      2016-10-28  156  		return ret;
4e978d06 Fenghua Yu      2016-10-28  157  	}
4e978d06 Fenghua Yu      2016-10-28  158  
4e978d06 Fenghua Yu      2016-10-28  159  	return 0;
4e978d06 Fenghua Yu      2016-10-28  160  }
4e978d06 Fenghua Yu      2016-10-28  161  

:::::: The code at line 149 was first introduced by commit
:::::: 4e978d06dedb8207b298a5a8a49fce4b2ab80d12 x86/intel_rdt: Add "info" files to resctrl file system

:::::: TO: Fenghua Yu <fenghua.yu@intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--l+goss899txtYvYf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qWzsoK2ttiqyichwyRq6/wfbXDh22ucBAA==

--l+goss899txtYvYf--
