Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34761C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1740208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOG9PuTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1740208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbeFTIbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33146 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:32 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so1376794plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9Kdipma9iNqIHKAMygoY8ZsChi5GOVdSQeD7pQwPZA=;
        b=FOG9PuTqm9nH2MOGjaD4rz1qbDQFvi63usEp6vTGdsVMoEnePHKhOUGGDa95AxxZDY
         N9u/CO7bm35xgc+QiJbiTtadWKjP7QdQBYbnAlzOUlGTuxJ6tVTpOZ1FriQuTf/La9dM
         jioCzEnoCS1vKOCJELe3cOsGSC/fF8bks+QcA/lKLnMxV4KLC/8iSI//2pnqZCOHS8X4
         sXU3Yzp29v1jzgPyizv4Xn8JyMDmDl6u3g60nL2z4phLWbsaznu7gZBlCDUic+zLALGs
         S6g9+aqrFSKMy8i7Z8joch80KcWpHojCpZwvhIwlNVve7kYvQBzDD+A7QahY6NESbZ7u
         mWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9Kdipma9iNqIHKAMygoY8ZsChi5GOVdSQeD7pQwPZA=;
        b=UCRR+wJG5xO49LlODvNb1NfXrsylq5j0US1o6peYDnJT+zDX9IbD/Htl7ROCE3mOTZ
         HEhtg42mTabH/Svs24OEUItHknFbXXQJJzsm9SyHs8BOoni7y3esWqcMOzjnArC4ojXT
         MZAJ2qsNk/7VjCY6hiC0KSnZeGGVAXp8mscN6qhAxJLWkkCKcAbUmqevPw228rXY4qAk
         PR9mfiP6IKRoXkgs1FoO+rF+LWYKvmIzl/Be+lqXtF7WFnjVdRS+IeUeSMvgax8Om7Qd
         XE/F1lTaae6cLX4ANhgl+SFR84jPqcOi/or0/q1tfipdRcQiqQQVt2pPI2W0k1YA92sA
         Lvkg==
X-Gm-Message-State: APt69E1ynRv6SF2qCWKyfpNcnl21krTdepuj6sB0kSsxz22mrj7VWLZn
        YZn8eWBVx9CIIa64sIl3G5Q=
X-Google-Smtp-Source: ADUXVKLt87b1ovZDXYKm4r4Bv/GgsDDD+II5jmbfqt8fnxy31hQsMSlwmMSvfL+OyXTzg3sS9cixYw==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr22350946plb.211.1529483491448;
        Wed, 20 Jun 2018 01:31:31 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id r86-v6sm3224997pfd.154.2018.06.20.01.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 01:31:29 -0700 (PDT)
