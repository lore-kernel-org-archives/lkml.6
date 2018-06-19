Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0F2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755638AbeFSFEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:04:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755575AbeFSFEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:04:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J5420x106150
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:04:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpre7dsaj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:04:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 06:04:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 06:04:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5J54ipF34734116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 05:04:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 668384C04E;
        Tue, 19 Jun 2018 05:55:45 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4282C4C044;
        Tue, 19 Jun 2018 05:55:42 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.195.32.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 05:55:42 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powernv/cpuidle Device-tree parsing cleanup 
Date:   Tue, 19 Jun 2018 10:34:25 +0530
X-Mailer: git-send-email 2.5.5
X-TM-AS-GCONF: 00
x-cbid: 18061905-0016-0000-0000-000001DD82B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061905-0017-0000-0000-000032318B3D
Message-Id: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=701 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code. 

First to identify supported flags, secondly, to identify deepest_state
and first deep state, Thirdly , during cpudidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places.

This series adds code to parse device tree once and save in global structure.

Akshay Adiga (3):
  powernv/cpuidle: Parse dt idle properties into global structure
  cpuidle/powernv: Change platform init to avoid reparsing dt
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  16 +++
 arch/powerpc/platforms/powernv/idle.c | 214 +++++++++++++++++++++-------------
 drivers/cpuidle/cpuidle-powernv.c     |  49 +++++---
 3 files changed, 182 insertions(+), 97 deletions(-)

-- 
2.5.5

