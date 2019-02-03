Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0422084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 04:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD9J/kgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBCEXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 23:23:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39705 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfBCEXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 23:23:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so5239307pld.6;
        Sat, 02 Feb 2019 20:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7RbUpPibeswbGRgIY4OwIaY+jlrRtGwiAzTtQkLXwHw=;
        b=ZD9J/kgAtOtS798CFd+sjuexyJ60rJ8F0z+5264n6CJtjFgzfYd+Vc2CXlUfVXyf80
         rcZMSQMw1Mg7EZSn3QuJsnmrmHZx3STdN9di73x5oml/9NSHAubfKNdl0R+9xsOyPUSn
         Ebwlx92wZkL6+Lkvte5x2lqUICakwgwrbNkqAVtP1+pzQzFJ6zNn/Dll+BdmbTF5lCxj
         H0n3nFLC4CEFnSc36WpO8LDvTqPz7UHj81mEkwXMQY3mkswPn2Kj08qHWqJnvxC/Y7Rq
         9TRHBP4psmWdVbj6v0nCYkgwck12NIsx4PNsubNYdWVemTE34vRIRMpkntryfpPN8Kue
         GVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7RbUpPibeswbGRgIY4OwIaY+jlrRtGwiAzTtQkLXwHw=;
        b=De/FnonAMAMzpDBy2qhBI6YyTedXwyKJWV+zoU1D3IECPYR96Ov8kY69wggYsHPkiM
         BpohO0cIyXW058Si3CMmgs9mZhx9oAXLpk0geekvq78cMZWoRjb1irXUN03eKx/lJPWF
         ZxP7J3nixOVqqCxrbaNEhjDQ/K9aJNWRnriktGtV8xtZf3MsHvFLr0Eep7Zum4OxfwsW
         rd1AjKS/UNYp33y1G7FWxcYKhbEEx6vXvQ3rxkRSEeW9YDI+ANBFCrj3njNb4IbwklfD
         XqOBxyNDn6Apg8j6TjGVdjNnSi36OpB5JkAGI+0gCJ8ep9zlfbth/JK9b1JDYNQVFiIJ
         TVHQ==
X-Gm-Message-State: AJcUukcZuV9K4qT4Xk1hsc/X2RjVaS21y9n5q5osWKgTTl1CVagYOArb
        E+eRsv2F/Cy5JKN1FQMCgMprRmMb1ew=
X-Google-Smtp-Source: ALg8bN70C2k2r1qvwM+29Ns8H5SId3S2Fkr8MN4drw1z0LvBfl6LOq0Ih8mZWfcJKhQVRMDu/yd31Q==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr46714537plb.312.1549167833846;
        Sat, 02 Feb 2019 20:23:53 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id e9sm15230831pff.5.2019.02.02.20.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 20:23:53 -0800 (PST)
Date:   Sat, 2 Feb 2019 20:23:51 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ldisc: Add NULL check for tty set_termios
 operation
Message-ID: <20190203042348.GA18582@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_termios should not be NULL so return EOPNOTSUPP if tty driver does
not support the operation.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..44ac2e9494cc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -474,10 +474,10 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
-	/* Error if the tty has no write op instead of leaving an exploitable
-	 * hole
+	/* Error if the tty has no write or set_termios op instead of leaving an
+	 * exploitable hole
 	 */
-	if (tty->ops->write == NULL)
+	if (tty->ops->write == NULL || tty->ops->set_termios == NULL)
 		return -EOPNOTSUPP;
 
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-- 
2.17.1

