Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D678C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57F2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pANATjUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfA3Fjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:39:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37918 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfA3Fjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:39:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so10889959pfi.5;
        Tue, 29 Jan 2019 21:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LdshRunszHp9eukYYa4D9KTgZEYpQJHlXxI/VoNDqWA=;
        b=pANATjUtIsOlIKh9xJTwdx864Jnm3O2x0hlt4dALksiCn4fi3ds3RPlryM30bCGK7f
         GWZ22xs2F3EasH3jAuD+PKJyyQDhgIwimo5eucrU4pwV3tr3XU89RAkQ2+3IYhokWKJi
         jlTEKZXleJqXDhDHJSFFzJforVai+Dp9I0r5hA1ftZVZDpOyZdqcntKI1YAkk1Xgg6qZ
         uOkGOMdVzmVLc9kPVH9hZ3mTkPEACdDtczALCgYrhxukjsXHNUHXNPVqw9iWd0veYlB+
         WWNzyLptqjEx3lWhOAr7E4GqgPoYFONyjNdbzBj77pdg9nrNzcadvrvRDxgVuVRR3PtT
         kkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LdshRunszHp9eukYYa4D9KTgZEYpQJHlXxI/VoNDqWA=;
        b=Fe8lTTpsQa6umkrKc1skBPZz6Dg0qvxwkrOLRVgmPCv/5LTMZxWAf0k5sTlCddNVyg
         XvZUTytC/wr57npzJzV79czSFJDoz9KqZXZo0JJXu1V/R1K/0DHwpD3pRzaM8gp3eq8N
         LXvw7z30mYx8ST4Ar53Bt2SkZYUW76vha0auz6jL/wRHVgHSAx6CsLAzgyzSXHOQ9xER
         +znm/Dcx4iFcxIKThaSsYXwRuyy4FQERe73cGejOTIhTESJSRkcb1rsQgIVvUh4NeMHr
         6umBxvFh/vlb0o/wiy7cMx4U09BSaxpjOfiAeTOBkyjqAQYLa3wvCw3SsNjaHZhUj3+r
         bJ1Q==
X-Gm-Message-State: AJcUukeX3iY8hVNKwbjXp3xTrGLF4XhGKvrizCtJUBjn5TUvtQe4FT/g
        pbDeVQRp0c3wI9fj5xACixk=
X-Google-Smtp-Source: ALg8bN75QKa6jJtgFr43JSIhKoMwFA1YD3gO04tJNYo3+WXhWVgdGVAWtjimy3yE1iajRhoL0c7Yng==
X-Received: by 2002:a63:6346:: with SMTP id x67mr26250988pgb.183.1548826771294;
        Tue, 29 Jan 2019 21:39:31 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id v89sm1134164pfk.12.2019.01.29.21.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 21:39:30 -0800 (PST)
Date:   Tue, 29 Jan 2019 21:39:28 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and tiocmset()
Message-ID: <20190130053925.GA26699@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tiocmget() and tiocmset() operations are optional and some tty drivers
like pty miss the operations. We need NULL check to prevent from
dereference.

Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ath.c   | 6 ++++++
 drivers/bluetooth/hci_ldisc.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index d568fbd94d6c..fb9f6323a911 100644
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
+		return -EOPNOTSUPP;
+
 	hu->hdev->set_bdaddr = ath_set_bdaddr;
 
 	return 0;
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

