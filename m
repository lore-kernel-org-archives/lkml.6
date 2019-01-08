Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEB72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNLPwfjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAHNFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:05:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:05:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so1723777pgb.4;
        Tue, 08 Jan 2019 05:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PxXkslBAlSJzljYoz5a9XaC/5ylc7ABn3sw1j74NO/w=;
        b=hNLPwfjjeJc7N7ii8wHPmq2rB+7ctOa30BRtL91KeMN4wP2Ph2HlBsHzC5pKAJLdL2
         q1eBKQ92XBr9rwBkmsyp55UMZCWefxIx429aIzs7OheTnWqVkuydQSWBI7CY0YxlgaOB
         TRP6nxuLS6/B+eNL1PntPxZYLNjNw/5jZCkoIauQJFQEzF2SUW0PNCI0Wl1KiuKrInGe
         J1aBY72abjbrk3Hx4g5mL5gzjvQG2C2Mvs6pK+2v9tH5TpTHw0xNxnOHtA2QqtKbBR4a
         FbgYji6DqPWsmycefzfVjkquuN+MfAS/UAeVpPucFfoDk7dE9KyaKP08NMtjIJLNTtTH
         irSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PxXkslBAlSJzljYoz5a9XaC/5ylc7ABn3sw1j74NO/w=;
        b=ocVaCfvMypfCZ3zs7cw94vq8fscnAupJfYTYUL0OpgWInQlDUveygMhC0kUE7eqrTV
         d59ZCY9IXG5qQyPWeR0/UcqjJ4iaiBwIytEMg5mwwqWB32dxI36M0u0fsL2Udc8SnUV/
         UfZIvkj+sFKBuQjgKEw8enPJkr49KGPV6S00AEm3lASQz60A1ykmeAPn42Eg+UqzYmCr
         WqPX/MNMc/z3g/Ub/tVuosia/G2cOoDrNNcks90Xfomuh2zNoXfa3cFy9eIQbXnuj/IU
         ZoMXmDLntZT0Jhw4Iq/HEEa7aVQ4dZ+iywEU31vigswTANpzbdEpgT/uFSn/a/GCgRCj
         VlkQ==
X-Gm-Message-State: AJcUukeW9GO9Nbz7fe7QI+h9YBoDb3GWzIr5mDcoJm/P9zjD+VZH9J4f
        3wUdUtiBQxzF1jSS/QvKYWE=
X-Google-Smtp-Source: ALg8bN5wNMRSoEFdWSxsVcCtuwm34hfaKlZeWDjKz2rECCn9hTpS+RPpakDI7oqb6foOZRsiWRURjA==
X-Received: by 2002:a62:442:: with SMTP id 63mr1645432pfe.156.1546952707326;
        Tue, 08 Jan 2019 05:05:07 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:811b:a348:3027:e3a0])
        by smtp.gmail.com with ESMTPSA id s190sm101281486pfb.103.2019.01.08.05.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:05:06 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de, viro@zeniv.linux.org.uk, davem@davemloft.net,
        linux@roeck-us.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: i4l: isdn_tty: Fix some concurrency double-free bugs
Date:   Tue,  8 Jan 2019 21:04:48 +0800
Message-Id: <20190108130448.22102-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions isdn_tty_tiocmset() and isdn_tty_set_termios() may be
concurrently executed.

isdn_tty_tiocmset
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

isdn_tty_set_termios
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

Thus, some concurrency double-free bugs may occur.

These possible bugs are found by a static tool written by myself and 
my manual code review.

To fix these possible bugs, the mutex lock "modem_info_mutex" used in
isdn_tty_tiocmset() is added in isdn_tty_set_termios().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/i4l/isdn_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 1b2239c1d569..dc1cded716c1 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1437,15 +1437,19 @@ isdn_tty_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	modem_info *info = (modem_info *) tty->driver_data;
 
+	mutex_lock(&modem_info_mutex);
 	if (!old_termios)
 		isdn_tty_change_speed(info);
 	else {
 		if (tty->termios.c_cflag == old_termios->c_cflag &&
 		    tty->termios.c_ispeed == old_termios->c_ispeed &&
-		    tty->termios.c_ospeed == old_termios->c_ospeed)
+		    tty->termios.c_ospeed == old_termios->c_ospeed) {
+			mutex_unlock(&modem_info_mutex);
 			return;
+		}
 		isdn_tty_change_speed(info);
 	}
+	mutex_unlock(&modem_info_mutex);
 }
 
 /*
-- 
2.17.0

