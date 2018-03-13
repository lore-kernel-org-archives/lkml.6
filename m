Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955885-2-52604021628134249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955885; b=lCzk4gF3PCAFiyceXk7PDCNSyU0bpmywwkrS+TRgnI1wje0
    L/BYG6L/5Vpr0V4EmUFH285e8IpQZq7pKnV/K+6fZ81yA+kwIGmtq/qy0zdK4nGj
    1SeXhFxDAD7YqaejugllRhDc5e/r5ZUVUE6ebkj2Y3nTvsqVo/sbq77wUSDf3HQ2
    6Od1kzQumgDg/vhj8E+T4OzpCjO7pG+TSa7HBV4dGDtz+ywYPJkkUfNtVq4HHwbT
    yjXmQ8hjObXJE8K5iQcQcryJLgrNqzAXJk7FNp1eutKqu9a8dANHYY6zm8EbRqgz
    BEozbgkGDYFVpoBRAt03qu5otGjXpGGvfDOPzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955885; bh=FgGW5TQup00YUDw7S/BOElYSVJ
    k5Uzf3TAjGTbKmAII=; b=vnsOv38BvFBsS7/cqUx2q2KO7cTWMgZyS9BUUgiIqq
    NHPoTUxv0QSGe8Fji8S3HGZlsLiww+sqwrwirhkeHibDznuNVV4BssFlm80R2wv6
    3O6hrwA69ti1H9+c7FBGo3WV2/FcQaVAWsXlwi4pQ9xGr6+ziVIerE8d/Ir+IBUQ
    li2oGS6RX8+VhCJiLZrlDVNv+km2F8mf1bZ4BxjxLo+qgosxUSudqLDwTNLLeKvi
    dn+NHDhMqg6E7PYT9DJJzqkfNOJ8e2WsfxyPN0ICe89CmcWSqRKqI6bBnt8loNS7
    Ms4x9nYenQ71k7G4uaYQLbqSFO14IyzjzWVf/HP+6UaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeCMPoP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:44:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935011AbeCMPli (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 135/140] kbuild: move cc-option and cc-disable-warning after incl. arch Makefile
Date: Tue, 13 Mar 2018 16:25:38 +0100
Message-Id: <20180313152507.256463364@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit cfe17c9bbe6a673fdafdab179c32b355ed447f66 upstream.

Geert reported commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before
incl. arch Makefile") broke cross-compilation using a cross-compiler
that supports less compiler options than the host compiler.

For example,

  cc1: error: unrecognized command line option "-Wno-unused-but-set-variable"

This problem happens on architectures that setup CROSS_COMPILE in their
arch/*/Makefile.

Move the cc-option and cc-disable-warning back to the original position,
but keep the Clang target options untouched.

Fixes: ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |   43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -492,26 +492,6 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TO
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
-KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-# Quiet clang warning: comparison of unsigned expression < 0 is always false
-KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
-# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-# source of a reference will be _MergedGlobals and not on of the whitelisted names.
-# See modpost pattern 2
-KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
-KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
-else
-
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 endif
 
 ifeq ($(config-targets),1)
@@ -724,6 +704,29 @@ ifdef CONFIG_CC_STACKPROTECTOR
 endif
 KBUILD_CFLAGS += $(stackp-flag)
 
+ifeq ($(cc-name),clang)
+KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
+KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+# Quiet clang warning: comparison of unsigned expression < 0 is always false
+KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
+# source of a reference will be _MergedGlobals and not on of the whitelisted names.
+# See modpost pattern 2
+KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
+KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+else
+
+# These warnings generated too much noise in a regular build.
+# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+endif
+
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
