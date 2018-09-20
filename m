Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACAECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD421522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pttsjsj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFD421522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeITKeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:34:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40997 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:34:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so3809022pgv.8;
        Wed, 19 Sep 2018 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+soXgwJ/7HQmE/hkBOJ0QhpbTAdZRSOzctZ+AQCngaI=;
        b=Pttsjsj4uSdTIvJiq7AlXC02gsm0QhPYCMFSv25NfhusIhuGLBR/9K8W1M2VfuwH5+
         UpM5HwimY9qnwJ2shkFD1VQsI9aG3hGUGco0KXkflQzLOtfKmK6KJxOYeEo6imbJdwf9
         c4zBH5O0fIdQnCnK/fTCXd4cRILdiShBnX9JtPb9dw0Ci1PowFglQAezlCCgrydpfkq3
         jHJ4v6L69VXfWlOhMoCYAJwQeGqaox79VvIXHwPXo+oSRoEE5bej6cowxpJ4KL99P3tM
         KKgvPU/jIsDQVLtHUtNQGGxf6A3Jz2X7XPX01NhPsjDyyLmDH3OfPvdOFmnZhH8CAkZX
         3I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+soXgwJ/7HQmE/hkBOJ0QhpbTAdZRSOzctZ+AQCngaI=;
        b=jHcaka+cVa0KzkFgfPY2tS3r1+1oy61ahq8jls3Kd7IuhDEJFNETIktsKX8gHoMjRz
         unPyCSpqHNswyiKBXKm79x1d8teEZrzllmCMtJkDtUabvFMi25loItCch01YnA/e6slU
         XzaMejD/LXONwSvAxCrzYR1Rr0cwnCOvLv/+hXqMs6ZlpMYms6CvU2diJweUqR/buWuc
         q0fMjc2PIOGhwJIuAliWI1NUakGhAuykLY0tsWvnhDbItg1VF13y1nKD+8o+HQue3oxF
         0IluUc/CVGL3Qpzf3+NmtbBRIIPiv6AmdwhE176odhRsRvhNvUozD9TMSAwClp3fRkUH
         QKRw==
X-Gm-Message-State: APzg51A9CJuQKpaQBqzNv6g2I3wBiY+9j2udmzx8TGilBaaDg87C8/eX
        S4HjZs3Zu3X7jmppJpZ9wXclfona
X-Google-Smtp-Source: ANB0VdYXXlPKbSZg0K6XrhrveYJbIBVvdqAxhe2eRLEm/hjMVtw12MBQiWQrzgYZz5NhvSF+qUKH6Q==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr39157386pfj.74.1537419172686;
        Wed, 19 Sep 2018 21:52:52 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id d66-v6sm39209705pfd.121.2018.09.19.21.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 21:52:51 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v4 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
Date:   Wed, 19 Sep 2018 21:41:03 -0700
Message-Id: <20180920044108.6606-1-deepa.kernel@gmail.com>
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
2. Provide y2038 safe versions of the syscalls for all ABIs.

[1] https://lkml.org/lkml/2018/8/27/651

Changes since v3:
* fixed pselect copy+paste error
Changes since v2:
* remove 64BIT_TIME conditional for ppoll, pselect,
  io_getpevents as per review comments
Changes since v1:
* fixed bug pointed out by arnd

Deepa Dinamani (5):
  signal: Add set_user_sigmask()
  signal: Add restore_user_sigmask()
  ppoll: use __kernel_timespec
  pselect6: use __kernel_timespec
  io_pgetevents: use __kernel_timespec

 fs/aio.c                 | 134 ++++++++++-----
 fs/eventpoll.c           |  52 +-----
 fs/select.c              | 360 ++++++++++++++++++++++-----------------
 include/linux/compat.h   |  20 +++
 include/linux/signal.h   |   4 +
 include/linux/syscalls.h |  20 ++-
 kernel/signal.c          |  78 +++++++++
 7 files changed, 426 insertions(+), 242 deletions(-)

-- 
2.17.1

