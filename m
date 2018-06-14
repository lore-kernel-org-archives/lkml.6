Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38169C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCE9208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCE9208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeFNGXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:23:41 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46112 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeFNGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC7FB609B29C;
        Thu, 14 Jun 2018 08:23:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V1k59KVeyyTQ; Thu, 14 Jun 2018 08:23:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8B13F6098140;
        Thu, 14 Jun 2018 08:23:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YjVxjO7Gczmb; Thu, 14 Jun 2018 08:23:35 +0200 (CEST)
Received: from blindfold.localnet (089144203253.atnat0012.highway.a1.net [89.144.203.253])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 593066094C4A;
        Thu, 14 Jun 2018 08:23:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] ubi: fastmap: Read PEB numbers more carefully
Date:   Thu, 14 Jun 2018 08:23:27 +0200
Message-ID: <191143367.e1U5rnYpgk@blindfold>
In-Reply-To: <201806140802.6mK4vHdX%fengguang.wu@intel.com>
References: <20180613212344.11608-2-richard@nod.at> <201806140802.6mK4vHdX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Juni 2018, 03:04:40 CEST schrieb kbuild test robot:
> Hi Richard,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on mtd/master]
> [also build test WARNING on v4.17 next-20180613]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Richard-Weinberger/ubi-Fastmap-updates/20180614-052830
> base:   git://git.infradead.org/linux-mtd.git master
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/mtd/ubi/fastmap.c:110:14: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] pnum @@    got  [usertype] pnum @@
>    drivers/mtd/ubi/fastmap.c:110:14:    expected restricted __be32 [usertype] pnum
>    drivers/mtd/ubi/fastmap.c:110:14:    got unsigned int
> >> drivers/mtd/ubi/fastmap.c:111:13: sparse: restricted __be32 degrades to integer
> >> drivers/mtd/ubi/fastmap.c:112:27: sparse: incorrect type in assignment (different base types) @@    expected int [signed] <noident> @@    got restricted __be3int [signed] <noident> @@
>    drivers/mtd/ubi/fastmap.c:112:27:    expected int [signed] <noident>
>    drivers/mtd/ubi/fastmap.c:112:27:    got restricted __be32 [usertype] pnum
>    drivers/mtd/ubi/fastmap.c:116:13: sparse: restricted __be32 degrades to integer
>    drivers/mtd/ubi/fastmap.c:116:25: sparse: restricted __be32 degrades to integer
>    drivers/mtd/ubi/fastmap.c:121:27: sparse: incorrect type in assignment (different base types) @@    expected int [signed] <noident> @@    got restricted __be3int [signed] <noident> @@
>    drivers/mtd/ubi/fastmap.c:121:27:    expected int [signed] <noident>
>    drivers/mtd/ubi/fastmap.c:121:27:    got restricted __be32 [usertype] pnum
>    drivers/mtd/ubi/fastmap.c:604:23: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] max_sqnum @@    got nsigned long long [unsigned] max_sqnum @@
>    drivers/mtd/ubi/fastmap.c:604:23:    expected unsigned long long [unsigned] max_sqnum
>    drivers/mtd/ubi/fastmap.c:604:23:    got restricted __be64 [usertype] sqnum
>    drivers/mtd/ubi/fastmap.c:1075:17: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] tmp_crc @@    got  [usertype] tmp_crc @@
>    drivers/mtd/ubi/fastmap.c:1075:17:    expected restricted __be32 [usertype] tmp_crc
>    drivers/mtd/ubi/fastmap.c:1075:17:    got unsigned int
>    drivers/mtd/ubi/fastmap.c:1077:13: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] crc @@    got  [usertype] crc @@
>    drivers/mtd/ubi/fastmap.c:1077:13:    expected restricted __be32 [usertype] crc
>    drivers/mtd/ubi/fastmap.c:1077:13:    got unsigned int
>    drivers/mtd/ubi/fastmap.c:1086:22: sparse: incorrect type in assignment (different base types) @@    expected restricted __be64 [usertype] sqnum @@    got unsigned lonrestricted __be64 [usertype] sqnum @@
>    drivers/mtd/ubi/fastmap.c:1086:22:    expected restricted __be64 [usertype] sqnum
>    drivers/mtd/ubi/fastmap.c:1086:22:    got unsigned long long [unsigned] [assigned] sqnum
> 
> vim +110 drivers/mtd/ubi/fastmap.c
> 
>    103	
>    104	static bool read_pnum(struct ubi_device *ubi, struct ubi_attach_info *ai,
>    105			     __be32 pnum, int *out_pnum)
>    106	{
>    107		int ret = true;
>    108		int max_pnum = ubi->peb_count;
>    109	
>  > 110		pnum = be32_to_cpu(pnum);
>  > 111		if (pnum == UBI_UNKNOWN) {
>  > 112			*out_pnum = pnum;
>    113			goto out;
>    114		}

Okay, let's use a new variable of type int instead of reusing pnum.

Thanks,
//richard
