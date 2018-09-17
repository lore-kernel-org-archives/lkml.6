Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D9520C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C++35MSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D9520C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeIRFWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44781 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbeIRFWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so357607edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uLlyfSZcFtLbr3lQDxgU62sL5d/DXhyf5GAy7VzmrfM=;
        b=C++35MSzbt+kfN4gdn4/TxOi3wZ62LKImy3XGDSWo5zwAVzgjWsIUEtYPnvnO5z4nL
         hmlGqf/T+oQ0irODLMXHuar4KOrFeaoZwvN6YIfcft2f3IUxreqdUC6O1aPAoDGvSczm
         Y3SEDQADE2YrzqhIzgFp01FMd2RadnV5+FuGpiKon1UB5UVRkIgQJMfHr60pMXpEdsr2
         zJjvjVeW6B4s7kPlzltLnOrPDsj+i62KO9zBEcxAFVo7JONLcuf+nTBcl+YiNtJASXAq
         x75UHhBZmhaAnJ6fA4b4PtJF/ny752OlBTk2mRPYLnrio2yWmS8jrTIOAH6ozfy4xWmR
         HMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uLlyfSZcFtLbr3lQDxgU62sL5d/DXhyf5GAy7VzmrfM=;
        b=FwkitqVldFvLayRj4KKWlhKi8+UsCz/oP3fbthWOBW70gD6MXB534acO7lROO39nMB
         N8AUwChqJR65Df38Fj5P2Bk2bmZYloI2vBhaXo86XZ/AJCumI//wBPXvMpiBP6iFHMZ5
         4mLB2p4S+ANKr3r/5DSzq8zG5VCjSyXoO8ZGpVu2g93Vtz4FsRujcE1saqJZwdZLVMvY
         CFDmqSZorBgMob/UB9F2eohoJannILDyH61+xpmfU6zO5G8KnIWAwrMETSewLYG6U7XP
         Wp2/o1opHZ0jKOpc8En0P1EXjhxmcjMCDp+LJ48DRmh2xR56a73WJ2QNm1PSjfNq05WD
         Ah5Q==
X-Gm-Message-State: APzg51DkuvbPBc6DjG/wJ5qnN20ZOJhvcUn3ZbHcnRU7XDMPgRJcc6mw
        qbftZ3IB8kZcdgJ7Gw73C617n8ibV9I=
X-Google-Smtp-Source: ANB0VdZ7LwTIvbPH7+QkgU55y7vS1+cfHIMnw4znrWGC7aZuAZrL4bWXMBpkFzi7W9Qvw9sfs9+Tig==
X-Received: by 2002:a50:8c98:: with SMTP id q24-v6mr48943727edq.2.1537228386078;
        Mon, 17 Sep 2018 16:53:06 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:05 -0700 (PDT)
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
Subject: [PATCHv5 4/7] tty: Simplify tty->count math in tty_reopen()
Date:   Tue, 18 Sep 2018 00:52:55 +0100
Message-Id: <20180917235258.5719-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
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
 drivers/tty/tty_io.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3ef8b977b167..44bf22b8d746 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1271,16 +1271,13 @@ static int tty_reopen(struct tty_struct *tty)
 	if (retval)
 		return retval;
 
-	tty->count++;
-	if (tty->ldisc)
-		goto out_unlock;
+	if (!tty->ldisc)
+		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	if (retval)
-		tty->count--;
+	if (retval == 0)
+		tty->count++;
 
-out_unlock:
-	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.13.6

