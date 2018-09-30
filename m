Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD507C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8CC2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv7jyqBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeJAC2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:28:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeJAC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so6649104wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zt4ufsuDAPJ4oOTQ4beR1DeJ6dggh0Pl9+Earf0C+7U=;
        b=Iv7jyqBcmMIkWqpiaji/FERC4gawdnFbFABPUQubg8KbK/Zsx3onA3SoN+q/02FvII
         C2qNhNbomazFF+y7EkDT7wSV/pIc4XONCUqKISVQB0+zfSnUR1W5eaNkbEVewV1YBMXb
         /5MBkt5kgBRN2ht05SMlHJcjQKkbIbBXsfeHO1oufrjCnnGRlnd9Mk307ByVW62RL2NV
         Rbf5Ih909QfuaopZEGBKzXNjT0Il+bpfTTyRC5Re5H/YScLakKPJfa+vHy3pazdqP+R4
         zmHhXjz+H321gBnFTECe3qBh3kGtjBTBsjJAWtjE2lUsFe8VhEF8H4xbXWZwuCBIN+KD
         2B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zt4ufsuDAPJ4oOTQ4beR1DeJ6dggh0Pl9+Earf0C+7U=;
        b=XRQQKMzS2c58Pnm7Mfp1+ddfGim/ws1tngg2AYry02QHkSG2XAOH1zp1AgzTryqKTe
         rXtjqup+vsMOmrDyPxgp1Pco4VPQ6ROp2/VPN7/bU0owJSCjaWGGIsuGRfLBswuuJfJO
         Bn7dUtwygmWwNfuZcga+LYp1ZXnXoHbyRLeiSFCdrlhI8+HlTYQwsjcNi6NVqA3jDFnp
         k2kZLIOwWRuomzhxXXZhdATyyW1Ck9LdY2uyT5F8bqlf8qe2JNsXS7AFG3VldBfbIUzC
         QnD5kT46mqJshMEG5K6CFFJcMytzUXyYXQYWwrxRsshSEzHTBQUd57AGpJ+4CPHoEBRm
         KWOA==
X-Gm-Message-State: ABuFfojy24zKxhnV4zoJCtnmnEWjriDqSUz/iNohqtgSwkr1q46U+d0P
        YDkzm89WCKo5nrlS0EdmYAk=
X-Google-Smtp-Source: ACcGV63/FzENZVDS/k8JwOaTBMYUsKpVpyRa/P3dxIFMGjdC7jtCL5Q2YjOthY7KFoB1CUrpSzzuVg==
X-Received: by 2002:a1c:9816:: with SMTP id a22-v6mr3132376wme.13.1538337214306;
        Sun, 30 Sep 2018 12:53:34 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/19] staging: rtl8188eu: simplify block comment in pwrseq.c
Date:   Sun, 30 Sep 2018 21:53:06 +0200
Message-Id: <20180930195310.1531-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify block comment to a single line to clear a checkpatch warning.
WARNING: Block comments use * on subsequent lines

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/pwrseq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/pwrseq.c b/drivers/staging/rtl8188eu/hal/pwrseq.c
index 4aa1dec0b5e4..f7890a8f4673 100644
--- a/drivers/staging/rtl8188eu/hal/pwrseq.c
+++ b/drivers/staging/rtl8188eu/hal/pwrseq.c
@@ -8,9 +8,8 @@
 #include "pwrseq.h"
 #include <rtl8188e_hal.h>
 
-/*
-    drivers should parse below arrays and do the corresponding actions
-*/
+/* drivers should parse below arrays and do the corresponding actions */
+
 /* 3 Power on  Array */
 struct wl_pwr_cfg rtl8188E_power_on_flow[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS +
 					 RTL8188E_TRANS_END_STEPS] = {
-- 
2.19.0

