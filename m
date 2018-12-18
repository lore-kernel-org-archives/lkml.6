Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9824C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9F821873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151351;
	bh=xwC08cP0zeQE5SDa+3FCsXW7pfKOFchhc1rsXMxPVDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hakQWkJZECGhdRYAcljDD3NWQ2zS4u/KhZAB2H7eA5uBj1L6Di/dHeBWvhHnci8TF
	 YD6T3Gh4lqI64dtM2AZeQZdi7v2Vnz/f8k3JahirbLDiOl8ZswqNDQnEYmfyrrd3CZ
	 i4p33RAhBm//Pucg8Yt//f6bLABqCzV4kN8EltuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLRQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeLRQm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:42:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9D521873;
        Tue, 18 Dec 2018 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151345;
        bh=xwC08cP0zeQE5SDa+3FCsXW7pfKOFchhc1rsXMxPVDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEVRp9giH4JFw+D7J6ZzelhCi0n8dbpkNtUGdZytHemrj5rbAkE9xbsXrrgiBv/FC
         /NAVB7ddMP4bIO8AYPUI+qE3zWH9dR95Ow+HaDuOow6T7ubKFoQy6V9vhyB6aYrAm9
         My/sooOD/lT8jmtxkuX8+zC3GSK+i43XSZsi/bm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 4.19 41/44] drm/amdgpu: update smu firmware images for VI variants (v2)
Date:   Tue, 18 Dec 2018 17:39:53 +0100
Message-Id: <20181218163932.197617808@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 153573d8870e1c173721bdc1ced72b3ad0d85de4 upstream.

Some new variants require updated firmware.

V2: add MODULE_FIRMWARE for new firmwares

Reviewed-by: Huang Rui <ray.huang@amd.com> (v1)
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |   33 ++++++++++++++++++++++----
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c |    3 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -330,7 +330,9 @@ static int amdgpu_cgs_get_firmware_info(
 			case CHIP_TOPAZ:
 				if (((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0x81)) ||
 				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0x83)) ||
-				    ((adev->pdev->device == 0x6907) && (adev->pdev->revision == 0x87))) {
+				    ((adev->pdev->device == 0x6907) && (adev->pdev->revision == 0x87)) ||
+				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0xD1)) ||
+				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0xD3))) {
 					info->is_kicker = true;
 					strcpy(fw_name, "amdgpu/topaz_k_smc.bin");
 				} else
@@ -351,7 +353,6 @@ static int amdgpu_cgs_get_firmware_info(
 				if (type == CGS_UCODE_ID_SMU) {
 					if (((adev->pdev->device == 0x67ef) &&
 					     ((adev->pdev->revision == 0xe0) ||
-					      (adev->pdev->revision == 0xe2) ||
 					      (adev->pdev->revision == 0xe5))) ||
 					    ((adev->pdev->device == 0x67ff) &&
 					     ((adev->pdev->revision == 0xcf) ||
@@ -359,8 +360,13 @@ static int amdgpu_cgs_get_firmware_info(
 					      (adev->pdev->revision == 0xff)))) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris11_k_smc.bin");
-					} else
+					} else if ((adev->pdev->device == 0x67ef) &&
+						   (adev->pdev->revision == 0xe2)) {
+						info->is_kicker = true;
+						strcpy(fw_name, "amdgpu/polaris11_k2_smc.bin");
+					} else {
 						strcpy(fw_name, "amdgpu/polaris11_smc.bin");
+					}
 				} else if (type == CGS_UCODE_ID_SMU_SK) {
 					strcpy(fw_name, "amdgpu/polaris11_smc_sk.bin");
 				}
@@ -378,14 +384,31 @@ static int amdgpu_cgs_get_firmware_info(
 					     (adev->pdev->revision == 0xef))) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k_smc.bin");
-					} else
+					} else if ((adev->pdev->device == 0x67df) &&
+						   ((adev->pdev->revision == 0xe1) ||
+						    (adev->pdev->revision == 0xf7))) {
+						info->is_kicker = true;
+						strcpy(fw_name, "amdgpu/polaris10_k2_smc.bin");
+					} else {
 						strcpy(fw_name, "amdgpu/polaris10_smc.bin");
+					}
 				} else if (type == CGS_UCODE_ID_SMU_SK) {
 					strcpy(fw_name, "amdgpu/polaris10_smc_sk.bin");
 				}
 				break;
 			case CHIP_POLARIS12:
-				strcpy(fw_name, "amdgpu/polaris12_smc.bin");
+				if (((adev->pdev->device == 0x6987) &&
+				     ((adev->pdev->revision == 0xc0) ||
+				      (adev->pdev->revision == 0xc3))) ||
+				    ((adev->pdev->device == 0x6981) &&
+				     ((adev->pdev->revision == 0x00) ||
+				      (adev->pdev->revision == 0x01) ||
+				      (adev->pdev->revision == 0x10)))) {
+					info->is_kicker = true;
+					strcpy(fw_name, "amdgpu/polaris12_k_smc.bin");
+				} else {
+					strcpy(fw_name, "amdgpu/polaris12_smc.bin");
+				}
 				break;
 			case CHIP_VEGAM:
 				strcpy(fw_name, "amdgpu/vegam_smc.bin");
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
@@ -37,10 +37,13 @@ MODULE_FIRMWARE("amdgpu/fiji_smc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_smc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_smc_sk.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_k_smc.bin");
+MODULE_FIRMWARE("amdgpu/polaris10_k2_smc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_smc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_smc_sk.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_k_smc.bin");
+MODULE_FIRMWARE("amdgpu/polaris11_k2_smc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_smc.bin");
+MODULE_FIRMWARE("amdgpu/polaris12_k_smc.bin");
 MODULE_FIRMWARE("amdgpu/vegam_smc.bin");
 MODULE_FIRMWARE("amdgpu/vega10_smc.bin");
 MODULE_FIRMWARE("amdgpu/vega10_acg_smc.bin");


