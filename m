Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9426C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D062145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpKJej3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfBEGnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:43:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBEGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:43:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1070680pfo.7;
        Mon, 04 Feb 2019 22:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UKKQw3AIruBvt5w48fVg81+3xC1ANTdWQ+Z3IPEfCJk=;
        b=dpKJej3pCHd7HistK/ZDgQpymxPvdETcAb0vdMeJtFfF6o74HyHbi4+wKiSgya6Xph
         9ceh/APqALuj736NDM8Z3k+hACM3bWKdMYuy/ZDd6mKe7+Xz3OjasZvTT5DOZKqXxI2S
         jdV9FMercFC+GYxQFkyd/XQ3kxWGOroHnXdjxB26HDQGjLrTdoQx4Z2ttE69shrPUHT+
         1Dobh/dsSnfcrHTx69TtulYvjhuPxffYnX4Bjht+/53HBgvmAqnKuZH+mVIVejDiVa2h
         lWWS+L9d0f+/5z5+6VTK8z1FFk5sHXD3CyQvDrXnXqx4uaNy6Szd28hwqJVmQIRzjA32
         GGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UKKQw3AIruBvt5w48fVg81+3xC1ANTdWQ+Z3IPEfCJk=;
        b=pKSjQAIGJ2r+LEQJeyPiBbT1VziHZkLb0XnIdS0kfIFOwr6kFm0aKfqN1na9vd3gri
         H/d5tuXkRQbp/sT5QhpYQK7u1RoPzeCJF6gdXDhpkzp0QPrR9AMuojlz4YWAOrDDysV8
         o0LzVlb4dIc3xJYHHNZu3m6ogDpwW62KY51sKfZ1X+SwPxWw21Hfa783kbPNpM1E+nJn
         QFnis5rkYVshPDN3F31TFUMFvNHm5ZJbkHDkUetv2MKxBOe0oPJke+VrF7+5rn2w0K/M
         6oiK2L5lnhdlo8Z6akqm0X4d8j9N5pBC3VK+8AWtX7Gab5HxbtSeK0MvmP2g6r6Bw0v+
         gyLA==
X-Gm-Message-State: AHQUAuaR1fzYwpPioR5t0d3iEXqvAQnbSW4bCO1eWT+Ec6nDT1/hUA33
        Adtsic4b7rwOB4qAHZ8Sm6Q=
X-Google-Smtp-Source: AHgI3IavYVcJ2EleGnLr7HtR+sbvBNgk1lJTkNmIti3v9DrjJT2QCyrK1q2qM7yyYfJvC0iXkq7n+g==
X-Received: by 2002:a63:5463:: with SMTP id e35mr3137501pgm.260.1549348992653;
        Mon, 04 Feb 2019 22:43:12 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.googlemail.com with ESMTPSA id k24sm2823687pfj.13.2019.02.04.22.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:43:12 -0800 (PST)
From:   Myungho Jung <mhjungk@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Myungho Jung <mhjungk@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in ath_setup()
Date:   Mon,  4 Feb 2019 22:41:41 -0800
Message-Id: <7783b5bb10aa8d6adbbbad31e0030ac3e788c0a8.1549346039.git.mhjungk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549346039.git.mhjungk@gmail.com>
References: <cover.1549346039.git.mhjungk@gmail.com>
In-Reply-To: <cover.1549346039.git.mhjungk@gmail.com>
References: <cover.1549346039.git.mhjungk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tiocmget() and tiocmset() operations are optional so they are not
guaranteed to be set. Return ENODEV in ath_setup() if tty driver doesn't
support the operations.

Fixes: 4c876c0edbdc ("hci_uart: Add Atheros support for address config")
Cc: <stable@vger.kernel.org> # 4.1
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
Changes in v2:
  - Add NULL check and return error in ath_setup() instead of
    ath_hci_uart_work()

Changes in v3:
  - Fix to return -ENODEV
  - Split into 2 patches
  - Add stable CC and fixes tags

 drivers/bluetooth/hci_ath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index d568fbd94d6c..9f1ac1805d23 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 
 static int ath_setup(struct hci_uart *hu)
 {
+	struct tty_struct *tty = hu->tty;
+
 	BT_DBG("hu %p", hu);
 
+	/* tty driver should support operations to set RTS */
+	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
+		return -ENODEV;
+
 	hu->hdev->set_bdaddr = ath_set_bdaddr;
 
 	return 0;
-- 
2.17.1

