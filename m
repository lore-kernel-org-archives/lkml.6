Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2958C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F8620848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F8620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeLCPzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:55:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52217 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeLCPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:55:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB3FsTb5502059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Dec 2018 07:54:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB3FsJ4t502054;
        Mon, 3 Dec 2018 07:54:19 -0800
Date:   Mon, 3 Dec 2018 07:54:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-182ddd16194cd082f25fa1b063dae3c7c5cce384@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        taijian@posteo.de, jgross@suse.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, jgross@suse.com,
          taijian@posteo.de, hpa@zytor.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20181203103811.17056-1-jgross@suse.com>
References: <20181203103811.17056-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Clear RSDP address in boot_params for
 broken loaders
Git-Commit-ID: 182ddd16194cd082f25fa1b063dae3c7c5cce384
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

Commit-ID:  182ddd16194cd082f25fa1b063dae3c7c5cce384
Gitweb:     https://git.kernel.org/tip/182ddd16194cd082f25fa1b063dae3c7c5cce384
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 3 Dec 2018 11:38:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Dec 2018 11:56:37 +0100

x86/boot: Clear RSDP address in boot_params for broken loaders

Gunnar Krueger reported a systemd-boot failure and bisected it down to:

  e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address from boot params if available")

In case a broken boot loader doesn't clear its 'struct boot_params', clear
rsdp_addr in sanitize_boot_params().

Reported-by: Gunnar Krueger <taijian@posteo.de>
Tested-by: Gunnar Krueger <taijian@posteo.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: sstabellini@kernel.org
Fixes: e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address from boot params if available")
Link: http://lkml.kernel.org/r/20181203103811.17056-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bootparam_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index a07ffd23e4dd..f6f6ef436599 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -36,6 +36,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 */
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
+		boot_params->acpi_rsdp_addr = 0;
 		memset(&boot_params->ext_ramdisk_image, 0,
 		       (char *)&boot_params->efi_info -
 			(char *)&boot_params->ext_ramdisk_image);
