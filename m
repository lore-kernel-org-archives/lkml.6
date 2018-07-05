Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56706C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC10240BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC10240BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeGELkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:40:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753921AbeGELkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:40:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65Bd2FS012909
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 07:40:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1gw64b3q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:40:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65BehJ938928602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2204C04A;
        Thu,  5 Jul 2018 14:41:08 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A888D4C046;
        Thu,  5 Jul 2018 14:41:05 +0100 (BST)
Received: from aksadiga.ibm (unknown [9.195.33.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 14:41:05 +0100 (BST)
From:   Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, stewart@linux.vnet.ibm.com,
        benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v4 0/2] powernv/cpuidle Device-tree parsing cleanup
Date:   Thu,  5 Jul 2018 17:10:20 +0530
X-Mailer: git-send-email 2.18.0.rc2.85.g1fb9df7
X-TM-AS-GCONF: 00
x-cbid: 18070511-0008-0000-0000-0000024FF133
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070511-0009-0000-0000-000021B60AD0
Message-Id: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=821 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code.

First to identify supported flags. Second time, to identify deepest_state
and first deep state. Third time, during cpuidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places. Errors in device-tree can be handled in a better manner.

This series adds code to parse device tree once and save in global structure.

Changes from v3 :
 - Removed a stale comment
Changes from v2 :
 - Fix build error (moved a hunk from patch 1 to patch 2)
Changes from v1 :
 - fold first 2 patches into 1
 - rename pm_ctrl_reg_* as psscr_*
 - added comment stating removal of pmicr parsing code
 - removed parsing code for pmicr
 - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
are valid combination,
 - Change function description of pnv_parse_cpuidle_dt
 - Added error handling code.


Akshay Adiga (2):
  powernv/cpuidle: Parse dt idle properties into global structure
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  13 ++
 arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
 drivers/cpuidle/cpuidle-powernv.c     | 158 ++++---------------
 3 files changed, 177 insertions(+), 210 deletions(-)

-- 
2.18.0.rc2.85.g1fb9df7

