Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79DECDFC0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A82120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C0MJjh0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A82120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeILFS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34377 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILFS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so363936eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4QtwhuObUSlGNPfCwQ8hN4GhR0c9gJCD7S4K9VPCSc=;
        b=C0MJjh0PmQmp4MUJRi+8X+77nK7zkFIxjdszDTZyl6hq64LXhs9D2HbVmgqEaDLVjZ
         ddpsHshptzzBIkBCqeK7iYwgnU85nLsda3HAxxQCWFX+IlHqgWEbQjPdIhCE04kwNY20
         ZBI8bnNTYBRpal/PZnypGxmP3rGMpsr9WQbmwmnaT1+qehwmwvP1UNOWSkVg42i0gTyX
         BIltxxgO4Tk6Xw+F2nTTE3fyR/nnV8NBk6AfOqAOWvdAcg3SNYuOvHV9NYxSu5TNeTqG
         s+kgteXveQfNofjTkLKC0/EbYKO4bgU+jwIZLARxwEkduP9Iz+Qg2Fb1YaP9wLWkNjw/
         +W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4QtwhuObUSlGNPfCwQ8hN4GhR0c9gJCD7S4K9VPCSc=;
        b=isn++Pgz96Z8ADI/ruoFj776B30GyC52BRy2qQyvsC4aHwkXzJlHGG8cTZXfzG8bqv
         sPHGsj5NA8W5Hl1d2WrWLFbA97mYnz+nZ99aKNpFRX62JOrMW5FJGpg6JhNwBjzf9BYW
         xkhN7BbA7Dc3OttXdDqV68hLTq6CjSPhZYiTI3KgruDWxCzjCFyLQNE6312A6fCpc9eq
         DhDYreh3HuSWyfWY5Z2nuHJxkduYWuW4U0YTkIv5A2D3wPaOhS91kqK9BijhoQoZKUUq
         YaFfKzAK1zlZXpGsENwHctvKHVVsdedQOz2feFwVX6jfcKzSVjsXxVl88nmD51QLmL47
         ogtw==
X-Gm-Message-State: APzg51DzAr1hAZBdORuH6KHS1W5rP0OI0/5MD7w1f8xwX10smGyq6wnG
        sDf1vjRE1SVrjPN1PpoJOC1ysxzxfEY=
X-Google-Smtp-Source: ANB0VdapjUHLSmgGKrdq0tmh1zPDhIl6NtnqRPM5zFlmyFdbgfExXQWZaVy10t3s+BaJ8FzWRad8ig==
X-Received: by 2002:aa7:dc49:: with SMTP id g9-v6mr30833524edu.115.1536711431187;
        Tue, 11 Sep 2018 17:17:11 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:10 -0700 (PDT)
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
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv4 4/7] tty: Simplify tty->count math in tty_reopen()
Date:   Wed, 12 Sep 2018 01:16:58 +0100
Message-Id: <20180912001702.18522-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As notted by Jiri, tty_ldisc_reinit() shouldn't rely on tty counter.
Simplify math by increasing the counter after reinit success.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Link: lkml.kernel.org/r/<20180829022353.23568-2-dima@arista.com>
Suggested-by: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Mark Rutland <mark.rutland@arm.com>
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

