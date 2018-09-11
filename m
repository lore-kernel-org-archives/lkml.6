Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D0C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCA020645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D+Oofkfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCA020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeIKGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35591 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeIKGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so17998270edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9f0tj5vsVUdzhrWKSKjpuy79m2IHGhKE6CbiI4NyPA=;
        b=D+Oofkfiv7u58Olx2NamFEWRP6f+OmHYsojL+U0XZFWru/5Y2T3pzYHlXRlU+x8Y1v
         FKZeH7IeGUoHBVD87lqcM48NfBICJldiJ0HKwh4Jl4nXLYd6Sddl+u3fe/pVWZZTi3zH
         rBgJfQXPMkNEijhZ5ENFnZcA2QJCuQiW7lAbi8MQzYjf1mWSjtqLmpAE+WGOzNedzM4E
         PGLP5kytHhxacd9OwoOYzlQg/AXkSExOuK3vqyWOz+e3qCa0BYPprEmiWfSBb+bdLAfl
         +kV2SJubej5NU7d04pf0OVKTmRsx5sJv6iTKH6sFT8I7QzFIiniomNWMV4zDc96MKTJq
         DEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9f0tj5vsVUdzhrWKSKjpuy79m2IHGhKE6CbiI4NyPA=;
        b=IkjrlEZICLil+uST8NJb2qzTGVs+70Ueqky374/OeOIl/tLBNLzW+h/1PUouuG5Jkp
         fJtT56JsgqwiKdSkah4FSyerMIPDBwZ2e/YEkgAHIg8Um3mvqbT14rM7I4IC5Bw9736M
         IsGNJlUZ3qiZ5iJZKHGmQ5v1t65G9uoTywShPRO2vfGGfFWfuzIl6TFtJTdUNC+7EzMU
         YAUEy5/tcRKr0ypGMFBYq2jIIuu8GYSqrhf57vdkwIeKtmVBgtVjHfiGzea+2AYCz6JO
         NiD0Y3v31fxREub5ZGtGQAsaNfoGpCpFg4Tn5Uk8PcS35yIsNy8pkJYQ3Xgeg//+HG7O
         jbTA==
X-Gm-Message-State: APzg51CCH9a8raMTPvHJC/CPgtbQ9kDcPe01C+CJtrlVTvML3d6OMPBT
        780SxJzKsH6RWzi1b8G9t5MbACUXSeU=
X-Google-Smtp-Source: ANB0VdZLZvCQaBT3bzV6BThY3aRtLhuMBMN3imrFJ+TQfETDIJSm5nB1I6Ot85dXRzgreI4Jn6oJJQ==
X-Received: by 2002:a50:9622:: with SMTP id y31-v6mr25698927eda.141.1536630511823;
        Mon, 10 Sep 2018 18:48:31 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:30 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv3 6/6] tty/ldsem: Decrement wait_readers on timeouted down_read()
Date:   Tue, 11 Sep 2018 02:48:21 +0100
Message-Id: <20180911014821.26286-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
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
index 832accbbcb6d..f7966ab7b450 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -237,6 +237,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 		raw_spin_lock_irq(&sem->wait_lock);
 		if (waiter.task) {
 			atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
+			sem->wait_readers--;
 			list_del(&waiter.list);
 			raw_spin_unlock_irq(&sem->wait_lock);
 			put_task_struct(waiter.task);
-- 
2.13.6

