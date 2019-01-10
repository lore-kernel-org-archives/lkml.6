Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5278C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40F420879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfAJNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45143 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728759AbfAJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADf27B008190;
        Thu, 10 Jan 2019 14:49:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptvjg2ptg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF2B231;
        Thu, 10 Jan 2019 13:49:18 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C83E504C;
        Thu, 10 Jan 2019 13:49:18 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:18 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:16
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 0/7] remoteproc: Fixes for memoy carveout management
Date:   Thu, 10 Jan 2019 14:49:04 +0100
Message-ID: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix the comments sent on remoteproc mailing
list after acceptation of memory carveout patch series [1].

In few words, series corrects:
- memory carveout allocation for rproc without iommu
- rproc_da_to_va and trace buffer access to take into account
  late carveout allocation
- resource table cast by adding warning messages

Regards,
Loic

[1] https://lkml.org/lkml/2018/7/27/612

---
Changes from v1:
- Modify way to notify resource table cast issue
- Complete trace buffer patch


Loic Pallardy (7):
  remoteproc: correct rproc_mem_entry_init() comments
  remoteproc: fix rproc_da_to_va in case of unallocated carveout
  remoteproc: fix rproc_alloc_carveout() bad variable cast
  remoteproc: add warning on resource table cast
  remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
  remoteproc: fix trace buffer va initialization
  remoteproc: fix rproc_check_carveout_da() returned error and comments

 drivers/remoteproc/remoteproc_core.c     | 108 ++++++++++++++++++-------------
 drivers/remoteproc/remoteproc_debugfs.c  |  21 ++++--
 drivers/remoteproc/remoteproc_internal.h |   9 ++-
 3 files changed, 89 insertions(+), 49 deletions(-)

-- 
2.7.4

