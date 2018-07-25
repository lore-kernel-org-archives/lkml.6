Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3614FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD54B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD54B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeGYPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:47:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728490AbeGYPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:47:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEXxfo127591
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kest6mg2e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 25 Jul 2018 15:35:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:35:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEZcig9896050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:35:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 883A811C058;
        Wed, 25 Jul 2018 17:35:52 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377CF11C054;
        Wed, 25 Jul 2018 17:35:52 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:35:52 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net/smc: patches 2018-07-25
Date:   Wed, 25 Jul 2018 16:35:29 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18072514-0016-0000-0000-000001EB4D2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-0017-0000-0000-000032403156
Message-Id: <20180725143533.7082-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

here are 4 more patches for SMC: The first one is just a small
code cleanup in preparation for patch 2. Patch 2 switches to the
use of the vlan-gid for VLAN traffic. Patch 3 improves diagnosis
when creating SMC connections. Patch 4 improves synchronization
between local and remote link groups.

Thanks, Ursula

Karsten Graul (2):
  net/smc: provide fallback reason code
  net/smc: improve delete link processing

Ursula Braun (2):
  net/smc: fewer parameters for smc_llc_send_confirm_link()
  net/smc: use correct vlan gid of RoCE device

 include/uapi/linux/smc_diag.h |  6 +++
 net/smc/af_smc.c              | 86 ++++++++++++++++++++++---------------------
 net/smc/smc.h                 |  2 +
 net/smc/smc_clc.c             | 16 ++++----
 net/smc/smc_clc.h             | 20 ++++++----
 net/smc/smc_core.c            | 84 +++++++++++++++++++++++-------------------
 net/smc/smc_core.h            |  9 +++--
 net/smc/smc_diag.c            |  8 +++-
 net/smc/smc_ib.c              | 41 ++++++++++++++++++---
 net/smc/smc_ib.h              |  3 +-
 net/smc/smc_llc.c             | 50 +++++++++++++------------
 net/smc/smc_llc.h             |  7 ++--
 net/smc/smc_pnet.c            | 30 ++++++++++-----
 net/smc/smc_pnet.h            |  3 +-
 net/smc/smc_wr.c              |  7 +---
 15 files changed, 228 insertions(+), 144 deletions(-)

-- 
2.16.4

