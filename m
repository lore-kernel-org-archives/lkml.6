Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57964C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254AF20838
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lvUlOl9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407871AbfBNQX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:23:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36577 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404808AbfBNQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:23:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so7164463wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STmqjTjXg1jNQMSDlRu0EeR/S+97p+o3Pg7VRk0pIjk=;
        b=lvUlOl9fVclj7xHiR/TzJ1Sr5upzKKLjL3f1ZpLygaDvPqrJRfpQZAQSYMKupD285A
         uvfZf7zpvQdRMSFC3sOuZfSDSgaL6EIpf5jECy48+kAwHDI5yWvGvIHU6LOJ5r3i2XO6
         Zs8VyGgo7haLRuchezf+KmeMWoTx2bDzMGZzY/sMaiH7iRjjtPC+bPm34nlATV9x5eTN
         uY4BgDtxVJ8l/JqmxKQHiktWmI+tnq4CnWqyt8nEphrP1uJ6REM1mwFrJsi+HvzC6yb5
         5kVN9+XBbvOfgP5RDLjl3ecpzFChW9oxankFKC+QnJ3sFtcab4z44xQCO0QGJrisDoAx
         2t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STmqjTjXg1jNQMSDlRu0EeR/S+97p+o3Pg7VRk0pIjk=;
        b=Us2rwZ6Umt8OJ6ZzkjZJGanvJ76y1GCvJOQz9atsv1j9SWDePD7ObNCCsYgNpCWKMP
         cGwUbTqaKZY13l+KGFqK9DHeT+6cNhR+2yyoWosZLXQAqPeSbxLCaMSp9yWnJgoGAaDb
         Y7ihJwln9OaHoJl7kgTLmFTFlh2JbXeqswhGTVdZvlUAkdZAt6qsM8kLsykdQkY5oAXV
         a5g138+9E/6wrmRcyq+q/1jacbxsJhVYVjKApzdOyQ6edb9UMKXvvhUt0nBoUh0lilhi
         x3s5H7xdEyn5cyeRmATuPoYFDP9JrlYzc6wPvJw50I8pvHPuNa8Xv6kxTsPb//OfEWoI
         /BMg==
X-Gm-Message-State: AHQUAuaKsyZh/Og3SOuGb7YmCFh3g7r/u1TVK5IJk/s0WCD16aM1afiP
        l1wTlZeu/523GZ1uoA7ssoQ+M3I2ST0=
X-Google-Smtp-Source: AHgI3IbMjZ1wLfqODQVfy8z1Ffvbqfr3zD84SB6KNOeiTLOX5ZQZ872rJ0mDW8AgQWCz67eO9JD1GQ==
X-Received: by 2002:adf:8143:: with SMTP id 61mr3376431wrm.47.1550161434676;
        Thu, 14 Feb 2019 08:23:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c1sm4142268wmb.14.2019.02.14.08.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:23:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] nvmem: core: fix the return value check when calling the notifier chain
Date:   Thu, 14 Feb 2019 17:23:49 +0100
Message-Id: <20190214162349.22740-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

blocking_notifier_call_chain() returns the value returned by the last
registered callback. A positive return value doesn't indicate an error
so check only if it's negative.

Fixes: bee1138bea15 ("nvmem: add a notifier chain")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb4ef3b..a3bed2d9aec7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -687,7 +687,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		goto err_remove_cells;
 
 	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
-	if (rval)
+	if (rval < 0)
 		goto err_remove_cells;
 
 	return nvmem;
-- 
2.20.1

