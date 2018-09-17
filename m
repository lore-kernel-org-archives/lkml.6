Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15009ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C090B20C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Sx2HcmVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C090B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIRFWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36852 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIRFWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so392440edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqltNY8k7Rov893LK2+c57lHF/MKn3vl6wo65bAnJB4=;
        b=Sx2HcmVmHhkyjpOf/iA0BIUwfhZKzrjGwk+YcFpEwNDc/fqEa7qfy7J3XcS9ayZvVj
         oDn73pu962z51cNzKYS0P3N7LYP/bE+O2oL0odSNnUxW4B7xY8BA50bPcTRWOSV0VeUZ
         qYLneGMquHwjiWwgu1LmEkrgPDIIetX+6EQ6GJ4p7/ber43SyqRWmGe9Xj3vNL2P4h5X
         4V8/Z95YNIbYQqidb4JYYII6V8RVqFwzexGw8eJgsqz+r4dTt//15Y10Il7w71aAPEuU
         r6ZFLdQD0sqjjU/HDfhkKbIS0GXts8kTGaVc/ZCL5GixMy0XHT0C/aQ8Vjiin2BjFaNy
         rg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqltNY8k7Rov893LK2+c57lHF/MKn3vl6wo65bAnJB4=;
        b=rLuypNl1oZj1JUSKjC9FCoVb6I357sDPHOXJbEpdAQwnejmd4RnbkBdI5h0OKM8kTo
         4mew0/BHWy6XeHXBAmJSxlwoljuCZCnlb3AOIfXWX//27B7i5P3pva8eG+lEKlA7HARE
         4LIBmC4+ivdmCtJQei3crCvtuzrEfDn+tJQoxZTDQWmTZxuEunRNRi9IyjRH2hecG1Ny
         VCGi1gbHVfQf4Adkw/fgoSKoM6njPXT7qE5afZ7ugHsWDfE1hsXnW1fY4hmfXHyTSnZi
         zmE/7pBl7GpYnChPR4OtQ07SN+Ycqcj58DXiDam/NgU4E653aQYo7L0QjuvqEnrFFgFO
         cloQ==
X-Gm-Message-State: APzg51BaffvMxva6rNEeRm/aqutZXfT48Z1hvxxaxv+3VPybss5lDVsQ
        anzY6f4I1iIUX/emNPzfZOHxqVpp45A=
X-Google-Smtp-Source: ANB0Vda8ZFP2cZPXWGJi4evFWxyRkZMZ5gZvBKA8xXaYGSiBvup4XhIo30GKTUzHqbA26t3iP4W+CA==
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr47210828edc.64.1537228383506;
        Mon, 17 Sep 2018 16:53:03 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:02 -0700 (PDT)
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
Subject: [PATCHv5 2/7] tty/ldsem: Wake up readers after timed out down_write()
Date:   Tue, 18 Sep 2018 00:52:53 +0100
Message-Id: <20180917235258.5719-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
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

Prevent readers wait for active readers to release ldisc semaphore.

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

