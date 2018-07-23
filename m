Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B64ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054D320881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054D320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeGWMyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387847AbeGWMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBo2TS042158
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdd3vkdgb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:17 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrGNr34996424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F6D4C044;
        Mon, 23 Jul 2018 14:53:32 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 138ED4C040;
        Mon, 23 Jul 2018 14:53:32 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:32 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net/smc: patches 2018-07-23
Date:   Mon, 23 Jul 2018 13:53:07 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18072311-0008-0000-0000-000002567813
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0009-0000-0000-000021BCE5B4
Message-Id: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=633 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

here are some small patches for SMC: Just the first patch contains a
functional change. It allows to differ between the modes SMCR and SMCD
on s390 when monitoring SMC sockets. The remaining patches are cleanups
without functional changes.

Thanks, Ursula

Karsten Graul (1):
  net/smc: provide smc mode in smc_diag.c

Stefan Raspl (2):
  net/smc: eliminate cursor read and write calls
  net/smc: add function to get link group from link

Ursula Braun (2):
  net/smc: use DECLARE_BITMAP for rtokens_used_mask
  net/smc: remove local variable page in smc_rx_splice()

 include/uapi/linux/smc_diag.h |  9 ++++++++-
 net/smc/af_smc.c              |  8 ++------
 net/smc/smc_cdc.c             | 35 ++++++++++++--------------------
 net/smc/smc_cdc.h             | 43 ++++++++++++++--------------------------
 net/smc/smc_core.h            |  8 ++++++--
 net/smc/smc_diag.c            |  7 ++++++-
 net/smc/smc_ib.c              |  3 +--
 net/smc/smc_llc.c             | 30 ++++++++--------------------
 net/smc/smc_rx.c              | 19 +++++-------------
 net/smc/smc_tx.c              | 46 ++++++++++++-------------------------------
 net/smc/smc_tx.h              |  4 ++--
 net/smc/smc_wr.c              | 27 +++++--------------------
 12 files changed, 84 insertions(+), 155 deletions(-)

-- 
2.16.4

