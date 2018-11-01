Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711AECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B42064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oLseqnDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4B42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeKAJZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46534 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeKAJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id f8-v6so2837052edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpTN5pGA7IFAwGBczXrryaSm+c6IlC0lW6r8xaAIF8A=;
        b=oLseqnDHr4p5PB7/ES8hk1xtj9E6ekh/vEPRkxzPe7sRa5WieveThRzItz3Z/LoY/P
         jAyWk4LZCNVz6OnNQZgvItK6AB/t0pdDzRVcTH1+dVIcE6fKh9XHc4kyTTC7Uz5zvWGl
         gJek8PSnJA7qgmVEcV96BET7dfyxefWHuYhwXHZ7YTFoGhqYaXfiT9shFgz6EAa02sXR
         OlWInqZG/cOZQW2Fj7N98MuPP8Y+UTl6Ox9cd5SfKvIkSYoSRPxOyhqlGS2F/VeaDCbB
         5hiyxrhzUOxmeogKY2Lwl2YJbnPfJPcYS8+plIpJGEfOnAPGgj+bFBeP7VKjL7wwJ1LY
         0M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpTN5pGA7IFAwGBczXrryaSm+c6IlC0lW6r8xaAIF8A=;
        b=uKyGcRRev6JDwCaB0IilqBwHnQIyWoouHK1A5x3g0r4blqLCTtmInpjjU7g9zc/Beu
         PCqSALGDE9V5UK1puUigNDlxp0X3eD19SeBvcu4m6kUEfFoJ2Z+tvVTkwDa38MQaxejc
         qzxlfd7vwMuEAlLUpgjMG0USZ2q9sp07w8cyiIS61ALrQNwqFjhr78BKTOd12uKRisZJ
         8BFE6TTXErHQJ34JEDQOse0bFnpKpBBy4zfMg656c4toMvAGJmNKaO/gcNe4u0U6zodU
         xdmkz/CUGfGVr45actYYK1arhMhi0RIYp7pL2ZLdcPjzH1agLgE8Wdy2fJ+v3eWTo8Sz
         qCGQ==
X-Gm-Message-State: AGRZ1gL7u/dl0axUYe31wCbGn5wg+53SPEi7sO8+4mXHQhsK4jiYrdec
        TLvINgo0uDA/n9fi3MoLTlYQiW3lxv0=
X-Google-Smtp-Source: AJdET5c4wOFKjJazBTYcLh5V2Z+H2q3Mk/+81MxDV79n6gd3H57gSkYJ159h1Yu/1yxYwVYQTs3kOg==
X-Received: by 2002:a17:906:2ec8:: with SMTP id s8-v6mr2795559eji.192.1541031906337;
        Wed, 31 Oct 2018 17:25:06 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:25:05 -0700 (PDT)
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
Subject: [PATCHv6 7/7] tty/ldsem: Decrement wait_readers on timeouted down_read()
Date:   Thu,  1 Nov 2018 00:24:52 +0000
Message-Id: <20181101002452.5483-8-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.1

