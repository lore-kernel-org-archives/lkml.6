Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD1820868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECkwDzlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD1820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeKXNH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:07:57 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40957 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbeKXNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:07:56 -0500
Received: by mail-yw1-f68.google.com with SMTP id r130so2260718ywg.7;
        Fri, 23 Nov 2018 18:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pybU4UWqYrI/CLuRvloJW5CDHGp6lmNrtOX4JnoQECY=;
        b=ECkwDzlfHDfN/rSSNJPyrwcOmULh/6nwUBuAyJcPQlJtuB9Z+DBpg7UJafpjhdPh15
         BYlsgXMrMngviycTTbxpTSS5b+z65xX7WpZ97tUMvQ5+QLW68z/SsH/myzkBK2Lj95lq
         4FZviQYA+4w7OGmXY8cvXUsszY01Dx6yZTlHZIK0o5p/NF8aj5XVvk2kfTe0MPDeUshY
         7MUU5lFW3QuX93zYKdP7iOEYV8IsOgVEWMsscFsmJ0xv7XMKltgsn6u9PBx2ZzDlhBtw
         fa3FG7SaCM1+tXfe/ZQY6B/vCZ1gb9K6xT7ZMo4NV1/PnM/BW5zareZIVrUYcnFtXA4Z
         ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pybU4UWqYrI/CLuRvloJW5CDHGp6lmNrtOX4JnoQECY=;
        b=VAcIfMXLEqqIghTP3BvqUKIizPGDLuaRG+eCB2i0pnJ91bxmzfCqPgVJjBFL2wgcTj
         xpaEWfhpIRxFbdjvIGW6YH33ZMcb8dluTHPUveldef3bCjKbM7h8JWM7L4mHqpTB/18w
         Vto93jFepzk9PuWuT5QgS0uiSHBGyEkyXWZHQdNYtwfTME/i+j2SR7K8RQEgfKGoFoye
         6TUgjD/2wIxA0xQK2kY10EKFXWVmJHoQgiJ+BZdat6RlDwp3NDTp8df9Ae+V7aPRO7Li
         GTRG2scQSJl1Tbrjloiiz1lQEhgTnH6n//C9oWfPEiYL1p4BXiCdyymGcmixHr5Crck9
         NOsA==
X-Gm-Message-State: AGRZ1gIp+7rD9SHFIHJl9NUnZ+ytLdzqNOfKk7nrBPxhnbIE1m9NqS+N
        hrupuNMyB/8q1jUsXpMkeM8=
X-Google-Smtp-Source: AJdET5drIBmGR7xXvOTI1s3dbO5tgeEZgUyIu7oKbQlXS+zZ57msuHkvaR9XTsbBGS9KShEIjaSwkQ==
X-Received: by 2002:a81:ed0b:: with SMTP id k11-v6mr19320272ywm.115.1543026077717;
        Fri, 23 Nov 2018 18:21:17 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:21:17 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, chris@zankel.net, fenghua.yu@intel.com,
        tglx@linutronix.de, schwidefsky@de.ibm.com,
        linux-ia64@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-s390@vger.kernel.org, deller@gmx.de, dhowells@redhat.com,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org, isdn@linux-pingi.de,
        ubraun@linux.ibm.com
Subject: [PATCH 0/8] net: y2038-safe socket timestamps 
Date:   Fri, 23 Nov 2018 18:20:27 -0800
Message-Id: <20181124022035.17519-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series introduces new socket timestamps that are
y2038 safe.

The time data types used for the existing socket timestamp
options: SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING
are not y2038 safe. The series introduces SO_TIMESTAMP_NEW,
SO_TIMESTAMPNS_NEW and SO_TIMESTAMPING_NEW to replace these.
These new timestamps can be used on all architectures.

The alternative considered was to extend the sys_setsockopt()
by using the flags. We did not receive any strong opinions about
either of the approaches. Hence, this was chosen, as glibc folks
preferred this.

The series does not deal with updating the internal kernel socket
calls like rxrpc to make them y2038 safe. This will be dealt
with separately.

