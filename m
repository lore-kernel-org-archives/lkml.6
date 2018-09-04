Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23372086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiTY2J0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23372086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIDHIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37150 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id f1-v6so889543plt.4;
        Mon, 03 Sep 2018 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ds3q9KD+4bwv6Be443Dyi9iiaHrBZT5yxhOOYzF9crg=;
        b=AiTY2J0yecEktVfXFRlwiIiAAy2sWRdA1OtLSTHDNtoNB4eYZFTegALMENThQPbch5
         rbiqZQQ3uBr9KDT7V5ymtK//+E35Tb5nksA3XhKCJsfkhZzhU2/rodIqHj/6ZR5O0l+O
         +j74wmpJB7AObwSbunt+cLYm2ltgK8PzOWntFlKfqriFhuvl24R7ifmAH7EwVRHH86qZ
         +Qx1+Da5S84kBucqunCfaOlNQE+nsevi7O0i77UCmr9IJsTaQ3Ml/tf+H1T33LtOyf4O
         DVKR6e6GA5xHYaUk9MWB7x14M/2HSncWv6KiHgAA14538CUldZZCk21Z49CO4rsrfTf8
         sV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ds3q9KD+4bwv6Be443Dyi9iiaHrBZT5yxhOOYzF9crg=;
        b=NcrnRdO8gMTS2Gd2MEA/LPQ/r8r7JK8JfYe3Bd1cl7RdYp2Nci18h2jtDXwURrOH8a
         tOl56yeXJIG26DIDcVTEH6YR4/gULmSWJf0hn/YcZ+L7YUVmGKGnTE5f/BLGi+OoqPZC
         JZSZCloo1YEHFV6JFGClvd7+M2PlVriO99KOrlX3CURh27x2ZuhtBPSWLTreQJR753e8
         8CGTq/ROzZ0sS4dTWaG4RAgZWEhKyuzugnWutl2OLpAhyGCzeK68U23jKAs37JVTVwEZ
         C2TAXVYg/LwcbaCMiAIWftPxCEU1d/eYxjDCbC1xOrqkdkhS3t9T8T3mytvPttK0lKSq
         0fJA==
X-Gm-Message-State: APzg51CCL0AW5d0gBpNnShXZ8LPcHw5CAGzJ3g2lQyJtgn/BY6GS6PfB
        1yuzQoZ6xU1nmH1vsxSOHoE=
X-Google-Smtp-Source: ANB0VdbBD8lSu0DKmafc+1B+HkvsKNZjsz3hST7COXm+YnNHboqI1PyturbOWyhIOIXz1rsoS383Dg==
X-Received: by 2002:a17:902:2804:: with SMTP id e4-v6mr31226863plb.327.1536029118457;
        Mon, 03 Sep 2018 19:45:18 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:17 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 04/25] s390: char: tty3270: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:30 +0900
Message-Id: <1536029091-4426-5-git-send-email-climbbb.kim@gmail.com>
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
 drivers/s390/char/tty3270.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5b8af27..2915f95 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1017,12 +1017,7 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 	raw3270_activate_view(&tp->view);
 
 port_install:
-	rc = tty_port_install(&tp->port, driver, tty);
-	if (rc) {
-		raw3270_put_view(&tp->view);
-		return rc;
-	}
-
+	tty_port_install(&tp->port, driver, tty);
 	tty->driver_data = tp;
 
 	return 0;
-- 
2.7.4

