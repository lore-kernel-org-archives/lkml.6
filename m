Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED59C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94982086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muBidcQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeFQFMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:12:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41590 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeFQFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:12:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so6644110pff.8;
        Sat, 16 Jun 2018 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D4n350cCCB/hHdOEonAhrnLl41AmAWn4q4W6SIER87Y=;
        b=muBidcQCJspt2ipEy7Ci8PLBWZJaLaAzeTpba8uOYLswQQMeq4yF8QjimeB36v46j0
         fDmY+lCZCKiME56oKnt+EGjesh6S3xglT1tWvsS8/tFnHDd/uIg566U5KB9b5D9JLkvg
         QXxs0sl3/zI1/MhMlI+Z4JX5CaH82MrlbAyXpXOPva2tAfUaYkxsXCPA7LjgCIQsbg3U
         /CHPmCBcveVgKTW5mn3tLftGPIBfGygheT1NtCSDvDZX2UbzQ6KjOJScU+/91fl2xnPP
         7NDb6Mb/SMgJCGMi4uiflJg62A4s4wOuPSCpsL48aKbBHPFjLXi7Y3ZV5X2CQyRhMdcw
         WyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D4n350cCCB/hHdOEonAhrnLl41AmAWn4q4W6SIER87Y=;
        b=MtI51CswrX9U4apuFtKrRiGWUo8WnQm5JHDs1koVu4TnfcWXwiT8PbuhNhAB45l4Vc
         Io4e7ECaLCvHnuUwhFtrPPnMPMC3me7PKuB79N5xLVpOyE3VXI7DjD98IHavpyU76Wca
         Xovk1am5XKf2GgWspWxaEhng3KsNl3hVA2Ozk8qdk8+Jk48ozEzEvFPJpJJrhfwYqsug
         H+NXAlxl1teHJWxIVJXtiVyq696UdFB6qjDpu6kHFaXNCri7GKqt3cRIUMqvcu6KSSER
         JOQxV1XdhSTzpK87HpDnOgfppubVYlWjo24ckC9uXKU1o0A5vTAz+1B1tskacd7CeZ9Y
         Vw7Q==
X-Gm-Message-State: APt69E0kNWw3yHSRaCZ/Zd55ukJyVFZZ5fttagzJvzs/eluFNzfdbFeW
        T4Bz86wbLS+H2K5nLNA1W0TxoQ==
X-Google-Smtp-Source: ADUXVKLEbLMPKj/XdgG8v0ZGHEmLcXxAs8lChu3C+cQ7L9uMCoIECb+5h6QMvqQUwtESmu2JTq44PQ==
X-Received: by 2002:a65:6612:: with SMTP id w18-v6mr6816736pgv.38.1529212322633;
        Sat, 16 Jun 2018 22:12:02 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h27-v6sm28354594pfk.160.2018.06.16.22.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 22:12:01 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH 0/3] time: Add y2038 safe struct __kernel_itimerspec
Date:   Sat, 16 Jun 2018 22:11:41 -0700
Message-Id: <20180617051144.29756-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series aims at adding a new y2038-safe struct __kernel_itimerspec.
This is intended to replace the struct itimerspec at ABI level.

The series is a continuation of efforts to convert all syscalls with
time_t or time_t-derived structures to be y2038-safe.

Arnd, maybe this series can go along with the rest of syscalls that you
have in your y2038 tree?

Deepa Dinamani (3):
  time: Introduce struct __kernel_itimerspec
  time: Enable get/put_compat_itimerspec64 always
  time: Change types to new y2038 safe __kernel_itimerspec

 fs/timerfd.c                |  8 ++++----
 include/linux/compat.h      |  9 ---------
 include/linux/compat_time.h |  9 +++++++++
 include/linux/syscalls.h    | 10 +++++-----
 include/linux/time.h        |  4 ++--
 include/linux/time64.h      |  1 +
 include/uapi/linux/time.h   |  7 +++++++
 kernel/compat.c             | 29 -----------------------------
 kernel/time/posix-timers.c  | 12 +++++++-----
 kernel/time/time.c          | 25 +++++++++++++++++++++++--
 10 files changed, 58 insertions(+), 56 deletions(-)


base-commit: 4b373f94fee5acf2ff4c1efbb3f702060379df1f
-- 
2.17.1

