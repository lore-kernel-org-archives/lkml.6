Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,TVD_PH_SUBJ_META1,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23267C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D9218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzB26dDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407812AbfBNQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:01:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502485AbfBNQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:01:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so6869177wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/luPbIaWn/o1jbjpJm684Y9h7+/FjogTtlIIBk0uBg=;
        b=IzB26dDEpEUV5HVpWtC2ecd2dQ6lnLwfGLrAyxoGL7tyWnidfv/uX7c6Gpd7kUVd7r
         j1IfCCoS/fApdCBbc+BaFwcMdeqQpukJyaeoqZV8H+epgLmVwSYxUdf+c8Ve28QFbn2g
         KIru1PVyBjks+/+GFMLTtz/ZnGxH7xbDZzZaMBJvAVs0lrSCe4ycBJ4p3Q8Sgl1q+wLd
         h22ztQ551zO6XcgzCT/e90FSYAR9RpSSBoqr2R93Nd5Ud+UV/SVfQlwUdsggeqlu75W5
         OoCPsayAffzI/dlnv/0h1Jkj9DAn8w6etL+XzlM2yVPPK8F6BHiTZuwnL1ERj1ZtRUq8
         51RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/luPbIaWn/o1jbjpJm684Y9h7+/FjogTtlIIBk0uBg=;
        b=qFFJXUCSHQ2fkieyzm5OS6KkipfDPcYAcymJYsuFExld8uqmPyet9UfP9G4+xQs1WT
         eWp8mDScXDrJaXtFZtLdATskPlKbdtRFmHS+QQOklrzWtPrTyUXwXQfuREDDjD0vS3Tb
         6RcClsLTxHq0a725Wrhpwm5NDhUNe5gyMAIH4WbtFa0jz3YTea69pszH9beBUndJsPGl
         fVyGKAHazK0k7tRV6MBixsuhpDO3XNz5A0gvYmjpju4oN7Vw3JzNN2hhuul5Sf0xN/xX
         XP4qaBxE9dZyqcg5YfdAKPf/v5fglOTA6ZrEcGiWiwWdponN31WyByrnL8qXosMfDNpW
         dSzA==
X-Gm-Message-State: AHQUAubWOfcMC6GHHFbGJpS8io1RS5zkYFGUnlhCyLpfcxNhUfJ1Yvaj
        D/7y01+ocN2rjCwHFLVxfv4=
X-Google-Smtp-Source: AHgI3IYHSADxWr1n7oDzGQD5oJX8FhCsU47HPr2TojZM1NSuAgo8c9yuCE+zIksIG61C5eQ+rQ5mRg==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr3417873wmc.92.1550160105440;
        Thu, 14 Feb 2019 08:01:45 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u15sm5092855wmu.17.2019.02.14.08.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:01:44 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v5 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Thu, 14 Feb 2019 18:01:14 +0200
Message-Id: <20190214160114.26314-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214160114.26314-1-oded.gabbay@gmail.com>
References: <20190214160114.26314-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The habanalabs driver was written from scratch from the very first days
of Habana and is maintained by Oded Gabbay.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index e818eb6a3e71..03f3d67126fc 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1222,7 +1222,7 @@ S: Brazil
 
 N: Oded Gabbay
 E: oded.gabbay@gmail.com
-D: AMD KFD maintainer
+D: HabanaLabs and AMD KFD maintainer
 S: 12 Shraga Raphaeli
 S: Petah-Tikva, 4906418
 S: Israel
diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..ac6fde220d2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6647,6 +6647,15 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
 F:	drivers/irqchip/irq-renesas-h8*.c
 
+HABANALABS PCI DRIVER
+M:	Oded Gabbay <oded.gabbay@gmail.com>
+T:	git https://github.com/HabanaAI/linux.git
+S:	Supported
+F:	drivers/misc/habanalabs/
+F:	include/uapi/misc/habanalabs.h
+F:	Documentation/ABI/testing/sysfs-driver-habanalabs
+F:	Documentation/ABI/testing/debugfs-driver-habanalabs
+
 HACKRF MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

