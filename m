Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9ACC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9580020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCPVzREE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9580020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIDHIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38531 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id f4-v6so891173pgq.5;
        Mon, 03 Sep 2018 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3hQFNTER0lszd0kvVWEV9kMR5sWuq9dK2/YVDi+Idr8=;
        b=VCPVzREENBfb8A3S3qPc2w/U09HYMnR5XjohbR7s87xH2founlXnJ7O2LxYkSefiuq
         KsuC0X422xiff0z0Rlrk4+ofOXd4g1EIaYHnlxpKKNux/l7AB3XHg9KKsOkO4P07Rws7
         hJqi7OObHxBUF2Mb0q1XpiUSrvJegONnM4mZZULdG//xUDPAczorNWMFdhEoAN8mkd5r
         FXPlZvM7PP2RPTnM19wOnLaGM3+bSK/bN3CM40wstgm9dcjsSGP2xDJoovFMHtcNciL2
         nPsZIRvd8rg0a4e6qnnO4JXKdGmmAlU++jWLQRlXmfQntrU61+HuBTGxUIK1fUCwTDtz
         RVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3hQFNTER0lszd0kvVWEV9kMR5sWuq9dK2/YVDi+Idr8=;
        b=iZm5bCcVu/CLRrBoGkONeNYx+dhJiyKI5Dfja/khi5zlvv8VDXUNXWxUWfMqfp1gNa
         s1Ucb2QFzaRcrdVru2TNknXN4WAa7CyC1ek85CGol9J+BCiSqwtnTSQI9zZBykSzIBF7
         jh6hDTzS25YkKPX+msfLpXUy9+dylABHSugb9eRxIgmMV+diq8TCLDW3y8WsN7vWFIq5
         ZX+MWXgNhC12UQyCNGQgUNzbQK0rx5YG3AdFKRkq1V/eYMoLEDZ/7V7JDJYrguz13mLj
         YxB+zDA9KF5SkDHLYvW9CHs/OFl/yEp/80rg35ibTAIvq8g5G/UnlKuDZiDx46bUXeX+
         Nhsg==
X-Gm-Message-State: APzg51AUrWUBlQghUJBI9f8U19+lczC/IRsnQ2rG18bv5c/zHVy4Ec/f
        1zB4LFU1t8ycJQixYQhj0F8=
X-Google-Smtp-Source: ANB0VdZGhGrOBh/Fz1lvUWCqJiTMNZnM5DkgqzgQGJrQBIlWSPsVG9V2HnHzIfB07WhBfG8nk/v2/w==
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr32916616pfb.114.1536029123060;
        Mon, 03 Sep 2018 19:45:23 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:22 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 05/25] tty: hvc: hvc_console: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:31 +0900
Message-Id: <1536029091-4426-6-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a..13fad62 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -329,7 +329,6 @@ static void hvc_unthrottle(struct tty_struct *tty)
 static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct hvc_struct *hp;
-	int rc;
 
 	/* Auto increments kref reference if found. */
 	hp = hvc_get_by_index(tty->index);
@@ -337,11 +336,9 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = hp;
+	tty_port_install(&hp->port, driver, tty);
 
-	rc = tty_port_install(&hp->port, driver, tty);
-	if (rc)
-		tty_port_put(&hp->port);
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.7.4

