Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1700296-1520506986-2-4704066709958625247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520506986; b=S8MhnbumRoRDRt55XgmMa/FvKdnJiV12xyUSrVcMKJRn8iW
    4Y4xSr3U98hyfPPCcHOedBAmGhwdW7ITScB6uQh4tZfXMJq8SThKSzSNFcLEBk12
    xpHdu+ljUkiO+yCCcE2Ab7zO+8WeiVVfqhHJ/Bm/USRX6JvNXW4UXZZveFbUVK5j
    /GbbwibYgKyFDAulrL6I6iwgoWqHicRjUwAnqlQIrL1Dd9GVnDfekbmpE/KzHae4
    LzvlIwaDzN5DQ+OykXBPb292LarSkckC0+4lueANmKXxeNcID5/yo4irn69T4LO0
    Fb0cufVMSjh5pHqfPna89aUnK5Wz7FFZMY9HElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520506986;
    bh=X32Fqes97BJaba7v4bnD+B2L/DXveYS2iK65yzThXhc=; b=cf0y70VKwYUW
    NPl11z6DZVXUGA4uomGWNNOu858atO9RN3MQUqDlWB5/fxmrzfeG4IxvIEwDvNZM
    mLmAY+Eg8cYnH0NmWq85Gpv5rStis7BU/WmWnPAwef1AI7Hl5Yfr7+JS9Eimy9AV
    xtxASTRua4+sof5IYjNdAQYWbu5sQqLi2Dh1Bmk2rvJ/Z9OIlu60X/POlhEdKWz/
    lBUvA2wM9+JGY9qqxiun/tYeleblY6EMecEtXWdLtMguoTkE7CB+Rjq7Q0feqWlT
    d4kGIdOaux0pyZ1N2LvmvHjeEuXqnXiG1lSRQvd5JhhpuRjS1ZkN19OXaWQm6CkX
    48PCixsOWg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1755224AbeCHLDD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 06:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeCHLDB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 06:03:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2345C2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: [PATCH v2] kbuild: Handle builtin dtb file names containing hyphens
Date: Thu,  8 Mar 2018 11:02:46 +0000
Message-Id: <20180308110246.16639-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
References: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
FDT (that is, the .dtb file) as binary data in the kernel image. This
assembly source contains labels before and after the binary data. The
label names incorporate the file name of the corresponding .dtb file.
Hyphens are not legal characters in labels, so .dtb files built into the
kernel with hyphens in the file name result in errors like the
following:

bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'

Fix this by updating cmd_dt_S_dtb to transform all hyphens from the file
name to underscores when constructing the labels.

As of v4.16-rc2, 1139 .dts files across ARM64, ARM, MIPS and PowerPC
contain hyphens in their names, but the issue only currently manifests
on Broadcom MIPS platforms, as that is the only place where such files
are built into the kernel. For example when CONFIG_DT_NETGEAR_CVG834G=y,
or on BMIPS kernels when the dtbs target is used (in the latter case it
admittedly shouldn't really build all the dtb.o files, but thats a
separate issue).

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
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
Changes in v2:
 - Rewrite commit message (thanks Frank for some improved wording).
 - Add Franks' reviewed-by.
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
