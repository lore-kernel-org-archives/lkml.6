Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84002C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC820684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TD16t7tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EC820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeH2GSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:18:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46075 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2GSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:18:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so2765315eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qrQiIIGCJFPVtNRO1+XE4NkipPOjwyNIEa9DuQIVZs=;
        b=TD16t7tWaVy7KYtWzQhm4PA8NrPHdwmjavi1QFXdiCRzPMJ++p5UgY6MD+cKX5tTMy
         R2TB5++NU9eSgkB2kisRMasxYvMhep5JGUrhcT2fFBVBp+FTQTT9F1BzXxFaV/+vZGwM
         /oq41MPAO3srJLxHfsost8WkGi208aBwURrke8K4UgR8ULS0008m1IyoLXlvfGdfXgS6
         ZD/lvhEEEKWVzCKN5nCZbS7u0M1u2RscGpR7tNTQ99lmc2Y+vczXx48FZ7eXbUzbmJ7Z
         ZvrkymjpWIdi2ClxcqMgqOCzVzlxMx/w9pKWBUOzIrSbke5yl8QuORJ9rf1NUx7lOIVO
         1txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qrQiIIGCJFPVtNRO1+XE4NkipPOjwyNIEa9DuQIVZs=;
        b=Zi5MzRnzp8BSf4JBSx9CVQyNalfT/ualAuQlN7WpTRQ4a7BkXTj+yrGZhDXN0fYJhz
         H5/ZX+Bqu5zasuddw2Wx1djSM2+1Tpvj5M5TDZxg0Kj+/RWwVBbUEfpBzT9ynIggab4i
         +T7BXQnEIWVH/yWmN9omF+xMjfgY9SnrzYSaaFhnG9mx0xJ4DZMtsrvi+HxPY5eRhYoD
         fn9gOd4IpyV/x5x7r1U3pnOOo05Io94eqa0KY2wsl1QxUCULyVAFtw94SJtFUFt1LBNp
         9zrmfoNacElo9SMBz9UnGEFPTo4oN9vOlx9VdLBJi1Sscg/vT7ce4bhAA1VKlEU9oCvV
         LQLA==
X-Gm-Message-State: APzg51B3EtRki26oqwVW3j3tGAPiBoRc0vIfScpbM7WPnOrjIVN30elS
        jlT8RH2kUui8ZJ27r1BUL546vWfxV08=
X-Google-Smtp-Source: ANB0VdYbpjhBwvJYiQqmvEqB/cENSXeiXp8NXThlwfY2qA82O+TOrPmGJjXbFDZZAQWO47QqpNdC2Q==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr5238018ede.273.1535509437525;
        Tue, 28 Aug 2018 19:23:57 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1236367edb.28.2018.08.28.19.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 19:23:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Wed, 29 Aug 2018 03:23:51 +0100
Message-Id: <20180829022353.23568-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180829022353.23568-1-dima@arista.com>
References: <20180829022353.23568-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
But it races with anyone who expects line discipline to be the same
after hoding read semaphore in tty_ldisc_ref().

We've seen the following crash on v4.9.108 stable:

BUG: unable to handle kernel paging request at 0000000000002260
IP: [..] n_tty_receive_buf_common+0x5f/0x86d
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 [..] n_tty_receive_buf2
 [..] tty_ldisc_receive_buf
 [..] flush_to_ldisc
 [..] process_one_work
 [..] worker_thread
 [..] kthread
 [..] ret_from_fork

I think, tty_ldisc_reinit() should be called with ldisc_sem hold for
writing, which will protect any reader against line discipline changes.

Note: I failed to reproduce the described crash, so obiviously can't
guarantee that this is the place where line discipline was switched.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5e5da9acaf0a..3ef8b977b167 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1267,15 +1267,20 @@ static int tty_reopen(struct tty_struct *tty)
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	tty->count++;
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		return retval;
 
+	tty->count++;
 	if (tty->ldisc)
-		return 0;
+		goto out_unlock;
 
 	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
 	if (retval)
 		tty->count--;
 
+out_unlock:
+	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.13.6

