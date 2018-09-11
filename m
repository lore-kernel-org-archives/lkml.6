Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15291C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2652086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mZFDLNka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2652086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIKGpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34085 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeIKGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so17996840eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9lxPQZZEilVfKBolFkQCYLuaGh77Uhl7thZfdXhC0U=;
        b=mZFDLNka7TvxmlBfrQUqGuLR2swhfoDoTra6Pn9vyVPwAiCiCmOyVLmBrYwspRrhMN
         GbBsKe9pc3Mk2AS8Y0PUmnajcGERFWbZHfrFDeWdqfl/6VwVs/6PLXbAVthuZtcGJsdF
         TlrNVlo+JrxUAd9HiA0bHC9bW2ljSAfKTfoWwmyE+uHnR7TrgoNsqEZLzqIHy4c2zceZ
         xGNr4LdjGNz+S+7twrtZJez8GKcvf+LFItnL3QsY/0Xco2dxtnFUpzLuadMD5v+/aQd+
         43LOoPWNXHrxTZ/ve8/GTsLNsv83/7W1M3mwr1YTPTSU1hMv7zIPhaA57b4bAwrE2ywL
         Q4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9lxPQZZEilVfKBolFkQCYLuaGh77Uhl7thZfdXhC0U=;
        b=VMtHX01WvQUxMeiBzzyyVrfKp7lBzbmDLLqeP1e7m2ZbGuAJK7S4BGbCluUXrd0NJk
         siZNcCYv8enUEk3t5SH531zFANKqGRZ1W0JRKxmtb3paN7pMKuzMxqdgo/b6cPNPHepq
         xBUuz610sg9apwf9lcV22wqJKi+Qe7UXtkICKEqkeAjzGg1QYg+WA2Av3MOL3PBoP/mF
         7493XIUSmH5rj48xI+W8GXCiB2qYip51VVsQ6hhuyIdRLTBJdxk3HsNQDM63petCqiR9
         dCzT4BPM/lO//2/G3pIfCE+TNxSNPNepidu6fYFRHgVjsbbgERysK4jqw8EaX9ydmCYE
         HJwQ==
X-Gm-Message-State: APzg51BvsfowZTsdzoJ7nJUVV11jHUyEzhzB5k/vi8C1fVDjOSolJ6Zt
        lXxQLkWNTGTBycaQ/TcZAhKGD4AXUe4=
X-Google-Smtp-Source: ANB0VdbinzIOkcq+iF4HGY25EcO74pX//nXNVa751qULagSld1EHvPQFMVNLtAp/lo+l0dVW21dqmA==
X-Received: by 2002:a50:a7e2:: with SMTP id i89-v6mr24963144edc.176.1536630505158;
        Mon, 10 Sep 2018 18:48:25 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:24 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>, Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv3 1/6] tty: Drop tty->count on tty_reopen() failure
Date:   Tue, 11 Sep 2018 02:48:16 +0100
Message-Id: <20180911014821.26286-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
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

