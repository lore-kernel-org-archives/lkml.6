Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F95C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84314206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="zFiRSBjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84314206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbeKVNMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:12:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47030 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKVNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:12:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so6029814qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gBfCtRnT7hMirUIQBIrazSIaq2eE8Jtpfcfo5Pc8x1U=;
        b=zFiRSBjKJ1TiABG4/5qdgNI2zdOqeaaMCyQYesCI9k0zKf/rJJXKJmfeO+rVimF7rK
         E9OekAxHa/NEOTGm9iLK9uhfddS1UsT+v4rbLy5a39B3o2V5no9269dszYi1psPNCE8m
         IJKQaWSL0xzzR9kDVgJJnez75V5nRzPOVZjMPTew4EZEfMn8wmXVmxsaE+OCyD88QM0c
         f+xG3CErbkJhI8LRheYKJp131WGllUE9KILEq3T4bXExQ4stJ0Ys57Mp75ORcZ9G4XwC
         RzaE99QG5GiRTtSn+lkX+rlmzsId8TGHgkhIODBlahPqo/YVGJxvOF0u3uudc5kgIWlc
         gFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gBfCtRnT7hMirUIQBIrazSIaq2eE8Jtpfcfo5Pc8x1U=;
        b=ojthxb/LJXPOkMdIG6/Cpxegrz2qlEwERWYBcQoLLb9y0nk2yHryqROdYvvAO43nIr
         PxpovRXU1JcA+rUACDwqP8OezFjEy/fwTSAriSMIAWzOmN1/j6VvSAq/2JC5OcelLEx8
         2C/eFnmnWmS2VerNEeCM3rgXGLkfxAXi4Jh2AECoQug7iC6bOQ9EEXZX07s0j4F51LI7
         4RhmsDAMAoDiz97IFhSTWfo3NXK9MXSVCIeaPK5GCXoIBGjJeawmd7WQm+T4jS4UT7pl
         cwMZr7KTxpvn9fJ1QGhw7gKqgGpWWmtfWB6Bao2s8NlOzCYOObcrRgZNimelfMLqokNK
         JSlA==
X-Gm-Message-State: AA+aEWZLGZ07/9UsyZt2gOabx1b4sGVm883VVPlPJzVqL+c3Q45N9lCz
        ugzwF2uQztG8p17cqEdBiWJ1rg==
X-Google-Smtp-Source: AFSGD/XcLthoJhH97FsyMIlY5nFGfY0GxgtxTDHkj39STxU+Da55nSjdxzN1Kry8qQhJufYB4LO46w==
X-Received: by 2002:a37:6b42:: with SMTP id g63mr7811638qkc.297.1542854105710;
        Wed, 21 Nov 2018 18:35:05 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id b17sm25240234qkj.69.2018.11.21.18.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 18:35:05 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     bjorn.andersson@linaro.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] firmware: qcom: scm: fix compilation error when disabled
Date:   Wed, 21 Nov 2018 21:32:25 -0500
Message-Id: <20181122023226.1074-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the case when CONFIG_QCOM_SCM is not enabled, and linux/errno.h
has not been included previously.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
drm/msm includes qcom_scm.h, but can be used with non-qcom hw (IMX5)

 include/linux/qcom_scm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 06996ad4f2bc..1637385bcc17 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -67,6 +67,9 @@ extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 #else
+
+#include <linux/errno.h>
+
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 {
-- 
2.17.1

