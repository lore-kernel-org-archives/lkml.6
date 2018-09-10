Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A612C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D1A20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="LIQKXLcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D1A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeIJW51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:57:27 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:44351 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbeIJW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536602474; x=1568138474;
  h=from:to:cc:subject:date:message-id;
  bh=z3TIGbAa2zYB36YOsBqfvxGSNJnCeTk8tXR6O9WdllY=;
  b=LIQKXLcOPc99xPIsEVoq9HG0ykQxkLVkPoiyVKudNrabrlSeJGApzkcZ
   ffdROP1NligFir5rDPJm8KZguYKw369zbEZOA4jO9d0EgihbSLp04l6mc
   7PYU4Sbtze/O3vcDuQYozrpTOpQaApfCtwDEsYiedPsHtczCQCNIh+sSe
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HfAQB/sJZbhyWd50NcHgEGDIUyKIx?=
 =?us-ascii?q?ki0CYQYF6C4Rsg30hNRcBAgEBAgEBAgEBAhABAQEKCwkIKS+CNSQBgmIWFVJ?=
 =?us-ascii?q?PbwESIoJ/ggKaWIlXAQEBgWgzigGGT4QWgVg/gRKNaAKONI1UBwKCBASNegI?=
 =?us-ascii?q?VjnCTZgIEAgQFAhSBQwGCDHCDPIIzjj5RjhYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HfAQB/sJZbhyWd50NcHgEGDIUyKIxki0CYQYF6C4Rsg?=
 =?us-ascii?q?30hNRcBAgEBAgEBAgEBAhABAQEKCwkIKS+CNSQBgmIWFVJPbwESIoJ/ggKaW?=
 =?us-ascii?q?IlXAQEBgWgzigGGT4QWgVg/gRKNaAKONI1UBwKCBASNegIVjnCTZgIEAgQFA?=
 =?us-ascii?q?hSBQwGCDHCDPIIzjj5RjhYBAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2018 13:01:13 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8AHwmEh107550;
        Mon, 10 Sep 2018 14:02:09 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2mdsbj1pky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 14:02:08 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Sep 2018 00:02:06 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.53,356,1531803600"; 
   d="scan'208";a="1298566026"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: dell-smbios-wmi: Correct a memory leak
Date:   Mon, 10 Sep 2018 13:01:52 -0500
Message-Id: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI buffers were being allocated but never freed.

Reported-by: Pinzhen Xu <pinzhen.xu@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/dell-smbios-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index 88afe56..cf2229e 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -78,6 +78,7 @@ static int run_smbios_call(struct wmi_device *wdev)
 	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
 		priv->buf->std.output[0], priv->buf->std.output[1],
 		priv->buf->std.output[2], priv->buf->std.output[3]);
+	kfree(output.pointer);
 
 	return 0;
 }
-- 
2.7.4

