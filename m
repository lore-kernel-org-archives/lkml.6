Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64220862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gmCoYTzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE64220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeICVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45649 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeICVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so1213351eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCAQX/U066t3wgneanUlVYEY20WkU8L8GJUwnaFQMPg=;
        b=gmCoYTzuPRPf2cpFV1c1J14jmQicsb8ZLyaDW5OK1/xK0UP7BGiczpdRSz5iGb+Sdc
         fCUydkNTs/24I4idwTRBoRcUZwr5FlsHPu5cVtoZfQX5bHJt/fTxfeb1kyuSzwKj4//L
         wo4AEDCBymQ2IYDXIpTbK2+G2CJQda5rk0cl2PWFJVZtSraP5XZMeEwnVBk6/HVe5qXD
         m5DsfJQrCeXIkTHzeIMmckHXGMiyeNpJ+dwIDwNqsBqE+SVw7T48mmiO/GtFrT1lsPB4
         pkSfdD3E7u/LJJxKdv+iRqS7JIYIDdK+0tgtTw0JF0nD5RMcp/NzC8rY8EizLN+BYL6S
         lasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCAQX/U066t3wgneanUlVYEY20WkU8L8GJUwnaFQMPg=;
        b=SHlcV7xoRxdXUlnb7HO59uebmaK7thXdstHfrjPDvcegL5V3t6g90M54ty8I56KR9I
         H9yAuN0ymtrjPJAwJ3wTGNQ/IlsxnaZ8lxD1OGfuUf4UGBwBrzwFyPsLXEw5MbTgarPp
         UheIaQqbTUhjBxzDBkrXqj9fcmkJK8lHBQ4AOJnt3aH9QFHyjRpjvr+VeOSBW683e77O
         cM8ICo2tJcY0Gh1wH9Zxy/YiqNaXG0phKhoE2k0e0gAhvRqoLEqDujKwETpqeAk3qIKc
         HZGBs1HyBnIOCWBrMT+frBmPRfN46jMIe/2BmFz4Cxc08szxoHtvxc2f5/zc6uFMcgD6
         slkQ==
X-Gm-Message-State: APzg51CLz5xuxS+F9lE/uYoQsdEzScX/tMdKyxQYO/n44puMlZiBGuii
        JeHOkoe8QBmMkkuzJM3kxPxfA97gVnY=
X-Google-Smtp-Source: ANB0VdbEdPIrmDYAqGuQdf4Gaw/FYdmgisXDOlti4kS6amKtjVzdaKjPqzpQ6M94xzzPX5WwsxxSpg==
X-Received: by 2002:aa7:d391:: with SMTP id x17-v6mr32682044edq.144.1535993579741;
        Mon, 03 Sep 2018 09:52:59 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8085745ede.14.2018.09.03.09.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:52:59 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: [PATCHv2 0/4] tty: Hold write ldisc sem in tty_reopen()
Date:   Mon,  3 Sep 2018 17:52:53 +0100
Message-Id: <20180903165257.29227-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two fixes are worth to have in stables as we've hit it
on v4.9 stable.

And for linux-next - adding lockdep asserts for line discipline changing
code, verifying that write ldisc sem will be held forthwith.

Changes since v1:
- Added tested-by/reported-by tags
- Dropped 3/4 (locking tty pair for lockdep sake),
  Because of that - not adding lockdep_assert_held() in tty_ldisc_open()
- Added 4/4 cleanup to inc tty->count only on success of
  tty_ldisc_reinit()
- lock ldisc without (5*HZ) timeout in tty_reopen()

v1 link: 
lkml.kernel.org/r/<20180829022353.23568-1-dima@arista.com>

Huuge cc list:
Cc: Daniel Axtens <dja@axtens.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Nathan March <nathan@gt.net>
Cc: Pasi Kärkkäinen <pasik@iki.fi>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
(please, ignore if I Cc'ed you mistakenly)

Dmitry Safonov (4):
  tty: Drop tty->count on tty_reopen() failure
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty/lockdep: Add ldisc_sem asserts
  tty: Simplify tty->count math in tty_reopen()

 drivers/tty/tty_io.c    | 12 ++++++++----
 drivers/tty/tty_ldisc.c |  5 +++++
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.13.6

