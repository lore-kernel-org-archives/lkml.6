Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25DEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C251214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RCMbsVvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C251214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeIRFXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:23:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46096 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIRFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so349761edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPpt0f/8LcZSCa9NDagMFTu6e0WQH286AZEzI/uklGw=;
        b=RCMbsVvxwUsTuEdUHueXzKB9PcShBqstZRSP/ekeNrqErU2tngNdcmp3WNgoFTqyah
         EW4zFt2wKj072z30v+0ZAKaa6tx70lBsFzclgwwOIERxSORtz8HaziseUvDJPwsndO/H
         801zFw6+Ooht1T/R80+LCz4nwNeu+QxPA6P8r3GjyLE+jl3qI2VBaaRL5AZAMuGlEqKF
         0BFbw+0pCVW25UOrW+nw1rr/wO8a80g21Af6X1XscYTB/YuomMdCRaBa2ySe2qK+x4yq
         A2hmyZ08pVErobju7JjQnbiBqlusWW0s/RbaGtUC9iY4gFebpQeAZV+sMkWiFT4x870t
         d/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPpt0f/8LcZSCa9NDagMFTu6e0WQH286AZEzI/uklGw=;
        b=DBYLbhr4ToYlasu1XN+oj7ujvD+31SWXuwc6+Ou1Cu6nzFNdUG2dNs3KjaloLtaODi
         H5h8luBog4wJ5v5fGLbWy199n0c2EsjX0SI4QE7FuSk2KzDK4TTuGo+9NfqvSRLCyjgS
         9xMKN+Td5iggcoGR2yRdzlAvwNHVZINNWKMvQP3skiHBZfKv9wGEDyRpfIaoleJei1A7
         DbVKuTeztwpCnXKCVgj06mNGdx55GJd1fWf+EniZRXqstMcmGtbCskXa57pOIQ1Iv4VD
         OSj/ZlQNJ1PrUM0ZLkAhoZ6rosWWa3igxySQxaVBHNvl0n6FB7Oez4r16u/bg/6FV1mj
         SYPQ==
X-Gm-Message-State: APzg51DKIYYf+g7hv0QYhfM0SYv2/mCfWrz2r7p4BUfRZOCrMIcjKeNw
        xMREWsHuMC9pmQCtpfxn67fowPJDfyw=
X-Google-Smtp-Source: ANB0VdYHa4Z7MI7nr2urSo8nnUcaTdCxl8e8IBnH7a1RFz54ls1qAUNYxSodqqEzoO2aPPKfg35e5A==
X-Received: by 2002:a50:ade6:: with SMTP id b35-v6mr24754702edd.168.1537228390296;
        Mon, 17 Sep 2018 16:53:10 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:09 -0700 (PDT)
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
Subject: [PATCHv5 7/7] tty/ldsem: Decrement wait_readers on timeouted down_read()
Date:   Tue, 18 Sep 2018 00:52:58 +0100
Message-Id: <20180917235258.5719-8-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
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

