Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184531-2-15332200142564800385
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184530; b=mZ8mvzAxXdRY3mzPGWF9t4yOW8J3pNYWBm1cuU0bMQrq40j
    N2I9BHyPkp7eXPsY+m7gjLJjenMNSlBcqaajxVsFQP7yUPHZFIrN+BvRfw5/w3EK
    IBLJ6ZP+ZIHJs2hMErZonmFuedKQtY9Gy6ZsmLOinl1s01OPkoRG+P2Bg3+WmlYd
    wnjHpD7gYUZYb6aXkCeocGGKT+2lzr6pSUZDJoga4dLGwTj09RGvXnDTq36R0kc7
    5x8cwBKpG4MWh3tfCynETbv+ykMTxSZkmjezjTYI4rEGK8RZZnp0L02ap2PHyOP0
    bhnAGlyoWXvhtIqFgwxDOI5m21vSU1YUWrHoj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184530; bh=i07V2AOiVYlV6GOKC+2mxUfyEO
    MEsqFcoQNzASurNvk=; b=MOVr/WbIMsaJP2VjfaW/Tbl85KjGfD/SClZJ6Py2gZ
    nfolO6reK2ROD26BiwgRccC3pLto4HpylP7H1GKV5yBOUJ82G2Zwfu7eP42EePIH
    j0bT2SZf9pgWjwQ4fWHPbR2esIMsULtYXY4gA151amfDB7SK5O3ekbVWcKTQP0JB
    Oq2W0PspoXOuU15zqG2o2eHRdQDc0i5QeeXkorWKbLZhHZqXHlUgPT/uyGO2KpMr
    +kxzbQh8ebLFLv04leNr5dBMOzIdzQ81NskCXhWwZ2fMkOXTXhKuyDDqdd/fCnaJ
    3upkmC4tWZhXMm79jyQ5kTQoVWixKTckdRJHDQRMJFvA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeBINpb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeBINp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 02/22] .gitignore: move *.dtb and *.dtb.S patterns to the top-level .gitignore
Date: Fri,  9 Feb 2018 14:39:51 +0100
Message-Id: <20180209133934.206781207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 10b62a2f785ab55857380f0c63d9fa468fd8c676 upstream.

Most of DT files are compiled under arch/*/boot/dts/, but we have some
other directories, like drivers/of/unittest-data/.  We often miss to
add gitignore patterns per directory.  Since there are no source files
that end with .dtb or .dtb.S, we can ignore the patterns globally.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 .gitignore                          |    2 ++
 arch/arc/boot/.gitignore            |    1 -
 arch/arm/boot/.gitignore            |    1 -
 arch/arm64/boot/dts/.gitignore      |    1 -
 arch/metag/boot/.gitignore          |    1 -
 arch/microblaze/boot/.gitignore     |    1 -
 arch/mips/boot/.gitignore           |    1 -
 arch/nios2/boot/.gitignore          |    1 -
 arch/powerpc/boot/.gitignore        |    1 -
 arch/xtensa/boot/.gitignore         |    1 -
 drivers/of/unittest-data/.gitignore |    2 --
 11 files changed, 2 insertions(+), 11 deletions(-)

--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,8 @@
 *.bin
 *.bz2
 *.c.[012]*.*
+*.dtb
+*.dtb.S
 *.dwo
 *.elf
 *.gcno
--- a/arch/arc/boot/.gitignore
+++ b/arch/arc/boot/.gitignore
@@ -1,2 +1 @@
-*.dtb*
 uImage
--- a/arch/arm/boot/.gitignore
+++ b/arch/arm/boot/.gitignore
@@ -3,4 +3,3 @@ zImage
 xipImage
 bootpImage
 uImage
-*.dtb
--- a/arch/arm64/boot/dts/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*.dtb
--- a/arch/metag/boot/.gitignore
+++ b/arch/metag/boot/.gitignore
@@ -1,4 +1,3 @@
 vmlinux*
 uImage*
 ramdisk.*
-*.dtb*
--- a/arch/microblaze/boot/.gitignore
+++ b/arch/microblaze/boot/.gitignore
@@ -1,3 +1,2 @@
-*.dtb
 linux.bin*
 simpleImage.*
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -5,4 +5,3 @@ zImage
 zImage.tmp
 calc_vmlinuz_load_addr
 uImage
-*.dtb
--- a/arch/nios2/boot/.gitignore
+++ b/arch/nios2/boot/.gitignore
@@ -1,2 +1 @@
-*.dtb
 vmImage
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -18,7 +18,6 @@ otheros.bld
 uImage
 cuImage.*
 dtbImage.*
-*.dtb
 treeImage.*
 vmlinux.strip
 zImage
--- a/arch/xtensa/boot/.gitignore
+++ b/arch/xtensa/boot/.gitignore
@@ -1,3 +1,2 @@
 uImage
 zImage.redboot
-*.dtb
--- a/drivers/of/unittest-data/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-testcases.dtb
-testcases.dtb.S
