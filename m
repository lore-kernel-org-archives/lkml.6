Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F40213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wc+qlYMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F40213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:50:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33082 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:50:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009143256euoutp0187595283a2681b67873e9175dc61fcbd~b90XTT0K_2733727337euoutp01P
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:32:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009143256euoutp0187595283a2681b67873e9175dc61fcbd~b90XTT0K_2733727337euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539095576;
        bh=ZWR5LLPRWzhQkmhySZniWiRy7mL4Rr9/X3/4fCuAa6Y=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Wc+qlYMYUMsYeZYxPvLydndAzJJC0wWtq7+ZYtbJCuxztMngIfJtIoZFVijhYeYJv
         sPqS5H0fhyVE7tcyHZNu5obCH5DzLn5FQMWx/L6RzgUd3Txx9i35Ae6/9O8Kb6ork4
         AaJQQscid0b7alycDPXlZmab9nPI+l9Vs9sAcQBg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009143256eucas1p1779af1c538670d935fbb17cd3ea0bf72~b90WxRRx90983409834eucas1p1v;
        Tue,  9 Oct 2018 14:32:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.99.04806.71CBCBB5; Tue,  9
        Oct 2018 15:32:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h;
        Tue,  9 Oct 2018 14:32:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009143255eusmtrp28ea3963817a2fbeef155e26adca94384~b90V0nP-61753817538eusmtrp23;
        Tue,  9 Oct 2018 14:32:55 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-72-5bbcbc172177
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.2D.04284.71CBCBB5; Tue,  9
        Oct 2018 15:32:55 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009143255eusmtip23d5ce3c3d2cbdaeb98adfe9efe563d23~b90VistcM2817828178eusmtip2T;
        Tue,  9 Oct 2018 14:32:55 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] block: remove redundant 'default n' from Kconfig-s
Date:   Tue, 9 Oct 2018 16:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7rie/ZEG+x4a2Ox+m4/m8XeW9oW
        l3fNYXNg9rh8ttTj8ya5AKYoLpuU1JzMstQifbsErozJCzQKripUXNh6ir2Bca9kFyMnh4SA
        icSd95PYuhi5OIQEVjBKPJq0iRHC+cIo0XbnKxOE85lR4vWFGYwwLc9/9kJVLWeU2HvwLDOE
        855R4nTHDRaQKhEBBYme3yvZQGxmAVuJ9pvP2EFsNgEriYntq8AmCQs4S+y40wkWZxFQkXg5
        YQJQnINDVCBCov+MOkiYV0BQ4uTMJywQY+Qltr+dA7ZLQuAym8S5972sEEVlEpPXv2WDuM5F
        YvOieewQtrDEq+NboGwZif875zNBNE9nlHjzaykLhLOeUWLNmWNMEFXWEoePX2QFuYJZQFNi
        /S59iLCjxMnfh9lBwhICfBI33gpCHMQnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMkMYXtI
        LOzoYgIpFxKIlbj+gW0Co8IsJF/OQvLlLIQTFjAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dL
        zs/dxAhMD6f/Hf+6g3Hfn6RDjAIcjEo8vDPydkcLsSaWFVfmHmKU4GBWEuEV3b4rWog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvsnkbo4UE0hNLUrNTUwtSi2CyTBycUg2MVQsYWpbLzNm5I0Gx
        0ueQ/Pu8tOXFqbOnFX83b1T2Xyq2XEBFzqk3cnFT/SXe7Zu8X91fKWR26Of6nz5Ts3zuLTSa
        rrVznyXfpBNbnM6YnLoV4+W8VO7QKtbFnKwNoQVyZ43ElXOd4yZM/fgtfr1Tu4r5gmkrzEs+
        PWiee97D4KnYizBNBZYUJZbijERDLeai4kQAFE8Y4QsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xe7rie/ZEGyy9IWCx+m4/m8XeW9oW
        l3fNYXNg9rh8ttTj8ya5AKYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzJCzQKripUXNh6ir2Bca9kFyMnh4SAicTzn72MXYxcHEICSxkldqy8
        xtrFyAGUkJE4vr4MokZY4s+1LjaImreMEss+TmIFSYgIKEj0/F7JBmIzC9hKtN98xg5iswlY
        SUxsX8UIYgsLOEvsuNMJFucVsJN4vquZGcRmEVCReDlhAliNqECExK2HHSwQNYISJ2c+YYGY
        qS7xZ94lZghbXmL72znMExj5ZyEpm4WkbBaSsgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
        NzECw3jbsZ+bdzBe2hh8iFGAg1GJh3dG3u5oIdbEsuLK3EOMEhzMSiK8ott3RQvxpiRWVqUW
        5ccXleakFh9iNAU6fCKzlGhyPjDG8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YW
        pBbB9DFxcEo1MCqLBH59FLrNZcMpD6ko1s8fYg8eimre7P1n5mU31ezaKCP96NymhyW+7Bcv
        LPwYp9Cco3pqd2HT7ub1n0pinj6PZ3vx9mF1urHVF7lkpyCjiLk3K1TnnG0uPPu73XmRdVp3
        JVdCpVSm+3bjNPZbG7fN8/QrnCH0eSLbQaVHaU56yVzX/1Z9VGIpzkg01GIuKk4EAFm5Wu15
        AgAA
