Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E3AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B6E216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfIqbT8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B6E216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeI1I3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:29:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45067 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1I3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:29:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id q20-v6so2896971qkc.12;
        Thu, 27 Sep 2018 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZGk7PgCdjrbqQG3oM6AhSpqvwyDq4O1Xo1g7NqXKqw=;
        b=UfIqbT8ozJcLUAeI4/IN7kTUltDCrJq1Qpq3c0fDACGQ1D+70jnbae8mdeLPPp1fLV
         0OrP6/IqZl8CdvJKfzDbV49n9w+1ur/dH+jSDKAn7RhRcTKd1hyqfhr9ljh5if4NhZXV
         tzhAmJY/AciwFHFRSpsKFOrvrKl/4opf3TDNK0dmSfTo9nKTIHtvzqn2ZfP9x536+FvY
         5RYVnzH2XCFuZvaX/K/DVEQ0WlkmuV40vZYvRMLk3jF2V5YMlLugULJSUoF1RSDUt6lC
         OpeVRXuhk0lINTVrz1MbjpFZDRDoCyEnQwyDyGtdvS6sBL7aWf1LS2bUuAzf6+iVevR5
         kkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZGk7PgCdjrbqQG3oM6AhSpqvwyDq4O1Xo1g7NqXKqw=;
        b=C1Ld9CXEjhZZaAv0NnMqyUTYuEv7TW9h1/dFAAxKK5wdLsKM9N6MPNeZeteeKadTxz
         rN8di/V73wnm+ZoXit2oI7WUMWM+PfJJs6mj6BWcdagbu6uqAZY9fw1fZJyi3XO1G6yM
         l/NUocn6TWBxlqPuvqxceB+tPdA4sMxjKZJxD6sXDbo4kRJTL6lS7SiV8lVTIbeAFsQp
         wsiPVYCcu3Y1Gzirlj7g6plzjEp2vA5Qla8hbC2agjRAZnC4ysNjxYIj5Ep3OHsND5e8
         cs0+unkIR9cT4dHl0jVn005L9TQYpol7H7P6lLFCEZ3GJxeoNuwbgWft5ngpRbZUFGB6
         C6lw==
X-Gm-Message-State: ABuFfoigeXm2sYN6u7fakXZKjY00TOzPBB8X6FT5NXoVzL94eiVLF+Em
        2DtHhNdT35HHIRMiawYNcF0=
X-Google-Smtp-Source: ACcGV62XTM8qrwa4L5ysEjsTivaNjYbfy1mXX9wujsbB6osaFZD/xRJlOl8UjPTl2RfPWGEfbvUKHg==
X-Received: by 2002:a37:1b4b:: with SMTP id b72-v6mr10255424qkb.48.1538100513257;
        Thu, 27 Sep 2018 19:08:33 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:08:32 -0700 (PDT)
From:   =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 0/7]  Remove errors building drivers/DRIVERNAME
Date:   Thu, 27 Sep 2018 23:08:09 -0300
Message-Id: <20180928020816.11251-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Special thanks for the feedback from:
- Finn Thain (I fixed the build problem)
- Geert Uytterhoeven (The cross compilers were very useful)
- Rolf Eike Beer (Was unintentional, thanks for the help!)

This Patchset changes some driver's Makefile to allow them building
using the command 'make drivers/DRIVERNAME', if compatible.

The changed drivers would return error if the above command was run
on them, after an x86 allyesconfig.

The main reason of this patchset is to allow building lists of
drivers looking for warnings and errors to be fixed.

I see this change as a new feature, not a bugfix. I understand
the default bahavior may be building with a simple 'make', but I
believe adding this new possibility will not be harmful.

My main objective is to allow developers with low processing power
to do changes in the kernel and look bugs using free services like
GiltabCI, before submitting to community.

If there is any interest helping/using this, I have a prototype in:
https://gitlab.com/LeoBras/linux-next


Leonardo Brás (7):
  drivers: dio: Avoids building driver if CONFIG_DIO is disabled
  drivers: nubus: Avoids building driver if CONFIG_NUBUS is disabled
  drivers: parisc: Avoids building driver if CONFIG_PARISC is disabled
  drivers: zorro: Avoids building proc.o if CONFIG_ZORRO is disabled
  drivers: s390: Avoids building drivers if ARCH is not s390.
  drivers: oprofile: Avoids building driver from direct make command
  drivers: hwtracing: Adds Makefile to enable building from directory.

 drivers/Makefile           | 4 +---
 drivers/dio/Makefile       | 2 +-
 drivers/hwtracing/Makefile | 3 +++
 drivers/nubus/Makefile     | 5 +++--
 drivers/oprofile/Makefile  | 1 +
 drivers/parisc/Makefile    | 2 +-
 drivers/s390/Makefile      | 8 ++++----
 drivers/zorro/Makefile     | 7 ++++---
 8 files changed, 18 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile
 create mode 100644 drivers/oprofile/Makefile

-- 
2.19.0

