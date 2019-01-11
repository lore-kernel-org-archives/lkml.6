Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A5C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CEC2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhQ8q5Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfAKGBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:01:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfAKGBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:01:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so13833195wrs.10;
        Thu, 10 Jan 2019 22:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zo5zacuE/J3emwXI9S0ANQnWAU734T5skdDndtMdLL8=;
        b=PhQ8q5Y6883lYM90PI4zrKMeikl3NNCrjuJssiG3/Uondui8fH08mWMHjnlHqQd4VD
         1jyiMc6Rxlm0Ei7x8IXCXU+gAQQQZ509GDoAyhyk/SudBr2BdXFy3syoTu2GlybyEOkb
         HtU479JnxK+Gy8gKTeg9xXGOdmDY1bFMkxdLxJRv408MFi3Ed+x7QzsMcFi1Xorq5AtS
         rHb5fZmfmz3CDQVWILyS3nFS7MH63vVN2AYGIUahc/XXiEJyhbZRffdc6OyN/vgV63+c
         z8/EQwYYp1pcHIAqsANRWnYVbeL7kK4Mcpwam2Yi4CIxVwqkff1PrS268YFWO0wIltdr
         rPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zo5zacuE/J3emwXI9S0ANQnWAU734T5skdDndtMdLL8=;
        b=CuUZjgYgdqcuJtEWfsBljgnYYmEJEsS+KTD9ZD0pH566s2aRwyJczas2JIHqEN/7wi
         pRgGK73l2DKOlPKvcBdhjVJOrnbevWyrOgtLLNJ+Y4L97tbks1q397JIeGupZrKVZDYw
         Lxf/vzdean+G+NsQsfOaoqdWjn1BwG7k/WPF67PHfFCi/DTROB6AVtx5FAFvW0vwdAjp
         LbO0pRtYmJFKTntIcrTZJMl73ei6ceYDAYzUQbOnEuKi/kckzhMTQ0D3/yf3CQiylPib
         QreQXMn+hEBpZc++6tVcYlbibSwc9a27p74tMuBnP6BiET1ZqW8p6BXfx3K1tNUcJ1db
         isow==
X-Gm-Message-State: AJcUukfv59QAwrwrlt8pvkfuFEMEcM3sooDiie8t/r7vNQWH2KFxsB4/
        M8xDu2z8cJBz5FA9KJA9Lw==
X-Google-Smtp-Source: ALg8bN6YFV7M2N7dSXhWqCfFqUH0d+9pmOQ8mIJAv6P12jNhwX44wy+BqV2IH+BT+0dd2+ONlAOfUQ==
X-Received: by 2002:adf:b649:: with SMTP id i9mr12397823wre.70.1547186475385;
        Thu, 10 Jan 2019 22:01:15 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id d2sm53771324wrs.97.2019.01.10.22.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 22:01:14 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:01:13 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] tracing/kprobes: fix NULL pointer dereference in
 trace_kprobe_create()
Message-ID: <20190111060113.GA22841@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to trigger a NULL pointer dereference by writing an
incorrectly formatted string to krpobe_events (trying to create a
kretprobe omitting the symbol).

Example:

 echo "r:event_1 " >> /sys/kernel/debug/tracing/kprobe_events

That triggers this:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 #PF error: [normal kernel read fault]
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 6 PID: 1757 Comm: bash Not tainted 5.0.0-rc1+ #125
 Hardware name: Dell Inc. XPS 13 9370/0F6P3V, BIOS 1.5.1 08/09/2018
 RIP: 0010:kstrtoull+0x2/0x20
 Code: 28 00 00 00 75 17 48 83 c4 18 5b 41 5c 5d c3 b8 ea ff ff ff eb e1 b8 de ff ff ff eb da e8 d6 36 bb ff 66 0f 1f 44 00 00 31 c0 <80> 3f 2b 55 48 89 e5 0f 94 c0 48 01 c7 e8 5c ff ff ff 5d c3 66 2e
 RSP: 0018:ffffb5d482e57cb8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff82b12720
 RDX: ffffb5d482e57cf8 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffffb5d482e57d70 R08: ffffa0c05e5a7080 R09: ffffa0c05e003980
 R10: 0000000000000000 R11: 0000000040000000 R12: ffffa0c04fe87b08
 R13: 0000000000000001 R14: 000000000000000b R15: ffffa0c058d749e1
 FS:  00007f137c7f7740(0000) GS:ffffa0c05e580000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000497d46004 CR4: 00000000003606e0
 Call Trace:
  ? trace_kprobe_create+0xb6/0x840
  ? _cond_resched+0x19/0x40
  ? _cond_resched+0x19/0x40
  ? __kmalloc+0x62/0x210
  ? argv_split+0x8f/0x140
  ? trace_kprobe_create+0x840/0x840
  ? trace_kprobe_create+0x840/0x840
  create_or_delete_trace_kprobe+0x11/0x30
  trace_run_command+0x50/0x90
  trace_parse_run_command+0xc1/0x160
  probes_write+0x10/0x20
  __vfs_write+0x3a/0x1b0
  ? apparmor_file_permission+0x1a/0x20
  ? security_file_permission+0x31/0xf0
  ? _cond_resched+0x19/0x40
  vfs_write+0xb1/0x1a0
  ksys_write+0x55/0xc0
  __x64_sys_write+0x1a/0x20
  do_syscall_64+0x5a/0x120
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix by doing the proper argument checks in trace_kprobe_create().

Link: https://lore.kernel.org/lkml/20190111095108.b79a2ee026185cbd62365977@kernel.org
Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 v2: argument check refactoring

 kernel/trace/trace_kprobe.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5c19b8c41c7e..d5fb09ebba8b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -607,11 +607,17 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL;
 
-	/* argc must be >= 1 */
-	if (argv[0][0] == 'r') {
+	switch (argv[0][0]) {
+	case 'r':
 		is_return = true;
 		flags |= TPARG_FL_RETURN;
-	} else if (argv[0][0] != 'p' || argc < 2)
+		break;
+	case 'p':
+		break;
+	default:
+		return -ECANCELED;
+	}
+	if (argc < 2)
 		return -ECANCELED;
 
 	event = strchr(&argv[0][1], ':');
-- 
2.17.1

