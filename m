Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04914C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F027A64
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejd6ElVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5F027A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936220AbeF1XV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:21:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34087 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeF1XVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:21:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id q24-v6so6147467edr.1;
        Thu, 28 Jun 2018 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=afXq2aPv2B3MzZ3D5CMcFffuyIH8CG7CNLmnWRAl9fw=;
        b=ejd6ElVvCipsxSWm6qlewdixNBcU/QLTjo9yHO8dLRV75bTHJJcx31V3m40PPCGIc9
         sMGTtJ9E6lwXQpZc1R+KxHfUwDa4YV4abXV8vzoP+p4WmNz+HkzweQdDpEScsvLvwAYQ
         z8/yLG90U8D01gczXmwXhrer2y7Kfxf/iUVED1dotD0YAmc4N8uLCRWx2zR6Cftrmvz4
         UZYzd1Bh6rVWTUTSqtDWTrbUAMiHc9pNkvX+xZSB1jOHxXvw//yKLlqj8TrPOqi4G/5j
         8dVwgipifzvc0b0GWSIoBeeoeU5I4AK0+3Xr1t35Z0hFMMrQPWwXxe28YGkbmwx+bv9J
         RdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=afXq2aPv2B3MzZ3D5CMcFffuyIH8CG7CNLmnWRAl9fw=;
        b=C8pHq3tRNzWXU2+xKiXbnrhv7a0SbJiHhsX+OgI1TC+KWBAUymS9xkEOqZUAA4d+w6
         VQFVBuB6esQepdqiGehkfoDEhWfycB/2BHdN1o7rW/RI4NuNzR198kjGAolso/a4gySx
         jGhS1ZXS2o415dpnCfm7HjQ5WrHjYUhTwPp4bU970+MPuclvnv5aGVS6S45505iDPrJb
         Kq1AdFdNCzglvywInMDck41LEX9D6TA1y9U6G/rBo46vppdQtaiUcGslrtOy5JT03AAu
         1FweC8HHlEfjCRXhFKkpQxnDcMKXNb5KFGc64H91+b3egyNzM0+zQ915M84ySvUmzNkl
         i90g==
X-Gm-Message-State: APt69E06mMGn+s3O/Rv+a0pILmyCM1PfPIJ7qAnT/P56ksRfUS8d2SvH
        HFj7eU/gp3IbM9VaFn71i8s=
X-Google-Smtp-Source: AAOMgpdBoq6+5FtqzCFhHl0g5i0C9BIzNWVuhy4PvMKiwyRPXeO65ofzTyjU3kSMeZ4ZYoBTnTzzWw==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr10824645edp.135.1530228082448;
        Thu, 28 Jun 2018 16:21:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40dc:3d00:7d3e:ff9f:2e8:f5a5])
        by smtp.gmail.com with ESMTPSA id w17-v6sm3361284edr.30.2018.06.28.16.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:21:21 -0700 (PDT)
Date:   Fri, 29 Jun 2018 01:21:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH] sparse: stricter warning for explicit cast to ulong
Message-ID: <20180628232119.5jaavhewv5nb6ufb@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
 <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse issues a warning when user pointers are casted to integer
types except to unsigned longs which are explicitly allowed.
However it may happen that we would like to also be warned
on casts to unsigned long.

Fix this by adding a new warning flag: -Wcast-from-as (to mirrors
-Wcast-to-as) which extends -Waddress-space to all casts that
remove an address space attribute (without using __force).

References: https://lore.kernel.org/lkml/20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com/
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

This patch is available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git warn-cast-from-as

----------------------------------------------------------------
Luc Van Oostenryck (1):
      stricter warning for explicit cast to ulong

 evaluate.c                         |  4 +--
 lib.c                              |  2 ++
 lib.h                              |  1 +
 sparse.1                           |  9 ++++++
 validation/Waddress-space-strict.c | 56 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 validation/Waddress-space-strict.c

diff --git a/evaluate.c b/evaluate.c
index 194b97218..64e1067ce 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2998,14 +2998,14 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		}
 	}
 
-	if (ttype == &ulong_ctype)
+	if (ttype == &ulong_ctype && !Wcast_from_as)
 		tas = -1;
 	else if (tclass == TYPE_PTR) {
 		examine_pointer_target(ttype);
 		tas = ttype->ctype.as;
 	}
 
