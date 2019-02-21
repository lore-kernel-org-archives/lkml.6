Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F512086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfBUIKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:10:17 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:40614 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfBUIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:10:16 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L86Rpg018643;
        Thu, 21 Feb 2019 08:10:12 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qsp38rvnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 08:10:12 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 191AE57;
        Thu, 21 Feb 2019 08:10:10 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 5024A4E;
        Thu, 21 Feb 2019 08:10:08 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH 0/4] misc: hpilo: Do not claim on unsupported hardware
Date:   Thu, 21 Feb 2019 16:04:38 +0800
Message-Id: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=720 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
1) Add additional subsystem_vendor check for SSID 0x1979.
2) Instead of having explicit if statement to check device IDs,
   provide a pci_device_id table of devices to blacklist.
3) Add new patch to add SSID 0x0289 to the blacklist table.
4) Bump version to reflect above minor changes.

Matt Hsiao (4):
  misc: hpilo: Be more specific when ignoring the aux iLO
  misc: hpilo: Exclude unsupported device via blacklist
  misc: hpilo: Do not claim unsupported hardware
  misc: hpilo: Update driver version

 drivers/misc/hpilo.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
1.8.3.1