Message-Id: <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
X-CMS-MailID: 20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb
References: <CGME20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb@eucas1p2.samsung.com>
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
 block/Kconfig         |    7 -------
 block/Kconfig.iosched |    3 ---
 2 files changed, 10 deletions(-)

Index: b/block/Kconfig
===================================================================
--- a/block/Kconfig	2018-10-09 15:58:37.031122890 +0200
+++ b/block/Kconfig	2018-10-09 16:30:22.959170887 +0200
@@ -74,7 +74,6 @@ config BLK_DEV_BSG
 
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
-	default n
 	select BLK_DEV_BSG
 	select BLK_SCSI_REQUEST
 	help
@@ -107,7 +106,6 @@ config BLK_DEV_ZONED
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
-	default n
 	---help---
 	Block layer bio throttling support. It can be used to limit
 	the IO rate to a device. IO rate policies are per cgroup and
@@ -119,7 +117,6 @@ config BLK_DEV_THROTTLING
 config BLK_DEV_THROTTLING_LOW
 	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
 	depends on BLK_DEV_THROTTLING
-	default n
 	---help---
 	Add .low limit interface for block throttling. The low limit is a best
 	effort limit to prioritize cgroups. Depending on the setting, the limit
@@ -130,7 +127,6 @@ config BLK_DEV_THROTTLING_LOW
 
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
-	default n
 	---help---
 	Enabling this option allows you to specify the partition layout from
 	the kernel boot args.  This is typically of use for embedded devices
@@ -141,7 +137,6 @@ config BLK_CMDLINE_PARSER
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
-	default n
 	---help---
 	Enabling this option enables the block layer to throttle buffered
 	background writeback from the VM, making it more smooth and having
@@ -152,7 +147,6 @@ config BLK_WBT
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP=y
-	default n
 	---help---
 	Enabling this option enables the .latency interface for IO throttling.
 	The IO controller will attempt to maintain average IO latencies below
@@ -163,7 +157,6 @@ config BLK_CGROUP_IOLATENCY
 
 config BLK_WBT_SQ
 	bool "Single queue writeback throttling"
-	default n
 	depends on BLK_WBT
 	---help---
 	Enable writeback throttling by default on legacy single queue devices
Index: b/block/Kconfig.iosched
===================================================================
--- a/block/Kconfig.iosched	2018-09-03 18:11:21.201792278 +0200
+++ b/block/Kconfig.iosched	2018-10-09 16:30:54.207171674 +0200
@@ -36,7 +36,6 @@ config IOSCHED_CFQ
 config CFQ_GROUP_IOSCHED
 	bool "CFQ Group Scheduling support"
 	depends on IOSCHED_CFQ && BLK_CGROUP
-	default n
 	---help---
 	  Enable group IO scheduling in CFQ.
 
@@ -82,7 +81,6 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
-	default n
 	---help---
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
 	of the device among all processes according to their weights,
@@ -94,7 +92,6 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
-       default n
        ---help---
 
        Enable hierarchical scheduling in BFQ, using the blkio
