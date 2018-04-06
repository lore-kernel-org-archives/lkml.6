Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492vgvf0d6PlfJB14e3xPaDbrO3yQGt8nsC7cMmFCbfTUFoXGNMf34tp2MXxN3YxZnoGNc7
ARC-Seal: i=1; a=rsa-sha256; t=1523021630; cv=none;
        d=google.com; s=arc-20160816;
        b=bJyC/XKaGhJWiw6n3qab/ax5jQWEXRcmNiAFKdeWuwW0TRvVj0Xe3g+eW6hK/F8Jb/
         tkxTv8WEO3fCAQIbGyzabiPqde7tMrVAIgVQM4w0riCs6JguJ0srdO7/HUC0QdV4xXOO
         XLJjQTcRh8KNWKO+1oEv9MJWQgTAsaohtudaOSOtwxwMqsKIVeXJQxCqXj7Nj3tYxun2
         /6nUqLlE9n9rqV47ZVAOQ1gfm3naX9nqMxtb6pclbOhwWdEzvCMUzs1X/GF4sF1tXCQ+
         gnB5F4pOdAmiMTc6KowrK/bbOighEHBK6btOF4TXw7dQFrBGDaX16YMlOYUJA4pxdAwP
         CPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4r3stDIja+htVwlVY9mCT32KeJnGEU7klHyVyJMFOM4=;
        b=l16nQ+JNs+pcs14zCYRamgBzq7/sYL0s6d/Y+/04i2QCpdPrX4fZOu3DKgneBQ4FfS
         IUWruO1UbH1JMAUD+rpzaY3UNipIRc9HqmSl/mL3+veyqAM/2XB6gy9jRINytLwbdaMl
         Is4TwAtyn1/CHVFLVbbH2cORcSF1vt13MlSmi0/ogxglztUp5/R7TnyWVa215I7GbwNT
         778VpiTx4Ilx6U2idjksA7ju+qUgigk02lYaZkUcDnByLwkRAAGTurJ3UwJDTJXV/1Y7
         4tN7YFEdVLS6uo7A7UaiGY6K5efzxPSw05J5PC5LUBTD+kgsoa1F5oPWIqTyNE6GGRsk
         EiWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 006/102] perf/hwbp: Simplify the perf-hwbp code, fix documentation
Date: Fri,  6 Apr 2018 15:22:47 +0200
Message-Id: <20180406084332.434692680@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003469119697595?=
X-GMAIL-MSGID: =?utf-8?q?1597003928833757216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f upstream.

Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
modification of a breakpoint - simplify it and remove the pointless
local variables.

Also update the stale Docbook while at it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/hw_breakpoint.c |   30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -427,16 +427,9 @@ EXPORT_SYMBOL_GPL(register_user_hw_break
  * modify_user_hw_breakpoint - modify a user-space hardware breakpoint
  * @bp: the breakpoint structure to modify
  * @attr: new breakpoint attributes
- * @triggered: callback to trigger when we hit the breakpoint
- * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	int err = 0;
-
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -451,27 +444,18 @@ int modify_user_hw_breakpoint(struct per
 	bp->attr.bp_addr = attr->bp_addr;
 	bp->attr.bp_type = attr->bp_type;
 	bp->attr.bp_len = attr->bp_len;
+	bp->attr.disabled = 1;
 
-	if (attr->disabled)
-		goto end;
-
-	err = validate_hw_breakpoint(bp);
-	if (!err)
-		perf_event_enable(bp);
+	if (!attr->disabled) {
+		int err = validate_hw_breakpoint(bp);
 
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len = old_len;
-		if (!bp->attr.disabled)
-			perf_event_enable(bp);
+		if (err)
+			return err;
 
-		return err;
+		perf_event_enable(bp);
+		bp->attr.disabled = 0;
 	}
 
-end:
-	bp->attr.disabled = attr->disabled;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
