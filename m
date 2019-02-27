Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8462620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfB0Dad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:30:33 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:54312 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0Dac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:30:32 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R3LG3M004595;
        Wed, 27 Feb 2019 03:30:29 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qwc292njw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 03:30:29 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 7321081;
        Wed, 27 Feb 2019 03:30:28 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1D5A536;
        Wed, 27 Feb 2019 03:30:25 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2 0/2] misc: hpilo: Do not claim on unsupported hardware
Date:   Wed, 27 Feb 2019 11:25:28 +0800
Message-Id: <1551237930-28823-1-git-send-email-matt.hsiao@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=498 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series prevent unsupported hardwares from using the hpilo module:
1) Instead of having explicit if statement to check SSID 0x1979,
   provide a pci_device_id table of devices to blacklist.
2) Add unsupported hardware with SSID 0x0289 to the blacklist table.

Changes since v1:
- Merge v1 patches 1 and 2 as v2 patch 1.
- Drop v1 patch 4 that bumps up version.
- Improve documentation of each patch.

Matt Hsiao (2):
  misc: hpilo: Exclude unsupported device via blacklist
  misc: hpilo: Do not claim unsupported hardware

 drivers/misc/hpilo.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
1.8.3.1

