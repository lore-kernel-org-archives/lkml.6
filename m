Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B514C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4592820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4592820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeLDLZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:25:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeLDLZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:25:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4BOrpa842547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 03:24:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4BOrfu842544;
        Tue, 4 Dec 2018 03:24:53 -0800
Date:   Tue, 4 Dec 2018 03:24:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Roland Dreier <tipbot@zytor.com>
Message-ID: <tip-d999c0ec2498e54b9328db6b2c1037710025add1@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@redhat.com, x86@kernel.org, bp@suse.de,
        roland@purestorage.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
          x86@kernel.org, linux-kernel@vger.kernel.org,
          roland@purestorage.com, mingo@kernel.org, bp@suse.de
In-Reply-To: <20181130211450.5200-1-roland@purestorage.com>
References: <20181130211450.5200-1-roland@purestorage.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Remove unused FSEC_PER_NSEC define
Git-Commit-ID: d999c0ec2498e54b9328db6b2c1037710025add1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d999c0ec2498e54b9328db6b2c1037710025add1
Gitweb:     https://git.kernel.org/tip/d999c0ec2498e54b9328db6b2c1037710025add1
Author:     Roland Dreier <roland@purestorage.com>
AuthorDate: Fri, 30 Nov 2018 13:14:50 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 4 Dec 2018 12:17:21 +0100

x86/hpet: Remove unused FSEC_PER_NSEC define

The FSEC_PER_NSEC macro has had zero users since commit

  ab0e08f15d23 ("x86: hpet: Cleanup the clockevents init and register code").

Remove it.

Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181130211450.5200-1-roland@purestorage.com
---
 arch/x86/kernel/hpet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index b0acb22e5a46..dfd3aca82c61 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -21,10 +21,6 @@
 
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
-/* FSEC = 10^-15
-   NSEC = 10^-9 */
-#define FSEC_PER_NSEC			1000000L
-
 #define HPET_DEV_USED_BIT		2
 #define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
 #define HPET_DEV_VALID			0x8
