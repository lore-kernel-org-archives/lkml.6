Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F8E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297960;
	bh=dHzIlYPXvNn4GSDT0rcYOMKu0zK5A881j+30d7oemsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukqNQaSqrt0boWZvIKgtXWBG+cyeR75uo/7wR9XsTjAvzMIIVp+jEhvsbDKFpkpPN
	 Owr2hK/ZrTNftlire0miD46kdKGjAk56RcnngIayM13/ot+obSOW0mWqGgpAUs8nfw
	 P2r48XLdGFxVrdBhMzajFctfOVWNzWOYQVf3MDjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeLTJZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbeLTJZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA15720656;
        Thu, 20 Dec 2018 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297956;
        bh=dHzIlYPXvNn4GSDT0rcYOMKu0zK5A881j+30d7oemsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAcDv5Ln9OLCzQougfpKiNtXpr1IHZQDSFWPCf0UwR0pmDssjzTXOLME69552iLRk
         i62xS5FXq+MPSJDz7wB5Pz5Dn93eeCWsl4WmD0Nt29FOoVAeB3AqdZgErdWvWpa/G2
         IuMSaWyqOJUNKTFsWs/0XiY0bgVGKCDS6pnRJId0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 18/72] drm/amdgpu: update SMC firmware image for polaris10 variants
Date:   Thu, 20 Dec 2018 10:18:17 +0100
Message-Id: <20181220085923.054704726@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junwei Zhang <Jerry.Zhang@amd.com>

commit d55d8be0747c96db28a1d08fc24d22ccd9b448ac upstream.

Some new variants require different firmwares.

Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -723,7 +723,8 @@ static int amdgpu_cgs_get_firmware_info(
 					      (adev->pdev->revision == 0xe7) ||
 					      (adev->pdev->revision == 0xef))) ||
 					    ((adev->pdev->device == 0x6fdf) &&
-					     (adev->pdev->revision == 0xef))) {
+					     ((adev->pdev->revision == 0xef) ||
+					      (adev->pdev->revision == 0xff)))) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k_smc.bin");
 					} else


