Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D878C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DD72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2Pp/XFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DD72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390319AbeKTDPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC3E213A2;
        Mon, 19 Nov 2018 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646290;
        bh=dSqytGO/JyRw3Cd7GI45KBSZcCQ3sj2KFlpvkiXQCls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2Pp/XFUo5FTAqDJ8d5yVRfR+hv6O6/h3F+B8ifLd8RJmvZPiwAnQwKKAjmzHaz7T
         D6QMDQLBdicWadETrZkR4R2dIaTg2TOm/lU1L6v2xEL7+OHLPpYcyUzqyjkhRuwMxM
         h98fo0iOJ/PJdqRPKEVblHqmr+i7eU2HV8Ct/TkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 108/124] drm/amdgpu: add missing CHIP_HAINAN in amdgpu_ucode_get_load_type
Date:   Mon, 19 Nov 2018 17:29:22 +0100
Message-Id: <20181119162632.285058024@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit d9997b64c52b70bd98c48f443f068253621d1ffc upstream.

This caused a confusing error message, but there is functionally
no problem since the default method is DIRECT.

Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -247,6 +247,7 @@ amdgpu_ucode_get_load_type(struct amdgpu
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
+	case CHIP_HAINAN:
 		return AMDGPU_FW_LOAD_DIRECT;
 #endif
 #ifdef CONFIG_DRM_AMDGPU_CIK


