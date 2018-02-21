Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225sakMGyF1RTE8lBb0ABnk7g8uCDrdZroPx0J+OEix/8sEPNR1HdNp8yPId3QXnGH9sjyEE
ARC-Seal: i=1; a=rsa-sha256; t=1519218556; cv=none;
        d=google.com; s=arc-20160816;
        b=XLi+ia2SnI9LqOhP04P+Bv72ZcqosUptMDqBOlJdl8b0tA9FpqRyI6iT07rZ4XImNA
         /TgtZ+BVSb8N5pZ5ePmsEJuwfiRcyACgU/tiAliYtxtw0S1VCdGKrQHZyZnKjktSE7qC
         l9dl15jzCbaVO8xiMyoi7Xw7O4SUMcSGNMFtoFZuIGitPJoo4Vt0O1HfjiolpgDs7FVF
         Zewi3YcNYcicDyBeOd5keU7Q9i+9lTVe9aRfDOcRT0ZoMKbaqdU4EqQEyLES43gG2JHC
         5akwAKssmzB4WjLA1arIfXxuR0QjMx9/7N6mtbufv3xXgIjpRjtGFfEoj8sEZ3NHHAWS
         GyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F2Fi4tfmE1aszUSYBcVXVFy9YL4+MmmkWAcj8AC8Pqc=;
        b=iZSe1Pbl86qHrs+XDnCnwd13YI1Ap1XCWfQpD4Y97+oVqW4q+dFLicZLYXeeunTf4A
         WtUPGeTY3sUvDO3rwo/sbDQEypEIG23lQUAfUp2+L+a3EmiCX/znDHphagXAkxFJ9tec
         Rlj4Ww1QYEuI93MtNMdaheiNQZFhLUVFf0VRzrQI0jlADr9uXgQNxmSyZLk54aJMHyii
         4ovm0jNnMLHLUNXXXKdr4qWcFDNppc9P+PbBScWWQPF2G9cQuH5EtZUnqpBs9Bd+pAoz
         KSK8WdoddDV8XOGSP9InKsIeJ1SjLYI9U9Qc485QCOwzWkSuCDj7ksPYx4pD/8A6clfa
         5+OQ==
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
Subject: [PATCH 4.15 081/163] x86/speculation: Add <asm/msr-index.h> dependency
Date: Wed, 21 Feb 2018 13:48:30 +0100
Message-Id: <20180221124534.909221582@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015329486886101?=
X-GMAIL-MSGID: =?utf-8?q?1593016117397117487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
