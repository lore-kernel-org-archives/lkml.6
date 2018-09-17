Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B792F20C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Tte6IcGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B792F20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeIRFWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38742 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIRFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so386326edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bOgwdcbB1AONl4K/v+gAHTVcRCVvcpItyB7zluGi9c=;
        b=Tte6IcGB3//aXsng6GSHU6OFREXVaH6rbqd9J8YPSjc6wjJuupSGxX+D25wXnFuNJc
         gSBG59aMEVao6aUlLMtYcYVHhuAfIrvCjx0thGwTbz49fADgWXOpHdU15JRHeUEkOTqD
         AOevKoZkFo80OF2WWJSlqWgJXD69/u5CQQSmM30rDuIyevZaShWJ8WeaXmKs7NcOPxYR
         Q6WU5d85sM0CrOa0fSKb4Z6JHq6qEzs8V8bqsRjjKLJAAMNeVtHunc5+R7tVg24VS7Qh
         WCYyCU2NQUF8Wc1xWuZZ6rdAkXbSmmuSMOyIhWr6unR0KPH6kaFvsxZaDRJA2t9dRLL/
         plaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bOgwdcbB1AONl4K/v+gAHTVcRCVvcpItyB7zluGi9c=;
        b=P8wSoBm6tm3lr+aIPcqo71NEAvsF6aHPXkSS96t+Alk4uRK0AAq7925oQQhtJ2s+JG
         V8r66HkYNFgOWyeV2/UylxoO4Ste5W07IGFnnbmXH1UbrkjUHR8i48eIXTRO+c7bUyJ8
         GfYsEQFt2dL3jJKfCHUuY7jlMkALqYCIvVRcgNLHBrmRYla0XUsey1/BAxp5dV2JZPqR
         gQ/cYsqOTQmABF80pOf1AUi9eYWtjMtK5a4HYNr/M6l10OJZ/UF3s8rhn/UqCLQlM34Y
         V6TC4Kyzu+lci00eSUDjoQa1Q96kzA3a00PTEcQ4UAhPJs9E3+fxPqykjKC53NUjrBH4
         QEvg==
X-Gm-Message-State: APzg51BN3JFJc7UUHfJy+kNXfCdEQVWSh/0IwIvyrhwCcWjsHpT6cjv4
        WIWq57m1Il5Wyy0etIBHj7sCk4mSZ4c=
X-Google-Smtp-Source: ANB0VdZ5Mcub6qnFN/nZkw6cn3vcGyz7l2Sn1HK86CNmHdFwJwiFPiz3BK/1qdHDlCRYw0aUELA/5A==
X-Received: by 2002:a50:a542:: with SMTP id z2-v6mr45949622edb.77.1537228380925;
        Mon, 17 Sep 2018 16:53:00 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: [PATCHv5 0/7] tty: Hold write ldisc sem in tty_reopen()
Date:   Tue, 18 Sep 2018 00:52:51 +0100
Message-Id: <20180917235258.5719-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Three fixes that worth to have in the @stable, as they were hit by
different people, including Arista on v4.9 stable.

And for linux-next - adding lockdep asserts for line discipline changing
code, verifying that write ldisc sem will be held forthwith.

The last patch is an optional and probably, timeout can be dropped for
read_lock(). I'll do it if everyone agrees.
(Or as per discussion with Peter in v3, just convert ldisc to
a regular rwsem).

Thanks,
Dima

Changes since v4:
- back to lock ldisc with (5*HZ) timeout in tty_reopen()
  (LKP report link: lkml.kernel.org/r/<1536940609.3185.29.camel@arista.com>)
- reordered 3/7 with 2/7 for LKP robot

Changes since v3:
- Added tested-by Mark Rutland (thanks!)
- Dropped patch with smp_wmb() - wrong idea
- lockdep_assert_held() should be actually lockdep_assert_held_exclusive()
- Described why tty_ldisc_open() can be called without ldisc_sem held
  for pty slave end (o_tty).
- Added Peter's patch for dropping self-made lockdep annotations
- Fix for a reader(s) of ldisc semaphore waiting for an active reader(s)

Changes since v2:
- Added reviewed-by tags
- Hopefully, fixed reported by 0-day issue.
- Added optional fix for wait_readers decrement

Changes since v1:
- Added tested-by/reported-by tags
- Dropped 3/4 (locking tty pair for lockdep sake),
  Because of that - not adding lockdep_assert_held() in tty_ldisc_open()
- Added 4/4 cleanup to inc tty->count only on success of
  tty_ldisc_reinit()
- lock ldisc without (5*HZ) timeout in tty_reopen()

v1 link: lkml.kernel.org/r/<20180829022353.23568-1-dima@arista.com>
v2 link: lkml.kernel.org/r/<20180903165257.29227-1-dima@arista.com>
v3 link: lkml.kernel.org/r/<20180911014821.26286-1-dima@arista.com>
v4 link: lkml.kernel.org/r/<20180912001702.18522-1-dima@arista.com>

Cc: Daniel Axtens <dja@axtens.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Nathan March <nathan@gt.net>
Cc: Pasi Kärkkäinen <pasik@iki.fi>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rong, Chen" <rong.a.chen@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
(please, ignore if I Cc'ed you mistakenly)

Dmitry Safonov (6):
  tty: Drop tty->count on tty_reopen() failure
  tty/ldsem: Wake up readers after timed out down_write()
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty: Simplify tty->count math in tty_reopen()
  tty/ldsem: Add lockdep asserts for ldisc_sem
  tty/ldsem: Decrement wait_readers on timeouted down_read()

Peter Zijlstra (1):
  tty/ldsem: Convert to regular lockdep annotations

 drivers/tty/tty_io.c    | 13 ++++++++---
 drivers/tty/tty_ldisc.c |  9 +++++++
 drivers/tty/tty_ldsem.c | 62 ++++++++++++++++++++-----------------------------
 3 files changed, 44 insertions(+), 40 deletions(-)

-- 
2.13.6

