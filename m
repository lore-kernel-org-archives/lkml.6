Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD30C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="L6H/+6pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF0D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbeITCU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:20:26 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36808 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:20:26 -0400
Received: by mail-yb1-f196.google.com with SMTP id 5-v6so2977859ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUZsGUZ+VQ+bvg0fQyVV61LuF0qa4lmHD2/u1Js04Lc=;
        b=L6H/+6pzIv1wZp9HLQuFOFvHhrK3NvIdQ/+4vY1smzK816ztCs4LCqBU6gHOdWtr2Y
         zzBwqUWNTUCx2LejSMA43FBgDJPI6ptWIdgri7f5vVQ6tkC65NJsR6FJ8Fh+vbHeLZ0n
         qkQ6Q4sDCtROXc1sA9OOHIpCUKbnrRkepFtSqKheRVJ2ofZtFT87uFHDwzQO8WUPSPTR
         oEQBjKMnjzPwF9F6aknaXaY+fTpzH65FavoqyhjrDNSOqgSiQ7wUkh5y12X7gCtBqqZA
         SjYNOOrmsuu8D7Wze9V9UXFmxWO2dbuWz4yFhbuWn6kpbks/GX4ruTmV1eeh6svnCCnf
         zoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUZsGUZ+VQ+bvg0fQyVV61LuF0qa4lmHD2/u1Js04Lc=;
        b=etswAq2g+0iACrJjOyt12I1XUYY6KTTjvktYctElOsJMEAf5fPhp6RyoZ+12zZG0Gh
         RFt/VvJh9xpqx0MN/Ao/4zFqhDL8n6rZsMN9KUOQlUCnTRK04Vf+yROPkxLQL504g2rx
         km2vIHWq44+m+NMLu0JEgURviD3jhLGsWtHFgoUi3l+qAq+X8TsWfz9UTRDP0ZHeHdja
         Ty4/f+Vh8DpKirsWndtCOMG3RRQCywjE6/CAK8Gyp8INnUHUdkBsSpYxlyO2gZznZBJ1
         YsQm0z2FEpsEwLV5cSwBqEdKpiNllUEGRSWbH4u6gUpwEZ2J9vw7VBCFu+GBsNzmsIkT
         0Tkw==
X-Gm-Message-State: APzg51AeDB4I6ASoSwXabFZwSH8teh7eGPKB1Wb9fRlBuea8tyt85kis
        TBJvMBOcBIog8eZdGmcxbFv+lg==
X-Google-Smtp-Source: ANB0VdaH3LuAxX4IYVs7bfijC8FDco/i3dQd+uZFf9WkqykjJsQ13fTYgs88zfCluTj4TQyul/Fo+g==
X-Received: by 2002:a25:a426:: with SMTP id f35-v6mr666313ybi.207.1537389648935;
        Wed, 19 Sep 2018 13:40:48 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id j66-v6sm2602989ywc.61.2018.09.19.13.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:48 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 2/2] MAINTAINERS: Move mxsfb drm driver to drm-misc tree
Date:   Wed, 19 Sep 2018 16:39:58 -0400
Message-Id: <20180919204026.3217-2-sean@poorly.run>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180919204026.3217-1-sean@poorly.run>
References: <20180919204026.3217-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Another "small driver" moving into drm-misc. Stefan has also offered to
co-maintain it.

Cc: Marek Vasut <marex@denx.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba1dbb8735b8..7184d53dcbd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9891,9 +9891,12 @@ F:	drivers/media/tuners/mxl5007t.*
 
 MXSFB DRM DRIVER
 M:	Marek Vasut <marex@denx.de>
+M:	Stefan Agner <stefan@agner.ch>
+L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/mxsfb/
 F:	Documentation/devicetree/bindings/display/mxsfb.txt
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
 M:	Chris Lee <christopher.lee@cspi.com>
-- 
Sean Paul, Software Engineer, Google / Chromium OS

