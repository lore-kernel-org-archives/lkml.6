Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5590C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5600F2238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5600F2238F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHJBAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:00:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:28258 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeHJBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:00:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 15:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="61997246"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2018 15:33:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fntUR-000H2p-Na; Fri, 10 Aug 2018 06:33:07 +0800
Date:   Fri, 10 Aug 2018 06:33:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/5] xen/blkback: don't keep persistent grants too long
Message-ID: <201808100636.B2N6Mzlj%fengguang.wu@intel.com>
References: <20180808142528.31029-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808142528.31029-2-jgross@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.18-rc8 next-20180809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Juergen-Gross/xen-blk-persistent-grant-rework/20180810-003229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/block/xen-blkback/blkback.c:91:14: sparse: symbol 'xen_blkif_pgrant_timeout' was not declared. Should it be static?
   drivers/block/xen-blkback/blkback.c:1368:41: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:409:29: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:409:29: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/blkback.c:791:38: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/common.h:434:21: sparse: expression using sizeof(void)
   drivers/block/xen-blkback/common.h:482:21: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
