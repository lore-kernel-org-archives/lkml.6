Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520825792-2-733744878147709877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825791; b=sPJuPZQofAW+F9nrOoskfOBEL0zOcnYzp6zwKhgPZ3YX8nH
    pg4HATVlSiL5hYtc5JwG79QapCHIagQg3RMyJQNHLskztF4wSAbuKLxqPD9V+VWM
    7BJUdB63th1XyM0fY8KAyhOhQ6E6OL8wYd9Qu0U/TmF48mhry1BBqQHzx0s82M8R
    L/4Z02kJ42AliGc1b30GsMVM1ZLEpO7ngasXavUI1L3onZ/wh//7DEK3P6HmZXhd
    6mupshM73qL3C620egXPWk3vNAq9mZUR9Y37s38YF8wxmEddlNIZxeLs6jPeRPMj
    dJmjUZRzx9x2rokYfWM/jpXZAbrg3aIi/AS148w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825791; bh=C/xaBV0EO2Wmb4LLLc+
    Wilrlvpr3I5lyuRlvVEItyD8=; b=hJxWZg5vSihNCv/JZQ7x5CTUOJe+KXUqVfY
    0FEST3I2Oi7YwxAlJ/sMPGVT6xog+UZlDoGZ4VKXPDGQ1KdtEwhvlLr5417Key7V
    b5hD/2gIgcFqEsKkbJKEtyAJ5JYliVhyQScLyI05sm59BQZwb7yjAnOKBOCzbzyQ
    7RVupYhpDL3jwlTIccmSP1Qe4vVkLhA49DJHjkZ/pRvqErQcp45PL2qXMBgb8Fyx
    0iuOAUOxi68w7OMHJgQU5wtI/yA9WkzfnYmoG626h/UPndHOqMLvG2wg4EpKZYtw
    usTx0Q1Suz8Cc9iBEaLW+KkfcSCnOTy4vadR10AxgGzUunDtIxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeCLDdz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:33:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42897 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932685AbeCLDdx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:33:53 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michal Marek" <mmarek@suse.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.461491392@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 20/76] kconfig.h: use __is_defined() to check if
 MODULE is defined
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 4f920843d248946545415c1bf6120942048708ed upstream.

The macro MODULE is not a config option, it is a per-file build
option.  So, config_enabled(MODULE) is not sensible.  (There is
another case in include/linux/export.h, where config_enabled() is
used against a non-config option.)

This commit renames some macros in include/linux/kconfig.h for the
use for non-config macros and replaces config_enabled(MODULE) with
__is_defined(MODULE).

I am keeping config_enabled() because it is still referenced from
some places, but I expect it would be deprecated in the future.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Michal Marek <mmarek@suse.com>
[bwh: Backported to 3.16: drop change in IS_REACHABLE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -17,10 +17,11 @@
  * the last step cherry picks the 2nd arg, we get a zero.
  */
 #define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
+#define config_enabled(cfg)		___is_defined(cfg)
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+#define __take_second_arg(__ignored, val, ...) val
 
 /*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
