Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014D21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbeLUAkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:40:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:41044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLUAkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:40:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 16:40:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; 
   d="gz'50?scan'50,208,50";a="112254345"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 16:40:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ga8ra-000ItL-TH; Fri, 21 Dec 2018 08:40:26 +0800
Date:   Fri, 21 Dec 2018 08:39:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] include/linux/nodemask.h: Use nr_node_ids (not
 MAX_NUMNODES) in __nodemask_pr_numnodes()
Message-ID: <201812210836.SVZGQPJS%fengguang.wu@intel.com>
References: <1545253492-32070-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1545253492-32070-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Waiman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.20-rc7 next-20181220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Waiman-Long/include-linux-nodemask-h-Use-nr_node_ids-not-MAX_NUMNODES-in-__nodemask_pr_numnodes/20181221-082352
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All warnings (new ones prefixed by >>):

   In file included from include/linux/sched.h:22,
                    from arch/riscv/kernel/asm-offsets.c:18:
>> include/linux/nodemask.h:492: warning: "nr_node_ids" redefined
    #define nr_node_ids  1
    
   include/linux/nodemask.h:105: note: this is the location of the previous definition
    #define nr_node_ids MAX_NUMNODES
    

vim +/nr_node_ids +492 include/linux/nodemask.h

13808910 Christoph Lameter 2007-10-16  485  
13808910 Christoph Lameter 2007-10-16  486  #define for_each_node_state(node, __state) \
13808910 Christoph Lameter 2007-10-16  487  	for ( (node) = 0; (node) == 0; (node) = 1)
13808910 Christoph Lameter 2007-10-16  488  
8357f869 KAMEZAWA Hiroyuki 2006-03-27  489  #define first_online_node	0
8d060bf4 David Rientjes    2014-08-06  490  #define first_memory_node	0
8357f869 KAMEZAWA Hiroyuki 2006-03-27  491  #define next_online_node(nid)	(MAX_NUMNODES)
74c7aa8b Christoph Lameter 2007-02-20 @492  #define nr_node_ids		1
62bc62a8 Christoph Lameter 2009-06-16  493  #define nr_online_nodes		1
13808910 Christoph Lameter 2007-10-16  494  

:::::: The code at line 492 was first introduced by commit
:::::: 74c7aa8b8581e0ba8d6d17c623b9279aaabbb0cf [PATCH] Replace highest_possible_node_id() with nr_node_ids

:::::: TO: Christoph Lameter <clameter@sgi.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--45Z9DzgjV8m4Oswq--
