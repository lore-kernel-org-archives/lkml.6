Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9DECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891CB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WYQIK3LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891CB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeKAJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40412 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKAJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id z12-v6so9411124edp.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WlrQzTFiPM+4wvhfAOXLKeQLq894q6/wVEpY/LQpVd0=;
        b=WYQIK3LSCWRZN1/RJ4O00AHkkXlMIfC8IFjqoboe8Q73SIxKXwG2r8n+H0rOa+ZLNS
         uVPILpHByZ51vP/jktYa/W7RaaKgVNmntlsChbHT06bT/hHN0yuHE91hAz8KhNPyVFiv
         XbsH2VMNAO+3jGu9JK9jAcud1Vgcp4Q6aL536X7OuaS3tXtJ4jx+zSNQDTyJeP/ayNEp
         rOdDN5PvXzyM5tarSMRSFvgmZ9V3wDnWfudZH1zu2ueZXvXqf4DbbPKsAAenTv1+ZuG1
         AlPyLrWR6X6pUfDqcpWh4XqbodeGZeEYU7nr1T1sd7lWV17NoN94NZhCNYfMonFb6NxB
         qagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlrQzTFiPM+4wvhfAOXLKeQLq894q6/wVEpY/LQpVd0=;
        b=rHuy4Ow8Gu/gYwfJ+NeO/UFJJJCaCPBkH5lD3b8itSwecSvPJ7Rz37Gzm4goB2Rrg+
         bS6uHixMsQfmhz8ETB3XH1jqiqbiPah9mDtHm8b3NvKrthE/TZH+dypENCPPW5V5/pXg
         pg1pJKlC/wiV5Wkt/ltFNP5SH01P03hwx1JOHFT+/3D01z3h786fOeiaJfA1dvhv+ZS/
         JpouTjTIKpDfR+iGE8v+M/JaPbcN13zhNd0Z7iZjT5f2Tor3IrcbzM6vn4eiwlTpGySZ
         3Sgc9NHjhdIwru8+HRQuzG4fA+9OzzMBFeU5S/V6QOVc7D6gWEhgLdUsYY9Lpd9A66il
         VDYA==
X-Gm-Message-State: AGRZ1gLga+cQjHXAaNJtLwMe5v/nVDCRxCOnwk7vKAgpDBqhahBBUuvp
        2jnYfXjS9p832tDelk+IkG5xjVF0SLA=
X-Google-Smtp-Source: AJdET5eNTj9LABD/4aPneQxvHmNhK82an9adOHdaxW3QeBbwxWA40CaxPgn5oJVSHSe1qWdL1ZYvqg==
X-Received: by 2002:a17:906:12c6:: with SMTP id l6-v6mr2816246ejb.74.1541031896480;
        Wed, 31 Oct 2018 17:24:56 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:24:55 -0700 (PDT)
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
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCHv6 1/7] tty/ldsem: Wake up readers after timed out down_write()
Date:   Thu,  1 Nov 2018 00:24:46 +0000
Message-Id: <20181101002452.5483-2-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Link: lkml.kernel.org/r/20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com
Link: lkml.kernel.org/r/20180907045041.GF1110@shao2-debian
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
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
2.19.1

