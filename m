Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10919C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92922145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Z0f6SQ/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBJUkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:40:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55376 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBJUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:40:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so13496877wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBD5fk1fv665z03ILBeG4waaS2hzD67GyjxfUY1jbJM=;
        b=Z0f6SQ/f11K05Vxrg1Rw8ZIEZlfa0MurHNMyE2SaQAzLHmtlXF+7FdXXNci2m868aE
         vRWhebZuDq5+JAWLowC+mgKKEwHSjhLLTax/d697qWTQKg/B62BvnDyClY/KX0A3P+rN
         793/A8Bsr3Uvqzz+oZxMOBhizEenHDJpAQgx/TkvsaiZjR6vvJIvDj2ueRB3LBjRFHoo
         cmY0RWM4jV0LDUJLR8TT2anNxyIdV1NAuQtGlbFekD4WKiB/97YAlUlDia5f2jfpY62g
         csRk4Re8FOF3M6q89KdvOQJBJHbFiDPj0vHL0Vhew8pJ0qn4f2YNqDbwxq1sbNCPhp40
         6xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBD5fk1fv665z03ILBeG4waaS2hzD67GyjxfUY1jbJM=;
        b=eJbaQdb2QKPWKlc+3AdSrpWcZ9+GKFIx2skUZTrSqcpAqcDcSsT/+ee3dphTmYumjU
         g79vpjH0o4OHGNGyd04HaV6ErB63z6QHhsgK77th8uD1Rm3Zkq122hY8k1Hbu4y3h/Fj
         FYEaMfxA+i9Et8CzEWOD7pYYyRFBcIujKDvtdUKhV8/hk9cOez4buOTn44w4K0hkyVSc
         i0rokAcYyzCXAWFZB8AYT/usS408dwUG15ytipN4Y1768KbwAnA+pd5jMEfWjcIuFDrJ
         dYq4rP6EvSBHqQhnf8i2KSGXwHBYkiNYsytSuJPMBF6amUW62EUb4ta53ccI3mg7JkLW
         NfQg==
X-Gm-Message-State: AHQUAubDOIu6UxhGvqKjG+W6RDDE/a3qU4hkfdmmb3EYDpUQctpLVBbY
        yroG/Zv6QXMcrH+LDWeRjuWHkg==
X-Google-Smtp-Source: AHgI3IbGDqJ1jBGxE4/SF2+B37v6+Tr4Do2d7gpyWVodHbmYAoc4D0i7YC5VcT3uAcxFQjdx0+mwwQ==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr2295751wmc.92.1549831200166;
        Sun, 10 Feb 2019 12:40:00 -0800 (PST)
Received: from localhost.localdomain (p200300EA6F14665209EDE1AF663E9C0B.dip0.t-ipconnect.de. [2003:ea:6f14:6652:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id l20sm16469784wrb.93.2019.02.10.12.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:39:59 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v4 1/3] sysctl: handle overflow in proc_get_long
Date:   Sun, 10 Feb 2019 21:39:41 +0100
Message-Id: <20190210203943.8227-2-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210203943.8227-1-christian@brauner.io>
References: <20190210203943.8227-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_get_long() is a funny function. It uses simple_strtoul() and for a
good reason. proc_get_long() wants to always succeed the parse and return
the maybe incorrect value and the trailing characters to check against a
pre-defined list of acceptable trailing values.
However, simple_strtoul() explicitly ignores overflows which can cause
funny things like the following to happen:

echo 18446744073709551616 > /proc/sys/fs/file-max
cat /proc/sys/fs/file-max
0

(Which will cause your system to silently die behind your back.)

On the other hand kstrtoul() does do overflow detection but does not return
the trailing characters, and also fails the parse when anything other than
'\n' is a trailing character whereas proc_get_long() wants to be more
lenient.

Now, before adding another kstrtoul() function let's simply add a static
parse strtoul_lenient() which:
- fails on overflow with -ERANGE
- returns the trailing characters to the caller

The reason why we should fail on ERANGE is that we already do a partial
fail on overflow right now. Namely, when the TMPBUFLEN is exceeded. So we
already reject values such as 184467440737095516160 (21 chars) but accept
values such as 18446744073709551616 (20 chars) but both are overflows. So
we should just always reject 64bit overflows and not special-case this
based on the number of chars.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
/* Changelog */
v3:
- (Kees) s/#include <../lib/kstrtox.h>/#include "../lib/kstrtox.h"/g
- (Kees) document strtoul_lenient()

v2:
- s/sysctl_cap_erange/sysctl_lenient/g
- consistenly fail on overflow

v1:
- s/sysctl_strtoul_lenient/strtoul_cap_erange/g
- (Al) remove bool overflow return argument from strtoul_cap_erange
- (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
- (Dominik) fix spelling in commit message
---
 kernel/sysctl.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..70581ade3555 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,6 +67,8 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 
+#include "../lib/kstrtox.h"
+
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
@@ -2092,6 +2094,41 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
 	}
 }
 
+/**
+ * strtoul_lenient - parse an ASCII formatted integer from a buffer and only
+ *                   fail on overflow
+ *
+ * @cp: kernel buffer containing the string to parse
+ * @endp: pointer to store the trailing characters
+ * @base: the base to use
+ * @res: where the parsed integer will be stored
+ *
+ * In case of success 0 is returned and @res will contain the parsed integer,
+ * @endp will hold any trailing characters.
+ * This function will fail the parse on overflow. If there wasn't an overflow
+ * the function will defer the decision what characters count as invalid to the
+ * caller.
+ */
+static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
+			   unsigned long *res)
+{
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(cp, &base);
+	rv = _parse_integer(cp, base, &result);
+	if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
+		return -ERANGE;
+
+	cp += rv;
+
+	if (endp)
+		*endp = (char *)cp;
+
+	*res = (unsigned long)result;
+	return 0;
+}
+
 #define TMPBUFLEN 22
 /**
  * proc_get_long - reads an ASCII formatted integer from a user buffer
@@ -2135,7 +2172,8 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	if (strtoul_lenient(p, &p, 0, val))
+		return -EINVAL;
 
 	len = p - tmp;
 
-- 
2.20.1