Note that the timestamps behavior already does not match the
man page specific behavior:
SIOCGSTAMP
    This ioctl should only be used if the socket option SO_TIMESTAMP
	is not set on the socket. Otherwise, it returns the timestamp of
	the last packet that was received while SO_TIMESTAMP was not set,
	or it fails if no such packet has been received,
	(i.e., ioctl(2) returns -1 with errno set to ENOENT).
	
The recommendation is to update the man page to remove the above statement.

The overview of the series is as below:
1. Delete asm specific socket.h when possible.
2. Support SO/SCM_TIMESTAMP* options only in userspace.
3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
3. Alter socket options so that SOCK_RCVTSTAMPNS does
   not rely on SOCK_RCVTSTAMP.
4. Introduce y2038 safe types for socket timestamp.
5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.

Deepa Dinamani (8):
  arch: Use asm-generic/socket.h when possible
  sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
  socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
  arch: sparc: Override struct __kernel_old_timeval
  socket: Use old_timeval types for socket timestamps
  socket: Add struct sock_timeval
  socket: Add SO_TIMESTAMP[NS]_NEW
  socket: Add SO_TIMESTAMPING_NEW

 arch/alpha/include/uapi/asm/socket.h      |  35 ++++--
 arch/ia64/include/uapi/asm/Kbuild         |   1 +
 arch/ia64/include/uapi/asm/socket.h       | 120 ------------------
 arch/mips/include/uapi/asm/socket.h       |  34 ++++--
 arch/parisc/include/uapi/asm/socket.h     |  34 ++++--
 arch/s390/include/uapi/asm/Kbuild         |   1 +
 arch/s390/include/uapi/asm/socket.h       | 117 ------------------
 arch/sparc/include/uapi/asm/posix_types.h |  10 ++
 arch/sparc/include/uapi/asm/socket.h      |  36 ++++--
 arch/x86/include/uapi/asm/Kbuild          |   1 +
 arch/x86/include/uapi/asm/socket.h        |   1 -
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/uapi/asm/Kbuild       |   1 +
 arch/xtensa/include/uapi/asm/socket.h     | 122 -------------------
 drivers/isdn/mISDN/socket.c               |   2 +-
 include/linux/skbuff.h                    |  24 +++-
 include/linux/socket.h                    |   7 ++
 include/net/sock.h                        |   5 +-
 include/uapi/asm-generic/socket.h         |  35 ++++--
 include/uapi/linux/errqueue.h             |   4 +
 include/uapi/linux/time.h                 |   7 ++
 net/bluetooth/hci_sock.c                  |   4 +-
 net/compat.c                              |  12 +-
 net/core/scm.c                            |  27 ++++
 net/core/sock.c                           | 142 ++++++++++++++--------
 net/ipv4/tcp.c                            |  82 ++++++++-----
 net/rds/af_rds.c                          |  10 +-
 net/rds/recv.c                            |  18 ++-
 net/rxrpc/local_object.c                  |   2 +-
 net/smc/af_smc.c                          |   3 +-
 net/socket.c                              |  68 +++++++----
 net/unix/af_unix.c                        |   4 +-
 32 files changed, 449 insertions(+), 521 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/socket.h
 delete mode 100644 arch/s390/include/uapi/asm/socket.h
 delete mode 100644 arch/x86/include/uapi/asm/socket.h
 delete mode 100644 arch/xtensa/include/uapi/asm/socket.h


base-commit: b124b524bc97868cc2b5656e6ffa21a9b752b7e0
-- 
2.17.1

Cc: chris@zankel.net
Cc: fenghua.yu@intel.com
Cc: tglx@linutronix.de
Cc: schwidefsky@de.ibm.com
Cc: linux-ia64@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-s390@vger.kernel.org
Cc: deller@gmx.de
Cc: dhowells@redhat.com
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: linux-afs@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: isdn@linux-pingi.de
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: chris@zankel.net
Cc: fenghua.yu@intel.com
Cc: rth@twiddle.net
Cc: tglx@linutronix.de
Cc: ubraun@linux.ibm.com
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-s390@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: sparclinux@vger.kernel.org
