Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C185AC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A821473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858A821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeK3Ig2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:36:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17381 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbeK3Ig2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:36:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wATLTaCh001701;
        Thu, 29 Nov 2018 22:29:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nxvnb6geu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:29:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CAED468;
        Thu, 29 Nov 2018 22:29:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3FA65981;
        Thu, 29 Nov 2018 21:29:34 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov
 2018 22:29:34 +0100
Received: from localhost (10.129.6.191) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov 2018 22:29:34
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 0/7] remoteproc: Fixes for memoy carveout management
Date:   Thu, 29 Nov 2018 22:29:21 +0100
Message-ID: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_13:,,
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

Loic Pallardy (7):
  remoteproc: correct rproc_mem_entry_init() comments
  remoteproc: fix rproc_da_to_va in case of unallocated carveout
  remoteproc: fix rproc_alloc_carveout() bad variable cast
  remoteproc: add warning on resource table cast
  remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
  remoteproc: fix trace buffer va initialization
  remoteproc: fix rproc_check_carveout_da() returned error and comments

 drivers/remoteproc/remoteproc_core.c     | 91 +++++++++++++++++++-------------
 drivers/remoteproc/remoteproc_debugfs.c  | 21 ++++++--
 drivers/remoteproc/remoteproc_internal.h |  9 +++-
 3 files changed, 78 insertions(+), 43 deletions(-)

-- 
2.7.4

