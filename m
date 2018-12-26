Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0015C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F66921720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="chPktIXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLZBwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:52:01 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54788 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeLZBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:52:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id DB4B5B38
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dk6wo7bq0akv for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:51:59 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id A85E9B22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:51:59 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id j3so17435892itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=icHXuY3EHnw/hQv6RlDa7X35TA+Ci/575h0Cz2uSOgQ=;
        b=chPktIXqBnEYINHmDKZOqXtBYrxdQrzbmd+Ud+8F1jlrZ8jJGN19M+4vL8lBFZ7A3F
         AmEoAby2Fpi/7cOfpoEUBjRW1KnRxDn99nwyvX62v0KJhrqqDPhmkTm9JLPcpFvW70b1
         PlBMXpVuG5GGku+iQx70vNu1YKnLYMgxDTSfMVcnxs3ngme5EW0usVnCDkUDuF4UFvAD
         Ea1lmpeDAqVJ87GpWgEsMYZWaQoEeygKEajFy+4tjCUfpVe9exMXL/FO3scOTCkBDK5O
         LP/LIaEdAbBX2Kb/gar4TeiLmpxv/tk5rtz7hivw7Fnb/RkbDmaWv4LUdISrfQqp6NVt
         LvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=icHXuY3EHnw/hQv6RlDa7X35TA+Ci/575h0Cz2uSOgQ=;
        b=Y/wwO/MUzlwPXq4dfGMOPitvc2JEH8Do1m+ElPbqyza+Ajx87ZOTvTlzt5QsYFD0qX
         6GPQ6NXLn9UXH0GZ1DbGUwNidZSVxvyFviMqCVhMdak7w5HhLasmjouRS3zpvFyOO/sc
         ptuyVtzazjsF8k/lvOkGUwLo28rhxxCH8il2FQdD4ghgxSYYxYkdpBcFyvvKvk/xtdwC
         Jytu7hGe39TDf1exx6FcrL1/Eshja7UN+XrMiZs7+c0naTypL6LT/pjy0vi+IhFzekJj
         YrV3qidi/6WhmaqDQQI7rEkCP0ZReOyVTP912lO9utFJlBKjtDXv5HIWwY+JGJonLEIN
         GTXA==
X-Gm-Message-State: AA+aEWarhmlMst+xi19K6fHlFTAmqapoMHW266FreNdp2vmKO+Hqlxz+
        ohSif3qvMU9ENsWINPw0f6MHbVbGcFkb0DjXCkGsIANEFPks2woz0Pbpsb0fKqLxVYGVO+UZeXM
        M5/ZyozyEJkC+HrqKfCLacYjyJT3Y
X-Received: by 2002:a24:bc1:: with SMTP id 184mr12362630itd.50.1545789119304;
        Tue, 25 Dec 2018 17:51:59 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UueGYJ3nJsMWpDbQqZsaNiFhY8M99vfh4loixeJjqqIKoEqPMjtIpCR0AFSI74XtcsaYZ9jQ==
X-Received: by 2002:a24:bc1:: with SMTP id 184mr12362627itd.50.1545789119083;
        Tue, 25 Dec 2018 17:51:59 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 195sm11832320itm.2.2018.12.25.17.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:51:58 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] keyboard: (samsung) fix a missing check of return value
Date:   Tue, 25 Dec 2018 19:51:29 -0600
Message-Id: <20181226015131.71198-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_device_is_compatible() returns false if the device is incompatible.
The fix adds a check for its return value;

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/keyboard/samsung-keypad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 1fe1aa2adf85..5ba940f3f76e 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -387,9 +387,13 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	keypad->stopped = true;
 	init_waitqueue_head(&keypad->wait);
 
-	if (pdev->dev.of_node)
-		keypad->type = of_device_is_compatible(pdev->dev.of_node,
-					"samsung,s5pv210-keypad");
+	if (pdev->dev.of_node) {
+		error = of_device_is_compatible(pdev->dev.of_node,
+				"samsung,s5pv210-keypad");
+		if (!error)
+			return -EINVAL;
+		keypad->type = error;
+	}
 	else
 		keypad->type = platform_get_device_id(pdev)->driver_data;
 
-- 
2.17.2 (Apple Git-113)

