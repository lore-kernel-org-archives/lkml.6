Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39243C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A6320825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="offyPTf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A6320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeKIVMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:12:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36898 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeKIVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:12:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so1300956lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnTi0jx0/4UXQ+D2nwGSCLEYEpBNpb/n5iC2H8YXFbE=;
        b=offyPTf+1HnOqU/wSf8V5M1I2Ed8cf+7RJZXmTxj+PyLlAQ4jbpMza6Wj0B8vN2q40
         nshwMesht/Iz79Bb8DSM2AZvF09SRz6+bAr0HaoAxxaukVEtcn1GKVoDL6KfBt6+OGer
         ng1tHdUKIT//tJO3O/lINZQPpI0/vnZVlOnwsdCSR0yhukW/k7vyqmuBRH4hDpzFm8A/
         BDDK/Mv+pn68Q4aqug7sKQaNKDylY08dB1Baj0P6tUcJHS2cKg3OvIHh4CwC1Chp8Q+R
         9wno7yrK/OLmCAyZWFRLZkhdrDSCyYCtBcfx9fYCXcMqC/Oin3MGlnqTO/kVNdAGorxN
         pRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnTi0jx0/4UXQ+D2nwGSCLEYEpBNpb/n5iC2H8YXFbE=;
        b=A4FsCvWYKjVA4vd27gHno1MQ3/Dbwy7uCPKJnf+wYV4B9Sjh/GkvMFWY1H5MJ2LF2F
         P5REOnonGuBWUJ0ghZpFs2gcoPTpmG5vzvDWvqV8jqt0mx1lZSu1x5eITIF74kKQsmH6
         t9/2PPgKc5xllK1BiqcBYbXPis8rRdOosocvZ1WlWSRHNCWIVCl2m+UrwTrWPUs27rvh
         scOjKIE/y2OVV2guoCj1dFX4+Ub/v6YXAa9m7g1ATSP79RTagUactXCUV3H0MuwWy8hq
         dRL1mfPRO2u60+h8PZbcZmsuF2xZJELj7PXyyeR0Uq192A/EPcFG0wZxbjNFHgEOC7dE
         +WCA==
X-Gm-Message-State: AGRZ1gKBqm1XwZ4Z+JEKcOCmBUEwBUQK8eMz3Wl/o3K7nVa6/TcbxuGF
        poUIGE5I0R9Z47GUTu4xnwI=
X-Google-Smtp-Source: AJdET5eH/Cu4WE/2r7A/aJ21M6f6L6svNsKK1H8wTQ80HZwe0JKHlh3HsFLYUwTFFRavhBM9uvVPeQ==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr5793839ljc.147.1541763121941;
        Fri, 09 Nov 2018 03:32:01 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id m63-v6sm1463181lje.81.2018.11.09.03.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 03:32:01 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id B6AC8460899; Fri,  9 Nov 2018 14:31:53 +0300 (MSK)
Date:   Fri, 9 Nov 2018 14:31:53 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrey Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] fs/proc: timers -- Test for potential index overflow
Message-ID: <20181109113153.GJ13195@uranus.lan>
References: <20181101182722.GA2869@uranus.lan>
 <alpine.DEB.2.21.1811091010440.1640@nanos.tec.linutronix.de>
 <20181109092810.GF13195@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109092810.GF13195@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When showing timer's notify symbolic name make sure we never fetch a value
sitting outside of the names array. Though the former issue displaying
timer->it_sigev_notify has been fixed by Thomas in commit cef31d9af9082434,
better to make sure we won't hit it again on furher modifications.

v2: Use explicit index overflow test (by tglx@). Since
    it should never happen add warn-once to notify.

Cc: Andrey Vagin <avagin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 fs/proc/base.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-ml.git/fs/proc/base.c
===================================================================
--- linux-ml.git.orig/fs/proc/base.c
+++ linux-ml.git/fs/proc/base.c
@@ -2297,6 +2297,12 @@ static int show_timer(struct seq_file *m
 	timer = list_entry((struct list_head *)v, struct k_itimer, list);
 	notify = timer->it_sigev_notify;
 
+	if ((notify & ~SIGEV_THREAD_ID) >= ARRAY_SIZE(nstr)) {
+		WARN_ONCE(1, "timer: Bad signal notify mode %#x on ID %d\n",
+			  notify, timer->it_id);
+		return -EINVAL;
+	}
+
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
 		   timer->sigq->info.si_signo,
