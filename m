Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6523C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC482086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543887;
	bh=Mvb5qzCPtRGig0jiZ+mnYELrv7yVtjcHQoS34Qikgh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYdtRh+56onqXyavv1hUmDMgUyvdgRobtBrreHUqZAhPQ4dfYO2g3kun/yum+pWkO
	 6aNZ5nx23zMbiNDQv7lXcll5Z7Cv8uCdpn+XKLw/OAjBli8G5YPBSOt/eDAKfoI2bi
	 4W42jr48ht2BpwTOf5q9NXyuEodUzzVzlTc8cwNY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC482086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeLKP6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbeLKP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BBE205C9;
        Tue, 11 Dec 2018 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543884;
        bh=Mvb5qzCPtRGig0jiZ+mnYELrv7yVtjcHQoS34Qikgh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft5A/vWNC5PK0lrN20DBojqfIqIYTTjVuD8sB0jxNPl1VDAGxkKttDYu+U3Lov/y5
         vhyk0URWoyZirtJTDZ7ZM9I3yI39lveySgoSsyIzW1GT2d2GohKAG/dfPJ8dgDJ6PY
         oN8c9u3qwKin460reUNqNEaR9mnDuFvc4opoToSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 101/118] drm/amdgpu/gmc8: always load MC firmware in the driver
Date:   Tue, 11 Dec 2018 16:42:00 +0100
Message-Id: <20181211151648.346347639@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

commit b52b6738cc2d50d2a8f4d0095bcb5a86716008a5 upstream.

Some power features rely on the driver loaded version so always
load the MC firmware from the driver even if the vbios loaded
a version already.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -365,7 +365,7 @@ static int gmc_v8_0_polaris_mc_load_micr
 	const struct mc_firmware_header_v1_0 *hdr;
 	const __le32 *fw_data = NULL;
 	const __le32 *io_mc_regs = NULL;
-	u32 data, vbios_version;
+	u32 data;
 	int i, ucode_size, regs_size;
 
 	/* Skip MC ucode loading on SR-IOV capable boards.
@@ -376,13 +376,6 @@ static int gmc_v8_0_polaris_mc_load_micr
 	if (amdgpu_sriov_bios(adev))
 		return 0;
 
-	WREG32(mmMC_SEQ_IO_DEBUG_INDEX, 0x9F);
-	data = RREG32(mmMC_SEQ_IO_DEBUG_DATA);
-	vbios_version = data & 0xf;
-
-	if (vbios_version == 0)
-		return 0;
-
 	if (!adev->gmc.fw)
 		return -EINVAL;
 


