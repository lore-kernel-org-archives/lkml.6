Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA5C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EBA20831
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj5IM+Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EBA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKCLeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:34:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeKCLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:34:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so1807818pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jgP/FSryjkPgs2dFeGL5IISgnlHI7Lv5u052+Cpj3QA=;
        b=Qj5IM+DnDJEJLwE9QzK7IjjTJCN+tzreC9TBKfF6xS7YJPfBeBg5hVi+3uH92tzxYN
         SDqz5lw7ohQX4C0SOO2R4cmhma0tSIeS+Lgh+BnNHoeL6QxoC0eAf6DO6Px8X1Qo5pn6
         IvcwP5s/NQ1A5ZWBgNIhwjbRkfAWgDU9pdSrkkvVTC9hE0f+0iM6Jwu62uk8ifEqI53z
         cq3cLHHUJSwdQx4c7EOFxtD8Neq0FnyEPfYuQaxH1nXo+1JF7ylDas8U7NfSn734ToBt
         mysPuOFJI44OWePpDvic9eqspChmEQjY0aKUXXfScl/coPZx7+bN7p4PJPot2w36PuUp
         veSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jgP/FSryjkPgs2dFeGL5IISgnlHI7Lv5u052+Cpj3QA=;
        b=oeISRIqhIwODa48m9aubardXoryA6kQ5/JRxOu0NRIFXhpXx/WEPXG3FFugtkbn6Vj
         p1GRAbR86saJwYFJbHkAYKf5yFngvZXU38blWVLWjImojhGXAH4EVqrABaN7/kOgtCsq
         pVnLqbgZpkGr+p92G4CJwMzPciIMSiq1EChRVHkAFEWQJCIORZHBH8L8jZ8QBba7k7ke
         v58rJMfdfDMmUnOzZhkiVWv2+fxPXKgYI1+QqnKt7iV6AjSXiWkjhgV13ysgARwckYbN
         sm6mzSu9suOj5U00kvQ395zu9cXutw9OZnVwuxiw3+tq6HYNZ3s/tsgLAT5NmHtozqmS
         XUgA==
X-Gm-Message-State: AGRZ1gLa9eqp7PofSquzqOAPDRDeYWZygkXi2grnLxh9RntIKqA7lSqU
        CUvDSsRkLe6619x5JXiLLA==
X-Google-Smtp-Source: AJdET5d/+2sVHyeNPgPKynWQT7ey+6m+jJufNDtRkSeb/Tjob8XsQ0on39QOhgQjy2HtMXEuNeO1hg==
X-Received: by 2002:a62:204a:: with SMTP id g71-v6mr13833573pfg.28.1541211875296;
        Fri, 02 Nov 2018 19:24:35 -0700 (PDT)
Received: from jeantsuru-pc (softbank126121223180.bbtec.net. [126.121.223.180])
        by smtp.gmail.com with ESMTPSA id h128sm967066pgc.15.2018.11.02.19.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 19:24:34 -0700 (PDT)
Date:   Sat, 3 Nov 2018 11:25:46 +0900
From:   Takeshi Misawa <jeliantsurux@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] trace: fix memory leak in create_filter()
Message-ID: <20181103022546.GA1404@jeantsuru-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In create_filter(), pe variable is leaked.

Since commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler
and faster"), create_filter_finish() is missing.

kmemleak:

unreferenced object 0xffff90148ba9c790 (size 8):
  comm "bash", pid 1378, jiffies 4294731025 (age 15.258s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000d9a25450>] create_filter+0x47/0xc0
    [<0000000084514f08>] set_trigger_filter+0x87/0x130
    [<0000000017f6c9ef>] event_trigger_callback+0x114/0x220
    [<000000005096f447>] event_trigger_write+0x113/0x1b0
    [<00000000a5f767d1>] __vfs_write+0x36/0x1a0
    [<00000000ca62b71e>] vfs_write+0xa5/0x1a0
    [<00000000fdbd8005>] ksys_write+0x4f/0xb0
    [<00000000ec6e3711>] do_syscall_64+0x5b/0x160
    [<000000003ad36bb4>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<000000007a35f0f5>] 0xffffffffffffffff

Fix this.

Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
---
I found kmemleak in tracing subsystem.
Please consider this patch.

Regards.
---
 kernel/trace/trace_events_filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 84a65173b1e9..fb4ba08163ba 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1719,6 +1719,8 @@ static int create_filter(struct trace_event_call *call,
 	if (err && set_str)
 		append_filter_err(pe, *filterp);
 
+	create_filter_finish(pe);
+
 	return err;
 }
 
-- 
2.19.1

