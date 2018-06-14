Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77B04C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33484208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33484208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbeFNBFo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:05:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:7304 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935869AbeFNBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:05:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 18:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="59072877"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2018 18:05:41 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTGho-000Ldp-IM; Thu, 14 Jun 2018 09:05:40 +0800
Date:   Thu, 14 Jun 2018 09:04:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     kbuild-all@01.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 01/14] ubi: fastmap: Read PEB numbers more carefully
Message-ID: <201806140802.6mK4vHdX%fengguang.wu@intel.com>
References: <20180613212344.11608-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613212344.11608-2-richard@nod.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/master]
[also build test WARNING on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Richard-Weinberger/ubi-Fastmap-updates/20180614-052830
base:   git://git.infradead.org/linux-mtd.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/ubi/fastmap.c:110:14: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] pnum @@    got  [usertype] pnum @@
   drivers/mtd/ubi/fastmap.c:110:14:    expected restricted __be32 [usertype] pnum
   drivers/mtd/ubi/fastmap.c:110:14:    got unsigned int
>> drivers/mtd/ubi/fastmap.c:111:13: sparse: restricted __be32 degrades to integer
>> drivers/mtd/ubi/fastmap.c:112:27: sparse: incorrect type in assignment (different base types) @@    expected int [signed] <noident> @@    got restricted __be3int [signed] <noident> @@
   drivers/mtd/ubi/fastmap.c:112:27:    expected int [signed] <noident>
   drivers/mtd/ubi/fastmap.c:112:27:    got restricted __be32 [usertype] pnum
   drivers/mtd/ubi/fastmap.c:116:13: sparse: restricted __be32 degrades to integer
   drivers/mtd/ubi/fastmap.c:116:25: sparse: restricted __be32 degrades to integer
   drivers/mtd/ubi/fastmap.c:121:27: sparse: incorrect type in assignment (different base types) @@    expected int [signed] <noident> @@    got restricted __be3int [signed] <noident> @@
   drivers/mtd/ubi/fastmap.c:121:27:    expected int [signed] <noident>
   drivers/mtd/ubi/fastmap.c:121:27:    got restricted __be32 [usertype] pnum
   drivers/mtd/ubi/fastmap.c:604:23: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] max_sqnum @@    got nsigned long long [unsigned] max_sqnum @@
   drivers/mtd/ubi/fastmap.c:604:23:    expected unsigned long long [unsigned] max_sqnum
   drivers/mtd/ubi/fastmap.c:604:23:    got restricted __be64 [usertype] sqnum
   drivers/mtd/ubi/fastmap.c:1075:17: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] tmp_crc @@    got  [usertype] tmp_crc @@
   drivers/mtd/ubi/fastmap.c:1075:17:    expected restricted __be32 [usertype] tmp_crc
   drivers/mtd/ubi/fastmap.c:1075:17:    got unsigned int
   drivers/mtd/ubi/fastmap.c:1077:13: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] crc @@    got  [usertype] crc @@
   drivers/mtd/ubi/fastmap.c:1077:13:    expected restricted __be32 [usertype] crc
   drivers/mtd/ubi/fastmap.c:1077:13:    got unsigned int
   drivers/mtd/ubi/fastmap.c:1086:22: sparse: incorrect type in assignment (different base types) @@    expected restricted __be64 [usertype] sqnum @@    got unsigned lonrestricted __be64 [usertype] sqnum @@
   drivers/mtd/ubi/fastmap.c:1086:22:    expected restricted __be64 [usertype] sqnum
   drivers/mtd/ubi/fastmap.c:1086:22:    got unsigned long long [unsigned] [assigned] sqnum

vim +110 drivers/mtd/ubi/fastmap.c

   103	
   104	static bool read_pnum(struct ubi_device *ubi, struct ubi_attach_info *ai,
   105			     __be32 pnum, int *out_pnum)
   106	{
   107		int ret = true;
   108		int max_pnum = ubi->peb_count;
   109	
 > 110		pnum = be32_to_cpu(pnum);
 > 111		if (pnum == UBI_UNKNOWN) {
 > 112			*out_pnum = pnum;
   113			goto out;
   114		}
   115	
   116		if (pnum < 0 || pnum >= max_pnum) {
   117			ubi_err(ubi, "fastmap references PEB out of range: %i", pnum);
   118			ret = false;
   119			goto out;
   120		} else {
   121			*out_pnum = pnum;
   122		}
   123	
   124	out:
   125		return ret;
   126	}
   127	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
