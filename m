Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7139C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9246B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mwjBlgyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9246B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJIV6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:58:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39223 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJIV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:58:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009144105euoutp027c5b0c10ab0a93261dd2c86dfc02f2d6~b97eP3v_X0871308713euoutp02V
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009144105euoutp027c5b0c10ab0a93261dd2c86dfc02f2d6~b97eP3v_X0871308713euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539096065;
        bh=a7Tk2crN95FHQGbnNEhIgyhBB6XD7HziqDIRR9FcpFw=;
        h=To:Cc:From:Subject:Date:References:From;
        b=mwjBlgyHSlVxzHbQLBwsKG9aDL/Wi45r1ciKMt+MuwX6269UN+MmARvNAqM61VtUz
         nwMFlknmxaOh44wDVwuYfz2rA/nPJzdt3CnHv6+7uJBZ1JF39HSGBEAyBpxZ9BbgVK
         Iq/zUo8SyXVGdUu/GIn2nbzTs9CEyZhaVdl1WtRU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009144104eucas1p10ce609146a01f9af086c3218fff0cc16~b97dkzeSE0885608856eucas1p1k;
        Tue,  9 Oct 2018 14:41:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.0C.04441.00EBCBB5; Tue,  9
        Oct 2018 15:41:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n;
        Tue,  9 Oct 2018 14:41:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009144103eusmtrp1460d142ec2219867942df89ff138d8b3~b97cSde5m2096520965eusmtrp10;
        Tue,  9 Oct 2018 14:41:03 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-ee-5bbcbe001e62
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.4E.04284.FFDBCBB5; Tue,  9
        Oct 2018 15:41:03 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009144102eusmtip179221369939272d1154a032daf6f5177~b97b4hyXM3256132561eusmtip1M;
        Tue,  9 Oct 2018 14:41:02 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] drivers/block: remove redundant 'default n' from Kconfig-s
Date:   Tue, 9 Oct 2018 16:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7oM+/ZEG6zsl7RYfbefzeLh1RUs
        FvO737NY7L2lbXF51xw2i2Vf37NbbGiZxW7xcuZjJotHEyYxOXB67Jx1l93j8tlSj02rOtk8
        nl45wuTR8qCNzWPnp82sHp83yQWwR3HZpKTmZJalFunbJXBlTP3/lq1gslhF38XMBsb5gl2M
        nBwSAiYSL370MYHYQgIrGCU6Zmh2MXIB2V8YJc4ve8ICkfjMKHHttT5Mw5lpZ1ggipYzSvQ1
        X2CGcN4zSnzd+IQNpEpEQEGi5/dKNpAEs8BWJomW1ptgo9gErCQmtq9iBLGFBbwldm95C2Rz
        cLAIqEjM21QOYooKREj0n1EHqeAVEJQ4ORPiCGYBeYntb+eA7ZIQWMUu8frHPzaIojKJq5/W
        MUJc5yKx5c4BdghbWOLV8S1QtozE6ck9LBDN0xkl3vxaCuWsZ5RYc+YYE0SVtcTh4xdZQa5g
        FtCUWL9LH8SUEHCU+LZRBMLkk7jxVhDiHj6JSdumM0OEeSU62oQgZqhJbFi2gQ1ma9fOlcwQ
        tofE3c/L2SDhGSuxa+cP1gmMCrOQfDkLyZezEE5YwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQv
        XS85P3cTIzARnf53/NMOxq+Xkg4xCnAwKvHwzsjbHS3EmlhWXJl7iFGCg1lJhFd0+65oId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgtgskycXBKNTCmc269+/jzqQ2P
        TJVnHGDZ/Jn/Sx1XxjO2fKezr1x3e1id/uj6hWm2e02jcTT3ZO7IyoBDlpdETb7/vsg61eWk
        wK4Vyx/oeFsnV26Pb/kzf2MRg+WK9zr68mvXdSR8yf0Vu3rSiwVOQeXHAlXjN6769Mvl+eWE
        5X/Y/+7PTDi3cdbz+6XeK6NalViKMxINtZiLihMB1eh4SkADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7r/9+6JNlj8S8Bi9d1+NouHV1ew
        WMzvfs9isfeWtsXlXXPYLJZ9fc9usaFlFrvFy5mPmSweTZjE5MDpsXPWXXaPy2dLPTat6mTz
        eHrlCJNHy4M2No+dnzazenzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5r
        ZWSqpG9nk5Kak1mWWqRvl6CXMfX/W7aCyWIVfRczGxjnC3YxcnJICJhInJl2hgXEFhJYyihx
        cLdkFyMHUFxG4vj6MogSYYk/17rYuhi5gEreMkrsan4BVi8ioCDR83slWIJZYCuTxJbbq5hB
        EmwCVhIT21cxgtjCAt4Su7e8ZQQZyitgJzH7ehKIySKgIjFvUzlIhahAhMSthx1gI3kFBCVO
        znwCZjMLqEv8mXeJGcKWl9j+dg7zBEb+WUjKZiEpm4WkbAEj8ypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzAiNl27OfmHYyXNgYfYhTgYFTi4Z2RtztaiDWxrLgy9xCjBAezkgiv6PZd0UK8
        KYmVValF+fFFpTmpxYcYTYHunsgsJZqcD4zmvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJ
        JanZqakFqUUwfUwcnFINjFl7Zghv27e041Uwt92czXw+ZV8XLnL5tPebxQKn2r+LHhlkB9XI
        bOvKqTTZ48gkrHn2yHWzl8wC7ko3CwovH1m8Uer/ArXjZybMWlugeq1zc6/e3ph1oldzDY4t
        aoztKGFO4guXuxAc+M1DeKLO9md9nbesXFc4znxy6ZcK94mV5gwL7M/nL1RiKc5INNRiLipO
        BABjSs9yrgIAAA==
