Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224e8aMuLdDvf2gFzu4JqMU1zvmBcfAUHmwth/U6uuaUs95IzijMfNNbi3Q3a/ZKyvcaNoYd
ARC-Seal: i=1; a=rsa-sha256; t=1518528515; cv=none;
        d=google.com; s=arc-20160816;
        b=NKKYxesh9U8plZmMaw+CEYPl7TVh+eWzT0+pHG19gTBnMmAwfz0qYy/CfLFjihPOxR
         2LzmCmratyhz37Puy+A29ZdQ5nSW10U1ahGPz37dvxgWEHKy1yGPeVERhTbGWSUmapYg
         IhYuwirwLfZulNQ18bcuUmbmMc5o7UyaKQJH2d+ZRqOUVbgEvbkIwSTfoJFw4++Tmet7
         RU84vsqDWAnwcaXaCZEGKjib5BZFNCsmnyyEI0ifAKg5fERwwYYSAXhto7wLRRCnJ5dG
         SZTOEfoO7GTdNRjipQtan3g1XtyyOMKJMa2Tfhtqd3SE2zL4ZVh4mVz9NJiSMWsybaMR
         inLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wX4AbLEH7bHfRQoyrxa0NF1w5pEQjC+PbCsPhlI34I4=;
        b=CR8FnZxuev08w98RQqk0bwXMO6WhkR9Ld89NF0tuP/Fbh+b98yFl9THz/yIuxjrBaI
         baPAyzS4qgNht7nOjAbqyY125hQyuQWUSr6AY5h/4Yp0riNEKHa8NcFt2k51xdte40rP
         Ozxrmph8uwTOeWZok0Uh9pSBO1a+XDScOiI0G8YTRAQJWIRh0TeY0q8Y1LjjauBB0/K0
         2u760R+TiN+tbQ5A/r32ODX39W9xqfb8SqfAW6oLJgIbq9ILU/rBhS2GmWtFBIHDYpDo
         f64c4uuR5g1HMb7k+Wk7WGC+NADXYfMv+gkQsZO8u1TP9DcEa3RchqgORBFp24yu0h9y
         S+vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=rA6ADkmc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=rA6ADkmc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 13 Feb 2018 14:28:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
	bp@alien8.de, tglx@linutronix.de, arjan@linux.intel.com,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org, hpa@zytor.com,
	gregkh@linuxfoundation.org, dan.j.williams@intel.com,
	dwmw@amazon.co.uk, luto@kernel.org, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>
Subject: Re: [tip:x86/pti] Revert "x86/speculation: Simplify
 indirect_branch_prediction_barrier()"
Message-ID: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
References: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
 <tip-f208820a321f9b23d77d7eed89945d862d62a3ed@git.kernel.org>
 <20180213094132.GF25201@hirez.programming.kicks-ass.net>
 <20180213112838.v2xu4qdnend5tflv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213112838.v2xu4qdnend5tflv@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160265203742206?=
X-GMAIL-MSGID: =?utf-8?q?1592292556001844357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 12:28:38PM +0100, Ingo Molnar wrote:

> Separate would be better, it makes sense and is one problem less to worry about?

Something like so then? I'm not entirely sure which commit wants to fo
in Fixes, I picked the earlier one, but it could equally have been:

Fixes: f208820a321f ("Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"")

---
Subject: x86/speculation: Add msr-index.h
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 13 Feb 2018 10:41:32 +0100

Joe Konno reported a compile failure resulting from using an MSR
without inclusion of msr-index.h, and while the current code builds
fine (by accident) this needs fixing for future patches.

Cc: mingo@kernel.org
Cc: dwmw2@infradead.org
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: tglx@linutronix.de
Cc: arjan@linux.intel.com
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: jpoimboe@redhat.com
Cc: hpa@zytor.com
Cc: gregkh@linuxfoundation.org
Cc: dwmw@amazon.co.uk
Cc: luto@kernel.org
Fixes: 20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
Reported-by: Joe Konno <joe.konno@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 #ifdef __ASSEMBLY__
 
