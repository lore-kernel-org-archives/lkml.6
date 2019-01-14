Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDB620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOkNuzzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfANU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:27:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35546 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:27:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so435385wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06uoGtHvpriE8VBGEcPTl689B7ZuMAcRhwqZCUATnsM=;
        b=QOkNuzzhrhfVO1Hm1paIPwv7Gua1popZrvHaGdUvkmNegiaZCyi88KILFYOFVAGd5Q
         QwXFYf62BPlUHzRG7GekMKFNEZJn8LjbEfn6OFPtQDYvPyjOLn2UdCuwroYKJFKFTK5i
         DZAJR3cuVzkNTbm36MJ/+YtuvCvbiCIxTD5EtlP6GTgvlXKtAKMlYezcLEKamkXnmPa7
         v/rcS6hlVYcs3eSzypfA0+vMxWOY5STRECaVSmwPyW9hnXkSNXZb+vQ6TjFmE0XcZKPn
         0OTzccRiMsTmTZGkxn86tvQbyCpvz3mLEfO6nlK4RkWLDzlTGJyzUs5yjuLpA3GiBZzK
         OWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=06uoGtHvpriE8VBGEcPTl689B7ZuMAcRhwqZCUATnsM=;
        b=rc7dCmf/k/sxfdmv3eC4e6J1KOJCDknOn5D1jLWlwtcd+vX7tnjRTjxf9tOtxomJyy
         e/RkUkqO/uPoliO9eFW/FWoWanK5AUJiP9GLHIfpnT/wpCjgpNCQbE7te81jQOUZrIq4
         uquPdmBkXL1WzxCP7/xUc/KhRLvaqBpntMs6KR2JynyIt4eSbWOPp8rfI7TD/hgc/1E7
         T8bQZV1pbUDvD9TGG+/bZNjgL0ZTdVFb7a2HrbW0Q/ZhsY6ZROeMxC4gjcvmnwWgwXzQ
         GOs70yVVCaU8ywrZ+IV9vTFJLnywJnYbLm8V0EOTLpAXeQfIMe+uIzPdyQr3s2Rr1vFM
         NzzA==
X-Gm-Message-State: AJcUukdg/VyuZ97LvQmyBk+hO2mCE/0ywBZRLChHmOUjJK30nt7SJ16a
        VaYAj/OF0oKNWB6Di1HpqK7d5E9m
X-Google-Smtp-Source: ALg8bN5os5KqKiD0Jq4n3Tuv97jBGs/ylQMhqG3ItTdlnvnEDSIpQY6Wm5HjPKs5joc1l6JO3qWDtA==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr181583wri.324.1547497626979;
        Mon, 14 Jan 2019 12:27:06 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id s1sm106814786wro.9.2019.01.14.12.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:27:06 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 31AFC11422AD; Mon, 14 Jan 2019 21:27:00 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: radeon: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:26:52 +0100
Message-Id: <20190114202652.15204-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  drivers/gpu/drm/radeon/evergreen_cs.c:1301:11: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index f471537c852f..fbf346185790 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		/* fall through */
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;
-- 
2.19.2

