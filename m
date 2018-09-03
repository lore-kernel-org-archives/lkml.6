Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B1C20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XCiT5ceK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B1C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeICVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:14:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46321 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbeICVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:14:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so1214873edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvdqY9eG7WLUmp029ivjAYmnogrvA/F5X2EcXNbUPzQ=;
        b=XCiT5ceKdBDONTnHw1Pu1aGFNqrGwvM2qNZ4OcXV5L7QNCWu27W6gLOmLNj6jYGgeg
         EKcNyEjy7XTZU/t69rFZF8fErGgIqki6zJodEV+u243ZBXlpdgqm/vwsRG5mXt7llnwo
         STTTi8f0r5mTztjBYQ8ET6z52u0r39QZWc+LF5U9xKeimEQU5yCrbhACLLaz820jYgcH
         OysFDdvy5FrRicl8j1z/qpkGbVDOfyZ8XjKNnHa+AgaCarfvBg5AV5xTUB/xXyTIjECz
         XIbHSSXPFZAO2yWh4q2hkoxS3YHSwhiZXkfCfRMzpq+wVbTpRPFPPOybm84Buh3S/yNq
         VYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvdqY9eG7WLUmp029ivjAYmnogrvA/F5X2EcXNbUPzQ=;
        b=dJhWnAn9f7qFB5m1Qr5d6q/Iwz7TnBuPvHn5v2WS74hbSEThy9chZGkax3HYRDxHL2
         JDIGr7kmM9nmbrKA3aE5DPkZ/OgvljqxWJrkBRQ6m8IoeOvs1G3CUGLsJrpmqtPpjYTX
         c2cb+fPsQLNTXbgU+LLXTTp8IEsVic/sLh0cbQV5iY4JRTqT4a/944xCEBfqcijvDE4I
         KdT3jIEgQnxsYStPlJLsrlCUbKseSwAUJCv0MnMPrJpLjXLefm+cVo6X0hTLTWH8rkPb
         MjsQhXKXGLuvqJSxN4+L0CLznbdJ7W4JPRszeX3ztA2ucEhDAZQWgI53euBJUZtqgb3N
         js5w==
X-Gm-Message-State: APzg51ADFI56JGsNq2BiJu32+d112QMq7e27mhXk8uTFNVlPXjGEia4W
        IqCUNtjaj+DdGghITOq7iWOnJEG76pc=
X-Google-Smtp-Source: ANB0Vdb597P6JqO1eJckMlDJQS2NYs2+urjbO5qh+Sm4mcHbMYG/FnMEPXhPjAD6cfnbNb1+/Aas7w==
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr31333297edb.73.1535993585465;
        Mon, 03 Sep 2018 09:53:05 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8085745ede.14.2018.09.03.09.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:53:04 -0700 (PDT)
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
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv2 4/4] tty: Simplify tty->count math in tty_reopen()
Date:   Mon,  3 Sep 2018 17:52:57 +0100
Message-Id: <20180903165257.29227-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180903165257.29227-1-dima@arista.com>
References: <20180903165257.29227-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Jiri, tty_ldisc_reinit() shouldn't rely on tty counter.
Simplify math by increasing the counter after reinit success.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Link: lkml.kernel.org/r/<20180829022353.23568-2-dima@arista.com>
Suggested-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a947719b4626..7f968ac14bbd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1268,17 +1268,13 @@ static int tty_reopen(struct tty_struct *tty)
 		return -EBUSY;
 
 	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
+	if (!tty->ldisc)
+		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	tty->count++;
-	if (tty->ldisc)
-		goto out_unlock;
+	if (retval == 0)
+		tty->count++;
 
-	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	if (retval)
-		tty->count--;
-
-out_unlock:
-	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.13.6

