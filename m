Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CFAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2785720855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DE6uYZz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfA1SaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:30:12 -0500
Received: from mx6.ucr.edu ([138.23.62.71]:49842 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfA1SaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548700212; x=1580236212;
  h=from:to:cc:subject:date:message-id;
  bh=O1NKJsbklK43F71j/XBC+1mow8DK0KjqoZO2LYm71mA=;
  b=DE6uYZz/gs/p8DjMfczZoyXVyciQqwUnAXpX+OKyQ8MhwhrkUjQFnX0U
   ZTAk/JcOXepKGxisWiFEdGHzclgfyUhE8kDUgNmjHQ/MWcMcCDGzk2a/+
   0KT/yhu50GO5UKyGHkB/G9nBvSUxc8+SAfNP72xM+iFf8VbE16mP5UWea
   xWihFKnsf05lirT1YtVo7gaLmQDdzaZkvjcvzXp9pl/DOiRMcD1JGC/fB
   Or6axaHbvoGY2EgdMY0rOcBXx9MHWDFwrj8p79Gz3ztzNIMKdKhqHCHmT
   13OJpRp6mwDX4S3wrjwjkIfKprkDl2a3rMXK2dsPy5gULfjOh4MfqE7zR
   A==;
IronPort-PHdr: =?us-ascii?q?9a23=3ASTnggxyN1dQsjb3XCy+O+j09IxM/srCxBDY+r6Qd?=
 =?us-ascii?q?1OIUIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbDQizf?=
 =?us-ascii?q?ssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1?=
 =?us-ascii?q?JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryhvOrHtIeu?=
 =?us-ascii?q?BWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3o05MLwqxbO?=
 =?us-ascii?q?SxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RSqt4LtqSB/wiS?=
 =?us-ascii?q?cIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyVMft+frjGfdMbQ2pBUdtaWTJYDIih?=
 =?us-ascii?q?YYsPDvQOPeJFoILgo1cDoweyCQyqCejyyDFHm2X20LU63eo/DA/I0g8uEdUVvX?=
 =?us-ascii?q?jIsNn4LrseXPqpwKXUyzjIcvNY2S366IjNah0uo/CMXLNwccrMzkkkCgTIj1WR?=
 =?us-ascii?q?qIzlJTyV1/gBv3SV4ud7SOKgl3QnpxtvrTey28chk4/EjZ8WxFDc7Sh13po5KN?=
 =?us-ascii?q?miREN4YdOoCoVcuzyaOodsXM8uX31ktD4nxrAHvZO3ZjYGxZonyhLFdfCKcpKE?=
 =?us-ascii?q?7xDsWeuXPDx2nmhqeKiliBa36UWgz+r8WdSq31tStSpFl8XMtmgK1xzO9siLUv?=
 =?us-ascii?q?t98Vml2TaIzw3T7/tLIUEwlabCM54hzaM8moMdsUjdAiP6hF/6jKCRdkUj9eio?=
 =?us-ascii?q?7/robq/6qZ+bMo94kgD+MqIwlcyjGek0LBQCUmyB9em/1LDv51P1TKhKg/EsjK?=
 =?us-ascii?q?XVrIzWKdwepqGjAg9V1ogj6wy4DzejyNkZnXgGLFJfdxKGk4TlJ1/DLevlDfij?=
 =?us-ascii?q?mVSgiilkyO3bPrH5GJXCMmDDkKv9fbZ680NczAszzdZC55NbE70BI+z8WlX3tN?=
 =?us-ascii?q?PGCh80KBK0w+n5B9VnzI8eWnyAArWfMKzMtV+E/OUvI/ODZNxdliz6Lq0U5uzu?=
 =?us-ascii?q?kHhxzU4PfaCohcNMQG2zBLJrL1jPMimkucsIDWpf5ll2d+ftklDXFGELag=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A2AgC6SU9cf8jXVdFlHQEBBQEHBQGBU?=
 =?us-ascii?q?QgBCwEBgzpKD4wcX4sXTwEBAQaKZRhthVeCcoUKgXsBCgEBLIMsgRSDISI0CQ0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJCwsIJzFCAQ4BgWgpgl82UlY/AQUBNVuCRwGBdA0Fnys8j?=
 =?us-ascii?q?BcziFQBB4FLCQEIh26EQYEPgQeDboR/g1SCQwKBLAEBAYo7hTKRKgEGAgGBY4F?=
 =?us-ascii?q?Cjn0kgWqBR4ZzOIdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgicXE44sHjOBB?=
 =?us-ascii?q?4ZWhQyCTQE?=
X-IPAS-Result: =?us-ascii?q?A2A2AgC6SU9cf8jXVdFlHQEBBQEHBQGBUQgBCwEBgzpKD4w?=
 =?us-ascii?q?cX4sXTwEBAQaKZRhthVeCcoUKgXsBCgEBLIMsgRSDISI0CQ0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJCwsIJzFCAQ4BgWgpgl82UlY/AQUBNVuCRwGBdA0Fnys8jBcziFQBB4FLCQE?=
 =?us-ascii?q?Ih26EQYEPgQeDboR/g1SCQwKBLAEBAYo7hTKRKgEGAgGBY4FCjn0kgWqBR4ZzO?=
 =?us-ascii?q?IdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgicXE44sHjOBB4ZWhQyCTQE?=
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="24297798"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 28 Jan 2019 10:30:11 -0800
Received: by mail-pg1-f200.google.com with SMTP id v72so12061100pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GzPvwOUSd0JK3oDETEZl7ProxxpTpEz9J+dEPSX9p9c=;
        b=ZuKgHbsf2biI0XIyG4lhdTadPGdOK9lrvKs3LprXlSJnxv26kPsMmjo1kpEJFsdyJj
         OzXL6TfmC8Ar6cw/OXBRxTEH3+ZclkgxI37IXDBL4Zk6UMt+xx5TTgUIqK2FF3KcZWyF
         eNqU5FcuZBCnH1BsdjeGrZtgacPhAC8Gj96Yb+wFD64JDw2a9M8hQ66Fo2lqnOumIJTU
         GgBvTCK6Y3nmCORgbG1DjWAbk1/eqHAc3EnlaVsWHk4eosHI3eYvXwnlsP+f3EEQsnQR
         nxYy9IkD3GKpFkd6eLQ1SScgmxe7Vr4Wq/Eyv87FnZ9oZVrnoMyK50qg3bVPYgu0b9gp
         Jt0g==
X-Gm-Message-State: AJcUukfLcI7dgyxEnWVLX+j2tO/Y18E6kcJAArls6x57MAbe6c4Gea78
        zykq/70wWISSC7utNvL9ascehzDnI2WcGGEe2qj09owbcmsMJI/P6d4LSgL8ew4fANKtOGq/PJK
        buv9kgtG0an7b5fGryKAVT+cO1Q==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr23374895pll.54.1548700210062;
        Mon, 28 Jan 2019 10:30:10 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5QpbDy8H8sa76Rva7JAMFD/uHT+d4oySmUFffvCMPTR3nsBEM5YuyjbqWPsQOJhcYiL7Ab9Q==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr23374857pll.54.1548700209702;
        Mon, 28 Jan 2019 10:30:09 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id o4sm82759805pgs.12.2019.01.28.10.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:30:08 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: gsc: Variable "gscblk_cfg" in function gsc_set_gscblk_fimd_wb() could be uninitialized
Date:   Mon, 28 Jan 2019 10:28:51 -0800
Message-Id: <20190128182851.8558-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function gsc_set_gscblk_fimd_wb(), local variable "gscblk_cfg"
could be uninitialized of function regmap_read returns -EINVAL.
However, this value will be  write to the register after "or"
operation. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 0506b2b17ac1..b1d0f974fe80 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -441,11 +441,16 @@ static int gsc_sw_reset(struct gsc_context *ctx)
 static void gsc_set_gscblk_fimd_wb(struct gsc_context *ctx, bool enable)
 {
 	unsigned int gscblk_cfg;
+	int ret;
 
 	if (!ctx->sysreg)
 		return;
 
-	regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
+	ret = regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
+	if (ret) {
+		DRM_ERROR("gsc: Fail to read system register\n");
+		return;
+	}
 
 	if (enable)
 		gscblk_cfg |= GSC_BLK_DISP1WB_DEST(ctx->id) |
-- 
2.17.1

