Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256QHkEorCqMfWqCGzH0087iNF+eo7kJR039nRPqs492OJLeU3jHppI24Ohh74AuUnr35yD
ARC-Seal: i=1; a=rsa-sha256; t=1519218082; cv=none;
        d=google.com; s=arc-20160816;
        b=KshqttHvbx0eAqm4YFvKoHSosGt3wDVJF8X5VCoq3FHcLxEKR1v7EZvaVVciJ1AE06
         UZK7YvG06fTa1p+jHAA9nj0ufq6h0ZYnlhL8IzNKQwr/9ScopW8jE5yoFSDNc+W9NjeW
         s4jl37vdBeAWU9qLLYtqbQtRmBwxvni/iUuU368bsxe/NpBLhZ5NkzyIMXuoKn3TkNwZ
         /X27hCl/mAsx0ed+ntSmSUMA1ThGDTt4oQ4cKq8VUIid7cGT8sYV5o7gWeGyTIjC5Fvd
         0fSu/BcFpPJdg1cqbgocV9K0kIR96HVKv22uiamh89U4mZHPYN0WU2cWDW9Q8i1SA+qY
         FE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ms04ClJc7nawTJbgU2u7/OgX4ay8KCK/bZefqjtuxq4=;
        b=pY+M6VGO/AmJeqwSSLWHa10onNhFin12FwWYKSD5YakSGeSwt8D4I9eQv54MIGg2bh
         +pPR/D57co6pGPldCuiO0FsZyqiPWRT9aSaWG1HXWdNIMNUN/OzpZU6biTfN/sTeyTDT
         0Ip/zQEOAhLIepLttRlQAwa99jFrm8itrBgif7zM+tcPDs05aeTIBT2ktrZ8G8xysbSQ
         Y0Lw+SfiiTSB/d/sjhATz4Ur734TX6tKU+8S040/UkPGBVphP3bceDdWVZct2kZ/SsJ5
         wCCKSHy6pO9HbKGZ24TAOSd+BCY6cObteHkThIqk5WaoWI07VghWbAlRm4OSSc9ALtIP
         S40Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sasha Levin <alexander.levin@verizon.com>,
	Alexander Potapenko <glider@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Michal Hocko <mhocko@kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tim Hansen <devtimhansen@gmail.com>,
	Vegard Nossum <vegardno@ifi.uio.no>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 081/167] kmemcheck: remove whats left of NOTRACK flags
Date: Wed, 21 Feb 2018 13:48:12 +0100
Message-Id: <20180221124528.877841731@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015619522534995?=
X-GMAIL-MSGID: =?utf-8?q?1593015619522534995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>

commit d8be75663cec0069b85f80191abd2682ce4a512f upstream.

Now that kmemcheck is gone, we don't need the NOTRACK flags.

Link: http://lkml.kernel.org/r/20171007030159.22241-5-alexander.levin@verizon.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Hansen <devtimhansen@gmail.com>
Cc: Vegard Nossum <vegardno@ifi.uio.no>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable.h       |    5 -----
 arch/x86/include/asm/pgtable_types.h |   13 -------------
 include/linux/gfp.h                  |    9 ---------
 include/linux/slab.h                 |    6 ------
 include/trace/events/mmflags.h       |    1 -
 mm/slub.c                            |    2 --
 tools/perf/builtin-kmem.c            |    1 -
 7 files changed, 37 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -668,11 +668,6 @@ static inline bool pte_accessible(struct
 	return false;
 }
 
-static inline int pte_hidden(pte_t pte)
-{
-	return pte_flags(pte) & _PAGE_HIDDEN;
-}
-
 static inline int pmd_present(pmd_t pmd)
 {
 	/*
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -32,7 +32,6 @@
 
 #define _PAGE_BIT_SPECIAL	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
-#define _PAGE_BIT_HIDDEN	_PAGE_BIT_SOFTW3 /* hidden by kmemcheck */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
@@ -79,18 +78,6 @@
 #define _PAGE_KNL_ERRATUM_MASK 0
 #endif
 
-#ifdef CONFIG_KMEMCHECK
-#define _PAGE_HIDDEN	(_AT(pteval_t, 1) << _PAGE_BIT_HIDDEN)
-#else
-#define _PAGE_HIDDEN	(_AT(pteval_t, 0))
-#endif
-
-/*
- * The same hidden bit is used by kmemcheck, but since kmemcheck
- * works on kernel pages while soft-dirty engine on user space,
- * they do not conflict with each other.
- */
-
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _PAGE_SOFT_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_SOFT_DIRTY)
 #else
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -37,7 +37,6 @@ struct vm_area_struct;
 #define ___GFP_THISNODE		0x40000u
 #define ___GFP_ATOMIC		0x80000u
 #define ___GFP_ACCOUNT		0x100000u
-#define ___GFP_NOTRACK		0x200000u
 #define ___GFP_DIRECT_RECLAIM	0x400000u
 #define ___GFP_WRITE		0x800000u
 #define ___GFP_KSWAPD_RECLAIM	0x1000000u
@@ -201,19 +200,11 @@ struct vm_area_struct;
  * __GFP_COMP address compound page metadata.
  *
  * __GFP_ZERO returns a zeroed page on success.
- *
- * __GFP_NOTRACK avoids tracking with kmemcheck.
- *
- * __GFP_NOTRACK_FALSE_POSITIVE is an alias of __GFP_NOTRACK. It's a means of
- *   distinguishing in the source between false positives and allocations that
- *   cannot be supported (e.g. page tables).
  */
 #define __GFP_COLD	((__force gfp_t)___GFP_COLD)
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
-#define __GFP_NOTRACK	((__force gfp_t)___GFP_NOTRACK)
-#define __GFP_NOTRACK_FALSE_POSITIVE (__GFP_NOTRACK)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -78,12 +78,6 @@
 
 #define SLAB_NOLEAKTRACE	0x00800000UL	/* Avoid kmemleak tracing */
 
-/* Don't track use of uninitialized memory */
-#ifdef CONFIG_KMEMCHECK
-# define SLAB_NOTRACK		0x01000000UL
-#else
-# define SLAB_NOTRACK		0x00000000UL
-#endif
 #ifdef CONFIG_FAILSLAB
 # define SLAB_FAILSLAB		0x02000000UL	/* Fault injection mark */
 #else
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -46,7 +46,6 @@
 	{(unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
 	{(unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
 	{(unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
-	{(unsigned long)__GFP_NOTRACK,		"__GFP_NOTRACK"},	\
 	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5633,8 +5633,6 @@ static char *create_unique_id(struct kme
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
 		*p++ = 'F';
-	if (!(s->flags & SLAB_NOTRACK))
-		*p++ = 't';
 	if (s->flags & SLAB_ACCOUNT)
 		*p++ = 'A';
 	if (p != name + 1)
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -655,7 +655,6 @@ static const struct {
 	{ "__GFP_RECLAIMABLE",		"RC" },
 	{ "__GFP_MOVABLE",		"M" },
 	{ "__GFP_ACCOUNT",		"AC" },
-	{ "__GFP_NOTRACK",		"NT" },
 	{ "__GFP_WRITE",		"WR" },
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
