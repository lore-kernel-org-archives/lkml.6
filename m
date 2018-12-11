Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB45C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1AF20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543598;
	bh=KoktMSn2MPJxFf09iWL9M2HN3eKJuVo6QyNCmhwziNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XQOiW2jUIJ1LU9wE8DxbfJRyJef9NFizaPQKdW0tzO1OHC7bUYy5fqesnDdv2Tr6E
	 HZ+QOucXTXPcoMXpPHWChaGCnZ4KnZ71M9MvEsw5Q2fuaNLKewPCLsNqUYM1430IBl
	 1B5v09jBVbP4LCvb4MDWtGnpAkfaZrwOgR9754Cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeLKPxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbeLKPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61D820855;
        Tue, 11 Dec 2018 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543594;
        bh=KoktMSn2MPJxFf09iWL9M2HN3eKJuVo6QyNCmhwziNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLEZaKe/axUBjzK7M9dQlGRmjl68YdI+Qxc+Ldp6wgbT6J7OXfmeniKQ0Q6vAi+VJ
         ey/Ytts4qHiNM90+2GajYDDDbeFHEUZBbqYNMYQbgk/ZHrxgxGcW0mI/MRIzUr+nvA
         n1ptJZgPs5U2cmzk5KbfbV1E66gQg5LD+F72yASY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 57/67] drm/amdgpu/gmc8: update MC firmware for polaris
Date:   Tue, 11 Dec 2018 16:41:57 +0100
Message-Id: <20181211151633.266259722@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit a81a7c9c9ea3042ab02d66ac35def74abf091c15 upstream.

Some variants require different MC firmware images.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -52,6 +52,8 @@ MODULE_FIRMWARE("amdgpu/tonga_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_mc.bin");
+MODULE_FIRMWARE("amdgpu/polaris11_k_mc.bin");
+MODULE_FIRMWARE("amdgpu/polaris10_k_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_k_mc.bin");
 
 static const u32 golden_settings_tonga_a11[] =
@@ -220,22 +222,39 @@ static int gmc_v8_0_init_microcode(struc
 		chip_name = "tonga";
 		break;
 	case CHIP_POLARIS11:
-		chip_name = "polaris11";
+		if (((adev->pdev->device == 0x67ef) &&
+		     ((adev->pdev->revision == 0xe0) ||
+		      (adev->pdev->revision == 0xe5))) ||
+		    ((adev->pdev->device == 0x67ff) &&
+		     ((adev->pdev->revision == 0xcf) ||
+		      (adev->pdev->revision == 0xef) ||
+		      (adev->pdev->revision == 0xff))))
+			chip_name = "polaris11_k";
+		else if ((adev->pdev->device == 0x67ef) &&
+			 (adev->pdev->revision == 0xe2))
+			chip_name = "polaris11_k";
+		else
+			chip_name = "polaris11";
 		break;
 	case CHIP_POLARIS10:
-		chip_name = "polaris10";
+		if ((adev->pdev->device == 0x67df) &&
+		    ((adev->pdev->revision == 0xe1) ||
+		     (adev->pdev->revision == 0xf7)))
+			chip_name = "polaris10_k";
+		else
+			chip_name = "polaris10";
 		break;
 	case CHIP_POLARIS12:
-		chip_name = "polaris12";
 		if (((adev->pdev->device == 0x6987) &&
 		     ((adev->pdev->revision == 0xc0) ||
 		      (adev->pdev->revision == 0xc3))) ||
 		    ((adev->pdev->device == 0x6981) &&
 		     ((adev->pdev->revision == 0x00) ||
 		      (adev->pdev->revision == 0x01) ||
-		      (adev->pdev->revision == 0x10)))) {
+		      (adev->pdev->revision == 0x10))))
 			chip_name = "polaris12_k";
-		}
+		else
+			chip_name = "polaris12";
 		break;
 	case CHIP_FIJI:
 	case CHIP_CARRIZO:


