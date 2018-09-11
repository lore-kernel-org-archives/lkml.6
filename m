Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0404620645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CuMNcQk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0404620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIKGpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42477 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeIKGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so17975196edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OYoJ3Dctgw9q9O/d9oDBWBYhZF1q5WIKaw+pIZHitw=;
        b=CuMNcQk8Z5rRmahlup4ogRv0xW8tAJ7emQ7mindx/cah8q4yJHua+TU0I5yesJsD5I
         5oEIUWMCy3cgVz58ngam5ucAS+LXKm0ysNbiN18Ouk0gm3AaNgNZRybeguMWkqMj34BT
         39/RVWb4dwBB0TbVEZGfxdAo6AkeKR6hgtmMa3wur2L0wJxgFlYquQhZKqFd9vgCkQMu
         rfQZ1lYoosNXLQEACvoZM9jli8yX9tI8sSLjBE/Buq2xZ81Mm0XcSS0+meC55yYvO8kz
         OQESKRNUdxprFMadfXK1klwzZs/qtkNfCyiaD/ovltUuhoepae5SD07EzhTmeLaLep7d
         +kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OYoJ3Dctgw9q9O/d9oDBWBYhZF1q5WIKaw+pIZHitw=;
        b=Tmb//0dzGB3aHh0FOnvLTEc5wac3Xhbu7XsQL34ZcDmTiCvmBVI93R3hQWueqiIMgg
         hA2WzbmyLp/bl2Jr/siZZmeMHW+q+tIwJnx9Ui+stsbZ9eXDfVJ0k4UnuZ7PtAGfQzi0
         bTgGPqJwZctdKmmggIcBhjCTJX2aLAZXtG0Kl2CUuthbX0WEBOya9a/+VeLWZkxp/oDW
         5vQd4e3y3bj8TTcggUEHuUHL2mvcqTP2wQGm5mxJBU1jbhYaQKlsP0O9S9COUevRW/uY
         zTUPzHDb9iDEW3xRSRxY4SDW/txH5qBRzbGCeocxTMpPZ02TbDNS511DPT9JKKMeKn/j
         KdHw==
X-Gm-Message-State: APzg51BLdIffwVWwVed+H4n0WhPGKE2o6MH+IW9s3A/gmCOkdZTTZCul
        pQiaMYvTDYj552xhGr8/RyM+uDxcI6U=
X-Google-Smtp-Source: ANB0VdaT3VSbWnVpxiq5FB6H8SV6a89g3+lWBCwlPtbED7SSlJX0XK+bDbqcRiR1sLk7oeshEpSrmA==
X-Received: by 2002:a05:6402:1545:: with SMTP id p5mr25108806edx.104.1536630506392;
        Mon, 10 Sep 2018 18:48:26 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:25 -0700 (PDT)
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
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up reader
Date:   Tue, 11 Sep 2018 02:48:17 +0100
Message-Id: <20180911014821.26286-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a couple of reports about lockup in ldsem_down_read() without
anyone holding write end of ldisc semaphore:
lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com>
lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>

They all looked like a missed wake up.
I wasn't lucky enough to reproduce it, but it seems like reader on
another CPU can miss waiter->task update and schedule again, resulting
in indefinite (MAX_SCHEDULE_TIMEOUT) sleep.

Make sure waked up reader will see waiter->task == NULL.

Cc: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldsem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 0c98d88f795a..832accbbcb6d 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -118,6 +118,8 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
 		tsk = waiter->task;
 		smp_mb();
 		waiter->task = NULL;
+		/* Make sure down_read_failed() will see !waiter->task update */
+		smp_wmb();
 		wake_up_process(tsk);
 		put_task_struct(tsk);
 	}
@@ -217,7 +219,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (!waiter.task)
+		if (!READ_ONCE(waiter.task))
 			break;
 		if (!timeout)
 			break;
-- 
2.13.6

