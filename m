Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C346C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SlL3OU5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6E42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJEXCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:02:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39303 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:02:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id v1-v6so5438225ywv.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhKjJ/dq4sh4AlTmKfdT6x+iVsKpjPdYbo2RGcYzJCE=;
        b=SlL3OU5izPZvIMDO/h7vlAfgORSl8L7v/PO+QTzRHdx6sMIW1TPmM4TT0ogDj1bcE5
         HDkAXHLK0zIxkmrUc7IBWkrw52Q81DrS3EBrtgXzNZXI+1KlQWBIiTztIcYdDM3IFxYk
         CIm/zS5h9WYCTe/9toVBEy0hggbYDoTWpAwmS8g+lHcznHU8IrUpIjHx7wRscDz8Onho
         k+NDebVJKgePUHv8YB3X+aobNXLnYAHBi2hfkiPFv4agRiUQMEuMOWXsKKTPyl8N7+46
         bVDzTjghPWqyCRKKxrbL9MVL9tJ2zXg6uLewgSIXqdOnT6BoyoTkJw3pBSak6CY7HNh5
         RZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhKjJ/dq4sh4AlTmKfdT6x+iVsKpjPdYbo2RGcYzJCE=;
        b=aWai91h4jWctCNJfo9v9A+CXu5Bu1yvIvtwB1pGj1tiPLLppDESlfM98Q4cHcI4OAb
         Xz+Iq1gP50S3ChHfT9I4rvFKceo1d+nqoYgLacqvmH6yy8s0mS7xmf72ZOKSaxqZK/j3
         bMgwuI0bJav2rceQic4PS1mTLfLTcyKHMUe0wkKK/15UlOnr3J8A86DqoppjFNAT44vx
         kUUVdrgo2mwkrocV74FoZ2FjzajBFZkUNF/ffU1aVUHk9R1qpP4D2P85i8ODv18mzYgN
         ouEaILJZ8UinIHoMtXJrYNtwYeot4GWGaa78hNq5U42M/g+rxlzTeJNVHUGUyaDacHS0
         9cDQ==
X-Gm-Message-State: ABuFfojymJqcBzDbP+UZgdewBQUfwzBdG/g9dDwX9rCXp3X9EhCVUjds
        dN2YFRGzsxe8ZWqd9cXo3+U9Cg==
X-Google-Smtp-Source: ACcGV620X8a9+7kYVdqxCggBL0UrV5sO3dT1Hzr3S9Rai3FlFRI8+LEnKUix20MffCOD2OCiIdgurA==
X-Received: by 2002:a0d:e081:: with SMTP id j123-v6mr6742288ywe.267.1538755378648;
        Fri, 05 Oct 2018 09:02:58 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id x133-v6sm2392116ywg.66.2018.10.05.09.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:02:58 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>, Dave Airlie <arlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Maxime Ripard as drm-misc maintainer
Date:   Fri,  5 Oct 2018 12:02:22 -0400
Message-Id: <20181005160256.200162-1-sean@poorly.run>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately Gustavo has decided to step down as drm-misc maintainer to
focus on other projects. Thanks Gustavo for your dedication and hard work!

Fortunately for us, we have a wealth of people qualified to assume a
-misc maintainer role. Maxime has done an outstanding job with sun4i and
in the community in general. I'm really excited that he agreed to take
on this responsibility and I look forward to working with him!

Cc: Dave Airlie <arlied@linux.ie>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard  <maxime.ripard@bootlin.com>
Signed-off-by: Sean Paul <sean@poorly.run>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c1fef3279b..da8507d401b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4755,8 +4755,8 @@ F:	include/uapi/drm/
 F:	include/linux/vga*
 
 DRM DRIVERS AND MISC GPU PATCHES
-M:	Gustavo Padovan <gustavo@padovan.org>
 M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
+M:	Maxime Ripard  <maxime.ripard@bootlin.com>
 M:	Sean Paul <sean@poorly.run>
 W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
 S:	Maintained
-- 
Sean Paul, Software Engineer, Google / Chromium OS

