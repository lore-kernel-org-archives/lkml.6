Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E2C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21B920857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762003;
	bh=Sfp03ZHFKRX2R7j/xFVN69ckJlfkI00kMDlxMXYYWEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUKXcdu/IQ8cUy3VtnOFVS0TUtoW7d1xpI3YTMWv0ibpOmw4ORGG9OaHXyf4VYIKl
	 IzcdT79OwsTtlTegdpVLez7D0AKCqWn8SAfkOsllChmIfastPwc9W+BaQGGDV9Kp+v
	 ziukKOiwC6jEI8pbeJ7BZVh+eayBi1HOZmNVnsvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfA2LkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfA2Lj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A16920989;
        Tue, 29 Jan 2019 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761997;
        bh=Sfp03ZHFKRX2R7j/xFVN69ckJlfkI00kMDlxMXYYWEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCA2KLQrm6MIPqoAAK9P2d26JUvWEz+jTi+TolsKKvjapGsWxF36z3pAx8yR+b0gf
         EqYsbchJbG3vxVkTz+VHI7W2a4YnwRZZYmcVW7Q0oiWgQuHAIKATd1IdayAF5M8aae
         ggm9icVuTdjh04RvZ3ynO5bjPHf437T7K9qdTxiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Qu <Jim.Qu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 074/117] drm/amdgpu: Add APTX quirk for Lenovo laptop
Date:   Tue, 29 Jan 2019 12:35:25 +0100
Message-Id: <20190129113211.213830528@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit f15f3eb26e8d9d25ea2330ed1273473df2f039df upstream.

Needs ATPX rather than _PR3 for dGPU power control.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=202263
Reviewed-by: Jim Qu <Jim.Qu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -576,6 +576,7 @@ static const struct amdgpu_px_quirk amdg
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1025, 0x125A, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x6900, 0x17AA, 0x3806, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 


