Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDF2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ibxkO2Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBDF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH2GS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:18:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42965 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2GS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:18:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so139441edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lT82Va3OFQGc4TMQuT/0EsfvOn0U4QTm1pkVepw5e0=;
        b=ibxkO2OeiGfl5FnQ8R+MdJ0WZSPo7yJh2RAWWuzBtz8dieHoMgU1v8sJH8XTVtQBWg
         75lPUpw4ybvGBBV0l9XTBoG3NinZfXdJ5gFBecrd1KV/qhboKuqM7RJh0i4QPR2G5o7V
         +SU0q3TE6KcYATjZN5jb3OmNbAOV2GEl3msOK0Fj4Bn5Yx2NAkIVDRT1r2oUpvupuWrI
         DYj3NqJk5Nr6yPCecWJ2CKxdrGLo8dm7H26F/gyz52OQ29g4ih/qf6McANf2wPBNOmsA
         ftUcrc8DMtL8Bv6aQOirgvz/UhcTqFLJxVfDuV8z8kjY1BjExv+4rLXMvpzO1B/fyt8r
         0FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lT82Va3OFQGc4TMQuT/0EsfvOn0U4QTm1pkVepw5e0=;
        b=oxHgN+KH0EyIqY8OMfxJfW+YjtSdhLotobr6Xpa2BxpLcKCSOf7NOXMaqadXaUIKd4
         Tjg450wasMk1xINEON/gGKTMzd2UzMo7HqeBlh3LnBos36Wmo5PQHWkz763Hy2U4PEfF
         nGdNc7kYM0zCZbXUnGZcZ87FsK89ynmCyQ78c3FWrC5pqWPSKcZC6Th99/SgPAG2NmxP
         ajlrsmxdIJRD3RKsZ2eRP3WHjS9eOOP4irGjqjXPbULNuDy53KEdfyV0hMy/eGhe7edb
         hbeqqgCxyZK8kBdXufvby+w9XBpKXVjCzgxHXDLPE1+a/cCN5e3sVHdsUp753DJj8y8F
         nuDw==
X-Gm-Message-State: APzg51Dcs049vAqFfVy7mTRFZTd2xxPvwdH90wAeoj3R3yD2SiaQAQ+4
        o4G4ikdBUmCIFfGIulBu5fdC6TewxBc=
X-Google-Smtp-Source: ANB0VdbChMjrF4kq5Wkhphbce00S0YWwtqQ5u47WdIYNyl8K1pPCrC7Op9bicuy7sKv5c/b/X+pu8Q==
X-Received: by 2002:a50:c05a:: with SMTP id u26-v6mr5077430edd.107.1535509435005;
        Tue, 28 Aug 2018 19:23:55 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1236367edb.28.2018.08.28.19.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 19:23:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCH 0/4] tty: Hold write ldisc sem in tty_reopen()
Date:   Wed, 29 Aug 2018 03:23:49 +0100
Message-Id: <20180829022353.23568-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for potential and real issues.
Looks worth to have in stables as we've hit it on v4.9 stable.
And for linux-next - adding lockdep asserts for line discipline changing
code, verifying that write ldisc sem will be held forthwith.

I couldn't verify that holding write lock fixes the issue as we've hit
it only once and I've failed in reproducing it.
But searching in lkml, Cc'ing here people who probably had the same
crash (and in hope someone of them could give tested-by):

Cc: Daniel Axtens <dja@axtens.net> 
Cc: Dmitry Vyukov <dvyukov@google.com> 
Cc: Michael Neuling <mikey@neuling.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Pasi Kärkkäinen <pasik@iki.fi>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> 
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
(please, ignore if I Cc'ed you mistakenly)

Dmitry Safonov (4):
  tty: Drop tty->count on tty_reopen() failure
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty: Lock tty pair in tty_init_dev()
  tty/lockdep: Add ldisc_sem asserts

 drivers/tty/tty_io.c    | 21 +++++++++++++++------
 drivers/tty/tty_ldisc.c | 12 ++++++++----
 include/linux/tty.h     |  4 ++++
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.13.6

