Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDXPmW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:42:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:58012 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeDXPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:42:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="35796702"
Date: Tue, 24 Apr 2018 23:41:16 +0800
From: kbuild test robot <lkp@intel.com>
To: jeffm@suse.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 5/5] procfs: share fd/fdinfo with thread group leader
 when files are shared
Message-ID: <201804242316.TemnBYbI%fengguang.wu@intel.com>
References: <20180424022106.16952-6-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424022106.16952-6-jeffm@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/jeffm-suse-com/procfs-reduce-duplication-by-using-symlinks/20180424-203620
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:285:34: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:331:42: sparse: expression using sizeof(void)
   fs/proc/base.c:834:32: sparse: expression using sizeof(void)
   fs/proc/base.c:950:27: sparse: expression using sizeof(void)
   fs/proc/base.c:951:28: sparse: expression using sizeof(void)
   fs/proc/base.c:951:28: sparse: expression using sizeof(void)
   fs/proc/base.c:2085:25: sparse: cast to restricted fmode_t
   fs/proc/base.c:2140:42: sparse: cast from restricted fmode_t
   fs/proc/base.c:2243:48: sparse: cast from restricted fmode_t
>> fs/proc/base.c:3568:32: sparse: symbol 'proc_pid_files_link_dentry_operations' was not declared. Should it be static?
   fs/proc/base.c:1078:36: sparse: context imbalance in '__set_oom_adj' - unexpected unlock
   fs/proc/base.c:2271:13: sparse: context imbalance in 'timers_start' - wrong count at exit
   fs/proc/base.c:2297:36: sparse: context imbalance in 'timers_stop' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
