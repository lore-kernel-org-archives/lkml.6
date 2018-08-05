Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EECC46472
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE3821918
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNCSvL5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE3821918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHEWN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:13:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:13:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so5759748pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G6DseO3rPF5EWlJQKxwhEg8rXradaptvsBm/kTE84M=;
        b=eNCSvL5Cbd+pRghA4wF/TFfqCh8rz6CvuhHV4tu2K1xUfhm3987+Ac1yz0e/gqXn7k
         IeY1hQ92oq+SnMIiROCn2z9dAM18Gni05mUJoK72LJ4m9Ci7nDV6GpZa3HpBCONXuLYK
         YvXIn7mpLzmChrqldVJ44PaDjCI6SFUoxxNhZJje5KXFvIVZJgOplSzRFCUf6SYhxsYB
         +VzI/0S6tRiHvYkrWldWt+1v/nUwENGbuLWYv1PoQM4yD3mhKJg40dXScpK/xYYCrcuU
         O8cwn/j4iMkZdduksJjBv1N8QDOjvN6vidSes8oxpwXYjJWe3GK1QnmAK9xWOp1qY8b3
         Dzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G6DseO3rPF5EWlJQKxwhEg8rXradaptvsBm/kTE84M=;
        b=Kv46JSYpkfpB7TU2oqI1rpjHuBP4kOfT04kOO4VdpUGxXnDVe4+8IkZS7pVyxfPiOj
         ZGmPM+7gy31+G79xTj2ahLujJeHRsnC7VwBGxpLltygwaVVOLbNHY55kQ7zSfa/UXazG
         c/UQTQLRUyXS2xcz1NfsvZCKTMESjZ4t7Y958f7VZoaDEj307mSSJuxd9Fvjrz7oI75u
         OIG5oO0cTtNcCjc8Ko39gp/UAoRj/2dYE7o8/EwUoPLASNJJYshfNjZZUxlwbWIIc8Ka
         jb7p9eRA1aIshMxFlcqbkbNpE7nbAtLZwJ5fcuuJ8ggW2BbBFeIpvbwQ5Mp1/guO3uNf
         8kKA==
X-Gm-Message-State: AOUpUlEA/ylDH7GTHEdy0EYMJVRF8Qy0uRnVpSmHJm9HwH9c19cz1Tod
        zdmdtwaIIxdg8llpijfcN8g=
X-Google-Smtp-Source: AAOMgpci+2f0lVexmOLWwjZS62V2tM+h/WnpLX+09esDnT0aB2fTdnNLUMTlwhR9CLUi2ct9s0idDQ==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr11815391pgq.36.1533499693385;
        Sun, 05 Aug 2018 13:08:13 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:12 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/15] staging: gasket: sysfs: clean up state if ENOMEM removing mapping
Date:   Sun,  5 Aug 2018 13:07:35 -0700
Message-Id: <20180805200749.116693-2-toddpoynor@gmail.com>
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

If kcalloc() returns NULL in put_mapping(), continue to clean up state,
including dropping the reference on the struct device and free attribute
memory.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index 56d62aea51118..fc45f0d13e87d 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -101,13 +101,12 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 		files_to_remove = kcalloc(num_files_to_remove,
 					  sizeof(*files_to_remove),
 					  GFP_KERNEL);
-		if (!files_to_remove) {
-			mutex_unlock(&mapping->mutex);
-			return;
-		}
-
-		for (i = 0; i < num_files_to_remove; i++)
-			files_to_remove[i] = mapping->attributes[i].attr;
+		if (files_to_remove)
+			for (i = 0; i < num_files_to_remove; i++)
+				files_to_remove[i] =
+				    mapping->attributes[i].attr;
+		else
+			num_files_to_remove = 0;
 
 		kfree(mapping->attributes);
 		mapping->attributes = NULL;
-- 
2.18.0.597.ga71716f1ad-goog

