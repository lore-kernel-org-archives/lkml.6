Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6672DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171562086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Yl2d/D5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171562086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeFQIzs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:55:48 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43810 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:55:47 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1E0625C128F;
        Sun, 17 Jun 2018 10:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529225746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=i+dpBz+p7w0cz2jmpJLNvo2UxWlSOlnUTAIylOo1OaU=;
        b=Yl2d/D5gDdjwezqeQ4fVeuqCnQzs5PMK/qc1no6vegtHWo5x9yzisUsrOb4kogWVQxyqy8
        nuha/Blg180Mxs2MFxYtUx6SgtIxafQqnlJm/rbCWJoiGwGKGV8Bwdm9VhiDlYUVshO+x9
        RcN9KxRpFftHk599SKeSUYCThfoi23A=
From:   Stefan Agner <stefan@agner.ch>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: ipp: use correct enum type
Date:   Sun, 17 Jun 2018 10:55:29 +0200
Message-Id: <20180617085533.13867-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limit_id_fallback array uses enum drm_ipp_size_id to index its
content. The content itself is of type enum drm_exynos_ipp_limit_type.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 26374e58c557..04702e974e81 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -428,7 +428,7 @@ enum drm_ipp_size_id {
 	IPP_LIMIT_BUFFER, IPP_LIMIT_AREA, IPP_LIMIT_ROTATED, IPP_LIMIT_MAX
 };
 
-static const enum drm_ipp_size_id limit_id_fallback[IPP_LIMIT_MAX][4] = {
+static const enum drm_exynos_ipp_limit_type limit_id_fallback[IPP_LIMIT_MAX][4] = {
 	[IPP_LIMIT_BUFFER]  = { DRM_EXYNOS_IPP_LIMIT_SIZE_BUFFER },
 	[IPP_LIMIT_AREA]    = { DRM_EXYNOS_IPP_LIMIT_SIZE_AREA,
 				DRM_EXYNOS_IPP_LIMIT_SIZE_BUFFER },
-- 
2.17.1

