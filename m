Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F75920856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HedT5wp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F75920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeGUNud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34184 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeGUNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:32 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so6335624plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hiW2Dbr3eUgq/g4Rbn6WYhxli/PT+BDktrtcY4Ukais=;
        b=HedT5wp8EvV9CUi3pn+2TVNo9N0xfgnTYcGYbcfb+j/QG8CAEszSOIwPngXFb2622z
         3WTs1EqRsFbtBYT9H7broJGH3iedLZspBjMJlvh7MY0izZh8/OtUPIiU575aGHXiVXPa
         TakRy8JCi1qJtOvr3SHfT0TuY+LQpnpEUdIk9c8+FsaT1/a1pcvl7sV/HUoUQ6USOFly
         7l7nenIhDYw/3HS+pYjISa3OVdBXEpTnz5nWrrY7ztkPRwPnVraTRUQZ4RLdbyO/LBJT
         vetUGDN6Ow0/wvYx6xy1Wq+9zXWr119ENVfb+fhEKdpAFCa/bEaCARRpyuJnmRb0KFG1
         CLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hiW2Dbr3eUgq/g4Rbn6WYhxli/PT+BDktrtcY4Ukais=;
        b=iUTusZj40mqNZ8TsAS8Hr9lydA0+ozJKQK3pacA2Zi3maLkxK0LFOsjnSjJMDMUJve
         3JfqztjFkNMQyzHEd8gLAyuMUex3Ysj5aWNU7I+aRic1rtY91Fhu7FcM+DHQsn7ExkLI
         p7inuvHZ/+jBg08KP80pbi3OHK6aSwbq4HzB1/pzFbO2Lvf87EzL38AgtIlFu44LHPLe
         jy8DMZpV5JGxsKBu5aSGVhOx3qwiIzNaDI9c5vYcTMZNCbgwUR/NMaRgB1kn6zmxY1gi
         PDJm0a2NeU5gSmbSYJN7c9LmDGWrTdG5jPjZYTeTEcOFWQQ4PnciY2GcMGbnvsxrWCyB
         ncNA==
X-Gm-Message-State: AOUpUlGd3n55I+EIsZ0LHyVu6jQPhlKx/9uKaFFrsEABFSgre8lHlMUf
        QGTc0Do2/B6BB+Uynmkl7+w=
X-Google-Smtp-Source: AAOMgpcPj+UyBIW1zbIXhIMoypKVigpo1lPhlEghDVmL8uvph2Danzl0h2jXjGvyofuUPQbPVE/SoQ==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr5730364plu.211.1532177872560;
        Sat, 21 Jul 2018 05:57:52 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 11/20] staging: gasket: fix comment syntax in apex.h
Date:   Sat, 21 Jul 2018 05:57:00 -0700
Message-Id: <20180721125713.88501-22-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex.h b/drivers/staging/gasket/apex.h
index 4ef264106f503..d89cc2387b7d4 100644
--- a/drivers/staging/gasket/apex.h
+++ b/drivers/staging/gasket/apex.h
@@ -22,9 +22,10 @@
 
 #define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
 
-/* Addresses are 2^3=8 bytes each. */
-/* page in second level page table */
-/* holds APEX_PAGE_SIZE/8 addresses  */
+/*
+ * Addresses are 2^3=8 bytes each. Page in second level page table holds
+ * APEX_PAGE_SIZE/8 addresses.
+ */
 #define APEX_ADDR_SHIFT 3
 #define APEX_LEVEL_SHIFT (APEX_PAGE_SHIFT - APEX_ADDR_SHIFT)
 #define APEX_LEVEL_SIZE BIT(APEX_LEVEL_SHIFT)
-- 
2.18.0.233.g985f88cf7e-goog

