Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C6C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 02:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE68021A38
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTGXT6aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE68021A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeHLEhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 00:37:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34105 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeHLEhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 00:37:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so5533245plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8cLyheqhBcsxd+uT2PiUOI2zJpPwZIO9aZZcC29dn/0=;
        b=OTGXT6aIHGZOKrKu9kL0VLttUVu68GFDRsZYZrZ6kP6DvFUegWO7p3w0NeNoaEE8Dv
         f23aKAD27shlMd4yPkWDumaGpZvB+4qymg60/oWsqOcVU7FZr7qb13CSkmO21Y5yMHbu
         IccFwkhaQVDVk4b2f1vZvgvlOqEwA2PORBfVW6m1MNXfk5XwfZr3fNVawh4DpvtnimZv
         zTFc2Mpx5j2BNCIPjKiP80/RbFZefpZZXVkOfFGIXd5C804DddqmnRynT5cFYKLJ6iZe
         ywArUQ7XRINf6GXnichmPQrenryDXVWXWN4BCmIBDPEYE96rj6NxNftpVjlLX3xHiOvJ
         mcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8cLyheqhBcsxd+uT2PiUOI2zJpPwZIO9aZZcC29dn/0=;
        b=a9BI3ibcOH65qoK5cyWYIx+yVDJIPusnrPGhooczEHu4yTaH+kjk6OVBPdFX8g8nzy
         SJLwG4XDwU0w87Qm+GVlWxqH7FSF1u+5AwGYXLyDUNONYv8Py8ovOTndxl9Ax5udoSNy
         mQK+1+jswHboJN+1hQFvoXeVEBFLuA6gd1PdzDv+riK1qgcYM/AI8p7HDXX2HX4Cvywy
         KqcFXiOMR0o/k590IYOY4GY7zooI0s2BGOVeTZ6ahkPhGumfoHMfNB9ae2ZZZt9yYq1R
         NBkcw4dStVVmwzFrCGvylxz++AR+yhJ9T33DODNQm4IeL7HYxjoAjTg0/KbblOlj2gBN
         HQLg==
X-Gm-Message-State: AOUpUlH/ldINrA0HdsV80aq1+x99rA9RceVtWLkrLZLH25p8NmpA1S+8
        yL4TQwK4BlKMgoYGYo1SC3+2RMP5
X-Google-Smtp-Source: AA+uWPyPGB+VZjDF0kDjteFNLaqiuGKIXaTxY/ykCUrwx4C0Prm3tVrVj6wVN98Ril2FVj517ssVag==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22-v6mr11578132pll.24.1534039287078;
        Sat, 11 Aug 2018 19:01:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:877f:9499::3947])
        by smtp.gmail.com with ESMTPSA id f90-v6sm23121928pfh.168.2018.08.11.19.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 19:01:26 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] f2fs-tools:: Use srcdir prefix to denote include path
Date:   Sat, 11 Aug 2018 19:01:18 -0700
Message-Id: <20180812020118.9633-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps builds when builddir != srcdir

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 tools/sg_write_buffer/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sg_write_buffer/Makefile.am b/tools/sg_write_buffer/Makefile.am
index 922c328..19c438d 100644
--- a/tools/sg_write_buffer/Makefile.am
+++ b/tools/sg_write_buffer/Makefile.am
@@ -1,7 +1,7 @@
 ## Makefile.am
 
 if LINUX
-AM_CPPFLAGS = -I./include
+AM_CPPFLAGS = -I$(srcdir)/include
 AM_CFLAGS = -Wall
 sbin_PROGRAMS = sg_write_buffer
 sg_write_buffer_SOURCES = sg_write_buffer.c \
-- 
2.18.0

