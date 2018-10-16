Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FD2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXSRp8Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJPMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:53:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:53:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so10252198pgv.3;
        Mon, 15 Oct 2018 22:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzFIh7fM68tNcvX7bLWay90B5Fk+fBTJ+wuZ+4raSCM=;
        b=LXSRp8VhXj3g2Fk3ooTCqSYzgxNH+tJfH1bAvQ5KuqT4d39aieVKU6JqgKp76E8Guf
         c5gNQBsRdnrifwViu+Yc7ucXO5TXX5K+2tVWJ4CvPtVnhO4sVyZuLnAKlkyV3P8ji/fR
         6khbaNuakA1GO2qz9LskhllVWLsr2fzUj16ng92/VIgdvE6JC+Q0wfEK+QQ9MJmoEUoh
         lF3o+ZALhLzqnnz3wKy7PQJy6yYn0pSfgVxG6v9/kr57Qz7OXHvvZF0Ex4KWvHPe0b3q
         1y7HvFmAtzSevfUapUE/17cpis8USdZwb10RiGTkQV18I13FgcjG+vGCnTfUMIxIdcEV
         zwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzFIh7fM68tNcvX7bLWay90B5Fk+fBTJ+wuZ+4raSCM=;
        b=Y8nL1e08ju80wVS7O67AxBxMFiXxtqYWTL2Q3udLoFjLBLzxqIGybztUOrk+CX/rxM
         FUZI651PBMYq/jbNbow+GfR/JgrPTTL3jswyQsPQ2DM6nWbuaWTWQ4cNTfPaC8Q2DcF1
         kO+y39YCPXmfH4ut9bakug9XKUyYsUPC3A8WxZ+lGi3uch8mOTjlme3RI2aSsKQlLD+a
         t7zbgd2405kk4JXSvKOmsmpKVmc20anWkc/sh1tt47O/FsWo2QalCzZ2Bj6MolNi8ml7
         EKtRJ4BLCpWxeoeYL0qLs/9OCNtyFOLurKipHLsg7KRUjqj6gD6RwNC6zDN/zCIAOXBF
         M0cg==
X-Gm-Message-State: ABuFfohFzUiAzBnrfaWbOrEUDNgB/IVt658CdcUPA4+huDp6KPnsiHwp
        0yi2CxPjnbOgF4YCJjK8Ww3LiSwK
X-Google-Smtp-Source: ACcGV63/G5OFSgqqcvhUYd4ptPCkqZUZ4Ntmi47XNZSKTpMTmxZ/SHxvUWVChk4eBHK0vgw29sVTcg==
X-Received: by 2002:a63:b4b:: with SMTP id a11-v6mr17827575pgl.97.1539666280957;
        Mon, 15 Oct 2018 22:04:40 -0700 (PDT)
Received: from localhost.localdomain ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19353225pfc.52.2018.10.15.22.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 22:04:39 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCHv2 0/4] less deadlock prone serial consoles
Date:   Tue, 16 Oct 2018 14:04:24 +0900
Message-Id: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,


	RFC


	The patch set reduces the number of ways serial consoles
can deadlock the system, including the recently reported deadlock
in panic().

The test scenario I ran on my x86_64 box:
- panic() the system while one of the CPUs holds 8250's
  uart_port->lock.

Test results:

	base		|	patched
	-----------------------------------------
	deadlock	|	flush logbuf
			|	reboot the system

To keep the cover letter short, please find full description in
commit messages.

P.S. since this is RFC I modify only 8250 serial driver.

Sergey Senozhatsky (4):
  panic: avoid deadlocks in re-entrant console drivers
  printk: move printk_safe macros to printk header
  seial: introduce uart_port locking helpers
  tty: 8250: switch to uart_port locking helpers

 drivers/tty/serial/8250/8250_core.c |  8 +--
 drivers/tty/serial/8250/8250_dma.c  |  4 +-
 drivers/tty/serial/8250/8250_port.c | 81 +++++++++++++----------------
 include/linux/printk.h              | 40 ++++++++++++++
 include/linux/serial_core.h         | 48 +++++++++++++++++
 kernel/panic.c                      |  6 +++
 kernel/printk/internal.h            | 37 -------------
 kernel/printk/printk_safe.c         |  6 ++-
 8 files changed, 141 insertions(+), 89 deletions(-)

-- 
2.19.1

