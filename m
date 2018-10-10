Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AFCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250DC2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250DC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJJNzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:55:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJNzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:55:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9A6XqIb1364723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 23:33:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9A6XoC21364719;
        Tue, 9 Oct 2018 23:33:50 -0700
Date:   Tue, 9 Oct 2018 23:33:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adam Borowski <tipbot@zytor.com>
Message-ID: <tip-72a9c673636b779e370983fea08e40f97039b981@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kilobyte@angband.pl,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Reply-To: gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, kilobyte@angband.pl,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20181009062803.4332-1-kilobyte@angband.pl>
References: <20181009062803.4332-1-kilobyte@angband.pl>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/defconfig: Enable CONFIG_USB_XHCI_HCD=y
Git-Commit-ID: 72a9c673636b779e370983fea08e40f97039b981
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

Commit-ID:  72a9c673636b779e370983fea08e40f97039b981
Gitweb:     https://git.kernel.org/tip/72a9c673636b779e370983fea08e40f97039b981
Author:     Adam Borowski <kilobyte@angband.pl>
AuthorDate: Tue, 9 Oct 2018 08:28:03 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Oct 2018 08:29:51 +0200

x86/defconfig: Enable CONFIG_USB_XHCI_HCD=y

A spanking new machine I just got has all but one USB ports wired as 3.0.
Booting defconfig resulted in no keyboard or mouse, which was pretty
uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
As 'y' not 'm' -- recovering from initrd problems needs a keyboard.

Also add it to the 32-bit defconfig.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-usb@vger.kernel.org
Link: http://lkml.kernel.org/r/20181009062803.4332-1-kilobyte@angband.pl
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 0eb9f92f3717..6c3ab05c231d 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -247,6 +247,7 @@ CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e32fc1f274d8..ac9ae487cfeb 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -243,6 +243,7 @@ CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
