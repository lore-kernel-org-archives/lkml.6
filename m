Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F52C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6332082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027151;
	bh=rqNhW8aphqb3Ru1QuvGEO4w7eRUNt9wXISzLmy3dh7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7Wnuejypzht61F176wZ/VQQW48Z1Ss7btZ+haWxNZ4/1wrUUdpns4rXeAelHnIpx
	 bPqUp83pd6ldzevORAciX5i8Yzjmj6zrhCwtUFPzpNLfd/HjvhON7Hl+pJrIIQsIoP
	 B53PmGmGEuqP/Z/lecADEgLoBEJudInltnGWOpxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfBMCdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbfBMCdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A485A222D0;
        Wed, 13 Feb 2019 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025224;
        bh=rqNhW8aphqb3Ru1QuvGEO4w7eRUNt9wXISzLmy3dh7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGRd11O5IZ3VG792s33PdOBGN8wbrL+AXya8df+T+G0Pxzt/RIpuceer0ZWcFEKZh
         PdHZMPueNC2dNcl6/KEOMr6gblArplMSMvuQJbpRqPqZK1D4XHsviAN+TOVgOI3gFj
         smV2eVN3S2Ons0cZutcmBHeZOKtnUHthJjWFB+Wk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 007/105] mfd: twl-core: Fix section annotations on {,un}protect_pm_master
Date:   Tue, 12 Feb 2019 21:31:58 -0500
Message-Id: <20190213023336.19019-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8838555089f0345b87f4277fe5a8dd647dc65589 ]

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3d84a3b): Section mismatch in reference from
the function twl_probe() to the function
.init.text:unprotect_pm_master()
The function twl_probe() references
the function __init unprotect_pm_master().
This is often because twl_probe lacks a __init
annotation or the annotation of unprotect_pm_master is wrong.

Remove the __init annotation on the *protect_pm_master functions so
there is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4be3d239da9e..299016bc46d9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -979,7 +979,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
  * letting it generate the right frequencies for USB, MADC, and
  * other purposes.
  */
-static inline int __init protect_pm_master(void)
+static inline int protect_pm_master(void)
 {
 	int e = 0;
 
@@ -988,7 +988,7 @@ static inline int __init protect_pm_master(void)
 	return e;
 }
 
-static inline int __init unprotect_pm_master(void)
+static inline int unprotect_pm_master(void)
 {
 	int e = 0;
 
-- 
2.19.1

