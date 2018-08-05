Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FAC46472
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AC921916
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvYQhjre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AC921916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHEWOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34003 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so5225872pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwnDCyJz+dWsH+0j9AKlU1tsmISAsJ2kN12TYVstnEs=;
        b=WvYQhjreAr5raOqEU8qqITkFCY5+TyTGw7ZyDXR3G7AH4V3nzQnj3G6pMqsCMMpzoz
         0t66pda6c0IlFSoc3jSaEe0XPONkCHOzKXwsv2s1whaS8ZhwiLJO7BWpgPP4XylGlrOc
         cbNaC43w+8jPeLG7lor8TD2TLqRucFVAVCw5IfdIKTpltZubySATLjEyi+2iEYDD1e5G
         y6xhB9rFYu/xfdvAYG+QKGAhTTX+p+9G++zIOR6DRI/s//s1tyTiKkiEMYMJcXct8fep
         BE02P4gWJwQ+B//zrj11Jm9dkBZHbdkMpRiVXccVaw0I94P6g+U36TJXKfH0rSd2hwts
         On0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwnDCyJz+dWsH+0j9AKlU1tsmISAsJ2kN12TYVstnEs=;
        b=b/9XsoEnx92uRQ2hSUKGKzjJolyQvx5955/6yWesy3CmZG/AmOCGE7W9qNTi3zvnTH
         mBSS4qYBATuEYLkRzrh/DeSUUsvF5imduk9/313g5oZWvd/2qAEL1Eg3sAupcd33LHxH
         GRjRJ6qgF3kF6VSj+zkNFi5xx34aA779Kr6P75sHgCQnoHmj4BUsfKzOSHoLEdTqXQ9k
         rZnuzbDF1JRGKvxprvg5wqDd/UlStTmLtA+qlGu4UislhVySrziWvTrL+DkL/zobL4tV
         POe/5qoj42/1HSL+eKij186YXxVyJ6o1nE+ZMAV24TnZdTvFD6h19+Bn8PuwtlRwEJqg
         o7qg==
X-Gm-Message-State: AOUpUlH+SsnmK8ymZ0ece4F2ob34xtN8U3UKLPqU1wrA+8sMkwgWW8YR
        Q42GW4MpdiBdL4ClXCwuPHqGlvX5
X-Google-Smtp-Source: AAOMgpf2jxNRfOHibP6u85GxinAG9ovuLG2IL50Xgt1KkhqSkYXut9+cHCFViNgeZ0h7OPr+i8DzKg==
X-Received: by 2002:a63:220d:: with SMTP id i13-v6mr12213226pgi.212.1533499699490;
        Sun, 05 Aug 2018 13:08:19 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:19 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/15] staging: gasket: core: convert remaining info logs to debug
Date:   Sun,  5 Aug 2018 13:07:38 -0700
Message-Id: <20180805200749.116693-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remaining info-level logs in gasket core converted to debug-level; the
information is not needed during normal system operation.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 01cafe1ff6605..2741256eacfe8 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1819,7 +1819,7 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	g_descs[desc_idx].driver_desc = NULL;
 	mutex_unlock(&g_mutex);
 
-	pr_info("removed %s driver\n", driver_desc->name);
+	pr_debug("removed %s driver\n", driver_desc->name);
 }
 EXPORT_SYMBOL(gasket_unregister_device);
 
@@ -1827,7 +1827,7 @@ static int __init gasket_init(void)
 {
 	int i;
 
-	pr_info("Performing one-time init of the Gasket framework.\n");
+	pr_debug("%s\n", __func__);
 	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
@@ -1843,8 +1843,7 @@ static int __init gasket_init(void)
 
 static void __exit gasket_exit(void)
 {
-	/* No deinit/dealloc needed at present. */
-	pr_info("Removing Gasket framework module.\n");
+	pr_debug("%s\n", __func__);
 }
 MODULE_DESCRIPTION("Google Gasket driver framework");
 MODULE_VERSION(GASKET_FRAMEWORK_VERSION);
-- 
2.18.0.597.ga71716f1ad-goog

