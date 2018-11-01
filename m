Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D68C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E59D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ7n9rBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E59D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeKBDgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:36:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34767 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeKBDgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:36:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so2603634ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kIA6zr1wEf1lIdhdSetuCJxbirtXd6KoEdbF/V6BJjI=;
        b=KJ7n9rBVDJ13MY77zJ5xD6km5dtNt9Mu94fase6vBFvBXc2uV7T+sJuiTuzhROFWoU
         Pv495Gf69fcvMJQhKb1s944c8qFf7ydPVagD9kwggjpbH5hgArMPAd5iKjEFjDNA+if4
         9uqUUbXbaMR/WTZf1+eEfpewkBEQYSQ8BBt502iJpE9qoCrCzMATsXM3602ckBLSHLwb
         AzrddzrT9w/z1xfrjOVa1cZbjETBuKUK5wRkdgoJbPtBw0DWe9001nDAImlG1+QZ6XCR
         K5J1BWb+knLtaOBaaXO+LpcRjnYsEbkAQcXa8NXGWFd+EzPJZShBHO5MVipBqQr/6oq1
         17ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kIA6zr1wEf1lIdhdSetuCJxbirtXd6KoEdbF/V6BJjI=;
        b=SQ3cVC6JUkdJz/HE/hzmRUc3SxlTQZQKw3XclsN4UVsCEnMjlXxRnyN2R5Ax/Q5uMI
         7RH3/dKwQned8S8WF44bFQAhLg2/1+AH3d/L2z++f0L/zQuvgBOCiQGBnug6apdEPGPu
         d+mVFNLS0PSaTh8zavzMlbEvuUnBTdufTpVN15RdmjRFX0Z8EwsrApFuJoGW48LZz6LO
         1N6FpNKbzhQ5CN+LGXGG2GNFX7QCKj6AeAEuW7ge16hl10G4L9CpNhASoS1YIM2ChHhV
         xZSel3dh9EaNRHygSe3fV/7ItupYWCANdnlR6Yjyft++1y04QY4RX5W/+ysng1T7RC5c
         QvqQ==
X-Gm-Message-State: AGRZ1gJsbp115xDwnqQQPqONcpIwB1IWlMXu3qAYjZwHH1fFLFvx3R0d
        qzOfk+qIGj/Yl3yqiMJ5IVQ=
X-Google-Smtp-Source: AJdET5exzvXQdTKRSCjGJxYMZNPKZiWEagxZeRhMM7DA9UJssbiDu7hTUxX5c9Yuo1dlEO+ooLOuuA==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr4832242ljb.104.1541096846440;
        Thu, 01 Nov 2018 11:27:26 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id o88sm2103635lfk.38.2018.11.01.11.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 11:27:24 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0B4D14607B5; Thu,  1 Nov 2018 21:27:23 +0300 (MSK)
Date:   Thu, 1 Nov 2018 21:27:23 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrey Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] posix-timers: Use array safe helper when fetching
 notification symbolic name
Message-ID: <20181101182722.GA2869@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When showing timer's notify symbolic name make sure we never fetch a value
sitting outside of the names array. Though the former issue displaying
timer->it_sigev_notify has been fixed by Thomas in commit cef31d9af9082434,
better to make sure we won't hit it again in furher modifications.

Cc: Andrey Vagin <avagin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 fs/proc/base.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-ml.git/fs/proc/base.c
===================================================================
--- linux-ml.git.orig/fs/proc/base.c
+++ linux-ml.git/fs/proc/base.c
@@ -2287,7 +2287,7 @@ static int show_timer(struct seq_file *m
 {
 	struct k_itimer *timer;
 	struct timers_private *tp = m->private;
-	int notify;
+	int notify, nidx;
 	static const char * const nstr[] = {
 		[SIGEV_SIGNAL] = "signal",
 		[SIGEV_NONE] = "none",
@@ -2296,13 +2296,13 @@ static int show_timer(struct seq_file *m
 
 	timer = list_entry((struct list_head *)v, struct k_itimer, list);
 	notify = timer->it_sigev_notify;
+	nidx = array_index_nospec(notify & ~SIGEV_THREAD_ID, ARRAY_SIZE(nstr));
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
 		   timer->sigq->info.si_signo,
 		   timer->sigq->info.si_value.sival_ptr);
-	seq_printf(m, "notify: %s/%s.%d\n",
-		   nstr[notify & ~SIGEV_THREAD_ID],
+	seq_printf(m, "notify: %s/%s.%d\n", nstr[nidx],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
 		   pid_nr_ns(timer->it_pid, tp->ns));
 	seq_printf(m, "ClockID: %d\n", timer->it_clock);
