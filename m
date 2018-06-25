Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CBAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297CF26213
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URfh8ucV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297CF26213
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbeFYWmI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:08 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:52798 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeFYWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:59 -0400
Received: by mail-io0-f202.google.com with SMTP id n21-v6so13057252iob.19
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JDe7omNGF3EhS1Wwn935GAPXMwY/I1wPiV41ZNKc+ik=;
        b=URfh8ucVQbWWC7LKzOUu783w72U62KYdfnmIDP3rKVYheqbAW+MgjqjLl7ZE/91lfy
         erUDfSfrmUrd9lcxra8yzLeBiwBRwlcuK34i5c7GBe5iMz72JRmTBTXUhyGdD/Qsty+b
         Kcwx1WR6o+NprV28iDuUBv4KDBl9nBBo24SrV6J5hm+Urm99RWyuKw+XDK6SLsqhUO90
         beOXEo9kO1yuls6OSOfiIw58ANYQVmM7mPmzCbqrJC7rfrkqhWISSpcJTJOhyoIsJL62
         cBwfNQZkaw2HcluQLM6Zoadyu7jjDB9VKZ3eslI+TssWcFJ9VLxcmQqEKQIr+r9vxyYX
         pb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JDe7omNGF3EhS1Wwn935GAPXMwY/I1wPiV41ZNKc+ik=;
        b=MaD0GLMNRY0UtLiJ2yjbXal70lX5jQBL1mT6YiVTK1XIrARrvdekxSvReUlyz11HKd
         aB9m4iw+NSpjlnoz9b0HdsjqcmLoDlqe86b01W7WPgawwKVZvHr7nzOPIPaE4uBQ0t/9
         GDEymNoY7yCmaNZjgLqYhJdOsJGkVsutrZ36TqXqSsS6YCnMJy8Oq1RHtr6ULwZY+l+L
         Z+cnMByvUXKOROUQ5xaqa9zzY59S8uLDw1RVK834GF1jt2y+GfJZ9zZfejM/kUyBpjck
         WHNshEfsFl4FSy4mFXpWO48pbw2LfFi+sRsX956kkQTUN0u4xx/xPm92r5GFZ8bBXHhC
         3M8Q==
X-Gm-Message-State: APt69E3/3ycuIBjntFzHnLdBLduxDjkLub25eE570FkQvcFuH0WLYxgh
        O7va1Qe2z/xAXYjG8zjqSSQtHZd83q9Asg==
X-Google-Smtp-Source: AAOMgpcafAqwUr9zdDE+lnCGR+mD+hrmqfpzgn75GOsICJZdayq/2nQbMCl1jhMrQE6+JPqebA/0ZQqn/tn89Q==
MIME-Version: 1.0
X-Received: by 2002:a24:5f84:: with SMTP id r126-v6mr1155993itb.42.1529966518814;
 Mon, 25 Jun 2018 15:41:58 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:04 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-17-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 16/27] compiler: Option to add PROVIDE_HIDDEN replacement
 for weak symbols
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to have a PROVIDE_HIDDEN (linker script) entry for
each weak symbol. This option solves an error in x86_64 where the linker
optimizes PIE generated code to be non-PIE because --emit-relocs was used
instead of -pie (to reduce dynamic relocations).

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 init/Kconfig            |  7 +++++++
 scripts/link-vmlinux.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index d4f90cc38ede..2d7431a8b108 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1974,6 +1974,13 @@ config ASN1
 	  inform it as to what tags are to be expected in a stream and what
 	  functions to call on what tags.
 
+config WEAK_PROVIDE_HIDDEN
+	bool
+	help
+	  Generate linker script PROVIDE_HIDDEN entries for all weak symbols. It
+	  allows to prevent non-PIE code being replaced by the linker if the
+	  emit-relocs option is used instead of PIE (useful for x86_64 PIE).
+
 source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4bf811c09f59..f5d31119b9d7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -142,6 +142,17 @@ kallsyms()
 	${CC} ${aflags} -c -o ${2} ${afile}
 }
 
+gen_weak_provide_hidden()
+{
+        if [ -n "${CONFIG_WEAK_PROVIDE_HIDDEN}" ]; then
+                local pattern="s/^\s\+ w \(\w\+\)$/PROVIDE_HIDDEN(\1 = .);/gp"
+                echo -e "SECTIONS {\n. = _end;" > .tmp_vmlinux_hiddenld
+                ${NM} ${1} | sed -n "${pattern}" >> .tmp_vmlinux_hiddenld
+                echo "}" >> .tmp_vmlinux_hiddenld
+                LDFLAGS_vmlinux="${LDFLAGS_vmlinux} -T .tmp_vmlinux_hiddenld"
+        fi
+}
+
 # Create map file with all symbols from ${1}
 # See mksymap for additional details
 mksysmap()
@@ -226,6 +237,9 @@ modpost_link vmlinux.o
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
+# Generate weak linker script
+gen_weak_provide_hidden vmlinux.o
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-- 
2.18.0.rc2.346.g013aa6912e-goog

