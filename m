Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7042C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F01B240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F01B240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGENwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:52:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753606AbeGENvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:51:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65DnmHJ143427
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 09:51:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1mdp8fch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:51:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 14:51:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 14:51:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65DpckA41877592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 13:51:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2675205A;
        Thu,  5 Jul 2018 16:52:02 +0100 (BST)
Received: from oc4502181600.ibm.com (unknown [9.79.199.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B653B5204E;
        Thu,  5 Jul 2018 16:52:00 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     linux@roeck-us.net, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] hwmon: Add attributes to enable/disable sensors
Date:   Thu,  5 Jul 2018 19:21:26 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18070513-0016-0000-0000-000001E3AF75
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070513-0017-0000-0000-000032381C38
Message-Id: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=306 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new attribute to enable or disable a sensor in
runtime.

v2 : https://lkml.org/lkml/2018/7/4/263
v1 : https://lkml.org/lkml/2018/3/22/214

Shilpasri G Bhat (3):
  powernv:opal-sensor-groups: Add support to enable sensor groups
  hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
  hwmon: Document the sensor enable attribute and update ibmpowernv

 Documentation/hwmon/ibmpowernv                     |  35 +++-
 Documentation/hwmon/sysfs-interface                |  82 +++++++++
 arch/powerpc/include/asm/opal-api.h                |   1 +
 arch/powerpc/include/asm/opal.h                    |   2 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c |  28 ++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 drivers/hwmon/ibmpowernv.c                         | 184 +++++++++++++++++----
 7 files changed, 302 insertions(+), 31 deletions(-)

-- 
1.8.3.1

