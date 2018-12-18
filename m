Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C15C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77BA21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151327;
	bh=yOoVSoOIUt+pfV8OulafLVnoz0/VibxfM/ob2YJ+Hm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gY21UlfMmBIFBykn/94lHnvt4fBVGom6eM66Q8CVG4WrTSjJT84fZrNNr2RBOPt3C
	 vQcbSU8PObiYiTPZ2kIS2vu66uHCcl0Jinu+dfFbfhJcewgppgkx3z/e5K3rfrkAK5
	 V7lJcqUivRErAXe+w4Kj3nxqsJUP6DSNYrbsLNbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeLRQmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeLRQmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:42:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8126521873;
        Tue, 18 Dec 2018 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151322;
        bh=yOoVSoOIUt+pfV8OulafLVnoz0/VibxfM/ob2YJ+Hm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FkcDL9NxbAcTw1e0BhNwG23J3bdBSZA9q2eudcgeHxGsjswlUQiR5Ogdnv/93C4RS
         ZpxFmDdWAIpgp96DGut1Epah1VxPIHAM+1oU/vuhZIiNOK/o+KuZMNITSQ+nCgh1Mi
         YyjFV0G5TqOMoFN/7CgeFONg1gD8iQXwh1f5RDJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 42/44] drm/amdgpu: update SMC firmware image for polaris10 variants
Date:   Tue, 18 Dec 2018 17:39:54 +0100
Message-Id: <20181218163932.324323153@linuxfoundation.org>
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
@@ -381,7 +381,8 @@ static int amdgpu_cgs_get_firmware_info(
 					      (adev->pdev->revision == 0xe7) ||
 					      (adev->pdev->revision == 0xef))) ||
 					    ((adev->pdev->device == 0x6fdf) &&
-					     (adev->pdev->revision == 0xef))) {
+					     ((adev->pdev->revision == 0xef) ||
+					      (adev->pdev->revision == 0xff)))) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k_smc.bin");
 					} else if ((adev->pdev->device == 0x67df) &&


