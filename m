Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076DE2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXI2cnVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfBNVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:40:15 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:32937 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503331AbfBNVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:44 -0500
Received: by mail-qk1-f201.google.com with SMTP id n197so6442272qke.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h+keLiQ8UrSvEm7+wL7InKcQs/d0wg/MdPLT1U+V0Ho=;
        b=BXI2cnVYMUYwcQEU11+rgRhxE47n/thlxwGOpDjMnOxVeEQP0xokJ4nExSRcuK7SM0
         QAAmlXECYYny7H4j6j51UL6iuiHYQF3g9l7aEuX2Jvz6oXm+2+CaJkevycJsRcEdkukZ
         AOTE+D/EYnpm5ajS1mu5g+SjJ9JXgvOFvJ5n1t49w29nl+2WdwVh2sdKeQyBUMSrPWNH
         fzldV7om7MT58A6bj4ylmdSIJhce8j1K2OfKJiif1T5QxSUGn4JvJ6fTMIn5/RTlHAyq
         be0LePsoUOPZVHvloaYd2XW+4pmC2FjvjAgvvCvI3eecIy5Y5XwruIR0CekLlogHJIyO
         6aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h+keLiQ8UrSvEm7+wL7InKcQs/d0wg/MdPLT1U+V0Ho=;
        b=cy/CoLX6m1tUjpcOuiBD0GLowoQuOWHBCPPVr7Y/kYivPcr1ASRqYrzvRBz0DjEtE2
         mE/F7fXDPIC8k81GFV+1jxcF/iw4pTZUNSL7KhHbOE4PdHwAY+kXTmAqLpCBPjiBVqOH
         5W1GqmvGSTq/e1hY9Q2JP2IlrLEgEgl00nTpVdIFJ113kMeCo8eTwPStY1ueK4bA+iae
         iuSlLjsQKCwoqpVOtqP9AVktAgqK/pCJBXl1MAbmPOGiCOTdmzRxNWKHMyzQkNCKRVEZ
         mZw9jnlRNqI1e2lGzFdBVHTNTnPEBG4iFcmu2NsI901hhswgfAslKXqHXB9eKa2h3dk0
         vB9A==
X-Gm-Message-State: AHQUAuZDUArO/b3Q/H7L9U6+w9WaLStJ6WaXTOaeogkiQUyckwyOHc2N
        EQZuW4P4e8bQvpb78AB2uKEOBvk+o1TrXHSEiE41Yw==
X-Google-Smtp-Source: AHgI3IYUSLyNNiD4a/w4HRwz+V30pDMQuGVooAEVXS4EAMj7mLItRzehEypNmaAk0pIfzA4HniHpwAB5iH9j08ChjsRL2w==
X-Received: by 2002:aed:22ac:: with SMTP id p41mr2368970qtc.55.1550180323042;
 Thu, 14 Feb 2019 13:38:43 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:18 -0800
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Message-Id: <20190214213729.21702-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 06/17] kbuild: enable building KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KUnit to root Kconfig and Makefile allowing it to actually be built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes Since Last Version
 - Rewrote patch description. This was previously called "[RFC v3 06/19]
   arch: um: enable running kunit from User Mode Linux," which was
   incorrect since this patch does not have any UML specific bits in it.
---
 Kconfig  | 2 ++
 Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 3142e67d03f1b..d10308eb7f214 100644
--- a/Makefile
+++ b/Makefile
@@ -958,7 +958,7 @@ endif
 PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-- 
2.21.0.rc0.258.g878e2cd30e-goog

