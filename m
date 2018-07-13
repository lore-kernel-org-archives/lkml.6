Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD62208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD62208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGMMUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:20:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43510 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbeGMMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:20:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so24921915wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6fYdUB0i8jBynCfAM9sOvQ/QAa+7oL9kLtwVtBAAb/I=;
        b=rL8iz1kG3AoUYbGNRKfg2NDrgrwCZ+EsBQrcVP+SvHLg7p5nkLr4fPWkMtzXAMIKYK
         /K9pVMM71o9pX0Gk1RKA71ncxtInzuIuDQgGgBukl+92gohODAIBXtg6iS9RouQL7bLL
         tszCclgUctUwTwF0v5fzDx9zXC16c2vQaRi9pB2f+6DY2qr2sp4LScw82KHtjrO3dKfY
         gLZaPKkeB+dOotA3r2dBCQY4JVp/E6hDT2mAp/kD69ItynoFNES82spfweYxofTcPi1y
         AaseWLUlloufnBcT9lK2S5Myqv9ZwT+p5xTgyRpLttKPA7WJVT+D9rnC2eHM40SBgnIV
         yuDA==
X-Gm-Message-State: AOUpUlGxJduf+ozaKmKq+FU5cHcUq+9b5bXmOPSh4hzak8v+tRQcFIpM
        WWM1mFbXPuzPpfZD+5Zxo03L3A==
X-Google-Smtp-Source: AAOMgpefkY7XlBaMFsngkP73DeL/6TERYXMvefA8CuLmXlG7OXYTSRZmPWQCO7NVz/zwotxKS0cs1Q==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr5115294wrr.138.1531483580623;
        Fri, 13 Jul 2018 05:06:20 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i6-v6sm23316328wrr.10.2018.07.13.05.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:06:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 1/3] ntp: Remove redundant arguments
Date:   Fri, 13 Jul 2018 14:06:40 +0200
Message-Id: <20180713120642.22147-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ts' argument of process_adj_status() and process_adjtimex_modes()
is unused and can be safely removed.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/time/ntp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a09ded765f6c..25031ffb5d25 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -642,7 +642,7 @@ void ntp_notify_cmos_timer(void)
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(struct timex *txc, struct timespec64 *ts)
+static inline void process_adj_status(struct timex *txc)
 {
 	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		time_state = TIME_OK;
@@ -665,12 +665,10 @@ static inline void process_adj_status(struct timex *txc, struct timespec64 *ts)
 }
 
 
-static inline void process_adjtimex_modes(struct timex *txc,
-						struct timespec64 *ts,
-						s32 *time_tai)
+static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc, ts);
+		process_adj_status(txc);
 
 	if (txc->modes & ADJ_NANO)
 		time_status |= STA_NANO;
@@ -735,7 +733,7 @@ int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
 
 		/* If there are input parameters, then process them: */
 		if (txc->modes)
-			process_adjtimex_modes(txc, ts, time_tai);
+			process_adjtimex_modes(txc, time_tai);
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
-- 
2.17.1

