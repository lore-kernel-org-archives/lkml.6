Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F63C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C82620850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpBCCoZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C82620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLCWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:54:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLCWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:54:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so2406679plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeEP0u7Oh2ap/F3/pDIZ557Zp4+YYiiRmpE0cGoJDDQ=;
        b=gpBCCoZqaZGixTp2Tn6L0qZvdMC2NJaHvCVVq0V9mPCdDyoF7oE2iwIk8Z6mtUwt0s
         Bqhgucbzlxkf5QpWRjUENij+Cbmxif1yH3Ul9nUD9g8qb0RO8oFwhC6gvRc6N0atsyQC
         6bN18zFopFGvCuenUuL+NvCSjWX3juIV5nxSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeEP0u7Oh2ap/F3/pDIZ557Zp4+YYiiRmpE0cGoJDDQ=;
        b=aWv4wcDCOVroRptUHNFa0X0Os77CTAaN8WVIo3goiCvl2wDUNkkmwLWavBcCP+kR7D
         6kigkfJAH8ktCOTluVibEAEY56bR/SKcs7OjXvSCbCelfVHJ4gZfRFgIcj0lUVuxuwM5
         1BMIC9iGwxpqvHBYZWXsWCHxoo0Q612MJX/UtgF6RtKa0RjHDO65GDy0/qdJ9S2vXf3a
         ivDZqFgxb5F69dYnKM7qclU2z94HxD9Vmyv2IHqOsQ0kp7akAbn78LN0zX4OhIZ0iOwh
         5u4BJ5FnXoAPhpACJqsP9613SYY9JTBHl+Uf+RUS0QTAre+rsEDEWQsdrkAB9wfqRBF9
         em8g==
X-Gm-Message-State: AA+aEWYZSpno0UKjeUrKSPG6hZBo3p18tjfCbamTh4A8/4wYLTH0cghX
        3WsqS+6YchAy4uuTnDVSpGKqpw==
X-Google-Smtp-Source: AFSGD/Ubuwie2HLmsWsoIBRbyAGnfxK4fpNITBNHiGYAYgFudf6p1ypDswdSGpgJNkUABd+6hrjVUA==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4mr11461293plb.191.1543877669111;
        Mon, 03 Dec 2018 14:54:29 -0800 (PST)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id w3sm17867264pge.8.2018.12.03.14.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:54:28 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     bleung@google.com, bleung@chromium.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: platform/chrome: Add Enric as a maintainer
Date:   Mon,  3 Dec 2018 14:54:07 -0800
Message-Id: <20181203225407.173234-1-bleung@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric has volunteered to help me with maintaining chrome-platform
as we change the development model toward strictly upstream-first for
any chrome-platform and cros_ec driver.

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a31c3a833763..8293efb566d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3549,6 +3549,7 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
 
 CHROME HARDWARE PLATFORM SUPPORT
 M:	Benson Leung <bleung@chromium.org>
+M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
-- 
2.20.0.rc1.387.gf8505762e3-goog

