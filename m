Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81874FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280D220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFIGoRxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280D220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3Sm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:42:26 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:45639 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3Sm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:42:26 -0400
Received: by mail-vk0-f73.google.com with SMTP id l5-v6so5616384vkd.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Zhd9brlUSU3VJSV9/oY0K6ohjn54GHCy8fO4/WEPHqo=;
        b=VFIGoRxHER+0LT4MJmafU4eevLxk039xJHN/613o1L0fblD7tl/6KD8+Idp/ickzeN
         gH7kQoaclbNNJV5G/Y0VY9jlXqmdDUUWLW21nWzT4kyUjC0eky0Q5NsqLScLpMXFo5QZ
         PKLWdWVFGJ2WdUonwLxat0blMohH5h4RE14Z641bwcgNBQwQi68MfUcvg/G8KAXWcevM
         YgUbaluiJPKaN0KRrUIAbwN91+JZ/29D35B7RQNpYr6/hKH0OEZmkInYjFtYKsYNv/HG
         QV5LISwj0LVchkUu+kIXd5rPrFquzJnD4LReYnCEIqHugt3P3dV/1kz2p86vpWWC2oqg
         SJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Zhd9brlUSU3VJSV9/oY0K6ohjn54GHCy8fO4/WEPHqo=;
        b=mIwJAnyUmqeM/pPzISv84yKdIydUfyVnmnELwOERC3z+LUPyltsALT80x9nl1FU7qV
         hOT18jJFXj9v/pZ5p9WB/rwWEJSl4kcsoOHC2D1Iyh/+2DX8LM+yxc5Keo51v2fZ+0B7
         k4M8kDHMYzBismDg0rBx72Xmps71rO7/68IYhVRUUrkPBwrYciSDpqOk9TGF9UrP9FdX
         JfOphxoHM5Cm66qm0UOLAUwPxsFVE1B54CXMbDLRnnjZF05ThuhQsPI8fWpfyEMAA6fQ
         5QlQ3aQNfV4O8dJEq26/JCPswaI4SLqCzisa3oRxetkeuo9wPP3pvihCJHr+TPtTaz39
         mUPw==
X-Gm-Message-State: AOUpUlGSmzG0/pPiabpz/E7qi3NJEVVuAnehQwa3iDEpyjwJ2da2JS9k
        g7C0m7WH9eIzbdCv1r19hjJ2DNuuLDRZACCrrmE=
X-Google-Smtp-Source: AAOMgpd9lSWOGLqmPeCiOhqJJlY9+jY2MlAjPOtPqh3BUXEbRv2W6HT4NIUey8nsNhjXKupzGLH1uGyP6zjZGyeV0Tk=
X-Received: by 2002:a1f:ae84:: with SMTP id x126-v6mr8762108vke.38.1532970390260;
 Mon, 30 Jul 2018 10:06:30 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:06:20 -0700
Message-Id: <20180730170622.99349-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     mka@chromium.org, ghackmann@android.com, ghackmann@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with Clang-7.0, _THIS_IP_ generates -Wreturn-stack-address
warnings for almost every translation unit. In general, I'd prefer to
leave this on (returning the address of a stack allocated variable is in
general a bad idea) and disable it only at whitelisted call sites.

We can't do something like:
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wreturn-stack-address"
 <code>
 #pragma clang diagnostic pop

in a GNU Statement Expression or macro, hence we use _Pragma, which is
its raison d'=C3=AAtre: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html

Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/kernel.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..5906f5727f90 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -168,7 +168,15 @@
=20
=20
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
-#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; }=
)
+#define _THIS_IP_  (							\
+{									\
+	_Pragma("clang diagnostic push")				\
+	_Pragma("clang diagnostic ignored \"-Wreturn-stack-address\"")	\
+	__label__ __here;						\
+__here: (unsigned long)&&__here;					\
+	_Pragma("clang diagnostic pop")					\
+}									\
+)
=20
 #ifdef CONFIG_LBDAF
 # include <asm/div64.h>
--=20
2.18.0.233.g985f88cf7e-goog

