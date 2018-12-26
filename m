Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11793C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4622148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbeLZAMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:12:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:7410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeLZAMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:12:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2018 16:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,398,1539673200"; 
   d="gz'50?scan'50,208,50";a="103311161"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2018 16:11:57 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gbwnl-0005Ch-2l; Wed, 26 Dec 2018 08:11:57 +0800
Date:   Wed, 26 Dec 2018 08:11:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     kbuild-all@01.org, kjlu@umn.edu, pakki001@umn.edu,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: fix a potential inconsistency caused by
 double-fetch
Message-ID: <201812260859.WLm448Ms%fengguang.wu@intel.com>
References: <20181225214633.69973-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20181225214633.69973-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kangjie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.20 next-20181224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/acpi-fix-a-potential-inconsistency-caused-by-double-fetch/20181226-054721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-c0-12260412 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:5:0,
                    from drivers/acpi/custom_method.c:5:
   drivers/acpi/custom_method.c: In function 'cm_write':
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   arch/x86/include/asm/uaccess.h:138:12: error: first argument to '__builtin_choose_expr' not a constant
    __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
               ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   arch/x86/include/asm/uaccess.h:138:12: error: first argument to '__builtin_choose_expr' not a constant
    __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
               ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   arch/x86/include/asm/uaccess.h:138:12: error: first argument to '__builtin_choose_expr' not a constant
    __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
               ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   arch/x86/include/asm/uaccess.h:174:11: note: in expansion of macro '__inttype'
     register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);  \
              ^~~~~~~~~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:36:42: error: request for member 'length' in something not a structure or union
        &(struct acpi_table_header *)user_buf->length))
                                             ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/acpi/custom_method.c:35:3: note: in expansion of macro 'if'
      if (get_user(max_size,
      ^~
   drivers/acpi/custom_method.c:35:7: note: in expansion of macro 'get_user'
      if (get_user(max_size,
          ^~~~~~~~
   drivers/acpi/custom_method.c:59:45: error: request for member 'length' in something not a structure or union
     (struct acpi_table_header *)(buf + (*ppos))->length = max_size;
                                                ^~

vim +/if +35 drivers/acpi/custom_method.c

   > 5	#include <linux/init.h>
     6	#include <linux/module.h>
     7	#include <linux/kernel.h>
     8	#include <linux/uaccess.h>
     9	#include <linux/debugfs.h>
    10	#include <linux/acpi.h>
    11	
    12	#include "internal.h"
    13	
    14	#define _COMPONENT		ACPI_SYSTEM_COMPONENT
    15	ACPI_MODULE_NAME("custom_method");
    16	MODULE_LICENSE("GPL");
    17	
    18	static struct dentry *cm_dentry;
    19	
    20	/* /sys/kernel/debug/acpi/custom_method */
    21	
    22	static ssize_t cm_write(struct file *file, const char __user * user_buf,
    23				size_t count, loff_t *ppos)
    24	{
    25		static char *buf;
    26		static u32 max_size;
    27		static u32 uncopied_bytes;
    28	
    29		acpi_status status;
    30	
    31		if (!(*ppos)) {
    32			/* parse the table header to get the table length */
    33			if (count <= sizeof(struct acpi_table_header))
    34				return -EINVAL;
  > 35			if (get_user(max_size,
    36					&(struct acpi_table_header *)user_buf->length))
    37				return -EFAULT;
    38			uncopied_bytes = max_size;
    39			buf = kzalloc(max_size, GFP_KERNEL);
    40			if (!buf)
    41				return -ENOMEM;
    42		}
    43	
    44		if (buf == NULL)
    45			return -EINVAL;
    46	
    47		if ((*ppos > max_size) ||
    48		    (*ppos + count > max_size) ||
    49		    (*ppos + count < count) ||
    50		    (count > uncopied_bytes))
    51			return -EINVAL;
    52	
    53		if (copy_from_user(buf + (*ppos), user_buf, count)) {
    54			kfree(buf);
    55			buf = NULL;
    56			return -EFAULT;
    57		}
    58		/* Ensure table length is not changed in the second copy */
    59		(struct acpi_table_header *)(buf + (*ppos))->length = max_size;
    60	
    61		uncopied_bytes -= count;
    62		*ppos += count;
    63	
    64		if (!uncopied_bytes) {
    65			status = acpi_install_method(buf);
    66			kfree(buf);
    67			buf = NULL;
    68			if (ACPI_FAILURE(status))
    69				return -EINVAL;
    70			add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
    71		}
    72	
    73		return count;
    74	}
    75	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AhhlLboLdkugWU4S--
