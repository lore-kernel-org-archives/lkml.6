Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ADC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE80206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCGpJ/ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE80206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeILI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:56:34 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35750 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeILI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:56:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id j7-v6so541096qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUSz9toAsBB1IjFCO49DVEMKkUMgFwJp0QpD6lUwQyU=;
        b=RCGpJ/lnaSB6yG37I7XCQbKI3X95LJLZGsWhZbzxNxn9yhZsVaB+Ujloago0rRj1gm
         D5Mh/ycfQTWYoR3hL6qWBfI5P5HdHCWD5QB5FPhtFF2l3xPoErdBb7JgqwFKHu9AGvtL
         2vHYlu7VhjDJukxnC6PwkfgjCqnlQGHOEwxzbEKkzpnQM338OS1jsBhXABWYNbYNKNbi
         0DYAxX1n6oq00QMpmcSoRDKSuqaNOfFnWzSuhdZRmd7ATeO3t7T+PU8rmwTfJr/Rn2kK
         YyC7af5rPmuztiqK14XQ6CkmSV2dDJwXIKAJYBYo099I8/MaiRPfzFDbZ89LcNMsuV2p
         INPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUSz9toAsBB1IjFCO49DVEMKkUMgFwJp0QpD6lUwQyU=;
        b=jQj2GsZa5itw6NGU897gzNarJ/XytBzenV3F3O0ojZXz8deBFp0LiFXSrnfNSBaAXL
         R259jxxH3simrGeKCnH//qQJ3uwucm3WQRg8UNxsT31VTXVzWrmIzzvBJr8FrNlAMW5E
         zvADUBKgwUloFtZVxSIQ+7TAaLYyDUdlqAPFYLmKe0LIBm4MiiWSUB4lWPhu5D7Ol2v0
         kkr2aAOaOqc1YrRLwF90JNeZpwn29njAi6hImusmhiEHZLgF+Wycg5YzarAw3WYid2XI
         /yt80i1RKlE4ZYGeWRXYHbYZjqqWU3j9exfTB0skD0/FF69qJgBMplXKHAhz17EPpktL
         YAkg==
X-Gm-Message-State: APzg51Cv5FmZ+8VUgXYLP0X5iYR4dh+yeAmfjxy30j5dAckYdFtBIGOU
        1vsfe3iXxmxkDAxKUVYqA+0=
X-Google-Smtp-Source: ANB0VdZIYi3nFm4Cm7XAihhqJe2yADs7yLlpG2NQpVLpETBjM7jQ14lP2n3ZYS7vAzSkSTS947fuUQ==
X-Received: by 2002:ac8:4691:: with SMTP id g17-v6mr22540880qto.137.1536724442340;
        Tue, 11 Sep 2018 20:54:02 -0700 (PDT)
Received: from localhost.localdomain ([187.66.107.61])
        by smtp.gmail.com with ESMTPSA id u184-v6sm10692199qkc.87.2018.09.11.20.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 20:54:01 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH TRIVIAL] Punctuation fixes
Date:   Wed, 12 Sep 2018 00:53:52 -0300
Message-Id: <20180912035352.11191-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 2 +-
 Makefile    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 5befd2d71..b82efb36d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
 W: http://www.linuxdiskcert.org/
 D: Random SMP kernel hacker...
 D: Uniform Multi-Platform E-IDE driver
-D: Active-ATA-Chipset maddness..........
+D: Active-ATA-Chipset maddness...
 D: Ultra DMA 133/100/66/33 w/48-bit Addressing
 D: ATA-Disconnect, ATA-TCQ
 D: ATA-Smart Kernel Daemon
diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c..6567bf245 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,7 +93,7 @@ Descriptions of section entries:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
-			much other than throw the odd patch in. See below..
+			much other than throw the odd patch in. See below.
 	   Orphan:	No current maintainer [but maybe you could take the
 			role as you write your new code].
 	   Obsolete:	Old code. Something tagged obsolete generally means
diff --git a/Makefile b/Makefile
index 4d5c883a9..7b5c5d634 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,7 +1109,7 @@ archprepare: archheaders archscripts prepare1 scripts_basic
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
 
-# All the preparing..
+# All the preparing...
 prepare: prepare0 prepare-objtool
 
 # Support for using generic headers in asm-generic
-- 
2.19.0

