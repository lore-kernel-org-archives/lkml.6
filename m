Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA55B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuh8eZQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfAJRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:39:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36844 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfAJRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:39:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so12368239wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=irOkNdKGnGKV4MKWUHOaZlcsapchqvro1r7W9fjm8nE=;
        b=tuh8eZQ6TG0E2a21sC1juhkXfN4SZ/eDVt9IAN29cgdlO4uB0JPbEY7KpqRwDRuadN
         JlqA5oI7j2h+KXsXb4/bpQ+IwoL1jO3ghBl1FvOMElWmC2ajS7veNaPPaqtjWxZ040x3
         blHQHb1n3wZE/c9xA7KNCxZO8+Ve5p8K08DyUOk4H+IdYC9FUw9tuAlrxjR0yjFAp/hX
         skflag0fnOvqDX5kxzNFWbxzI3QyqyuHCiEZRR434JToXgjlTZmzwJigIa1eDJa5JoFn
         fSDv30xgBLEBu22MmDIK/xhz4c+bt2fHswgqIJwZCB4Ezrb0FCet7Qd9+axDsNNPTiSU
         kg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=irOkNdKGnGKV4MKWUHOaZlcsapchqvro1r7W9fjm8nE=;
        b=IcgF5twyTCq2OxEtfHoN7cjUnpgsXeDr8yFiIQ2jfQlWjJ1wlOaMxZGw7EBD7KzQvz
         tBF7YTYJx3byQFxIErSnotzTaz5ntowcRUnkMZSqNDM/ZPuaMaZazqzWyc2C44H3vWZ8
         KjqRsNR6+Q1NABsRGkf8rkUQ6O7nR7xO+A5jMgaT2kk8cYEnbpTkJh5INhVSx0A8qasR
         w6EWJ6i+OTI5pL2xqjoV/mvhqvlyjEpn14g8c+5QJz3SGM7XseCIj8TTrchQPhK81H5U
         fmlik4xa8lo9j7TgXb+vxKGb7/Ci5yCJHMqldNU/vMNPDe252lUtgGsKiXuWkoStr3Qt
         3/NA==
X-Gm-Message-State: AJcUukffS7ZZQFkdocK8r7IpDlRIC4aVHX5GPQa2rv1oGssP+T+mqV7c
        MlMTLg43BXIpPZGPGwgRaZDC16aHbg==
X-Google-Smtp-Source: ALg8bN64ES443wfqY0MQF0KQ341Vd1+N7SalgKsll/kmF54+8nB1dfLwPqMKgKcc19NyrgPEAeek7Q==
X-Received: by 2002:adf:c612:: with SMTP id n18mr9874066wrg.174.1547141988567;
        Thu, 10 Jan 2019 09:39:48 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id c8sm51844622wrx.42.2019.01.10.09.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:39:48 -0800 (PST)
Date:   Thu, 10 Jan 2019 18:39:47 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/kprobes: fix NULL pointer dereference in
 trace_kprobe_create()
Message-ID: <20190110173947.GA19243@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to trigger a NULL pointer dereference by writing an
incorrectly formatted string to krpobe_events (omitting the symbol).

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

Fix by doing the proper argument check when a NULL symbol is passed in
trace_kprobe_create().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 kernel/trace/trace_kprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5c19b8c41c7e..76410ceeff50 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -644,6 +644,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
 
 	/* try to parse an address. if that fails, try to read the
 	 * input as a symbol. */
+	if (!argv[1])
+		return -EINVAL;
 	if (kstrtoul(argv[1], 0, (unsigned long *)&addr)) {
 		/* Check whether uprobe event specified */
 		if (strchr(argv[1], '/') && strchr(argv[1], ':'))
-- 
2.17.1

