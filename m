Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B73C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BD72184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdI4iTQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfAYKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:15:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53857 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfAYKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:15:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so6189609wmb.3;
        Fri, 25 Jan 2019 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Ke2IPsE03IyucB6vV/gx6p370HSOpPiyyMFC8AjOCc=;
        b=VdI4iTQVfqaVp+98mSKz/Pb0FtLfGaTtlzhaZ4MRfQtP8euGJAkHMP4R4U4m26XrGq
         DgjBbcsfPQIPh3iKYUSvy4r6Yt/75lL9SaGVLeZ022IkWcqtSGqGMkckHPa+KcbcJQvB
         de104w/S5N8NwTruFndz+twNW6a262lInk/u3BUy1o7WqbuyJLoReRvexeZhfHyAIoXl
         maH8RwKn8TycrXLKK9+qBvOVWs6RIkeiasF+y/I82mqxcvQbx3SOMTe7slxgSifTyOJj
         QB9EOWv2GEcZHm6zZPVHm+vYgMptobx9vRcEtaEx42Qzk3qwHNHCzbaTAyy1NjpYK5NN
         KADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Ke2IPsE03IyucB6vV/gx6p370HSOpPiyyMFC8AjOCc=;
        b=YEp5nlhYCOR0A0gXq+uSYTs/+7d/XSROJYflEHHVOftn7T9qIDQUcCDCJAH+oUPKNA
         y/eqaZ80qFKpVxDBzdpT71ALCrrizK+HEU3cYdhrejiWPADeuPx3Uaqg2W7n58ncvOQU
         yDvv//bxMTIt48BImOl73ni/8Gw8GjSqo6gD2+HT/3fD5pNHOGP8DSxYWTOf20Qbb6/U
         BnJ2Ct1vlYtwX9WNyMUPLyNOjdY4pLylEdDVQ+fOmC1UZfhX8ON4qcgMsgINY1SCAvSQ
         C5nnew5XhXg+u5hibnH8/EV7uNcMCbuG3AByDP47IfTKk38h+xEXaZojhcF2XpMG91bo
         4lZg==
X-Gm-Message-State: AJcUukd8R2JkaO7QVN5tQHXPR6MjWuyXYeD5a4sFoehW/tQ+EX59C+dE
        iDghiNxDl28y3fADTSboho4=
X-Google-Smtp-Source: ALg8bN6A6mUkjCApnYO0pNAZi4QxMg4VoQP1GhhM9x5ESEh3UNqBCj4+liobXPoEf796VtLGMltjXQ==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr6166649wmg.55.1548411356136;
        Fri, 25 Jan 2019 02:15:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e16sm182548401wrn.72.2019.01.25.02.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:15:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] reset: Don't WARN if trying to get a used reset control
Date:   Fri, 25 Jan 2019 11:15:54 +0100
Message-Id: <20190125101554.5947-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

When requesting a reset control for exclusive use that's already in use,
an -EBUSY error code is returned. Users can react accordingly when they
receive that error code, so there is no need to loudly complain.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/reset/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 9582efb70025..6b452f010b66 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -416,7 +416,7 @@ static struct reset_control *__reset_control_get_internal(
 
 	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
 		if (rstc->id == index) {
-			if (WARN_ON(!rstc->shared || !shared))
+			if (!rstc->shared || !shared)
 				return ERR_PTR(-EBUSY);
 
 			kref_get(&rstc->refcnt);
-- 
2.19.1

