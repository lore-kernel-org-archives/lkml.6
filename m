Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85358214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lsScUGKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85358214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJJWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:04:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33610 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJJWED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:04:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181010144133euoutp02465a19e6ddc17e55a2cd1d6d6f3a4c49~cRlKdrNsZ1970619706euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:41:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181010144133euoutp02465a19e6ddc17e55a2cd1d6d6f3a4c49~cRlKdrNsZ1970619706euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539182493;
        bh=MiPCfUa1HrmoxemD1A9JuzW3ZiWLvzynHiEV+uBE+4U=;
        h=To:Cc:From:Subject:Date:References:From;
        b=lsScUGKWkLPq86EgO6tepMes8238Wxt1RzaVhYrzwrUFItyJ2Bp32H5oKkjVxofEM
         Sg8RigvYeSHclAGjxg2kCqUYchuJWZfQqkRLN2TkrgscG0P0GifSkSGBZQSS5mT4L6
         CxBin1cR3lZ0sTBaT9O4to02VnVgT/iuqiW0wZqw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010144132eucas1p2c904cb0b5b94d37117895eb6dbaa4963~cRlKA9ZTz3027230272eucas1p2x;
        Wed, 10 Oct 2018 14:41:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E1.21.04806.C9F0EBB5; Wed, 10
        Oct 2018 15:41:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da~cRlJN49vs2486624866eucas1p1i;
        Wed, 10 Oct 2018 14:41:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181010144131eusmtrp25d7f4fdb627e3a55e56262de874a7037~cRlI9UOm02620426204eusmtrp2l;
        Wed, 10 Oct 2018 14:41:31 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-03-5bbe0f9c71e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.61.04284.B9F0EBB5; Wed, 10
        Oct 2018 15:41:31 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181010144131eusmtip2caa1ce12b62b42c6386a1c8247fbee73~cRlIuO3xj0958209582eusmtip2W;
        Wed, 10 Oct 2018 14:41:31 +0000 (GMT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ACPI: remove redundant 'default n' from Kconfig
Date:   Wed, 10 Oct 2018 16:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned05/PuiDfqmKVjsfPiWzWL5vn5G
        i8u75rBZnDl9idWBxWPTqk42jy1X21k8Pm+SC2CO4rJJSc3JLEst0rdL4Mq4Mnkbe8FMsYo9
        Sz+xNTA2C3YxcnJICJhIPJrxkx3EFhJYwSgx6YBrFyMXkP2FUeLR8fssEM5nRon9k7czw3Rc
        nrqfFSKxnFHi282dzBDOe6Cq5umsIFUiAh4Sj77fBpvLLGAj0TDnEZjNJmAlMbF9FSOILSzg
        IDH39HywqSwCqhIXJnQA1XBwiApESPSfUQcJ8woISpyc+YQFYoy8xPa3c6COeM0m8emUK0RN
        mUTjy0uMIK0SAi4Si6a7Q5QIS7w6voUdwpaR+L9zPhPImRIC0xkl3vxaygLhrGeUWHPmGBNE
        lbXE4eMXWUEGMQtoSqzfpQ8RdpTYf2Q9C8R8PokbbwUhzuGTmLRtOjNEmFeio00IolpNYsOy
        DWwwa7t2roS62ENiZkMXIySgYyUmfr7OPIFRYRaSJ2cheXIWwg0LGJlXMYqnlhbnpqcWG+el
        lusVJ+YWl+al6yXn525iBCaN0/+Of93BuO9P0iFGAQ5GJR7ehgt7ooVYE8uKK3MPMUpwMCuJ
        8N46vDdaiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+yeRujhQTSE0tSs1NTC1KLYLJMHJxSDYyi
        vOvvbGKyuiKQ2Hp76/yWyW+2XEk7HSZaMOX+Hd2zlx5IK/Mfec3poWVUseKe+UnDwLyZ+yaf
        i0iYHWqzIKpMgtcw9Vlfss6E/hZvtvk5OmkrXD6VCvuu1S2eaFFax7qQ52r49Z/b45XlqvXM
        n/follr97josbXXmTHquk9kR3reXF7yp8VBiKc5INNRiLipOBADTulU6FgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xe7qz+fdFG5zfqG6x8+FbNovl+/oZ
        LS7vmsNmceb0JVYHFo9NqzrZPLZcbWfx+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jyuRt7AUzxSr2LP3E1sDYLNjFyMkhIWAicXnq
        ftYuRi4OIYGljBI35pxi72LkAErISBxfXwZRIyzx51oXG0TNW0aJs3desIAkRAQ8JB59v80O
        YjML2Eg0zHkEZrMJWElMbF/FCGILCzhIzD09nxlkJq+AncS2GVwgYRYBVYkLEzrAykUFIiRu
        PewAG8krIChxcuYTFoiR6hJ/5l1ihrDlJba/ncM8gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9
        t9hQrzgxt7g0L10vOT93EyMwvLcd+7l5B+OljcGHGAU4GJV4eBsu7IkWYk0sK67MPcQowcGs
        JMJ76/DeaCHelMTKqtSi/Pii0pzU4kOMpkCHT2SWEk3OB8ZeXkm8oamhuYWlobmxubGZhZI4
        73mDyighgfTEktTs1NSC1CKYPiYOTqkGxurMfSY/VHrfHyswt2Tv8X5W5bqMy/D20YVHpTo5
        FBYW1cx9382uJbh67cllzge6jp1M7jlTp+y79Rd/ckKUAOe+exKuXNcu2IULPFrw7xpzrt2P
        LOPwf/MMDQ7NnxA87Ro/c97BgOkxf78/+v6jZ0ILw++nh7zZnm/+EzfzavJSJqE8kSNvziqx
        FGckGmoxFxUnAgAwScNlhQIAAA==
Message-Id: <20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da~cRlJN49vs2486624866eucas1p1i@eucas1p1.samsung.com>
X-CMS-MailID: 20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da
References: <CGME20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da@eucas1p1.samsung.com>
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
 drivers/acpi/Kconfig |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/acpi/Kconfig
===================================================================
--- a/drivers/acpi/Kconfig	2018-09-26 15:54:31.942819766 +0200
+++ b/drivers/acpi/Kconfig	2018-10-10 16:38:09.691897907 +0200
@@ -138,7 +138,6 @@ config ACPI_REV_OVERRIDE_POSSIBLE
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
-	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
 
@@ -283,7 +282,6 @@ config ACPI_PROCESSOR
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on IPMI_HANDLER
-	default n
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
@@ -361,7 +359,6 @@ config ACPI_TABLE_UPGRADE
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	default n
 	help
 	  The ACPI subsystem can produce debug output.  Saying Y enables this
 	  output and increases the kernel size by around 50K.
@@ -374,7 +371,6 @@ config ACPI_DEBUG
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
 	depends on SYSFS
-	default n
 	help
 	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
 	  slots in the system.  This can help correlate PCI bus addresses,
@@ -436,7 +432,6 @@ config ACPI_HED
 config ACPI_CUSTOM_METHOD
 	tristate "Allow ACPI methods to be inserted/replaced at run time"
 	depends on DEBUG_FS
-	default n
 	help
 	  This debug facility allows ACPI AML methods to be inserted and/or
 	  replaced without rebooting the system. For details refer to:
@@ -481,7 +476,6 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
-	default n
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
 	  more information about the error than what can be described in
