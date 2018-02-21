Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224U4CpyEEuu2BCXo2KU5P3su7JA03LCwenCGGeBWzC/bufOPoNjo6FrNMa9+8Vdl2yF3RAj
ARC-Seal: i=1; a=rsa-sha256; t=1519217805; cv=none;
        d=google.com; s=arc-20160816;
        b=N0HD6tJeksIDnW6p7t45NyQAgxGKV+ci8nA72VrKDUkJkXO2o4mILZUv0VRmaRVFTA
         v65vSooZsxnlGAA0h9dSbo0wkNcR0zBk1zvZSwwZa0/ZBMuqpGfsMzojz/CJTZIanRH6
         /cAibU9eoeJj1C0SQm3P/YEHiRqQ04gSziMiSh5Gy1aVX8ufCAVs6245yIV9XDvK/gW5
         Zj0jTcdfVFfqktWD7wIMZexF68S9H3IEO7d/TBnEaMMQNK/P3c9001Ay1xZN5I70djkM
         yBfbEHVz7PNFs6u4m6rN3Y/oq8OlAsxA4xPZCj8bj7TrFeH8jsO1t8oCyqV9C/kHBdJG
         XSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xHl1gRg3tmq11JK7ndcSb6f9Q+/qZDFhMvzZbicORAk=;
        b=rOYWRDmfLSGQ8tQ2Yez5xpKKFenrEBkdvoQE4ng2PuosF73M/QQu+QkB88Kp2dsKQy
         jbdEsFHRLpaHcHo6EVXB/joAGrBI8HMEkwxtLw/Aa6B3IzJUaa0mtv5qmqfIjWUXAG9O
         ssSQMeLVIgNW1Q1TqWkeQ4nuM0OLZHLg7+LeXL5qDzZHdBUW285/O9RFZvSmCdHk6XUZ
         /C0XtiO2gQ9SCdib79hFTkydGm5ilpr9KmJFLW2i4bGknl7Uz95MaJtOfnV4dtJWqw3E
         YPwp/GJsFnUbiw/UEEKAIwLyPrbpwv3tOG4dMTvDKFt0YTf5J8qUBCpeQq7zk0GK4DNy
         Bb3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan@linux.intel.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dwmw2@infradead.org,
	dwmw@amazon.co.uk,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org,
	luto@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 62/77] x86/speculation: Add <asm/msr-index.h> dependency
Date: Wed, 21 Feb 2018 13:49:11 +0100
Message-Id: <20180221124434.818302526@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015329486886101?=
X-GMAIL-MSGID: =?utf-8?q?1593015329486886101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ea00f301285ea2f07393678cd2b6057878320c9d upstream.

Joe Konno reported a compile failure resulting from using an MSR
without inclusion of <asm/msr-index.h>, and while the current code builds
fine (by accident) this needs fixing for future patches.

Reported-by: Joe Konno <joe.konno@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan@linux.intel.com
Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: dwmw2@infradead.org
Cc: dwmw@amazon.co.uk
Cc: gregkh@linuxfoundation.org
Cc: hpa@zytor.com
Cc: jpoimboe@redhat.com
Cc: linux-tip-commits@vger.kernel.org
Cc: luto@kernel.org
Fixes: 20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
Link: http://lkml.kernel.org/r/20180213132819.GJ25201@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
 
