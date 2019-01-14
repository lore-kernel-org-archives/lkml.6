Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29048C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6172206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSZiPWQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfANU2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:28:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfANU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:28:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so438884wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mRgFtaQSDGQ8meA3Ni8+iUvpq1Q85dE+uuhMia3848=;
        b=qSZiPWQIoU4f4Fy/tVJqimNL7ZYof3TIZr/aJ2ia0Yi2lmuRgq3CCDc2uTUJEYEsxj
         h3j4ydYz3QZdBRUuaRF01brNPo5IJHZdOOeIjby9gR/HixI5Kp4kTYSegJvKtRLeM24M
         ph8PcyKc0uTet4si6iAefwDY/q/722tcYyNTuqgk5q5dpg70wcm/3suQmeNfF94pCjpv
         as2oZfwzC+YuvyKDhje3dIhe/ij+Oi5WrmyHsy+VrCqLZLkgdMsxzmafA7NWERTtPn7I
         Th4ownsDYqSYsWqQ2gA9svdqh6DmYtDpB+OaUZN1kl8X/fFvlKleRm+EoC268Y/LFDyL
         FwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6mRgFtaQSDGQ8meA3Ni8+iUvpq1Q85dE+uuhMia3848=;
        b=ZquOOt/v390Shwx4v32dbLoSlawR1UEtPdWYAZc6LNUywlaPYKzGVwHfp4wsY8c9Vt
         RnbUplRRqwCOMqKtvOUFVcS2a5hg9/Q2jPj8oX5cBJ2oIlHibEbiSaP4pZYBR7XMu9oW
         jTtemmPyY4jUcE0l4oOeyk2fL64Vd2nPdoemQ5rlS143buL8lvBXLMDUIi85bmo8Gn+2
         xIkGtc9ItQerZYfHvPkJ5xI9jhh5vq7pWefU7TfF+A6gB376q36Xl+wu6oO9ltmPPhEZ
         GCINMDDFYb+NJVYfpo/dv8S3pmBzi29MnAANSPKGgKWL5PWkpNqsfu1QtxG/1iQ8h2hQ
         HKVg==
X-Gm-Message-State: AJcUukcgErs5KZqlUKSpXyvrYakL0xX3usq6hRMotLmh+R3TmQn/v13C
        9p4J6XLZ62WCRxKnxcevy3k=
X-Google-Smtp-Source: ALg8bN7iGUTW8m0gD/Lq0Ws+gqhghbke9152QTB22qD+Y23EIamw8MSI7P1YEY0JeSN+vAY67n19NA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr193032wrp.242.1547497688288;
        Mon, 14 Jan 2019 12:28:08 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id g129sm27976691wmf.39.2019.01.14.12.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:28:07 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 6A58411422AD; Mon, 14 Jan 2019 21:28:06 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:27:47 +0100
Message-Id: <20190114202748.15584-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
  include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
  drivers/gpu/drm/drm_dp_helper.c:155:3: note: in expansion of macro 'WARN'
  include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
  include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
  drivers/gpu/drm/drm_dp_helper.c:173:3: note: in expansion of macro 'WARN'
  drivers/gpu/drm/drm_dp_helper.c:547:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 516e82d0ed50..26835d174939 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -154,6 +154,7 @@ u8 drm_dp_link_rate_to_bw_code(int link_rate)
 	default:
 		WARN(1, "unknown DP link rate %d, using %x\n", link_rate,
 		     DP_LINK_BW_1_62);
+		/* fall through */
 	case 162000:
 		return DP_LINK_BW_1_62;
 	case 270000:
@@ -171,6 +172,7 @@ int drm_dp_bw_code_to_link_rate(u8 link_bw)
 	switch (link_bw) {
 	default:
 		WARN(1, "unknown DP link BW code %x, using 162000\n", link_bw);
+		/* fall through */
 	case DP_LINK_BW_1_62:
 		return 162000;
 	case DP_LINK_BW_2_7:
@@ -552,6 +554,7 @@ int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 		case DP_DS_16BPC:
 			return 16;
 		}
+		/* fall through */
 	default:
 		return 0;
 	}
-- 
2.19.2

