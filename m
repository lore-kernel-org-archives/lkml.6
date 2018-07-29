Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9A5C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39920857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEzudPX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D39920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeG2Sk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54612 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeG2Sk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so10542488wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4x7RuylqcI+40EpLni4YbXnwf4Sk8Q6oFoguQTRWis=;
        b=CEzudPX5EflHK50h7c+Y/s/nNiiMNRTPYetuXFzUE+3VQvvhPoUx9Y8rgboM73NmEd
         AJqwNUptYUXJSyL3Th/h6PTjFswEFANcsNJkADa0AyuGXXwIswmG/GuRvjBwHYhgFrZa
         t7qeJolJukPBSpYS7jln9FKbrF+hJdrpXrHywMcP1dVONVT0/bYGAV92KGHL5ipmP8eQ
         tF14B7Oy6U6SZdTAH2lcpDsHNQS+6MNoApgay9FIPIWTgXtH3pOQasK0H9KKtEd+irDr
         jc74dC9YZ03XKySGZH3QD0Juc36aTOugsV73qNxUFn2yGCs+udWq9x8aOCrcecneZBOj
         dC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4x7RuylqcI+40EpLni4YbXnwf4Sk8Q6oFoguQTRWis=;
        b=DN8M8B6Ju1wOWwJzQwgKqjvKKrWvAWEfkqlNoABNmK2qM0gde+DS7XDlIWKLtevn4G
         FbqiPQ426oRoKh8Lj2y3i8bhtoKFs7HVfBiFEzooQ5oX5nwVHjJS+4VsSZOB2G4rS4Oa
         +xiLPK/MV2c/mpFTlncwYaM6D8Ue6XbgvhBvJJwVAYYuL9PeVA7wqXe7aAjQqga5cAjV
         ahAk5nLhAJlkoEgjtxk7Rn8OfQFXcIqyDXZrDSyQm+aHqcnnm/gpZnmT6FSiUCbXLsh5
         tPPo4BOp9gTHyzNU5kWFqz9bF8BcFfJybkURBHQi2Keo4SWV5aJ/OzWYVLOwOPid6z1a
         hOjw==
X-Gm-Message-State: AOUpUlFIPMqf6CQem9ka8bOR6se1vTLT+7KQ4Fa1o6KSdU9fVWQS+4A/
        7SBSIBs/bqd8T6gTKar8vNX4Dm+f
X-Google-Smtp-Source: AAOMgpfJi0H/qi0/w6LGL87j6TO4P0hee1B+jReXHN1DTXw/K/aqAW69BhSCuRRwQWVraNOdU63Snw==
X-Received: by 2002:a1c:c912:: with SMTP id f18-v6mr12443730wmb.73.1532884161542;
        Sun, 29 Jul 2018 10:09:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: replace tabs with spaces
Date:   Sun, 29 Jul 2018 19:08:48 +0200
Message-Id: <20180729170851.2581-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in function definition and variable
declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index 0baf4e616b6a..c43e7b438058 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -8,9 +8,9 @@
 #define _HAL_INTF_C_
 #include <hal_intf.h>
 
-uint	 rtw_hal_init(struct adapter *adapt)
+uint rtw_hal_init(struct adapter *adapt)
 {
-	uint	status = _SUCCESS;
+	uint status = _SUCCESS;
 
 	adapt->hw_init_completed = false;
 
@@ -34,7 +34,7 @@ uint	 rtw_hal_init(struct adapter *adapt)
 
 uint rtw_hal_deinit(struct adapter *adapt)
 {
-	uint	status = _SUCCESS;
+	uint status = _SUCCESS;
 
 	status = rtl8188eu_hal_deinit(adapt);
 
-- 
2.18.0

