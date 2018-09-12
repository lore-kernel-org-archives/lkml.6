Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0443C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A70920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AfBEnBxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeILFTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:19:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33482 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeILFTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:19:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so371352edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPpt0f/8LcZSCa9NDagMFTu6e0WQH286AZEzI/uklGw=;
        b=AfBEnBxNhRtFU6Dh8F0nITA42hrLxMA78o5O22BX3H5i4N5c1MNBPgHWAJ+5LobWzj
         Oy+qPjqJzS6E71ivm0TEssbrGChvrnHpFbH44SsreYsut/UhTFC97reC/YiLHdrZYKAm
         tifOWCE5NRgvvdp+pib67sAK+1TgEqXb2ahx/hWG5BP+bKpVTqwGUM4J0CQDxEXkQ+w7
         WDT1/UeZR4tvypm7RaD9yCvN/9MeZHHtCTgBkh6qNg0J5pcJXC+IudGTaENAElRGpYpg
         sHbExCoCkLmhduPDITehY502qNPMxOFs2xw2QKb43AD77baxCbYXjTxXUWFurg2Xhw5r
         W/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPpt0f/8LcZSCa9NDagMFTu6e0WQH286AZEzI/uklGw=;
        b=hgkhrsCLOXQezu2YhpWp3+T1UlA9D1+ifAkf0/Xlr4WvJrWgzKEgvMOZWl0MRzYT/u
         BLQpYqvpwas/OgENByEbMz2xfJ4w9dvxuEDoHjkqSovIVTrLv+DH5kpB6cf5G9VNTkNF
         tszVqwoXUDkF3KMH18+BuClx9nU5NALEYQku8JAFkLVJjEwcihSQMNJ9kfWdm02m1zVe
         AT1zzqrBO2R9S6Hfpzc7tXbK0JMsomn3AUtgml5CNrSZaVJEjc89EYeGBmUmXhr1Z4Yf
         W7Lww0WUzde+TY1FsD0+WJIrXg7lr17YTwQvLeObdPDWbo/wotwEBsLZdfGl6Fxu5j0o
         fZTw==
X-Gm-Message-State: APzg51BqOwPFxFTqPhJ+ZvUst6PZQgFjYvXZLjwAh6JKGUWQr+C+UTET
        /i4MmfvDvwWt/E5OZnwRZGCNu7d1x40=
X-Google-Smtp-Source: ANB0VdZrhnAASfm76bUrSscA977tblJV+PKfDYCbqx0/rpTQy3csE28Zbj1ZPlVAUYTODzNTbBRn+g==
X-Received: by 2002:a50:aba3:: with SMTP id u32-v6mr29895029edc.257.1536711435387;
        Tue, 11 Sep 2018 17:17:15 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:14 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv4 7/7] tty/ldsem: Decrement wait_readers on timeouted down_read()
Date:   Wed, 12 Sep 2018 01:17:01 +0100
Message-Id: <20180912001702.18522-8-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like when ldsem_down_read() fails with timeout, it misses
update for sem->wait_readers. By that reason, when writer finally
releases write end of the semaphore __ldsem_wake_readers() does adjust
sem->count with wrong value:
sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS)

I.e, if update comes with 1 missed wait_readers decrement, sem->count
will be 0x100000001 which means that there is active reader and it'll
make any further writer to fail in acquiring the semaphore.

It looks like, this is a dead-code, because ldsem_down_read() is never
called with timeout different than MAX_SCHEDULE_TIMEOUT, so it might be
worth to delete timeout parameter and error path fall-back..

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldsem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index d4d0dbf4a6d9..717292c1c0df 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -212,6 +212,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 		raw_spin_lock_irq(&sem->wait_lock);
 		if (waiter.task) {
 			atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
+			sem->wait_readers--;
 			list_del(&waiter.list);
 			raw_spin_unlock_irq(&sem->wait_lock);
 			put_task_struct(waiter.task);
-- 
2.13.6

