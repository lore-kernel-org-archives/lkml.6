Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30501C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17DA20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iaDZVPHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17DA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKAJZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44881 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeKAJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id n19-v6so4213132edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMG15DGucezO+5b7xza6DB5g0NQ7vbcTXol7ObZ389M=;
        b=iaDZVPHtx55/QS26V7+6Hm0VXueSzEldiK4I+RsTrlr+LVeB/JUJCHRIBXpWlmjOgy
         UQCVdxdMeDzwfrXRS5nW0PMU/cp7JfrtUwLtuaPNAyUSbByj145nJUyzf4gLW9wrFuIp
         jEIyxlexpGIaPCuYWUvfmqpNteYImuARjR40+KRMtZD/fcae8UOqYeimXkRs4Yc1Ghb1
         bLYhgQa0OFs4AjsgEao+tRZQquSLciRjxFc4ZIYAx3/Ofi+AqPrpWlwb3UjKnfGvIGvu
         WaiFbqnAtB33u5lxRYtlNNXbrgwUuA1IQUL8aw6NSblpXOr+TaPQA78OqOa6ZZgTeujv
         aZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMG15DGucezO+5b7xza6DB5g0NQ7vbcTXol7ObZ389M=;
        b=tDw5aLZ7Ev5aUNexIrcqHIziebRULIOAmAcRwUpQ9HaW1fEHFXE7V3OaIfoG9x+rDv
         cV7fMW4CJ+ur9aVoEaK3Ru51k3ihU1S3cKsSeIbit4lbGNmbKJwQk1lwWcFomOmt4qXq
         aOnzsZnCYN/Uzo4VNV6svDoh4DuKXnrXlcIcOMDMFgc5bYShviquXu3ZEmY+UOfZzf/z
         IlZIOwTUL7yMzOhx8Onndl90nnPQU9z+hkzrBktUjHvicjwOfUKhhNRpzLO8r5Xv7Z7s
         rHhfilzpRxNZpnHO1TgKKVckS/2JxD2MIaMeJ2cUwCYCoVSpi9nnBWkAtJ+xw3LP+Re1
         jdgA==
X-Gm-Message-State: AGRZ1gLcqNufwgKaM4F5jRstpVz8MBjrZxYtbaLR1GqIrN/GdgPqAWdz
        k7aaQrhnb2RVSrueTzCBMjRwOk+0NqM=
X-Google-Smtp-Source: AJdET5dAkU9WS4uvQRwcKbhH4e30BSi7IrtAkdRvgwMO7qfQIFi2xHSzl/0fHNQeqRaMNMKogOMlkA==
X-Received: by 2002:aa7:da86:: with SMTP id q6-v6mr3865947eds.13.1541031894893;
        Wed, 31 Oct 2018 17:24:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:24:53 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
Date:   Thu,  1 Nov 2018 00:24:45 +0000
Message-Id: <20181101002452.5483-1-dima@arista.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are fixes that worth to have in the @stable, as they were hit by
different people, including Arista on v4.9 stable.

And for linux-next - adding lockdep asserts for line discipline changing
code, verifying that write ldisc sem will be held forthwith.

Mikulas, can you add your tested-by on this patches set again, please?
I tried to reproduce reboot issue on qemu-hppa and even built
cross-compiler for pa-risc.. but was unlucky in reproducing.

Thanks,
Dima

Changes since v5:
- Better commit tags
- Hopefully fixed issue with reboot on pa-risc with Debian 5

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
  tty/ldsem: Wake up readers after timed out down_write()
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty: Don't block on IO when ldisc change is pending
  tty: Simplify tty->count math in tty_reopen()
  tty/ldsem: Add lockdep asserts for ldisc_sem
  tty/ldsem: Decrement wait_readers on timeouted down_read()

Peter Zijlstra (1):
  tty/ldsem: Convert to regular lockdep annotations

 drivers/tty/n_hdlc.c    |  4 +--
 drivers/tty/n_r3964.c   |  2 +-
 drivers/tty/n_tty.c     |  8 +++---
 drivers/tty/tty_io.c    | 14 ++++++----
 drivers/tty/tty_ldisc.c | 16 +++++++++++
 drivers/tty/tty_ldsem.c | 62 +++++++++++++++++------------------------
 include/linux/tty.h     |  7 +++++
 7 files changed, 63 insertions(+), 50 deletions(-)

-- 
2.19.1