Date:   Wed, 20 Jun 2018 17:31:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180620083126.GA477@jagdpanzerIV>
References: <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 07:44), Dmitry Vyukov wrote:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> sysfs: cannot create duplicate filename '/class/ieee80211/!'
> PGD 1cae7e067 P4D 1cae7e067 PUD 1b4da6067 PMD 0
> Oops: 0010 [#1] SMP KASAN
> CPU: 1 PID: 1728 Comm: syz-executor4 Not tainted 4.17.0+ #84
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> CPU: 0 PID: 1738 Comm: syz-executor7 Not tainted 4.17.0+ #84
> RIP: 0010:          (null)
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Code:
> Call Trace:
> Bad RIP value.
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> RSP: 0018:ffff88018cd3f590 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff880192f05800 RCX: 1ffffffff10eeea9
>  sysfs_warn_dup.cold.3+0x1c/0x2b fs/sysfs/dir.c:30
> RDX: ffff88018cd3fab0 RSI: ffff8801c927a480 RDI: ffff88018c77c040
>  sysfs_do_create_link_sd.isra.2+0x116/0x130 fs/sysfs/symlink.c:50
> RBP: ffff88018cd3f700 R08: 0000000000000001 R09: 0000000000000000
>  sysfs_do_create_link fs/sysfs/symlink.c:79 [inline]
>  sysfs_create_link+0x65/0xc0 fs/sysfs/symlink.c:91
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100319a7eb7
> R13: ffff88018cd3fab0 R14: ffff880192f05812 R15: ffff880192f05c58
>  device_add_class_symlinks drivers/base/core.c:1632 [inline]
>  device_add+0x5c9/0x16f0 drivers/base/core.c:1834
> FS:  00007f4a8e71f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000191e1b000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  wiphy_register+0x182e/0x24e0 net/wireless/core.c:813
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ieee80211_register_hw+0x13cd/0x35d0 net/mac80211/main.c:1050
>  sock_poll+0x1d1/0x710 net/socket.c:1168
>  mac80211_hwsim_new_radio+0x1da2/0x33b0
> drivers/net/wireless/mac80211_hwsim.c:2772
>  vfs_poll+0x77/0x2a0 fs/select.c:40
>  do_pollfd fs/select.c:848 [inline]
>  do_poll fs/select.c:896 [inline]
>  do_sys_poll+0x6fd/0x1100 fs/select.c:990
>  hwsim_new_radio_nl+0x7b8/0xa60 drivers/net/wireless/mac80211_hwsim.c:3247
>  genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
>  genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
>  __do_sys_poll fs/select.c:1048 [inline]
>  __se_sys_poll fs/select.c:1036 [inline]
>  __x64_sys_poll+0x189/0x510 fs/select.c:1036
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455b29
>  sock_sendmsg_nosec net/socket.c:645 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:655
> Code:
>  ___sys_sendmsg+0x805/0x940 net/socket.c:2161
> 1d
> ba
> fb
> ff
> c3
> 66
> 2e
> 0f
> 1f
>  __sys_sendmsg+0x115/0x270 net/socket.c:2199
> 84
> 00
> 00
> 00
>  __do_sys_sendmsg net/socket.c:2208 [inline]
>  __se_sys_sendmsg net/socket.c:2206 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2206
> 00
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
> 00 66
> 90
> 48
> 89
> f8 48
> 89

Meh, pr_cont() output... I forgot about it. So I have a very simple
patch [probably buggy]. One thing we can be sure of is that It does
not handle pr_cont() interleaving properly - it logs the context which
has stored the messages, while in case of pr_cont() it is not always
correct since we can have a preliminary pr_cont() flush. It also doesn't
handle printk_safe stuff. Tetsuo's patch, probably, handled all those
cases. Hmm.

The patch below is less intrusive but also less complete / less universal.
Maybe it's enough for you, maybe it's not. Wondering if this patch will
make any difference on your side to being with. Note, I'm not pushing for
this particular message format, we can change it the way you want.

===

Subject: [PATCH] printk: log message origin context info

---
 kernel/printk/printk.c | 31 ++++++++++++++++++++++++++++++-
 lib/Kconfig.debug      |  8 ++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..304a02b0c432 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -580,16 +580,38 @@ static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
 	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
 }
 
+static size_t log_message_origin(char *buf, size_t buf_len)
+{
+	size_t ret = 0;
+
+#ifdef CONFIG_PRINTK_LOG_MESSAGE_ORIGIN
+	ret = snprintf(buf,
+			buf_len,
+			"[%d/%d preempt:%lu/%lu/%lu] ",
+			raw_smp_processor_id(),
+			task_pid_nr(current),
+			in_nmi(),
+			in_irq(),
+			in_serving_softirq());
+#endif
+	return ret;
+}
+
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(int facility, int level,
 		     enum log_flags flags, u64 ts_nsec,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
+	static char log_origin[64];
+	static size_t log_origin_len;
 	struct printk_log *msg;
 	u32 size, pad_len;
 	u16 trunc_msg_len = 0;
 
+	log_origin_len = log_message_origin(log_origin, sizeof(log_origin));
+	text_len += log_origin_len;
+
 	/* number of '\0' padding bytes to next message */
 	size = msg_used_size(text_len, dict_len, &pad_len);
 
@@ -614,7 +636,14 @@ static int log_store(int facility, int level,
 
 	/* fill message */
 	msg = (struct printk_log *)(log_buf + log_next_idx);
-	memcpy(log_text(msg), text, text_len);
+	if (log_origin_len) {
+		memcpy(log_text(msg), log_origin, log_origin_len);
+		memcpy(log_text(msg) + log_origin_len,
+			text,
+			text_len - log_origin_len);
+	} else {
+		memcpy(log_text(msg), text, text_len);
+	}
 	msg->text_len = text_len;
 	if (trunc_msg_len) {
 		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..57220642a00b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -15,6 +15,14 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
+config PRINTK_LOG_MESSAGE_ORIGIN
+	bool "Store printk() message origin context info"
+	depends on PRINTK
+	help
+	  Selecting this option causes extra information - CPU, task pid,
+	  preemption mask - to be added to the every message. This can be
+	  helpful when interleaving printk() lines cause too much.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
2.17.1

