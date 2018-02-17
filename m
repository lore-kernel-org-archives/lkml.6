Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x225dHaUhyNPMAcBhXD5AKiPVa9nPa1gX2/NZ6lDkZcBhpMP+6JQlv3KsoUhHOvGbAYR3XIP6
ARC-Seal: i=1; a=rsa-sha256; t=1518863537; cv=none;
        d=google.com; s=arc-20160816;
        b=rpF1dW+iMm06ScmAuR2hj/DwybkmssM4PvSpQGj1n4SCMSGzI3/2w2qdQCJzylUnrj
         9vr8ieaH4JfZW//xeqj1kW6/92zz3istAYvEX/lF51KzyvOcsCtnquXqNFJdPYfd3kar
         adU6X/S9QT82IjKIwDCyIX8wLbRInsiX2gnIKjnTgJ3ikz691psTTlxhPL24ZIFXnf0a
         aAmA00O74jwpfjuORV3pbPWtX5fWEEoLkPbs/tdQA9xTeUlnRKLzbHYHb7eSN7Fw8mhb
         DRuSuWwvawAd8eNijQp17F7B1z05ozkgj12gf3GMx91K2l2u6vz2aUPJT/VGTYt921oB
         P8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=yTGBBif0lbDAQISpeHIwqJuXp04h6pTUYUt7yXT8FMc=;
        b=T1IYX0JF8agMrC9y5GTOjpowUyo4FvxajTdB95RWUC41OvBWcHbSvunjhP1/1WrbWD
         Tuqyd9IgDH5s5al3YSy40LQuOuPs17MmlYEpSLGWNWxFOUuVfB4gyOBbstBbEQSqGoYD
         +IDUvGfxG0LDvdGQmJRjuv51p9GXGamztyWIgOEnvtwNICf6ikhyk2LMlj8BEwGhtrPK
         wq3ccOmvXTO2ShJWUbuHreif/OWMHRjG0zKjvg+OaZq3PE4OZEiWcWtnPSoOAL3gTuC6
         vTqpaY7nK4s5Dspd0qzMd7Z+l45mMiUTBAesryrQ1IVZhvTSx01rpK4u7CnPrM/RKlN/
         gKMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 02:11:00 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8@git.kernel.org>
Cc: tglx@linutronix.de, will.deacon@arm.com, peterz@infradead.org,
        linux@rasmusvillemoes.dk, arjan@linux.intel.com,
        dan.j.williams@intel.com, bp@alien8.de, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, dwmw2@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org
Reply-To: jpoimboe@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        gregkh@linuxfoundation.org, dwmw2@infradead.org,
        dan.j.williams@intel.com, bp@alien8.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, peterz@infradead.org, linux@rasmusvillemoes.dk,
        will.deacon@arm.com, arjan@linux.intel.com
In-Reply-To: <151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] nospec: Allow index argument to have const-qualified
 type
Git-Commit-ID: b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592643852360261406?=
X-GMAIL-MSGID: =?utf-8?q?1592643852360261406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8
Gitweb:     https://git.kernel.org/tip/b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Fri, 16 Feb 2018 13:20:48 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 08:40:59 +0100

nospec: Allow index argument to have const-qualified type

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nospec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index d6701e3..172a19d 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -52,7 +52,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
