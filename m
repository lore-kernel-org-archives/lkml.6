Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227Atc+LzDzGp81HLI0r4zzYTs9KxSB2Not0laiWGLJAm/ZwtxeZtndPhgxCacDo1/IC+W6R
ARC-Seal: i=1; a=rsa-sha256; t=1517866583; cv=none;
        d=google.com; s=arc-20160816;
        b=Ud01jy+4fpvjUTgGbHBn22xczWkqUxcThIYZbFo3gCszIsSMxgmuYfilQrjeQ/RKzl
         HitiTZYdLfAx9AGMDIAZsOF1r7Mhf9iWYrCpfyX9EbHSiWSf2PFHl4kz8rio2piBwkdP
         r+cJNfUbr7PJqePBVLjm/AvZT18+eMErSKC+49CdawBSFTDxk3Wu8rJvpR1cLkZ59Xoi
         onYEhveapOwqJW+kqGqJwnT7QXK+s/4yH8u2EOZpib9pGGXCWh0q16eOzn2QZvq2dJdy
         liv0KYPW04bEcQDA0oe3qbcp/VAuFwapv7iYBdgFsEihuobMlAUEuCgm8QYCmpZfW3WE
         t0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=CaVnhevVSGf4X/7J0h9RZV+BKPK7jCEgBwcYMLh9clU=;
        b=qOzMtGF/vkin1eRgF2GT3Wgcy+msJz6XC48EXn9AfU9yWH9wqK/bObh++lR0Fxzb4k
         JV377JG0/psw4nqL6fn2N8P4kcO11DACnJH/pBnbtDqu+xshgdYr7ZJs8ofPHwPBmFXm
         QSw+TxsSY0RkP59kk9x3nRY1wp9dY8WMJBIhhi31AYB9m6VT8gATJ84FM6GlnXveQBvr
         wXfJ3I4xu2iEtXw7zIP313ORdmMEgp8jnZUmgorzzDUEYMPv/m2UEIgwdsCyql5/C1KJ
         d0VTheNyxxur8f73TAUykTq25ZlSVNDjboT+/kCX2UG/wht+O+T/+IFTaDKiHwtjB5rE
         LPcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 5 Feb 2018 13:27:44 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-92485487ba834f6665ec13dfb2c69e80cd0c7c37@git.kernel.org>
Cc: tglx@linutronix.de, paul.elder@pitt.edu, avi@scylladb.com,
        linux@armlinux.org.uk, stern@rowland.harvard.edu,
        shuahkh@osg.samsung.com, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, torvalds@linux-foundation.org, luto@kernel.org,
        parri.andrea@gmail.com, mingo@kernel.org, alice.ferrazzi@gmail.com,
        sehr@google.com, paulmck@linux.vnet.ibm.com, paulus@samba.org,
        maged.michael@gmail.com, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, ahh@google.com, hpa@zytor.com,
        ghackmann@google.com, peterz@infradead.org, will.deacon@arm.com,
        davejwatson@fb.com
Reply-To: parri.andrea@gmail.com, torvalds@linux-foundation.org,
        luto@kernel.org, sehr@google.com, alice.ferrazzi@gmail.com,
        mingo@kernel.org, avi@scylladb.com, tglx@linutronix.de,
        paul.elder@pitt.edu, linux@armlinux.org.uk, stern@rowland.harvard.edu,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        shuahkh@osg.samsung.com, hpa@zytor.com, ahh@google.com,
        benh@kernel.crashing.org, ghackmann@google.com, davejwatson@fb.com,
        will.deacon@arm.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        maged.michael@gmail.com, paulus@samba.org, gregkh@linuxfoundation.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com
In-Reply-To: <20180129202020.8515-6-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-6-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier/selftest: Test global expedited
 command
Git-Commit-ID: 92485487ba834f6665ec13dfb2c69e80cd0c7c37
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591598470460819447?=
X-GMAIL-MSGID: =?utf-8?q?1591598470460819447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  92485487ba834f6665ec13dfb2c69e80cd0c7c37
Gitweb:     https://git.kernel.org/tip/92485487ba834f6665ec13dfb2c69e80cd0c7c37
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:14 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:34:40 +0100

membarrier/selftest: Test global expedited command

Test the new MEMBARRIER_CMD_GLOBAL_EXPEDITED and
MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED commands.

Adapt to the MEMBARRIER_CMD_SHARED -> MEMBARRIER_CMD_GLOBAL rename.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Elder <paul.elder@pitt.edu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Link: http://lkml.kernel.org/r/20180129202020.8515-6-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../testing/selftests/membarrier/membarrier_test.c | 59 ++++++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index e6ee73d..eec39a0 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -59,10 +59,10 @@ static int test_membarrier_flags_fail(void)
 	return 0;
 }
 
-static int test_membarrier_shared_success(void)
+static int test_membarrier_global_success(void)
 {
-	int cmd = MEMBARRIER_CMD_SHARED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED";
+	int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL";
 
 	if (sys_membarrier(cmd, flags) != 0) {
 		ksft_exit_fail_msg(
@@ -132,6 +132,40 @@ static int test_membarrier_private_expedited_success(void)
 	return 0;
 }
 
+static int test_membarrier_register_global_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_global_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
 static int test_membarrier(void)
 {
 	int status;
@@ -142,7 +176,7 @@ static int test_membarrier(void)
 	status = test_membarrier_flags_fail();
 	if (status)
 		return status;
-	status = test_membarrier_shared_success();
+	status = test_membarrier_global_success();
 	if (status)
 		return status;
 	status = test_membarrier_private_expedited_fail();
@@ -154,6 +188,19 @@ static int test_membarrier(void)
 	status = test_membarrier_private_expedited_success();
 	if (status)
 		return status;
+	/*
+	 * It is valid to send a global membarrier from a non-registered
+	 * process.
+	 */
+	status = test_membarrier_global_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_register_global_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_global_expedited_success();
+	if (status)
+		return status;
 	return 0;
 }
 
@@ -173,8 +220,10 @@ static int test_membarrier_query(void)
 		}
 		ksft_exit_fail_msg("sys_membarrier() failed\n");
 	}
-	if (!(ret & MEMBARRIER_CMD_SHARED))
+	if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
+		ksft_test_result_fail("sys_membarrier() CMD_GLOBAL query failed\n");
 		ksft_exit_fail_msg("sys_membarrier is not supported.\n");
+	}
 
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
