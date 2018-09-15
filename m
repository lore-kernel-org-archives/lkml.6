Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39036ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1CE2148E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kpYVXz1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CE2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeIOFyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:54:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37360 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeIOFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:54:18 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8F0bR6T071581;
        Fri, 14 Sep 2018 19:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536971847;
        bh=KtVtTFHcaHVtJCxf71DE/bjrheZLypwGVv0Ot5VUQTI=;
        h=From:To:CC:Subject:Date;
        b=kpYVXz1nTk47qUK20UOPTUp4JTKYrTxA51yvyH207E6UuvNylYAdhKoGDy80OWc5X
         UBLWHp7rE5nnMO1QjxvZCDaF+yVtEiRgGlCh12hqJC3dPPSIm6BVgY9yAiVsVftnge
         F0+vmemr9IScCTKxOuXHrX1qzCsUrbq04q9qI31I=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bRwL023585;
        Fri, 14 Sep 2018 19:37:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 19:37:27 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 19:37:27 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bRIi007366;
        Fri, 14 Sep 2018 19:37:27 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8F0bRx13335;
        Fri, 14 Sep 2018 19:37:27 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/5] remoteproc sysfs fixes/improvements
Date:   Fri, 14 Sep 2018 19:37:20 -0500
Message-ID: <20180915003725.17549-1-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

The following series includes couple of fixes and improvements
associated with the sysfs interfaces. Patches are based on top
of 4.19-rc1. The first 3 patches are independent of each other.

Following is the patch summary:
 - Patch 1 fixes an issue with unbalanced sysfs start/stop
   and module removal
 - Patch 2 adds a minor additional check on firmware name
   being echoed into the sysfs file
 - Patch 3 is a minor kerneldoc fix.
 - Patches 4 and 5 introduce a new request denial to sysfs
   interfaces to not allow userspace to meddle with a remoteproc
   client driven boot flow, and usage of it by Wkup M3 remoteproc
   driver

regards
Suman

Suman Anna (5):
  remoteproc: Fix unbalanced boot with sysfs for no auto-boot rprocs
  remoteproc: Check for NULL firmwares in sysfs interface
  remoteproc: Add missing kernel-doc comment for auto-boot
  remoteproc: Introduce deny_sysfs_ops flag
  remoteproc/wkup_m3: Set deny_sysfs_ops flag

 drivers/remoteproc/remoteproc_sysfs.c | 29 ++++++++++++++++++++++++++-
 drivers/remoteproc/wkup_m3_rproc.c    |  1 +
 include/linux/remoteproc.h            |  3 +++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.18.0

