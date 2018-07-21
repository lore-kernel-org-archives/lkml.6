Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMoePVAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeGUUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so14098166wra.13;
        Sat, 21 Jul 2018 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kN9n0PrhQwGth982mv27AcZIZq4LowLYQ8bufArZCyY=;
        b=cMoePVApHMX+ORL5ec/As+Aw479/lxyxs24N/6DhqJzVH8dz4N8VL4YEf9JFXmvz/9
         JpY6n5VkZyxfubwswCcVFxb5wEo1YxrxE/pNFzW8NZ3fIfgh2Lw9Qh1CNdXrmkFGSZGi
         bPPFyQcisD5NeS64+RmzCDnytMTHDR2tu/oClWF1QeUdZNV4oqdykhNMyWEXIUTJwIZ9
         kDOyWwI7GCdqNfl6Htqh9ccoMp0viFa1MnU+ZEhr/BBJU6jEUzxpVZK3JFr1EIc0dGV0
         0TV/xLYY7SDjJ8oTvRYpaPUm0S9+B8Pc5tE+iSlR3OMQjAf+Sc5s48Ss+fmNDbavxOPM
         rOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kN9n0PrhQwGth982mv27AcZIZq4LowLYQ8bufArZCyY=;
        b=qUlAjE415ZlOMBo4UVAF/UHqQnu16UH3nntyQtGwOmMNYSeewKgRWVQThOm/cReF6W
         MAcDs2nYous6p2jCYWnfOxEXqjOlpLhw7bKWB/kfQ39hoC8h7WvvHf49zUSR1dnwV/Xv
         CSeet0AagtrDYFm61RuRZ5tNrL4XOLBS20PTFzjn05LxyoWPHAWjOtLHABbN9v2QIv8j
         8iuO/+eazgnkm3vRaaF6/cAG9e0DO0hz8V3FY0tQyEYyQ5cV0AN7S5hVOw3FdIqTljdX
         mnH69+aHWugjvvJX57CIPZSkqVyLMod+P0UtBIHYgndEg91xuV1cx6De2pIAjRJYQIgL
         pUrQ==
X-Gm-Message-State: AOUpUlH/LML2U7M0lFOTJpJjB6omYjwlb0ZDWpZls8KhhFANh43DgtPJ
        dzytYCOChjWN58SemjyXnLo=
X-Google-Smtp-Source: AAOMgpckP4WIJGdrvjBOIxV2cm4oPZgm5hk722bQ8UuHccnOGuCW8lKdx3olWTk+hJBuZtD70Canlw==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr4609547wrb.204.1532200252355;
        Sat, 21 Jul 2018 12:10:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:51 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] touchscreen: mc13783: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:47 +0530
Message-Id: <20180721191029.25658-6-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/mc13783_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index ef64f36c5ffc..4e33349f101e 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -25,9 +25,9 @@
 #define DEFAULT_SAMPLE_TOLERANCE 300
 
 static unsigned int sample_tolerance = DEFAULT_SAMPLE_TOLERANCE;
-module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
+module_param(sample_tolerance, uint, 0644);
 MODULE_PARM_DESC(sample_tolerance,
-		"If the minimal and maximal value read out for one axis (out "
+		"If the minimal and maximum value read out for one axis (out "
 		"of three) differ by this value (default: "
 		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
 		"is supposed to be wrong and is discarded.  Set to 0 to "
-- 
2.17.1

