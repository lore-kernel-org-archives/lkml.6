Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59772C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF8A20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF8A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTNjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:39:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:36256 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:39:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 03:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="gz'50?scan'50,208,50";a="84783381"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2018 03:24:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1frhLu-000BwH-Lm; Mon, 20 Aug 2018 18:24:02 +0800
Date:   Mon, 20 Aug 2018 18:23:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     kbuild-all@01.org, broonie@kernel.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: Re: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Message-ID: <201808201808.34Gndc50%fengguang.wu@intel.com>
References: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chuanhua,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chuanhua-Han/mtd-m25p80-consider-max-message-size-when-use-the-spi_mem_xx-API/20180820-174451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-x076-201833 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/list.h:9:0,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/dmaengine.h:20,
                    from drivers/spi/spi-mem.c:8:
   drivers/spi/spi-mem.c: In function 'spi_mem_adjust_op_size':
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:820:48: note: in definition of macro '__is_constexpr'
     (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                   ^
   include/linux/kernel.h:826:25: note: in expansion of macro '__no_side_effects'
      (__typecheck(x, y) && __no_side_effects(x, y))
                            ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:828:27: note: in definition of macro '__cmp'
    #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                              ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:828:40: note: in definition of macro '__cmp'
    #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                                           ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:831:10: note: in definition of macro '__cmp_once'
      typeof(x) unique_x = (x);  \
             ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:831:25: note: in definition of macro '__cmp_once'
      typeof(x) unique_x = (x);  \
                            ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
>> drivers/spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
--
   In file included from include/linux/list.h:9:0,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/dmaengine.h:20,
                    from drivers//spi/spi-mem.c:8:
   drivers//spi/spi-mem.c: In function 'spi_mem_adjust_op_size':
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:820:48: note: in definition of macro '__is_constexpr'
     (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                   ^
   include/linux/kernel.h:826:25: note: in expansion of macro '__no_side_effects'
      (__typecheck(x, y) && __no_side_effects(x, y))
                            ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:828:27: note: in definition of macro '__cmp'
    #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                              ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:828:40: note: in definition of macro '__cmp'
    #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                                           ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:831:10: note: in definition of macro '__cmp_once'
      typeof(x) unique_x = (x);  \
             ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~
   include/linux/kernel.h:812:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:831:25: note: in definition of macro '__cmp_once'
      typeof(x) unique_x = (x);  \
                            ^
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
>> include/linux/kernel.h:860:23: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                          ^~~
   include/linux/kernel.h:826:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), \
                           ^~~~~~~~~~
   include/linux/kernel.h:845:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   include/linux/kernel.h:860:38: note: in expansion of macro 'min'
    #define min3(x, y, z) min((typeof(x))min(x, y), z)
                                         ^~~
   drivers//spi/spi-mem.c:360:21: note: in expansion of macro 'min3'
      op->data.nbytes = min3((unsigned long)op->data.nbytes,
                        ^~~~

vim +/min3 +360 drivers/spi/spi-mem.c

   330	
   331	/**
   332	 * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
   333	 *			      match controller limitations
   334	 * @mem: the SPI memory
   335	 * @op: the operation to adjust
   336	 *
   337	 * Some controllers have FIFO limitations and must split a data transfer
   338	 * operation into multiple ones, others require a specific alignment for
   339	 * optimized accesses. This function allows SPI mem drivers to split a single
   340	 * operation into multiple sub-operations when required.
   341	 *
   342	 * Return: a negative error code if the controller can't properly adjust @op,
   343	 *	   0 otherwise. Note that @op->data.nbytes will be updated if @op
   344	 *	   can't be handled in a single step.
   345	 */
   346	int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
   347	{
   348		struct spi_controller *ctlr = mem->spi->controller;
   349		unsigned long val =	sizeof(op->cmd.opcode) +
   350								  op->addr.nbytes +
   351								  op->dummy.nbytes;
   352	
   353		if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
   354			return ctlr->mem_ops->adjust_op_size(mem, op);
   355	
   356		if (spi_max_message_size(mem->spi) < val)
   357			return -EINVAL;
   358	
   359		if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
 > 360			op->data.nbytes = min3((unsigned long)op->data.nbytes,
   361					spi_max_transfer_size(mem->spi),
   362					spi_max_message_size(mem->spi) - val);
   363	
   364		return 0;
   365	}
   366	EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
   367	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Qxx1br4bt0+wmkIi--
