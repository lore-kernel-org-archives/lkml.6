Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeFEHfV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:35:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:49807 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbeFEHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:35:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="gz'50?scan'50,208,50";a="47368548"
Date: Tue, 5 Jun 2018 15:34:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Nadav Amit <namit@vmware.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 5/9] x86: bug: prevent gcc distortions
Message-ID: <201806051333.gjsWHgPs%fengguang.wu@intel.com>
References: <20180604112131.59100-6-namit@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20180604112131.59100-6-namit@vmware.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nadav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17 next-20180604]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nadav-Amit/x86-macrofying-inline-asm-for-better-compilation/20180605-124313
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/bug.h:5:0,
                    from include/linux/crypto.h:23,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/ktime.h: In function 'ktime_divns':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
>> include/linux/ktime.h:150:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(div < 0);
     ^~~~~~
   include/linux/rhashtable.h: In function 'rhashtable_lookup_insert_fast':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
>> include/linux/rhashtable.h:936:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(ht->p.obj_hashfn);
     ^~~~~~
   include/linux/rhashtable.h: In function 'rhashtable_lookup_get_insert_fast':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/rhashtable.h:962:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(ht->p.obj_hashfn);
     ^~~~~~
   include/linux/rhashtable.h: In function 'rhashtable_lookup_insert_key':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/rhashtable.h:996:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(!ht->p.obj_hashfn || !key);
     ^~~~~~
   include/linux/rhashtable.h: In function 'rhashtable_lookup_get_insert_key':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/rhashtable.h:1020:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(!ht->p.obj_hashfn || !key);
     ^~~~~~
   include/linux/crypto.h: In function 'crypto_blkcipher_cast':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
>> include/linux/crypto.h:1118:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_BLKCIPHER);
     ^~~~~~
   include/linux/crypto.h: In function 'crypto_cipher_cast':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/crypto.h:1438:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
     ^~~~~~
   include/linux/crypto.h: In function 'crypto_comp_cast':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/crypto.h:1603:2: note: in expansion of macro 'BUG_ON'
     BUG_ON((crypto_tfm_alg_type(tfm) ^ CRYPTO_ALG_TYPE_COMPRESS) &
     ^~~~~~
   include/linux/quota.h: In function 'make_kqid':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
>> include/linux/quota.h:114:3: note: in expansion of macro 'BUG'
      BUG();
      ^~~
   include/linux/quota.h: In function 'make_kqid_invalid':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/linux/quota.h:141:3: note: in expansion of macro 'BUG'
      BUG();
      ^~~
   include/linux/fs.h: In function 'kill_block_super':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
>> include/linux/fs.h:2124:2: note: in expansion of macro 'BUG'
     BUG();
     ^~~
   include/linux/fs.h: In function 'break_deleg_wait':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/linux/fs.h:2371:2: note: in expansion of macro 'BUG'
     BUG();
     ^~~
   include/linux/seq_file.h: In function 'seq_get_buf':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
>> include/linux/seq_file.h:66:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(m->count > m->size);
     ^~~~~~
   include/linux/seq_file.h: In function 'seq_commit':
>> arch/x86/include/asm/bug.h:31:17: error: invalid application of 'sizeof' to incomplete type 'struct bug_entry'
        "i" (sizeof(struct bug_entry)));  \
                    ^
   arch/x86/include/asm/bug.h:37:2: note: in expansion of macro '_BUG_FLAGS'
     _BUG_FLAGS(ASM_UD2, 0);     \
     ^~~~~~~~~~
   include/asm-generic/bug.h:176:47: note: in expansion of macro 'BUG'
    #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
                                                  ^~~
   include/linux/seq_file.h:89:3: note: in expansion of macro 'BUG_ON'
      BUG_ON(m->count + num > m->size);
      ^~~~~~
   include/asm-generic/fixmap.h: In function 'virt_to_fix':

vim +31 arch/x86/include/asm/bug.h

9a93848f arch/x86/include/asm/bug.h Peter Zijlstra  2017-02-02  24  
9a93848f arch/x86/include/asm/bug.h Peter Zijlstra  2017-02-02  25  #define _BUG_FLAGS(ins, flags)						\
68fdc55c include/asm-x86/bug.h      Thomas Gleixner 2007-10-17  26  do {									\
6eca12b3 arch/x86/include/asm/bug.h Nadav Amit      2018-06-04  27  	asm volatile("ASM_BUG ins=\"" ins "\" file=%c0 line=%c1 "	\
6eca12b3 arch/x86/include/asm/bug.h Nadav Amit      2018-06-04  28  		     "flags=%c2 size=%c3"				\
68fdc55c include/asm-x86/bug.h      Thomas Gleixner 2007-10-17  29  		     : : "i" (__FILE__), "i" (__LINE__),                \
9a93848f arch/x86/include/asm/bug.h Peter Zijlstra  2017-02-02  30  			 "i" (flags),                                   \
68fdc55c include/asm-x86/bug.h      Thomas Gleixner 2007-10-17 @31  			 "i" (sizeof(struct bug_entry)));		\
68fdc55c include/asm-x86/bug.h      Thomas Gleixner 2007-10-17  32  } while (0)
68fdc55c include/asm-x86/bug.h      Thomas Gleixner 2007-10-17  33  

:::::: The code at line 31 was first introduced by commit
:::::: 68fdc55c48fd2e8f4938a1e815216c25baf8a17e x86: unify include/asm/bug_32/64.h

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@inhelltoy.tec.linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--
