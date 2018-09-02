Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB120835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DB120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIBQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:28:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:28:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w82CCvPL2913737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Sep 2018 05:12:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w82CCt392913734;
        Sun, 2 Sep 2018 05:12:55 -0700
Date:   Sun, 2 Sep 2018 05:12:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jacek Tomaka <tipbot@zytor.com>
Message-ID: <tip-f4661d293eb2d01dfc742982761a36fafe456d46@git.kernel.org>
Cc:     tglx@linutronix.de, timb@dug.com, mingo@kernel.org, bp@suse.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jacek.tomaka@poczta.fm
Reply-To: bp@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, jacek.tomaka@poczta.fm, tglx@linutronix.de,
          timb@dug.com
In-Reply-To: <20180825035039.14409-1-jacekt@dugeo.com>
References: <20180825035039.14409-1-jacekt@dugeo.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode: Make revision and processor
 flags world-readable
Git-Commit-ID: f4661d293eb2d01dfc742982761a36fafe456d46
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

Commit-ID:  f4661d293eb2d01dfc742982761a36fafe456d46
Gitweb:     https://git.kernel.org/tip/f4661d293eb2d01dfc742982761a36fafe456d46
Author:     Jacek Tomaka <jacek.tomaka@poczta.fm>
AuthorDate: Sat, 25 Aug 2018 11:50:39 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 2 Sep 2018 14:09:13 +0200

x86/microcode: Make revision and processor flags world-readable

The microcode revision is already readable for non-root users via
/proc/cpuinfo. Thus, there's no reason to keep the same information
readable by root only in /sys/devices/system/cpu/cpuX/microcode/.

Make .../processor_flags world-readable too, while at it.

Reported-by: Tim Burgess <timb@dug.com>
Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180825035039.14409-1-jacekt@dugeo.com

---
 arch/x86/kernel/cpu/microcode/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b9bc8a1a584e..2637ff09d6a0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -666,8 +666,8 @@ static ssize_t pf_show(struct device *dev,
 }
 
 static DEVICE_ATTR_WO(reload);
-static DEVICE_ATTR(version, 0400, version_show, NULL);
-static DEVICE_ATTR(processor_flags, 0400, pf_show, NULL);
+static DEVICE_ATTR(version, 0444, version_show, NULL);
+static DEVICE_ATTR(processor_flags, 0444, pf_show, NULL);
 
 static struct attribute *mc_default_attrs[] = {
 	&dev_attr_version.attr,
