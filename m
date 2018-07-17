Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF156ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A2A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWruVVLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A2A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeGQCkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33047 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGQCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so27216399pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4vI3ThfI6wnQvrRD92mDNSgcOf+uT/aJeHrGY+htzE=;
        b=bWruVVLPQN/M3YQoJ0ixG/fl5EZaGn6LVRbcgVi0wLecT4XQS6RSRfRNIX9iAk2jKO
         AoSx8EGpx1k6h652gYAQ13F9lB5RrRba/Toh6ze4Nai7owm5zjEH3wUAtyr1vpxvjUll
         V3RcM+2XdlxX1I/VJwlOsjSDWvJkbG1ggErefRVnB8sJhTPrkEIAl1ejqZtf3TzsM5Uw
         GfI/JrPY4ZLWWOq90Or7Wz1i1SpqVWhKq0LcI2+WWwaz9Yf/d2FW0k7kpZlgvdARt201
         AoxujzSZEeRZ+FGr7eiv+QSiY/US2ShE/6VeYvL/64ebybzVUGKrpC4bi7B4wJ/dhnko
         axQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4vI3ThfI6wnQvrRD92mDNSgcOf+uT/aJeHrGY+htzE=;
        b=GFqFCmPQsIvJfQeyzicrcUIjIeGqFZ5/OvP+ptwaaGYacoFRYzABFQA60vH5ZnttpV
         00h9Z/JAVNC2EwWJiAb6XfRv3BBiHY6Ti/+D5B8d74Pa43kqXYHleqtIwcOyO1UfQvmJ
         cN0xdnpYzVCCW1nXlYQqP2f774kj+qwdwj8cEnyesOzdmptBrhoLlMuADpC8qlrVsF9W
         VNe1JeqMX4BEfkv3ELOnEZGxrHEEDuAy432o3bIDvok2BY+VOowfEYnmucYmrZa7PijI
         b75uIZIli/3MUnVnVO9w0GzUe74uqHjT/PhT/IY6WUgB/LUsBcEm+42kJ5OozMfg6tGn
         wFvA==
X-Gm-Message-State: AOUpUlGh8UrHIwn0vQgqYi2TDn2lFaZXFzleXETSCT7ifKrvwy5VnchO
        zcCyDQ/oUVk67LAGDX9/z8s=
X-Google-Smtp-Source: AAOMgpcB7XvaYW9sPrEjF5RMM8Q/H2PWb83SHCoanGuu0/yH9KaKSQaCgjWTd3a7MvHBU/zgh0eRxQ==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr17839197pgv.20.1531793426338;
        Mon, 16 Jul 2018 19:10:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:25 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 28/32] staging: gasket: fix comment syntax in apex.h
Date:   Mon, 16 Jul 2018 19:09:22 -0700
Message-Id: <20180717020926.176408-29-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
2.18.0.203.gfac676dfb9-goog

