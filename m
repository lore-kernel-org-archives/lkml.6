Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeEAWuq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:50:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:20750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeEAWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:50:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="gz'50?scan'50,208,50";a="224977139"
Date: Wed, 2 May 2018 06:49:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86, memcpy_mcsafe: define copy_to_iter_mcsafe()
Message-ID: <201805020551.YQoEZubE%fengguang.wu@intel.com>
References: <152520752986.36522.6608981678390805141.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <152520752986.36522.6608981678390805141.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180501]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/use-memcpy_mcsafe-for-copy_to_iter/20180502-045742
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   lib/iov_iter.c: In function 'copyout_mcsafe':
>> lib/iov_iter.c:146:7: error: implicit declaration of function 'copy_to_user_mcsafe'; did you mean 'copy_to_iter_mcsafe'? [-Werror=implicit-function-declaration]
      n = copy_to_user_mcsafe((__force void *) to, from, n);
          ^~~~~~~~~~~~~~~~~~~
          copy_to_iter_mcsafe
   cc1: some warnings being treated as errors

vim +146 lib/iov_iter.c

   141	
   142	static int copyout_mcsafe(void __user *to, const void *from, size_t n)
   143	{
   144		if (access_ok(VERIFY_WRITE, to, n)) {
   145			kasan_check_read(from, n);
 > 146			n = copy_to_user_mcsafe((__force void *) to, from, n);
   147		}
   148		return n;
   149	}
   150	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ikeVEW9yuYc//A+q--
