Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83985C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480882086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpjhR3oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480882086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLJKBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:01:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33444 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeLJKBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:01:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so4744835pgu.0;
        Mon, 10 Dec 2018 02:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=peCtqHPgEFAhWJHczd1QY0IszZgub03YwSwFFTBTHG8=;
        b=TpjhR3oe4ldfNLmLXwwPTrhsZyJPw+YgouM865PvVKNYAGWoiOA1R8XSgu6zNKN6Sp
         Ma40mqY7OzDPPwr84PoY1TDU5TxlRhR537OR6VS63l/SG0nxvj6ihi2gMkCCHCYpGw7/
         9SwKFFQGEtO+gomLU5Cm/PrrgkH5REfic7ix160cPWQbdVC5cjqXdIiQJ6Ab6hbMiVim
         6i3MM7i85IKuB9zPfryFa4ad3CNhPgb5/UAI03EMAPEFfNEu7hol309xNkOZnQqI8jhq
         jtg3zFE7WIC7E1TvYy+kf66SEdE8FUS8SAlngymAilKvYot8XRnrFk+Me9zVjmw/xlR8
         dRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=peCtqHPgEFAhWJHczd1QY0IszZgub03YwSwFFTBTHG8=;
        b=A6S7rHx7S9oOBbdNiFD/EDnPTi9t+bWcYMJVKhfD0PjFs1xr6MJE3bKEZrJlBsxWeh
         xodsGpG96q5yDf1aPGD0DspFMd75AymZt6fUfL5sbliu62U5bn5GnThDCGzn3XKLiCcr
         eYP8cY8pbRElhHVGhaAjF5m4qX4E1vowmY8cfgLkIcU4Zru9NpFySlvCbfAw9xlz0eVo
         tifLOmZOn6HhrbT9aY7KSEcjy1As9/thdogrvyF/r50H3nJM6oVlQRBgpd+aUPv5rF1z
         mCEv/BE0SxvVOBQv+T3jAgqx4LVC+66oxrPSyPgkfg9e47dRBLLr1mo2v8DVmSbjYMgd
         zT3Q==
X-Gm-Message-State: AA+aEWZgzve+iNVobhsCv+PKshSJs7rIb+3AjBPeizMnPRpGWCKCJAig
        12apNQmwNMjZzJYVOdreb44jRCY0
X-Google-Smtp-Source: AFSGD/UUs52acA+9iJVIxltAe9ieYd32bZBZ96RWL1vDWEe534K+Ya1rPHFeUtzzvR04JAu2i3fm1w==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr11642060pfg.235.1544436060558;
        Mon, 10 Dec 2018 02:01:00 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b5sm22843660pfc.150.2018.12.10.02.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:00:59 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event
Date:   Mon, 10 Dec 2018 18:00:52 +0800
Message-Id: <4c3dc15beee77a541042f79f35702574347dffc9.1544436052.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a kernel-infoleak, which is caused by an uninitialized
field(sin6_flowinfo) of addr->a.v6 in sctp_inet6addr_event().
The call trace is as below:

  BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 lib/usercopy.c:33
  CPU: 1 PID: 8164 Comm: syz-executor2 Not tainted 4.20.0-rc3+ #95
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
  Google 01/01/2011
  Call Trace:
    __dump_stack lib/dump_stack.c:77 [inline]
    dump_stack+0x32d/0x480 lib/dump_stack.c:113
    kmsan_report+0x12c/0x290 mm/kmsan/kmsan.c:683
    kmsan_internal_check_memory+0x32a/0xa50 mm/kmsan/kmsan.c:743
    kmsan_copy_to_user+0x78/0xd0 mm/kmsan/kmsan_hooks.c:634
    _copy_to_user+0x19a/0x230 lib/usercopy.c:33
    copy_to_user include/linux/uaccess.h:183 [inline]
    sctp_getsockopt_local_addrs net/sctp/socket.c:5998 [inline]
    sctp_getsockopt+0x15248/0x186f0 net/sctp/socket.c:7477
    sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
    __sys_getsockopt+0x489/0x550 net/socket.c:1939
    __do_sys_getsockopt net/socket.c:1950 [inline]
    __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
    __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
    do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
    entry_SYSCALL_64_after_hwframe+0x63/0xe7

sin6_flowinfo is not really used by SCTP, so it will be fixed by simply
setting it to 0.

The issue exists since very beginning.
Thanks Alexander for the reproducer provided.

Reported-by: syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index fc6c5e4..7f0539d 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -101,6 +101,7 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
 			addr->a.v6.sin6_port = 0;
+			addr->a.v6.sin6_flowinfo = 0;
 			addr->a.v6.sin6_addr = ifa->addr;
 			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
 			addr->valid = 1;
-- 
2.1.0

