Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF85C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CA32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpJut3MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CA32146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbeK3BfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbeK3BfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691F12145D;
        Thu, 29 Nov 2018 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501788;
        bh=+xsDmVJY5H6ac35tM9RyBh3F/+gyYkWLxPriUUKxTGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpJut3MBLBy7TyET72N2w+JZk3nuTX6iDhNI8CtR0k9VUZVgOUVIdRVo73EFC6Cu4
         4+0+uD7/StOE+SHyPFlFdaxqUfF2Hel6BQHP7OcQswrHeWrTjKESNxEa+9ne3yg244
         KsBSAI2bkhUsWUtilhh3240qrvMVn5i9jEC9uv98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 041/110] drm/amdgpu: Add missing firmware entry for HAINAN
Date:   Thu, 29 Nov 2018 15:12:12 +0100
Message-Id: <20181129135922.922590330@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8d4d7c58994759bbd9f4fec32d88bf0e0b89302e upstream.

Due to lack of MODULE_FIRMWARE() with hainan_mc.bin, the driver
doesn't work properly in initrd.  Let's add it.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1116239
Fixes: 8eaf2b1faaf4 ("drm/amdgpu: switch firmware path for SI parts")
Cc: <stable@vger.kernel.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -45,6 +45,7 @@ MODULE_FIRMWARE("amdgpu/tahiti_mc.bin");
 MODULE_FIRMWARE("amdgpu/pitcairn_mc.bin");
 MODULE_FIRMWARE("amdgpu/verde_mc.bin");
 MODULE_FIRMWARE("amdgpu/oland_mc.bin");
+MODULE_FIRMWARE("amdgpu/hainan_mc.bin");
 MODULE_FIRMWARE("amdgpu/si58_mc.bin");
 
 #define MC_SEQ_MISC0__MT__MASK   0xf0000000


