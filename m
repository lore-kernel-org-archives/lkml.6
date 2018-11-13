Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD38C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3212223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4JjvajD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3212223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbeKNI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:29:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42661 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:29:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so9825447wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlzqQztw5ybxsZPNf7wxGDOGdt0sdpBNZnWupQ5Jun8=;
        b=b4JjvajDk37ehHPWzQgoKT38Bsa2zRom7ReX20K9QE1N6sqQyuyKa+suliy01yXRZl
         9sG2ABgDDWiTu/PZVmXNZl0NHRzc0vO8p4JSwL+BxoDyk/eq/3eC3u29Xx7pSr+TAiMf
         2tNgXzUMJI8XvlBLvZjJY1iKVu3483wxAT6411aHiP1gatXNMEVNHzI4Yi/OJlJBRNUs
         ajoEwQXejpnKVHI47bJGX7BUzxsz8Fc5JBD4TQXAvP06E4ztuzemjee2uuPL/c9weT+j
         6nmIY7nY/JeVqZbtdlB19JNAOGujEHf3RO3tI9QMAH74cb6kIE8lcT1b78UQOSG3FAco
         rg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlzqQztw5ybxsZPNf7wxGDOGdt0sdpBNZnWupQ5Jun8=;
        b=SjQEJ4CNaVmEKMxdNFdb6dNhIU8KzUpZejp6YCZaKqkMSaDKfGSg1BZthnao++brf2
         zg5PzSXLIdydnzQsbY+oiybfefhTuFlemVNqktvMn9j4fdqsg3OdSDL691uuzzhXVv/s
         yDoUwWnZ0BddQdkWAfHW7mNRLQZWiShgLDytpOcif/vid7Zy2P8TzDNPHU+QhQugBWNa
         euYrHxCT6SgrA+aJC0C6FfZu8hQa4UxYC0MK+3oR4/WxleAi0u56ffcM95vUX+NZSDNQ
         nFJYxn+kC/RRPqfby+C8kMBKkIBY+mJeaWFVptPjWGDQ5bREHrBM35/VVC2heZVTM8UK
         Y85A==
X-Gm-Message-State: AGRZ1gL7X3BUIuifG3pphuH+ROjOVrJxqHDsXfMMEBLLPrlrInil42CV
        Wn9JpRJgkUtLqbO77F7MbJY=
X-Google-Smtp-Source: AJdET5d4lj8VQg9kWYG1fEHrGSl1n6b7iBymG6kRg78QilOdUofvXsEoQnzuXmQk8RVmZf4A+YQtVQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr6249862wrp.92.1542148125140;
        Tue, 13 Nov 2018 14:28:45 -0800 (PST)
Received: from localhost.localdomain ([2.236.87.61])
        by smtp.googlemail.com with ESMTPSA id o15-v6sm17818440wrw.47.2018.11.13.14.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 14:28:44 -0800 (PST)
From:   Paolo Cretaro <paolocretaro@gmail.com>
To:     tytso@mit.edu
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Paolo Cretaro <paolocretaro@gmail.com>
Subject: [PATCH] drivers/char/random.c: add missing include <linux/hw_random.h>
Date:   Tue, 13 Nov 2018 23:28:11 +0100
Message-Id: <20181113222811.6724-1-paolocretaro@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/hw_random.h header file to silence the following
Wmissing-prototypes gcc warning:
drivers/char/random.c:2346:6: warning: no previous prototype for ‘add_hwgenerator_randomness’ [-Wmissing-prototypes]

Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0a381897e4a5..02c65dd417ae 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -265,6 +265,7 @@
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
+#include <linux/hw_random.h>
 #include <crypto/chacha20.h>
 
 #include <asm/processor.h>
-- 
2.19.1

