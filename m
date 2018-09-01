Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A6DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993AD2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4ks+oRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993AD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIBBBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:01:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40553 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeIBBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:01:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so6934077plp.7;
        Sat, 01 Sep 2018 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YVpiMF8uFeZnKLcO54LPpNRHCKeKyRVBqTnm9OawYj0=;
        b=k4ks+oRXxDcV14541ceaGovPtIIqkELcvFGKo/6mgDpUHce05hEvt318eYTMoUr6mF
         rQJ1k2Gku5YJyOZWpy/b80FXakfxVYCXEY+e65PD5hha1v6Ukv/NJlnU32WjuxLTuqyV
         6ZGTLEir9gwCnT4m17sIFCL+Wgf2v0NHcPB2OhikZjurOs55HjIrjnjoAm/acvYm/XQS
         EuY6pZhbAk9kSXjFHpNXjNafG6qncbQSvM54m27DZ5mpUN8Iz/JxfbV8bbZlvhOKExFU
         DrqZe+6gwkv6hnOqlrMg9IhUbxRbJhGQInXV6Kj13LF1DTfRa5yQcpIXg5yfMUD49ZwS
         hUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YVpiMF8uFeZnKLcO54LPpNRHCKeKyRVBqTnm9OawYj0=;
        b=iS5O0GSKvlR1cglFnDC5nSDOXVUI28HxPCg9B4TbjqZ0h+tiLQi1am5SKh8q6oJRDm
         3j+J2rmElo+rr5k70R7p0C4rw95acJYRc4+toeWNglp1hxQ/F7o1KIJDc26/1ptPlD6L
         XY8Pj+Dx0xuIKkYb9KrIii0u2pcJW3fYLoHAQWL/O3MPvA1FsUYzw2/KMJNKvafBq2mv
         hzgWAXbYuJDnv23L0lEl+BToHBjHEWJCg2PKkms1N1B7W4JxvXPfHY0mNUSrUBTIpcmY
         iNpMRTBtiBDaxeggKXZbJp+XG13cmyWSYs9IX/Pdmg7OhVX6XAxhkKpljBo/Jkn+n6sW
         yQDQ==
X-Gm-Message-State: APzg51Co/qr3A0FshVnb6y1tCCPumiyIj66VXdazzWGvazLdDXjwa6kb
        oywg+dFsYcFJhzmmujfX2xj9R6xz
X-Google-Smtp-Source: ANB0VdYGcNfwGVIKMVbQwKQbYNC09t63XfSWVDJKB4EaiLETnlzYv+yCSVQYh8XkM9mRtxAthPglaw==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr21738076plk.127.1535834883397;
        Sat, 01 Sep 2018 13:48:03 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id u17-v6sm24512265pfa.176.2018.09.01.13.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 13:48:02 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
Date:   Sat,  1 Sep 2018 13:47:16 -0700
Message-Id: <20180901204721.13117-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series transitions the ppoll, io_getevents, and pselect syscalls
to be y2038 safe.

This is part of the work proceeding for syscalls for y2038.
It is based on the series [1] from Arnd Bergmann.

The overview of the series is as below:
1. Refactor sigmask handling logic for the above syscalls.
2. Provide y2038 safe versions of syscalls for all ABIs.

[1] https://lkml.org/lkml/2018/8/27/651

Deepa Dinamani (5):
  signal: Add set_user_sigmask()
  signal: Add restore_user_sigmask()
  ppoll: use __kernel_timespec
  pselect6: use __kernel_timespec
  io_pgetevents: use __kernel_timespec

 fs/aio.c                 | 138 ++++++++++-----
 fs/eventpoll.c           |  52 +-----
 fs/select.c              | 367 +++++++++++++++++++++++----------------
 include/linux/compat.h   |  20 +++
 include/linux/signal.h   |   4 +
 include/linux/syscalls.h |  20 ++-
 kernel/signal.c          |  78 +++++++++
 7 files changed, 437 insertions(+), 242 deletions(-)

-- 
2.17.1

