Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3402803-1520431635-2-16276562262456668815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520431634; b=IXYeyvDbI46dj0sptY8ifAsWLPJJuzQGKyJkyprcJ9ZZLgh
    QX2em1PfE0XgJtg65iVhxHnRcqN83TksWR/we9LVkky5sjLhu+ehV6WFT3DeVu21
    T7IkIb3Brf55/bhwBVLNrNjxsVMNVvGvi+UO6mBX3zUpql4FfKlK9X+C/y4keSa0
    RKXEWuI/dehobKINrFGxb+LWK+6bATlt+r+0T7hEgusNQ2RL3xkt6qJz6U+9nMn+
    2sVuA6ZzIcLNUvE+s2zlgNikXTzTidh5IRYYtDjxIM4uqY5vUDTMkjbM7T7XO9We
    pG0s02g3Wm4FmibE3zgnfpMJaOgV+biD64EdOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520431634; bh=dSe9w1Y1DTi4anM8KXJ7seJOWD
    hk9/nRn4A1R8EBk78=; b=Z+QeIDcNztS5W15dWjZuTKJ/eoKzASlhqpeRUgh0zX
    0/0kdU8ZX3Rzs3z6gdBMeZ8Th4cg2bzE0vWPRw+L+23X3WYY4JohdT1GjvxjI9BL
    iHpphQ/ZRSd/hoVBttTmSFFPi1s39vBDbYCQfTZm2a3NTL/sKcTZV74kZNpbw+f0
    QM3JOHzxBmcAY8etTC37geOKLuzj+FBOw0Zy6OmrGuajT+/O9p8rTvdtyIEgSKjJ
    3GoLVfiJfeX+UtJ91rngRLJAEZZfih/K7rSpVgtZ84E/JU7aJCyRdT3tqU/Zr/TB
    1VIKogA/mqYlgGZ7uoiP9XIXJ+KiD1xNyzl26ejJWrfw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeCGOHL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 09:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeCGOHK (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 09:07:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07E52172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: [PATCH] kbuild: Handle builtin dtb files containing hyphens
Date: Wed,  7 Mar 2018 14:06:33 +0000
Message-Id: <20180307140633.26182-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On dtb files which contain hyphens, the dt_S_dtb command to build the
dtb.S files (which allow DTB files to be built into the kernel) results
in errors like the following:

bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'

This is due to the hyphen being used in symbol names. Replace all
hyphens with underscores in the dt_S_dtb command to avoid this problem.

Quite a lot of dts files have hyphens, but its only a problem on MIPS
where such files can be built into the kernel. For example when
CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
used (in the latter case it admitedly shouldn't really build all the
dtb.o files, but thats a separate issue).

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.9+
---
 scripts/Makefile.lib | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5589bae34af6..a6f538b31ad6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -297,11 +297,11 @@ cmd_dt_S_dtb=						\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
-	echo '.global __dtb_$(*F)_begin';		\
-	echo '__dtb_$(*F)_begin:';			\
+	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
+	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
 	echo '.incbin "$<" ';				\
-	echo '__dtb_$(*F)_end:';			\
-	echo '.global __dtb_$(*F)_end';			\
+	echo '__dtb_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
 ) > $@
 
-- 
2.13.6
