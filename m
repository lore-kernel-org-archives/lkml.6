Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC78C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DD220851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gow6BwEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DD220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLKU10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:27:26 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43328 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKU1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:27:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id l200so5999634ywe.10;
        Tue, 11 Dec 2018 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lKnmtK0zdgi2LDNyagX2ic26ZL1LqZiggpIN6hpm3DU=;
        b=Gow6BwEfeBgmgZu5DPVo7p1vPOEYJhSui+9IcN2SGOgfXTbQDUIOorpQ25I4W+gYE5
         lcuNsh2pA5+mgHCO65Hxw6l2fV5Rb5seuvK3JPJdD6XFbDM4qKX6TbTZ18VAzEmFJmi2
         Uw5jYe7oXpFAYvpJ41svImuMtCJjp2fnebplMV/7NGG46EQ+4CSwT/Cutyhz3qGdiLW6
         +YqYV7eVupIAHkTiTuOpFkbCaWEln1PgWIuZlSe79XNbXixo+idzIIiazMNeCmxe3gdJ
         JxBrsd8b4j4b6pi9OIIocXxDD71ZZFZOysIRwAABerRV1eFMH3E4iqr1eEPyP4pi7Wlo
         XcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lKnmtK0zdgi2LDNyagX2ic26ZL1LqZiggpIN6hpm3DU=;
        b=Pqvu3OY51SI5UkRFiopa5XCe7CQcq1rNDlh5HomV9zCgV+40TtiIbkNIIYJczqtz4h
         3AD6aQELuG8yDBs9GCXRoZSO4gv/tZWIeUl+rFD9r7/CrX58Ya9pY3mwQgkiTLRXDP/v
         +oL07i87DeMcdsx45HsFLdqC/UoyLtluX7uKhAMqQ67ZCv2T7WJEzlqIiXrMqdnmyR7k
         +8g+V6M2HSpFDLe92hWO9lGNk+AKL8qt/lYdq+K3H8IRBZTUaTOKElUCFDXbYvNsOomz
         TV9z8TVlufVVZvB0XYWXk2Uy3E9X88sBrMKvNkHLmMLJJv8GFpjMHcVpI8YBC7DvPuYQ
         Qs9Q==
X-Gm-Message-State: AA+aEWaXdTdic1UFtdXzrcq8iFf9LiOX5qf5bRRse7l0i5/P6X3F3yYt
        aIco1KtiMoDSt1xSSLARSus=
X-Google-Smtp-Source: AFSGD/XX/7GrO16O5AHM1atAPiFR1rOuak6/5VYrwIFa5Jk/ft7SxBgX7YNRTRBb138oKIAs22obfA==
X-Received: by 2002:a81:9244:: with SMTP id j65mr18123835ywg.36.1544560042623;
        Tue, 11 Dec 2018 12:27:22 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id l35sm5415078ywh.48.2018.12.11.12.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:27:21 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        chris@zankel.net, deller@gmx.de, dhowells@redhat.com,
        fenghua.yu@intel.com, isdn@linux-pingi.de, jejb@parisc-linux.org,
        ralf@linux-mips.org, rth@twiddle.net, schwidefsky@de.ibm.com,
        tglx@linutronix.de, ubraun@linux.ibm.com,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 0/8] net: y2038-safe socket timestamps 
Date:   Tue, 11 Dec 2018 12:25:12 -0800
Message-Id: <20181211202520.16799-1-deepa.kernel@gmail.com>
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

Changes since v1:
* Dropped the change to disentangle sock flags
* Renamed sock_timeval to __kernel_sock_timeval
* Updated a few comments
* Added documentation changes

Deepa Dinamani (8):
  arch: Use asm-generic/socket.h when possible
  sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
  arch: sparc: Override struct __kernel_old_timeval
  socket: Use old_timeval types for socket timestamps
  socket: Add struct __kernel_sock_timeval
  socket: Add SO_TIMESTAMP[NS]_NEW
  socket: Add SO_TIMESTAMPING_NEW
  socket: Update timestamping Documentation

 Documentation/networking/timestamping.txt |  43 ++++++-
 arch/alpha/include/uapi/asm/socket.h      |  35 ++++--
 arch/ia64/include/uapi/asm/Kbuild         |   1 +
 arch/ia64/include/uapi/asm/socket.h       | 120 -------------------
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
 include/net/sock.h                        |   1 +
 include/uapi/asm-generic/socket.h         |  35 ++++--
 include/uapi/linux/errqueue.h             |   4 +
 include/uapi/linux/time.h                 |   7 ++
 net/bluetooth/hci_sock.c                  |   4 +-
 net/compat.c                              |  12 +-
 net/core/scm.c                            |  27 +++++
 net/core/sock.c                           | 138 ++++++++++++++--------
 net/ipv4/tcp.c                            |  82 ++++++++-----
 net/rds/af_rds.c                          |  10 +-
 net/rds/recv.c                            |  18 ++-
 net/rxrpc/local_object.c                  |   2 +-
 net/smc/af_smc.c                          |   3 +-
 net/socket.c                              |  64 +++++++---
 32 files changed, 478 insertions(+), 519 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/socket.h
 delete mode 100644 arch/s390/include/uapi/asm/socket.h
 delete mode 100644 arch/x86/include/uapi/asm/socket.h
 delete mode 100644 arch/xtensa/include/uapi/asm/socket.h


base-commit: b124b524bc97868cc2b5656e6ffa21a9b752b7e0
-- 
2.17.1

Cc: chris@zankel.net
Cc: deller@gmx.de
Cc: dhowells@redhat.com
Cc: fenghua.yu@intel.com
Cc: isdn@linux-pingi.de
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: schwidefsky@de.ibm.com
Cc: tglx@linutronix.de
Cc: ubraun@linux.ibm.com

Cc: linux-afs@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org
