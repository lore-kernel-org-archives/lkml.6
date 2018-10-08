Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4C4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C6120858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C6120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJHRn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:43:57 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:34674 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:43:57 -0400
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1g9SqF-0005ie-JK; Mon, 08 Oct 2018 12:32:49 +0200
Received: from sirius.angband.pl ([2001:470:64f4::9])
        by barad-dur.angband.pl with esmtp (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1g9SqD-0000NU-U4; Mon, 08 Oct 2018 12:32:45 +0200
Received: from kilobyte by sirius.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@sirius.angband.pl>)
        id 1g9Sq8-00040X-S0; Mon, 08 Oct 2018 12:32:40 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon,  8 Oct 2018 12:32:23 +0200
Message-Id: <20181008103223.15362-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A spanking new machine I just got has all but one USB ports wired as 3.0.
Booting defconfig resulted in no keyboard or mouse, which was pretty
uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
As 'y' not 'm' -- recovering from initrd problems needs a keyboard.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/x86/configs/x86_64_defconfig | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.19.0

