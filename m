Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D97C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B14920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B14920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKSUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:42:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbeKSUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:42:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAJGQq2524776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:19:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAJFc42524773;
        Mon, 19 Nov 2018 02:19:15 -0800
Date:   Mon, 19 Nov 2018 02:19:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-72dc571a3a77081112944fe0c2dbff614114b04a@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, mail@maciej.szmigiero.name,
        tglx@linutronix.de, bp@suse.de, lkp@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de, bp@suse.de,
          mail@maciej.szmigiero.name, lkp@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181107170218.7596-13-bp@alien8.de>
References: <20181107170218.7596-13-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Fix container size's type
Git-Commit-ID: 72dc571a3a77081112944fe0c2dbff614114b04a
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

Commit-ID:  72dc571a3a77081112944fe0c2dbff614114b04a
Gitweb:     https://git.kernel.org/tip/72dc571a3a77081112944fe0c2dbff614114b04a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 12 Sep 2018 18:50:23 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:55:06 +0100

x86/microcode/AMD: Fix container size's type

Make it size_t everywhere as this is what we get from cpio.

 [ bp: Fix a smatch warning. ]

Originally-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20181107170218.7596-13-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5775dc996df3..66490ff087d9 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -186,8 +186,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize, bool early
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int
-__verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
+static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size)
 {
 	u32 max_size;
 
@@ -285,10 +284,10 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
+static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
 	struct equiv_cpu_entry *eq;
-	ssize_t orig_size = size;
+	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
 	u16 eq_id;
 	u8 *buf;
@@ -366,15 +365,18 @@ out:
  */
 static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	ssize_t rem = size;
-
-	while (rem >= 0) {
-		ssize_t s = parse_container(ucode, rem, desc);
+	while (size) {
+		size_t s = parse_container(ucode, size, desc);
 		if (!s)
 			return;
 
-		ucode += s;
-		rem   -= s;
+		/* catch wraparound */
+		if (size >= s) {
+			ucode += s;
+			size  -= s;
+		} else {
+			return;
+		}
 	}
 }
 
