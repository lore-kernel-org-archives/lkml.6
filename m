Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC775C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FABC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FABC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeIMTPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:15:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeIMTPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1495ED36;
        Thu, 13 Sep 2018 14:06:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 156/197] drm/amdgpu: update uvd_v6_0_ring_vm_funcs to use new nop packet
Date:   Thu, 13 Sep 2018 15:31:45 +0200
Message-Id: <20180913131847.796884988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit afb1436c7b44ab928e6369a4d48e3abb8215241e upstream.

Was missed when updating the uvd 6 module.

Fixes: 1aac3c9180 (drm/amdgpu: fix insert nop for UVD6 ring)
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1569,7 +1569,6 @@ static const struct amdgpu_ring_funcs uv
 static const struct amdgpu_ring_funcs uvd_v6_0_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_UVD,
 	.align_mask = 0xf,
-	.nop = PACKET0(mmUVD_NO_OP, 0),
 	.support_64bit_ptrs = false,
 	.get_rptr = uvd_v6_0_ring_get_rptr,
 	.get_wptr = uvd_v6_0_ring_get_wptr,
@@ -1587,7 +1586,7 @@ static const struct amdgpu_ring_funcs uv
 	.emit_hdp_flush = uvd_v6_0_ring_emit_hdp_flush,
 	.test_ring = uvd_v6_0_ring_test_ring,
 	.test_ib = amdgpu_uvd_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = uvd_v6_0_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_uvd_ring_begin_use,
 	.end_use = amdgpu_uvd_ring_end_use,


