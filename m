Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F350C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1495020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1495020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeKJErV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:47:21 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:51272 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeKJEpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:45:17 -0500
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3p-000520-QG; Fri, 09 Nov 2018 20:03:19 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
        by barad-dur.angband.pl with smtp (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3o-00059m-8s; Fri, 09 Nov 2018 20:03:17 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation); Fri, 09 Nov 2018 20:03:16 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri,  9 Nov 2018 20:02:50 +0100
Message-Id: <20181109190304.8573-3-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 03/17] .gitignore: add ZSTD-compressed files
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, that's arch/x86/boot/compressed/vmlinux.bin.zst but probably more
will come, thus let's be consistent with all other compressors.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..0d09cf1c053c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -42,6 +42,7 @@
 *.tab.[ch]
 *.tar
 *.xz
+*.zst
 Module.symvers
 modules.builtin
 
-- 
2.19.1

