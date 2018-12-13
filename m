Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89953C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E3C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgZ9J17R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E3C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeLMS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:26:27 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38488 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeLMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:26:26 -0500
Received: by mail-yw1-f68.google.com with SMTP id i20so1214076ywc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lcpo9vkJaU/B4DRr40bY8llUuPtTjVRD00OqQ9pC5Zo=;
        b=dgZ9J17RUPUsqOOMfwvpBt5e4f74oO/VZvzdKi3C7aPTbDQKiPcbF6JWqRgJLXMGUx
         koHMvOjy0Daf7pL+eQ1K09oTyfZ7w7R8JOU28p/6e+QGX4gjslGSQehQEqKn79HfIMwF
         KT+1YE5AftrG3MdLwZskFK0pTF/9m1Pbu6qBSrICa7T8FXI+uhJXyNc9TH9NWxx6EKM1
         +iqjJVj1De9r/9AniE6J2r49THX5Njcm+Rd55egqi1jdM3ORoYnO5sD4j7/whbKwuM7B
         1Wkj59UcbkYcdmOfvi5tfj09NB7sdOIZ1xR2k7AQqFUufS6BouJFGNztFu6Qyk+ickuC
         8jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lcpo9vkJaU/B4DRr40bY8llUuPtTjVRD00OqQ9pC5Zo=;
        b=LLgQfgXNrFCFe4zXk91nrip4Iuao+OCPU/YKHvDuFRPZNVKcXmnowKDJ064bKPSwPb
         AlVT98KZD3pL01iVSj4/g4NOD/5La2+tqvfT6FQcoR5Frcugx6dNIu/xuI3GsBgkxagY
         T8TM/P2ik3K+F8Ybmw4AarovdDjTzJxPc3As8LGrtEaCwS5B/FxqXZ2LtQfWcxa/MPjc
         ruqiDND7EBfw8fbUipYOKiaOyJjzUw9y6J5lljo4LRVqMRPA3uWf9t4ZAAUo3NDr552f
         8qwMqoaWW/5iePhb6rrP5aqS8XoAdi9P21YUjiwbw0nLKFqwaeKH7dF2Nxsk5wKlXLar
         D3/w==
X-Gm-Message-State: AA+aEWYTskiz1vC0wKv4Mb542FUo8qqdcS0SodkKdlm6JVyvmgXn/jWw
        qfyPp/xwwOGUWuMOH/HlqvU=
X-Google-Smtp-Source: AFSGD/UC9mxyyUIeO5pDvQMTLYWfxQnQ1DDjcnNSdQsHBZdqgGl7EcwzeKVJBRq2aTOW4qxN9O2Crg==
X-Received: by 2002:a81:b623:: with SMTP id u35mr26337540ywh.177.1544725586238;
        Thu, 13 Dec 2018 10:26:26 -0800 (PST)
Received: from ubuntu ([67.191.186.148])
        by smtp.gmail.com with ESMTPSA id u84sm786258ywb.12.2018.12.13.10.26.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 10:26:25 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] Staging: comedi: cb_pcidas: fixed a spelling mistake coding style issue
Date:   Thu, 13 Dec 2018 10:26:24 -0800
Message-Id: <1544725584-39138-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
index 8429d57..02ae00c 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas.c
@@ -116,7 +116,7 @@
 #define PCIDAS_TRIG_SEL_ANALOG	PCIDAS_TRIG_SEL(3) /* ext. analog trigger */
 #define PCIDAS_TRIG_SEL_MASK	PCIDAS_TRIG_SEL(3) /* start trigger mask */
 #define PCIDAS_TRIG_POL		BIT(2)	/* invert trigger (1602 only) */
-#define PCIDAS_TRIG_MODE	BIT(3)	/* edge/level trigerred (1602 only) */
+#define PCIDAS_TRIG_MODE	BIT(3)	/* edge/level triggered (1602 only) */
 #define PCIDAS_TRIG_EN		BIT(4)	/* enable external start trigger */
 #define PCIDAS_TRIG_BURSTE	BIT(5)	/* burst mode enable */
 #define PCIDAS_TRIG_CLR		BIT(7)	/* clear external trigger */
-- 
2.7.4

