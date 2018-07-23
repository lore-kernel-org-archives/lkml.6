Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B120779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAP1Clwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3B120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGWPbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:31:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46173 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWPbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:31:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so296526ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d/enA9Dabp1CBMZ1IgW5Q6tHLtresYeIsFqybjDD+kI=;
        b=vAP1ClwbgUJp8927jmENPLPQAL2Px/JDKC0SpKfIEH/RIm/z3rl6U/KxXRSfRW7Nxj
         VuTm0boZ4NOlpT46nPeVfvusd8gs7Iz/roEXsFjPi4aznWuSd1z3/hJnqb+43nHz0g+B
         I2Mc3gCy7TXpbilI0303mfm6zieXuN8OJlDYuXr5eTd19/SxjpElukdwFH7VQrbGeyQy
         ehaU0Ved/n4O9x59JK/W+HZbpgvxKXG4SOWVE56nxo6zVsaWm4ZReb2lKkJQasEdySRh
         QvrrNNqxA1lVnd7XmsREF6uV29gTBxeTeGewNxkfT+BDoUijSJ43rICEO5TSJf4dXCxV
         uOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d/enA9Dabp1CBMZ1IgW5Q6tHLtresYeIsFqybjDD+kI=;
        b=ICULXLKFuPvy1oY3aVLSNLnoRlbNZAtoadDlsEUNlFZR07V8dKvW57DJ4xTZX3olxc
         3dNzFPrPn0bxcDgulpe/pkAr9+IqPWo+2hVW5b/7y3XjArIU1UwPeAn1g6C0tmXo1Pry
         AW2aUiX83BRe6Ej4S2w25WWouHKjdo4ZHRGmp9jRpBnMcHq9B4ARTMCRtoiRIzvfRVWp
         22BnvLH8muz5nBUnn2XJfrk3ljQ1o4RnoamGx366Zt6/WmiusyPnrNvFW7MoFuP9EPys
         Jt5/Y143Qj1RNG1UhxY90pxdL6DbAAXrTRoH7Ikp5djiSACOFOra0ZAFl6ZxDUPg9esG
         Y5Sg==
X-Gm-Message-State: AOUpUlG04kvi7LwrRk69RYRbCN6myGorpHJL8RKYj2Zqz7MPZzbB/dzU
        xurzHFdkzVHlVrzaVeB956g=
X-Google-Smtp-Source: AAOMgpccE27i/VxdGmzLtohBaqhmKzGDwPTf2GpsBFnJr68saTuOtXtsh12sIp1yUvUx8nK8flsEtw==
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr13197141plh.291.1532356203444;
        Mon, 23 Jul 2018 07:30:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id p3-v6sm13228872pfo.130.2018.07.23.07.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:30:03 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Rex.Zhu@amd.com,
        harry.wentland@amd.com, Samuel.Li@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: amdgpu: Replace mdelay with msleep in cik_pcie_gen3_enable()
Date:   Mon, 23 Jul 2018 22:29:56 +0800
Message-Id: <20180723142956.3718-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cik_pcie_gen3_enable() is only called by cik_common_hw_init(), which is
never called in atomic context.
cik_pcie_gen3_enable() calls mdelay() to busily wait, which is not
necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 0df22030e713..5b7fab2c2008 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1476,7 +1476,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				tmp |= PCIE_LC_CNTL4__LC_REDO_EQ_MASK;
 				WREG32_PCIE(ixPCIE_LC_CNTL4, tmp);
 
-				mdelay(100);
+				msleep(100);
 
 				/* linkctl */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-- 
2.17.0

