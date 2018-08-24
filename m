Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F9CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB5C208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB5C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHXJGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:06:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:18026 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeHXJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:06:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 22:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,281,1531810800"; 
   d="scan'208";a="86001473"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2018 22:33:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ft4ib-0004lt-Mu; Fri, 24 Aug 2018 13:33:09 +0800
Date:   Fri, 24 Aug 2018 13:32:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Weikang Shi <swkhack@gmail.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org,
        alexander.h.duyck@intel.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@suse.de, l.stach@pengutronix.de, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        my_email@gmail.com, Weikang Shi <swkhack@gmail.com>
Subject: Re: [PATCH] fs: fix local var type
Message-ID: <201808241151.885cwq5J%fengguang.wu@intel.com>
References: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weikang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18 next-20180822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Weikang-Shi/fs-fix-local-var-type/20180823-180758
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/seq_file.c:210:21: sparse: expression using sizeof(void)
   fs/seq_file.c:210:21: sparse: expression using sizeof(void)
   fs/seq_file.c:276:13: sparse: expression using sizeof(void)
   fs/seq_file.c:276:13: sparse: expression using sizeof(void)
>> fs/seq_file.c:860:27: sparse: incompatible types in comparison expression (different type sizes)
   fs/seq_file.c:1037:24: sparse: incompatible types in comparison expression (different address spaces)
   fs/seq_file.c:1039:24: sparse: incompatible types in comparison expression (different address spaces)
>> fs/seq_file.c:860:27: sparse: call with no type!
   In file included from include/linux/list.h:9:0,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/seq_file.c:10:
   fs/seq_file.c: In function 'seq_hex_dump':
   include/linux/kernel.h:845:29: warning: comparison of distinct pointer types lacks a cast
      (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                ^
   include/linux/kernel.h:859:4: note: in expansion of macro '__typecheck'
      (__typecheck(x, y) && __no_side_effects(x, y))
       ^~~~~~~~~~~
   include/linux/kernel.h:869:24: note: in expansion of macro '__safe_cmp'
     __builtin_choose_expr(__safe_cmp(x, y), 23-                        ^~~~~~~~~~
   include/linux/kernel.h:878:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(x, y, <)
                      ^~~~~~~~~~~~~
   fs/seq_file.c:860:13: note: in expansion of macro 'min'
      linelen = min(remaining, rowsize);
                ^~~

vim +860 fs/seq_file.c

839cc2a9 Tetsuo Handa    2013-11-14  843  
37607102 Andy Shevchenko 2015-09-09  844  /* A complete analogue of print_hex_dump() */
37607102 Andy Shevchenko 2015-09-09  845  void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
37607102 Andy Shevchenko 2015-09-09  846  		  int rowsize, int groupsize, const void *buf, size_t len,
37607102 Andy Shevchenko 2015-09-09  847  		  bool ascii)
37607102 Andy Shevchenko 2015-09-09  848  {
37607102 Andy Shevchenko 2015-09-09  849  	const u8 *ptr = buf;
5f9924ac Weikang Shi     2018-08-23  850  	int i, linelen;
5f9924ac Weikang Shi     2018-08-23  851  	size_t remaining = len;
8b91a318 Andy Shevchenko 2015-11-06  852  	char *buffer;
8b91a318 Andy Shevchenko 2015-11-06  853  	size_t size;
37607102 Andy Shevchenko 2015-09-09  854  	int ret;
37607102 Andy Shevchenko 2015-09-09  855  
37607102 Andy Shevchenko 2015-09-09  856  	if (rowsize != 16 && rowsize != 32)
37607102 Andy Shevchenko 2015-09-09  857  		rowsize = 16;
37607102 Andy Shevchenko 2015-09-09  858  
37607102 Andy Shevchenko 2015-09-09  859  	for (i = 0; i < len && !seq_has_overflowed(m); i += rowsize) {
37607102 Andy Shevchenko 2015-09-09 @860  		linelen = min(remaining, rowsize);
37607102 Andy Shevchenko 2015-09-09  861  		remaining -= rowsize;
37607102 Andy Shevchenko 2015-09-09  862  
37607102 Andy Shevchenko 2015-09-09  863  		switch (prefix_type) {
37607102 Andy Shevchenko 2015-09-09  864  		case DUMP_PREFIX_ADDRESS:
37607102 Andy Shevchenko 2015-09-09  865  			seq_printf(m, "%s%p: ", prefix_str, ptr + i);
37607102 Andy Shevchenko 2015-09-09  866  			break;
37607102 Andy Shevchenko 2015-09-09  867  		case DUMP_PREFIX_OFFSET:
37607102 Andy Shevchenko 2015-09-09  868  			seq_printf(m, "%s%.8x: ", prefix_str, i);
37607102 Andy Shevchenko 2015-09-09  869  			break;
37607102 Andy Shevchenko 2015-09-09  870  		default:
37607102 Andy Shevchenko 2015-09-09  871  			seq_printf(m, "%s", prefix_str);
37607102 Andy Shevchenko 2015-09-09  872  			break;
37607102 Andy Shevchenko 2015-09-09  873  		}
37607102 Andy Shevchenko 2015-09-09  874  
8b91a318 Andy Shevchenko 2015-11-06  875  		size = seq_get_buf(m, &buffer);
37607102 Andy Shevchenko 2015-09-09  876  		ret = hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
8b91a318 Andy Shevchenko 2015-11-06  877  					 buffer, size, ascii);
8b91a318 Andy Shevchenko 2015-11-06  878  		seq_commit(m, ret < size ? ret : -1);
8b91a318 Andy Shevchenko 2015-11-06  879  
37607102 Andy Shevchenko 2015-09-09  880  		seq_putc(m, '\n');
37607102 Andy Shevchenko 2015-09-09  881  	}
37607102 Andy Shevchenko 2015-09-09  882  }
37607102 Andy Shevchenko 2015-09-09  883  EXPORT_SYMBOL(seq_hex_dump);
37607102 Andy Shevchenko 2015-09-09  884  

:::::: The code at line 860 was first introduced by commit
:::::: 37607102c4426cf92aeb5da1b1d9a79ba6d95e3f seq_file: provide an analogue of print_hex_dump()

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
