Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD2C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EF320866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KftZGGWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EF320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeILFSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36623 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILFSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so358167edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQY37jV+CFCvVZI5cJxkzHhhhXO91lxoPI5YzSeDuEQ=;
        b=KftZGGWHHQaQwfG047VS0ddjTX+RMb+n+K+h2ufmkKow7SZ2Ew/R5MvAvrJ9Q7aHn/
         Q54aLHEVZr6dvnrfuLWP6YaotXJGQ8xoBiibUdvgIgzuhVvr8FP9JqzlTSdCagkBEGKb
         Fk9Z/FmFwVorNcW+7phvKUYnXEgwVIFozXo81k8//+agMBjR29MUCUUT2w+57W78Opgf
         iarhRITg83OMbf5F+8Z27e5fQC5+uVggNRB88adffj/70BDLHbwY1rZCqqNnkskJP+7G
         YF64ldKbUszyLJ/JfGPu1/ZAVurNX2ZxJCZMLC9eKgVrl/WWDXiWSk6Hr/aqJH0fVWFR
         BR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQY37jV+CFCvVZI5cJxkzHhhhXO91lxoPI5YzSeDuEQ=;
        b=JR6dI1WJzygw/rpzYl9o87ZEr0/lxKKMHCnpkebU/VkODnhBqSfDUePn75jD01Z4wj
         eeKKRlRoD3JU4E4Acy4BFqAii4HH0yvVPIWUW9jVnkMWukK4Z+dS0zIKHVQjApfjhMuF
         N2du/1Dk3eQIy13rjPYaIUQatd/yUTWrrXT6Jo3R96DvrzMs4ISWk0xDYtlzHluL3bEg
         QB3KySG2eXjkLVjHAi8xrLGduG+TsTdUZ73PZKW7piyhVwpDHB6YaLHqnJZL4LTmtzev
         VwTtZoLa/0G7IFBgQYhnLsV3xvFbfO+pAUAITCVW0etoZO8Pnx6M1XfDw5ym4U4URL6/
         FDZw==
X-Gm-Message-State: APzg51Dr1FJpRn0bv2Thz1cNKLZURdih525KDE4RA4gLk3ACo/6HWwyM
        X5BAyCdLhbHkau8wnDJroWu3QAQ2Whk=
X-Google-Smtp-Source: ANB0VdY1ty6mx2AILiqnJEoIH5mFgH1Mx3w64+eEU9+X+gQmHa0PA+RjXZ246Z1j4pNkeg3tpxYweg==
X-Received: by 2002:a50:88a4:: with SMTP id d33-v6mr30770988edd.239.1536711424435;
        Tue, 11 Sep 2018 17:17:04 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:03 -0700 (PDT)
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
Subject: [PATCHv4 0/7] tty: Hold write ldisc sem in tty_reopen()
Date:   Wed, 12 Sep 2018 01:16:54 +0100
Message-Id: <20180912001702.18522-1-dima@arista.com>
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
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty/ldsem: Wake up readers after timed out down_write()
  tty: Simplify tty->count math in tty_reopen()
  tty/ldsem: Add lockdep asserts for ldisc_sem
  tty/ldsem: Decrement wait_readers on timeouted down_read()

Peter Zijlstra (1):
  tty/ldsem: Convert to regular lockdep annotations

 drivers/tty/tty_io.c    | 12 ++++++----
 drivers/tty/tty_ldisc.c |  9 +++++++
 drivers/tty/tty_ldsem.c | 62 ++++++++++++++++++++-----------------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.13.6