-	if (stype == &ulong_ctype)
+	if (stype == &ulong_ctype && !Wcast_from_as)
 		sas = -1;
 	else if (sclass == TYPE_PTR) {
 		examine_pointer_target(stype);
diff --git a/lib.c b/lib.c
index 308f8f699..0bb5232ab 100644
--- a/lib.c
+++ b/lib.c
@@ -248,6 +248,7 @@ static struct token *pre_buffer_end = NULL;
 int Waddress = 0;
 int Waddress_space = 1;
 int Wbitwise = 1;
+int Wcast_from_as = 0;
 int Wcast_to_as = 0;
 int Wcast_truncate = 1;
 int Wconstexpr_not_const = 0;
@@ -678,6 +679,7 @@ static const struct flag warnings[] = {
 	{ "address", &Waddress },
 	{ "address-space", &Waddress_space },
 	{ "bitwise", &Wbitwise },
+	{ "cast-from-as", &Wcast_from_as },
 	{ "cast-to-as", &Wcast_to_as },
 	{ "cast-truncate", &Wcast_truncate },
 	{ "constexpr-not-const", &Wconstexpr_not_const},
diff --git a/lib.h b/lib.h
index b0453bb6e..46e685421 100644
--- a/lib.h
+++ b/lib.h
@@ -137,6 +137,7 @@ extern int preprocess_only;
 extern int Waddress;
 extern int Waddress_space;
 extern int Wbitwise;
+extern int Wcast_from_as;
 extern int Wcast_to_as;
 extern int Wcast_truncate;
 extern int Wconstexpr_not_const;
diff --git a/sparse.1 b/sparse.1
index 806fb0cf0..62956f18b 100644
--- a/sparse.1
+++ b/sparse.1
@@ -77,6 +77,15 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-bitwise\fR.
 .
 .TP
+.B \-Wcast\-from\-as
+Warn about which remove an address space to a pointer type.
+
+This is similar to \fB\-Waddress\-space\fR but will also warn
+on casts to \fBunsigned long\fR.
+
+Sparse does not issues these warnings by default.
+.
+.TP
 .B \-Wcast\-to\-as
 Warn about casts which add an address space to a pointer type.
 
diff --git a/validation/Waddress-space-strict.c b/validation/Waddress-space-strict.c
new file mode 100644
index 000000000..ad23f74ae
--- /dev/null
+++ b/validation/Waddress-space-strict.c
@@ -0,0 +1,56 @@
+#define __user __attribute__((address_space(1)))
+
+typedef unsigned long ulong;
+typedef long long llong;
+typedef struct s obj_t;
+
+static void expl(int i, ulong u, llong l, void *v, obj_t *o, obj_t __user *p)
+{
+	(obj_t*)(i);
+	(obj_t __user*)(i);
+
+	(obj_t*)(u);
+	(obj_t __user*)(u);
+
+	(obj_t*)(l);
+	(obj_t __user*)(l);
+
+	(obj_t*)(v);
+	(obj_t __user*)(v);
+
+	(int)(o);
+	(ulong)(o);
+	(llong)(o);
+	(void *)(o);
+	(obj_t*)(o);
+	(obj_t __user*)(o);
+
+	(int)(p);		// w
+	(ulong)(p);		// w!
+	(llong)(p);		// w
+	(void *)(p);		// w
+	(obj_t*)(p);		// w
+	(obj_t __user*)(p);	// ok
+}
+
+/*
+ * check-name: Waddress-space-strict
+ * check-command: sparse -Wcast-from-as -Wcast-to-as $file
+ *
+ * check-error-start
+Waddress-space-strict.c:10:10: warning: cast adds address space to expression (<asn:1>)
+Waddress-space-strict.c:13:10: warning: cast adds address space to expression (<asn:1>)
+Waddress-space-strict.c:16:10: warning: cast adds address space to expression (<asn:1>)
+Waddress-space-strict.c:19:10: warning: cast adds address space to expression (<asn:1>)
+Waddress-space-strict.c:26:10: warning: cast adds address space to expression (<asn:1>)
+Waddress-space-strict.c:28:10: warning: cast removes address space of expression
+Waddress-space-strict.c:29:10: warning: cast removes address space of expression
+Waddress-space-strict.c:30:10: warning: cast removes address space of expression
+Waddress-space-strict.c:31:10: warning: cast removes address space of expression
+Waddress-space-strict.c:32:10: warning: cast removes address space of expression
+Waddress-space-strict.c:9:10: warning: non size-preserving integer to pointer cast
+Waddress-space-strict.c:10:10: warning: non size-preserving integer to pointer cast
+Waddress-space-strict.c:21:10: warning: non size-preserving pointer to integer cast
+Waddress-space-strict.c:28:10: warning: non size-preserving pointer to integer cast
+ * check-error-end
+ */
-- 
2.18.0