Message-Id: <20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
X-CMS-MailID: 20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1
References: <CGME20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/block/Kconfig      |    1 -
 drivers/block/drbd/Kconfig |    1 -
 drivers/block/zram/Kconfig |    2 --
 3 files changed, 4 deletions(-)

Index: b/drivers/block/Kconfig
===================================================================
--- a/drivers/block/Kconfig	2018-09-26 15:54:31.958819766 +0200
+++ b/drivers/block/Kconfig	2018-10-09 16:35:01.327177898 +0200
@@ -461,7 +461,6 @@ config BLK_DEV_RBD
 	select LIBCRC32C
 	select CRYPTO_AES
 	select CRYPTO
-	default n
 	help
 	  Say Y here if you want include the Rados block device, which stripes
 	  a block device over objects stored in the Ceph distributed object
Index: b/drivers/block/drbd/Kconfig
===================================================================
--- a/drivers/block/drbd/Kconfig	2018-09-03 18:11:21.973792264 +0200
+++ b/drivers/block/drbd/Kconfig	2018-10-09 16:35:10.251178122 +0200
@@ -11,7 +11,6 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select LIBCRC32C
-	default n
 	help
 
 	  NOTE: In order to authenticate connections you have to select
Index: b/drivers/block/zram/Kconfig
===================================================================
--- a/drivers/block/zram/Kconfig	2018-09-03 18:11:22.185792260 +0200
+++ b/drivers/block/zram/Kconfig	2018-10-09 16:35:21.667178410 +0200
@@ -3,7 +3,6 @@ config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
 	select CRYPTO_LZO
-	default n
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
@@ -18,7 +17,6 @@ config ZRAM
 config ZRAM_WRITEBACK
        bool "Write back incompressible page to backing device"
        depends on ZRAM
-       default n
        help
 	 With incompressible page, there is no memory saving to keep it
 	 in memory. Instead, write it out to backing device.
