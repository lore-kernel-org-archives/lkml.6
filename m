Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4089C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7513320664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnAd/sfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7513320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeKAJW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:22:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44714 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeKAJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:22:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id n19-v6so4209408edq.11;
        Wed, 31 Oct 2018 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9wez5ygq9emTYIvZbgpHGnwoRGbsHaraoBem95C3dc=;
        b=YnAd/sfUs8fbb+9oyjUQNjMksteFBYqxHkq9llwW3RgXyOrPJZx1Hx1s6M60KRwq57
         2L0kyvpAidazs0VLCV+0CFKhf1LytfeVsM374Qes1MFYPSbUaK8wF2LbagoDhpoP32Z6
         r202m2ZiQuUCfUXu3quYnfJcOTRD9XX2YXoL4XXltgJRZrW2kLxJUGW1PMA32pIovmgl
         qdrhgDgI+HC67kLFZnQdo/S8ra8WK5jLC6/DYghub0XqdC1su5TeNjLRC1FOUNQRP+nP
         +ftL44sHAzIstEtpQEa/PZuIaIi/Nc4M/DCZicTATjlMEhAwj/Gcoaf+wZq8IYX1B6nS
         2iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9wez5ygq9emTYIvZbgpHGnwoRGbsHaraoBem95C3dc=;
        b=GUR24ONIf8lJdQZwptCOTKImxounD7fW4L2lZA7/YDA8fask8tR+2UQZaILyVZgt9j
         t0zopt181usNn478srEs1TUp7qQSB/J0TrjY4EdgHVfs+/BRTrpJrEvt6dOYZWz33PW5
         C7BdbCwSeeumqhxp0qoJmQ3x9ooRG6YP8MooCpO8saj90l7/Tq2GgvQ4+hsY/ThtfZbA
         HCdn4niFgP1wb2Sj5elFiph0HbwBxZo6bXiHeaC1UEw5GvM2YmZQO79bNRXf78xz5ufd
         JtlGyfJuoAeofub4xrJpZYzYpYYlsHPnoD/mtuul8SRf6htaXgP2JqPfNhlU41GSaSxy
         8/lg==
X-Gm-Message-State: AGRZ1gICi4EP0TwWW6c5JNvbrUWSFPDyRd8DjaFEF7TXWAAU2D7imqWd
        ixAdx0hBIlz7uyd4zHH789Q=
X-Google-Smtp-Source: AJdET5emHYts92bH7InW/swN413q/3E97D3tImftf+Kxnb55KPCDMbn6Gsjf+kR7h9xm7Mhqk1pUfQ==
X-Received: by 2002:a50:a974:: with SMTP id m49-v6mr143648edc.169.1541031714036;
        Wed, 31 Oct 2018 17:21:54 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:bc9f::a3c])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2981468ejd.3.2018.10.31.17.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:21:53 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 3/3] asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
Date:   Wed, 31 Oct 2018 17:21:28 -0700
Message-Id: <20181101002128.28884-4-jprvita@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
References: <20181101002128.28884-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Asus firmware engineers, the meaning of these codes is only
to notify the OS that the screen brightness has been turned on/off by
the EC. This does not match the meaning of KEY_DISPLAYTOGGLE /
KEY_DISPLAY_OFF, where userspace is expected to change the display
brightness.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 5a00a7665f9b..b6f2ff95c3ed 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -442,8 +442,6 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
-	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
-	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
 	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
-- 
2.19.1

