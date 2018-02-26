Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676843-2-17346789917059148964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676842; b=VbKastnJ//s+PkLg+XcTbz0xoHv3YVbcAYxnTzRYZt/6M46
    g5aivj8rqYR0cJlzmWd5a7mPBHJUxUb6AtEJ+R5QW0sBu7gKiGhqT/8T2eEIxp43
    FmeG6aLFJDQBh8F2wedZUrOTWBOmbkmhcou2d+EFpRhz/t8VRR6feLqPqysqGphY
    k2LI1fdK/kC6qKkniZep7ltaIQOIoFjLnuOc7F83NIwKw5WuKkdYJneO+bd1/u9a
    ShQuDIbCp/cI6F1jVELok90SYC/RLYnT6YElAcxk7Wbwg8YWoRk81Ud9O97uQ57K
    3qi0JFyB5wglMBx0kPdxdX4w/rhOWCNK0WZ6fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676842; bh=IAlcO60sCxUv/c093SzpDxulQK
    0+iyeqCGiluRjCaJw=; b=pWkGkXJ1I3dXcm70dwuMnvkIr6/T/OZLtxlmhME9MF
    /nivoK9ouQjqCIvDeJOyxYeHqqZHsjbIPlu2qXu+/iRcdF38EzwCkSwZMQ00FTwL
    xb90zxMfmLTwdrXL63mkq2RyC6GzO25t1vNZnwL7kjoqPRolFJop0eD5y/1fAC2K
    rCjW522SiIU9uDmPPJS8J6WnTv0ojoRVyLdfTi49XOPloZSlx93mJ/AEUphosmmw
    7pym5g8zKjDXmOsuAlQvjoEnAtHUxlT6CSfWmV2ysEQZouwRCcVafsFPlFGGuTDs
    JryFlBR0MJoPAfyVrbdtPzdCrPt+LVsbgVjS1Y+nor5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeBZU1S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbeBZU1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 04/64] MIPS: boot: Define __ASSEMBLY__ for its.S build
Date: Mon, 26 Feb 2018 21:21:41 +0100
Message-Id: <20180226202153.629766347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 0f9da844d87796ac31b04e81ee95e155e9043132 upstream.

The MIPS %.its.S compiler command did not define __ASSEMBLY__, which meant
when compiler_types.h was added to kconfig.h, unexpected things appeared
(e.g. struct declarations) which should not have been present. As done in
the general %.S compiler command, __ASSEMBLY__ is now included here too.

The failure was:

    Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
    FATAL ERROR: Unable to parse input tree
    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
    /usr/bin/mkimage Can't add hashes to FIT blob

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 28128c61e08e ("kconfig.h: Include compiler types to avoid missed struct attributes")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srct
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
