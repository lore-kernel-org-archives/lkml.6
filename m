Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B941ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSeprbON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C0F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeIQGa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:30:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36312 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeIQGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:30:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so6743344pfo.3;
        Sun, 16 Sep 2018 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oROOCkizn4j2A/SVO8+bl4BE+p6HSQ0RvRyQn4yW198=;
        b=SSeprbONpr8pqKCsE8dby2FJ7nngW0zxKFOU7ZU99wR9e5El2V1zdKJUdRQfcP6rua
         dpuImc9gPtuVT4lssBZBa2k6dpIKiNp4orcP0y0iQvbg26KcNugODGZYRL6iOySeIZlG
         cDtXTN2lNstORQ/rPJv1bDHZ/x3SwXsudC7S2BnpUrmRa7Gq/dJE1ilKmTc/GIiGOJZJ
         8f8Prg/jWsJqYZJuOCbxLAzPQaUgwcSqblPj75JVd4xxieMHdXpXupFzLGiNgr0LuvKX
         R2iv+QJEpNHrW9dibJoh94peXKMwr7J+bR1uniGeUS40sA0OIsVLMl8b3XZSpb7yLiLT
         JI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oROOCkizn4j2A/SVO8+bl4BE+p6HSQ0RvRyQn4yW198=;
        b=cbRCPNb6xKdZg5QnAXMJY5v+96CCO+kGcK5fU3m+ggxHlB9p1w2ThMWRmTEJ+YkVhj
         zABCy5r9LALt0IfSTvYtmU8FQogLSnvsHp6QwHAjP+lF+Flcr2yZT1pIjDZkdAdRGrca
         C+qY3QeOsNJz5OT5pBi8MSmx7/R9rXYZIk7AaB5Ygb/r1J8J57I9PYagDlk2HMRHFq1O
         SuOa6yXHLyCX5Nt4hJ1MFMlRaj6PTLFW8TAs8GOZUteTDOT7iHJAiD12zuir74ZUooGL
         VkzsNX54P8++KWyLiHJ2RRO5l4srtsjvwwx9kVVhMCyHO7I3dFBusaxM6Q47XirQzOGf
         ZynQ==
X-Gm-Message-State: APzg51ByvdeRiqsXVtOzAwsR6gsuIL+5Z8cz0JcLa+W0giTJt4evJGU0
        gZWzziEzAGgqgBvRFqwSpLnzbkGz
X-Google-Smtp-Source: ANB0Vda6Cbms3QFPxkn627xjO80DQxeo3iyxJurD53odLNzymviYoQECY1AHdTxpH2ACixsK/5lUDA==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr21755038pgn.0.1537146332351;
        Sun, 16 Sep 2018 18:05:32 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id b73-v6sm21135598pfj.93.2018.09.16.18.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 18:05:30 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v3 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
Date:   Sun, 16 Sep 2018 18:04:53 -0700
Message-Id: <20180917010458.23159-1-deepa.kernel@gmail.com>
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

 fs/aio.c                 | 135 ++++++++++-----
 fs/eventpoll.c           |  52 +-----
 fs/select.c              | 360 ++++++++++++++++++++++-----------------
 include/linux/compat.h   |  20 +++
 include/linux/signal.h   |   4 +
 include/linux/syscalls.h |  20 ++-
 kernel/signal.c          |  78 +++++++++
 7 files changed, 427 insertions(+), 242 deletions(-)

-- 
2.17.1

