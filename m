Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D9AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D452146F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9+cbqU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBEGnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:43:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38820 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBEGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:43:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1010554pgc.5;
        Mon, 04 Feb 2019 22:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rRbBcTZq3hXfWPWoeJVSOfiF3bXYvYeCff1R3IhwAC8=;
        b=M9+cbqU+hIe//yTDYjhRCUQXVy8Qreh2/klscRx7XBQlIbsGhTlxNZxux0s9VWK39V
         uYAte7K+2oGPckTV/i7/fQ7VruPGVwnkQbXMlgOZnRxYRvqqrj478ep86xlH06d+r4Uz
         ZZWLpVno/KOhCqUU6BvfJV3wIPi7HoxjX2GUQ12YGwr06JxlgC4GgG8f86c7xfYF3QNG
         38qcibROb2VWtfl5WBgmbJllDPGocKrTnP8i3HAaYHR72qVWZpvvF8bZ6ZzbqTUruXDb
         yJIlSxbdl7GYO9g+2h2wfBgjGDLkkiMnVxxxrhX7n/HI0Q1dxYXh2O0xK8qbhuZ1wk+7
         obUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rRbBcTZq3hXfWPWoeJVSOfiF3bXYvYeCff1R3IhwAC8=;
        b=K9j4h6e3Ppki29MsL2iW6EULq7PlIuGZOvsv1q2N7FoyvGDza4Cvpt1spZEO97wfIr
         XW1mMobszjyQ+u1uRmgRL4uV299DW18+3V0QA/YCcQkD6cJAiRfbMMva1x04Oy9ERemU
         I2v+Zs3nBH32PCJ09JfpcZNbpQtolEkkAFwo+AZmQTcP+rOXgtkS6/1BiwHm19NAriSd
         lO969ka53QLU1knkamWvJ5hkOCzHkd2D9P93IDbeBwnX9amsVSaC/a8bAEW6GZl2CXLH
         6wotinPgpz7zjV+9fJn0AU7WSVsTttnf4VNH799uWpdY28YXgLnHOj9WB/XjfU7sFSrJ
         P3uA==
X-Gm-Message-State: AHQUAuaJ2HsmnWfrebhRro/zdArEHexH8Th3JJG64RZfQMqHLiRMpQRU
        wdNLDqh7UnBl2/o0h46CgI8=
X-Google-Smtp-Source: AHgI3IZ/a4W3yqXOWoFyUxIN7H2EZ/Gu50+eiMtV/E7VEiIuhK4ho6V6YJEGYFM0ADAKhuFNbcy8BQ==
X-Received: by 2002:a63:1f06:: with SMTP id f6mr3168834pgf.414.1549348997376;
        Mon, 04 Feb 2019 22:43:17 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.googlemail.com with ESMTPSA id k24sm2823687pfj.13.2019.02.04.22.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:43:16 -0800 (PST)
From:   Myungho Jung <mhjungk@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Myungho Jung <mhjungk@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in hci_uart_set_flow_control()
Date:   Mon,  4 Feb 2019 22:41:42 -0800
Message-Id: <4cc3a826614822661dbedad74d9970172cbfa6d7.1549346039.git.mhjungk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549346039.git.mhjungk@gmail.com>
References: <cover.1549346039.git.mhjungk@gmail.com>
In-Reply-To: <cover.1549346039.git.mhjungk@gmail.com>
References: <cover.1549346039.git.mhjungk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tiocmget() or tiocmset() operations are optional. Just return from
hci_uart_set_flow_control() if tiocmget() or tiocmset() operation is
NULL.

Fixes: 2a973dfada2b ("hci_uart: Add new line discipline enhancements")
Cc: <stable@vger.kernel.org> # 4.2
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
Changes in v2:
  - Remove braces in if statment

Changes in v3:
  - Split into 2 patches
  - Add stable CC and fixes tags

 drivers/bluetooth/hci_ldisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..cb31c2d8d826 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -314,6 +314,10 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		return;
 	}
 
+	/* tiocmget() and tiocmset() operations are optional */
+	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
+		return;
+
 	if (enable) {
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
-- 
2.17.1

