Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D891C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55B620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PVeyOio0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55B620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeILFS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33473 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeILFS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so371266edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=he0HXqppHUTbBLA6Bjwne6q49IoG3fa5OMEO+oLgI88=;
        b=PVeyOio0ZzvsZtpnwz7fRCs701dWjIKtDUiimCjSFR3ZoTHXGWXeAHkQcLVUrWb84C
         O1Yn8zbot2/CO5tga6lZUuqgQogZjV37m9tYKWiYuQqwSi/5/Dc3LVGS1RBuC6p/vhUV
         jI95NaHH1z+JMiSQPkEmTC02nmCGlp6PqVsjeYJwz60RpO+6bylUhcUUj+gF7QpukdsE
         TU+dqXGsm3zFu57XeAuqqj5A0iyFfTYEJv2Dy6znZX9BsB84SmI0qbbQgqJuqPPT7hSb
         HHh0neDRwJgEDrFNPME7yLwL5dPYJj4zujKlYgIfsfPUJox4YrCH4C/hCpVrQTvnRT2S
         4lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=he0HXqppHUTbBLA6Bjwne6q49IoG3fa5OMEO+oLgI88=;
        b=Soi6CiIwlGSQaxKxqG0SWhbukd87VXhcxNH7inwtRqL61rS1PpaiyaTSeV8RNRbQ4i
         x08FTdiek2W7GxxJHJO9Yn2M5diD/J7NRkwJZUwny8BKSZXDsnh4iSWalf6+Q8vzEiVq
         9ekw5qtiQIiCoFJjiUOLjVGxm8O9q9YLx3pW3oJo5WMcV4t3uUpNhxxVZJfHjPyVtxRL
         ObIIQJkdORDVXdWpcISEC91JUDwAe0SkhLEV1HUkVBLXtJIXFznTX2IZg5x7oSp/mKuy
         VMZ5l1xD3ZCt7lgl8zA1F3DehZzOdmZbbSBePP0JG1n7KiD9XKmC1T54Z7BB/qhkZA/P
         iSuQ==
X-Gm-Message-State: APzg51D/WP+C/ErKQaxX6ffi2Ukj2n3XfamLcQRi+P2kKjLMCL3ZURnz
        DkttY4x6gBwem3ueB73taBrwh2uf2qk=
X-Google-Smtp-Source: ANB0VdZBDId7oP7p4sl2yRKiBJB7l74FHHXqzGPEjutMj4O07YtvBAi7FK5SAhlqB29khDHQ9fseGA==
X-Received: by 2002:a50:ba59:: with SMTP id 25-v6mr30764083eds.214.1536711429896;
        Tue, 11 Sep 2018 17:17:09 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:09 -0700 (PDT)
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
Subject: [PATCHv4 3/7] tty/ldsem: Wake up readers after timed out down_write()
Date:   Wed, 12 Sep 2018 01:16:57 +0100
Message-Id: <20180912001702.18522-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ldsem_down_read() will sleep if there is pending writer in the queue.
If the writer times out, readers in the queue should be woken up,
otherwise they may miss a chance to acquire the semaphore until the last
active reader will do ldsem_up_read().

There was a couple of reports where there was one active reader and
other readers soft locked up:
  Showing all locks held in the system:
  2 locks held by khungtaskd/17:
   #0:  (rcu_read_lock){......}, at: watchdog+0x124/0x6d1
   #1:  (tasklist_lock){.+.+..}, at: debug_show_all_locks+0x72/0x2d3
  2 locks held by askfirst/123:
   #0:  (&tty->ldisc_sem){.+.+.+}, at: ldsem_down_read+0x46/0x58
   #1:  (&ldata->atomic_read_lock){+.+...}, at: n_tty_read+0x115/0xbe4

Prevent readers wait for active readers to release ldisc semaphore
by waking them up.

Link: lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com>
Link: lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldsem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 0c98d88f795a..b989ca26fc78 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -293,6 +293,16 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
 	if (!locked)
 		atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
 	list_del(&waiter.list);
+
+	/*
+	 * In case of timeout, wake up every reader who gave the right of way
+	 * to writer. Prevent separation readers into two groups:
+	 * one that helds semaphore and another that sleeps.
+	 * (in case of no contention with a writer)
+	 */
+	if (!locked && list_empty(&sem->write_wait))
+		__ldsem_wake_readers(sem);
+
 	raw_spin_unlock_irq(&sem->wait_lock);
 
 	__set_current_state(TASK_RUNNING);
-- 
2.13.6

