Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEDCC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D0620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LqGmUUUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D0620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeJOSk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:40:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39535 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeJOSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:40:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so20759080wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CVmx7Ut+0e/8zX/9p6SV4r6HN9NiAub+K+s0wdKcmPk=;
        b=LqGmUUUiprVbj18u3q19Af2O6Oj5JXeefJR/hUp+2NZ8jAIOGLlB2JzNpOFHBzpv3j
         ZPaVJRhM4E6N2HI/RS2ZkTeKn9XlqDDE30aXJKhGrhl6wIOG0cEg6P9FIoKp26fRJH6B
         37ktwUPa3n+it0eyhf3c2RwOwXkqjExzx2cA0lnBnT8NzR0l8YnbpIyJyQDaWiUAeA9O
         FpEEf6vvRfA8zh235YPJxm4h9f36eik2aQ8t1DxvBhsmYiEOHlvX+bCJ1QU55tOudhrY
         2Ge8aXO1drflq8o4H43dfiCXbW7DG9kzSCkG9nwy5h2iljWGdMTlnQhl5oYCYpWqkjcw
         eQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CVmx7Ut+0e/8zX/9p6SV4r6HN9NiAub+K+s0wdKcmPk=;
        b=szDjkZG+ZRY6iT5EyaLd+3D6tf7faNVOse8SHZVd28lKc/S0asF//LNPcJO2cc4YR/
         sfqNleluDg3lw8aej6ttp3RVuu9o4XhF6g+A+IRMttbhUR5IxgdcGZpplp32yz0Ps0sS
         K5NgLc2fnZbN0OEzQweVLTAf608AO6akLkNKcURKf0jtAhvpVcbMEec5xlXoTT+sC6Hi
         +3MRzVz/PhkSATnifnF86hSFFsI1gepeVuLXPtx7qS+fSa1w1dH8V6WEtaIXE6CE3nFg
         OSIbGHjOGr7Fxme1j4tvXUtTFPYsZlF6S1DGZ+MO/jI42eBT3LvkqxAC6Skq86+ySZau
         XmLA==
X-Gm-Message-State: ABuFfoj9qCDpHf5UHMYDt7BpRA12xp2mhJ5LahJXa9METZYvtP3e4aqC
        uRjacFrDdmNNShXPX/J5qKULGQ==
X-Google-Smtp-Source: ACcGV60CydaQHQPfGDdDD1izRxDx/aoUBO7nsFruXfvT3rCJZrgzAYIztZZidfFU3FLFiyp0xwrwGA==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr14893252wrg.255.1539600971732;
        Mon, 15 Oct 2018 03:56:11 -0700 (PDT)
Received: from localhost.localdomain (u-086-c100.eap.uni-tuebingen.de. [134.2.86.100])
        by smtp.gmail.com with ESMTPSA id a11-v6sm14236484wrp.3.2018.10.15.03.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:56:10 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
Date:   Mon, 15 Oct 2018 12:55:43 +0200
Message-Id: <20181015105544.4395-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015105544.4395-1-christian@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
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

On the other hand kstrtoul() does do overflow detection but fails the parse
in this case, does not return the trailing characters, and also fails the
parse when anything other than '\n' is a trailing character whereas
proc_get_long() wants to be more lenient.

Now, before adding another kstrtoul() function let's simply add a static
parse strtoul_cap_erange() which does:
- returns ULONG_MAX on ERANGE
- returns the trailing characters to the caller
This guarantees that we don't regress userspace in any way but also caps
any parsed value to ULONG_MAX and prevents things like file-max to become 0
on overflow.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
- s/sysctl_strtoul_lenient/strtoul_cap_erange/g
- (Al) remove bool overflow return argument from strtoul_cap_erange
- (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
- (Dominik) fix spelling in commit message
---
 kernel/sysctl.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..97551eb42946 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,6 +67,7 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
+#include <../lib/kstrtox.h>
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
@@ -2065,6 +2066,25 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
 	}
 }
 
+static unsigned long strtoul_cap_erange(const char *cp, char **endp,
+					unsigned int base)
+{
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(cp, &base);
+	rv = _parse_integer(cp, base, &result);
+	if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
+		result = ULONG_MAX;
+
+	cp += (rv & ~KSTRTOX_OVERFLOW);
+
+	if (endp)
+		*endp = (char *)cp;
+
+	return result;
+}
+
 #define TMPBUFLEN 22
 /**
  * proc_get_long - reads an ASCII formatted integer from a user buffer
@@ -2108,7 +2128,7 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	*val = strtoul_cap_erange(p, &p, 0);
 
 	len = p - tmp;
 
-- 
2.17.1

