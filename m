Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79581C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C202084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWNzKxTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C202084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKZGje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43857 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeKZGjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16729828wrs.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oRfRYlHEgaG55OS5W6e1It4GqkPEPevt7il/gsL1g1g=;
        b=CWNzKxTFw3m7I/y1pYPbiUInXXZDT1zwmBVZCXtZCIHS0nQzHaO41dQzmx0SWAq/kV
         Am/G4hQBDtylcGPHKvl9Iim/qf/HqC9KXd7Iescn4vbHURMC/E9+pC1GZJV5gUJJw1r2
         A92ty+Wm/gYekVego1ry9NdnBFT6BO3WQ6COhWTHRsKlT4PzMZUkAKgk4tUjyTLZ0pRq
         1kEPkF7Cm//V2KPQWE2vORY8c0+ZlGdx8UvcdSu8x0UaBx4kQCtzbgOx8Vr1M6qjOTLb
         2d22jmx1RYWI6Mm5tVVBy2oowmM6nrlIryceJ28Me+tDBoEvdiYKkfH41GCrWZ+OeyYS
         suFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oRfRYlHEgaG55OS5W6e1It4GqkPEPevt7il/gsL1g1g=;
        b=sNm/M6OI3kz1GwcsBKTBLA3doIURKE/xBDD6Umee+BGrJRGe6jnuY7Y43TKwOGPK0y
         UOlIFWep6GOkGoH1K59KB9rxsXj7849WVzER0lz5SVEJiJ1VgQZTeFjR94qM2DQ4IBog
         LJtAX5Tbtr4tJYFHupT8ar6r2p+qe01gleu+Iu0UDDqS7mAoZy828M6ILoFOYAjI4QbW
         Fgxzhh0XQXjatfXdbmX53ZmHWwfD5ILUbezFzcpdGpilcePag+4I9KVeKHkIoWDgDCxG
         AA3lrb9P3bVxxnW0kwymH914/oNFNTISNDO0Pw8P4ZeIkJkWUORf4aeUATeNrHOt2Rz7
         T4zA==
X-Gm-Message-State: AA+aEWYsuytfI7x6X5KtcmeLyrwvDYJ38+NzTr4pI/UOWtTK1mEV+FY7
        x35+YLW7csisMvGr+Cewywo=
X-Google-Smtp-Source: AFSGD/UzgDNs8cnrk5zMmUF9Ak+qlZhXAXCN7Jp/AlkB7JLGKwmBBctbGhSFBjiGTKSG09QR0hCXNg==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr16850230wrr.155.1543175264201;
        Sun, 25 Nov 2018 11:47:44 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:43 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/6] char: lp: do not use return as a function
Date:   Sun, 25 Nov 2018 19:47:34 +0000
Message-Id: <20181125194737.5591-3-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return is not a function, parentheses are not required.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 65bf32244f48..4153c6f5683a 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -184,7 +184,7 @@ static int lp_preempt(void *handle)
 {
 	struct lp_struct *this_lp = (struct lp_struct *)handle;
 	set_bit(LP_PREEMPT_REQUEST, &this_lp->bits);
-	return (1);
+	return 1;
 }
 
 
@@ -199,7 +199,7 @@ static int lp_negotiate(struct parport * port, int mode)
 		parport_negotiate (port, mode);
 	}
 
-	return (mode);
+	return mode;
 }
 
 static int lp_reset(int minor)
@@ -279,7 +279,7 @@ static int lp_wait_ready(int minor, int nonblock)
 
 	/* If we're not in compatibility mode, we're ready now! */
 	if (lp_table[minor].current_mode != IEEE1284_MODE_COMPAT) {
-	  return (0);
+		return 0;
 	}
 
 	do {
-- 
2.11.0

