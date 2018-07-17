Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F61ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQGXUtCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8B1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeGQClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:41:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40624 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeGQCkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so13843666pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVeH5n1Steh+nCSUwSglA8tJJ5RPowz1UxONv6zWlSI=;
        b=oQGXUtCuiORgjD6gLV4pUuZdTV5BU5/aJc0SV0JHMpYNMBzxLBOfo/Nyfhe1oNscZm
         EEqhz6gLUJLVO04PzlqzH36A9HVYIOjMmoMlfrvdfiZ2CC1h+WMKa3XI+91Bnce90ovm
         KMcnxbemJ1y5R5TmBnaNCUcGe7ezOzk66xb53oGWJ/Bv+0FbGvaAXnWS/w6q7SBi9se0
         CVAIZv6yHG3HHNYpV6dyhOa0JLPeo2PjRMpGRqA3OA7gBbaM0d2e2h1KE7V3A/1OBeDq
         trko/C0gu5fDJwSjeKFCZz2/5O+FpVlqZNLXaX/bibAsRWbfgmyvTBXMUdqIMQipUUkI
         6dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVeH5n1Steh+nCSUwSglA8tJJ5RPowz1UxONv6zWlSI=;
        b=DLlgPQJoYkNE8sTfZBQcBxzyB08QUzE9eW65oM8NQlS68jgVxPZXW+uuiN3SXksmHu
         VLyUX/pZRRxTldZXnGR5uKZNHGunc4rsoSPHIY9JIrzFi4i8/GxPgwaLnLT+MJgZQicV
         fti39jqzUnBpTS3K2bd43rSNh2lHZR87GTG5pZDX/b119Zhjq4Ee5iQrnW7pmXUq8U76
         DL94OwQHGiZRGXswDAbdzjOHcjlBOgl7qzTgcSqSqALD+YnkH8BvEBZOrzihXbdTewia
         b/Uf7nCsyTaBrnL4ms/VDKBZdROGSTKR/wA+Vv2mUKgpgcXm+pvmDgoaX6B+rLh5sL/V
         DYQA==
X-Gm-Message-State: AOUpUlGSM+SXkGmKH9xo7DGvfOWvC0gvAiRJDDa8up+tLuVu5STslrgk
        r3UQfKvdN9czjnSiXbiNEtw=
X-Google-Smtp-Source: AAOMgpfciSehzMaJ2fXLXBTGjrTL8ujHNEZ51nwZheVZ3ZzcwkLQYeSZKBuxEy5RjcmzXHfbez0NpQ==
X-Received: by 2002:a63:d704:: with SMTP id d4-v6mr17611093pgg.312.1531793421934;
        Mon, 16 Jul 2018 19:10:21 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:21 -0700 (PDT)
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
Subject: [PATCH 25/32] staging: gasket: apex_ioctl_check_permissions use bool return type
Date:   Mon, 16 Jul 2018 19:09:19 -0700
Message-Id: <20180717020926.176408-26-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Convert from int return to bool.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index a1fec53d152b9..81288aae02d88 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -141,7 +141,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type);
 
 static int apex_get_status(struct gasket_dev *gasket_dev);
 
-static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
+static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
 static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
 
@@ -626,9 +626,9 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  * @file: File pointer from ioctl.
  * @cmd: ioctl command.
  *
- * Returns 1 if the current user may execute this ioctl, and 0 otherwise.
+ * Returns true if the current user may execute this ioctl, and false otherwise.
  */
-static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
+static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
 	fmode_t write;
 
-- 
2.18.0.203.gfac676dfb9-goog

