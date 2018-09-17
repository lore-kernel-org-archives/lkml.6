Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1624ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5550920C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="O0Zu8VHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5550920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeIRFWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36849 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeIRFWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so392418edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YmuauxZavQGn8pT/koRDQ0Q9xTQ32n86mobHdHHnjg=;
        b=O0Zu8VHd2/UCkNL92y8z6E0kDmFXOkvExAH8If2rIR9a+4wstTaqoCuFxhrqx7Xv+V
         ltB5NmzNHA7lzQHeKvf4NCk0SnxG4QVSHPAuElDWv8+bWv+Hun7NtYyg+sbggTYB8ozW
         lkl+5NtN6vofadqAyxjNMy1kI83W4Gc853aFyCqrejn5Um+StqJVWViRmazwACgHO84u
         w0xl5fBa6Rk10kFBAN0dIcpt2rVihOcjPBT91Qu5AUENoQxK1WHdcMmvl2nwV4y5EeyC
         on/vv8XOQlGhf40kl4QDsspNBWU9op+Ochp+r4v7VXLiCdCPMCcY/JoiDu8CepS66S94
         W9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YmuauxZavQGn8pT/koRDQ0Q9xTQ32n86mobHdHHnjg=;
        b=Q7a9+ksbFD4XzR6Yhso8EPMvLS+fijNcmSh53oo5fwttMs4q7SMdt11u2dsddNyqM5
         o97oj4g+zfj8ALgyN1/MSDKhHqy5O+5IuDkCfgA1uWP9kB0wfkJ4O+RIAqQNZpfs1hTw
         +TtB9Trhx5W8Vab4hsn8zlR+JSPeCD5xTjAvPcUpd2sxvAtC5V+tvj40FSBlTiXvW83N
         s7PK70YIIkiSqnYeOjUolQkL7S4j9nLXxFBIrMDm84MCawRYdb9WRS202jidxN3Lizo1
         6zpRmuo32zZdPocBe7j08nolwRxqr+mw6ldaAjjeMu6RB6kEpUZSUOn+Y6Dbb/rCVJNG
         4vnA==
X-Gm-Message-State: APzg51Bp3YOdoOKPgxWkLSrJfGiyNFtjLgmWNQNMu+YJ9TBfakbMZhvx
        Z8aIB1mb+PXf3ardxMnmAxZLatlt/1o=
X-Google-Smtp-Source: ANB0VdbUe9+RhoVg1vgvc5vXPxIXqE+oE7IKvgTuCTopriM/mM0PSrySpTRm3064IiqaaW1VsOU7dQ==
X-Received: by 2002:a50:bc03:: with SMTP id j3-v6mr47271830edh.34.1537228382216;
        Mon, 17 Sep 2018 16:53:02 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:01 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>, Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv5 1/7] tty: Drop tty->count on tty_reopen() failure
Date:   Tue, 18 Sep 2018 00:52:52 +0100
Message-Id: <20180917235258.5719-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of tty_ldisc_reinit() failure, tty->count should be decremented
back, otherwise we will never release_tty().
Tetsuo reported that it fixes noisy warnings on tty release like:
  pts pts4033: tty_release: tty->count(10529) != (#fd's(7) + #kopen's(0))

Fixes: commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup")

Cc: stable@vger.kernel.org # v4.6+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Jiri Slaby <jslaby@suse.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..5e5da9acaf0a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1255,6 +1255,7 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
+	int retval;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,10 +1269,14 @@ static int tty_reopen(struct tty_struct *tty)
 
 	tty->count++;
 
-	if (!tty->ldisc)
-		return tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (tty->ldisc)
+		return 0;
 
-	return 0;
+	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (retval)
+		tty->count--;
+
+	return retval;
 }
 
 /**
-- 
2.13.6

