Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2820894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttUwhsgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeG3XLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:11:34 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:33078 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeG3XLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:11:33 -0400
Received: by mail-io0-f201.google.com with SMTP id s14-v6so9891257ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GSFhJJjXAKzwslV2aojDI50z4s/ItifdXUjanLyszkw=;
        b=ttUwhsgIUMC/pNurY8Q95D/T9JgNxVEFdxw5WmQj8pxw9cPi+6tJDJihkShWRv3Q4x
         jBQA0jODT73b1/N+glRBqP3xZMlgnH2nQ/9vaEGw+Q4DNb46JD14Q0oYxmKWMxujME0k
         9GthLRRAD0lmtrwb/HsPWVuq8l+ix/JqrxMLR91H4L735xjBGQzrDPJ7P3+gcC/1wD0Z
         NonJj/h8VSDjQbzsTX506c/rqbunXXUmXtBzyUV1Bh36Hym77cHLhVVvQVr7uLwNNmnw
         m3ODUU1HZACxEfbxNVDqwYDzigs28nqkhac619+z7vHxsMF5uT+tBlJJ7qpEaASRF/EY
         y8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GSFhJJjXAKzwslV2aojDI50z4s/ItifdXUjanLyszkw=;
        b=MvaNYqgyS2qgppyK2HWR/7sSFRKjXvtEuDJ8JbFCyDNPrsntE89/i/EXRtbpGaF3G/
         eFTZdSKEWKJqqOAGsqVZvajZvGOEuDbbSqXv8SvJLwo70aMVt2sRJJ5FwrW/+symZ8o+
         T+WzNs4T9knUL1yobhfmX3eJuzpbLNsSq7h789Zpx5ShfadhW4pTh8s78ZvRjZoVL1z+
         wgxwPe5gJMO5lcb0UGCTRmqvpoqpofENVlrPHQv6ctIjy/TF/Yne1VWEsnPB2WtkgySc
         5W0NiKSOTFlxPw8szNG+gyh+ylKMZuZOVKMhZmPtyeL9qaOMbJLhoH/gd89zwGXVU1cR
         N3BA==
X-Gm-Message-State: AOUpUlESEu3SMYnj8Iwne+tTCn6FIIjaDNh4TjrJMgfngHspNoTBSyZ+
        sSo7PFQHF87kQXvwp/xpflXPkzRIDH39szPzWK8=
X-Google-Smtp-Source: AAOMgpeZUMlCjsaH4mZlkR2Mnawsc3nzrQEMMQ8P3nheOcu/J4EpJs9j6CGTR8+x5yfarJSwakQIb148mvXS2OtnSH8=
X-Received: by 2002:a24:7a51:: with SMTP id a78-v6mr461560itc.8.1532986478540;
 Mon, 30 Jul 2018 14:34:38 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:34:12 -0700
In-Reply-To: <20180730213412.242849-1-ndesaulniers@google.com>
Message-Id: <20180730213412.242849-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20180730213412.242849-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, natechancellor@gmail.com
Cc:     arnd@arndb.de, paul.burton@mips.com, christophe.leroy@c-s.fr,
        shorne@gmail.com, yamada.masahiro@socionext.com,
        keescook@chromium.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rdunlap@infradead.org, bp@suse.de, neilb@suse.com,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dwmw@amazon.co.uk, sandipan@linux.vnet.ibm.com,
        linux@rasmusvillemoes.dk, paullawrence@google.com,
        andreyknvl@google.com, will.deacon@arm.com, ghackmann@android.com,
        stable@vger.kernel.org, ghackmann@google.com, mka@chromium.org,
        jpoimboe@redhat.com, wvw@google.com, avagin@openvz.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

We also can't use compiler specific pragma's without triggering
-Werror=3Dunknown-pragmas in other compilers, so use __diag.

Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/kernel.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..909bb771c0ca 100644
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
+	__label__ __here;						\
+	__diag_push()							\
+	__diag_ignore(CLANG, 7, "-Wreturn-stack-address", "")		\
+__here: (unsigned long)&&__here;					\
+	__diag_pop()							\
+}									\
+)
=20
 #ifdef CONFIG_LBDAF
 # include <asm/div64.h>
--=20
2.18.0.345.g5c9ce644c3-goog

