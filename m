Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226pOnlqO6P0ZlF6Z9v5DPLqLfvlvK2wUMfLHAc1mkr/pifq9c15vvKow7bexHtxfwzBNz6S
ARC-Seal: i=1; a=rsa-sha256; t=1517866538; cv=none;
        d=google.com; s=arc-20160816;
        b=DVH2PzfqQBdnX39P1/8e8mp2Rm4csqT/HAo1MCP8xIWtgtAWtAunlHDc7Yzct/0oVm
         KGKz4zUhx+fGnYnHG9LcnHB5cdjBRiX3xt1cxTylE5ZXcgEl7r9NGQGJ9bxgcgrSoFXS
         MrwyyzddgpQ/ykPR2h//UHrcS46Xu+9adHesrFkEOoz6pFbuyMqTEdDgYm62kBTBxn1l
         ZEWjsZDqO6sgdmRI6UYTYvzHxaqLjjHiIlPfb84rZx9iC/TV+vuhiXQoJ4FTI2I4erTR
         1jIZEoc448YhVQ/A5uINwMQoPDTKOLiCJToRn3HoNYcbLIw2aNVSAmTeZMq+TE+rN3kC
         NfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=GtlyaJ6EUpsxS+vumO39CD1PY/O45OxEwbtp9owLejc=;
        b=h55wM9U4mV1hxBIHmwswtaBTxIEWt6sVIsaeaLNFqlDJ7EWS9FIPCINlyIrW1i3lH7
         E78ZxKLei2HSmfsO9iZZng+WroT62wOV8QjQgPPakVpW/bGWtVrxEPzIcYdjVMO97Jkp
         UoiU7xUCah4MOrmEXW5STQsgBy2PPCq+cPYnA3x52HkyTt6F6GHhbXAr2MRNwcPFnLNI
         TibF3BONyWXdJiUugGLZTPB9BTfMJ00maDqAmxKSNveQ5/wMx9BHPsYLwe7YzJmEag7e
         ldyBlhqg0TmjNWjTNZXzbHTdDUfvPcAoRbOcEIgQENtLxZbQNk6Wp/irvW0bEPWIyfdP
         OB2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 5 Feb 2018 13:25:48 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-667ca1ec7c9eb7ac3b80590b6597151b4c2a750b@git.kernel.org>
Cc: ghackmann@google.com, mpe@ellerman.id.au, hpa@zytor.com, mingo@kernel.org,
        paulus@samba.org, parri.andrea@gmail.com, ahh@google.com,
        will.deacon@arm.com, maged.michael@gmail.com, luto@kernel.org,
        avi@scylladb.com, sehr@google.com, boqun.feng@gmail.com,
        peterz@infradead.org, linux@armlinux.org.uk, davejwatson@fb.com,
        alice.ferrazzi@gmail.com, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        stern@rowland.harvard.edu, paul.elder@pitt.edu,
        benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        shuahkh@osg.samsung.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de
Reply-To: mathieu.desnoyers@efficios.com, alice.ferrazzi@gmail.com,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org, paul.elder@pitt.edu,
        benh@kernel.crashing.org, gregkh@linuxfoundation.org,
        shuahkh@osg.samsung.com, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, avi@scylladb.com, sehr@google.com,
        boqun.feng@gmail.com, peterz@infradead.org, linux@armlinux.org.uk,
        davejwatson@fb.com, hpa@zytor.com, mingo@kernel.org, paulus@samba.org,
        parri.andrea@gmail.com, ahh@google.com, will.deacon@arm.com,
        maged.michael@gmail.com, luto@kernel.org, ghackmann@google.com,
        mpe@ellerman.id.au
In-Reply-To: <20180129202020.8515-2-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-2-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier/selftest: Test private expedited
 command
Git-Commit-ID: 667ca1ec7c9eb7ac3b80590b6597151b4c2a750b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591598422993599737?=
X-GMAIL-MSGID: =?utf-8?q?1591598422993599737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  667ca1ec7c9eb7ac3b80590b6597151b4c2a750b
Gitweb:     https://git.kernel.org/tip/667ca1ec7c9eb7ac3b80590b6597151b4c2a750b
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:10 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:33:29 +0100

membarrier/selftest: Test private expedited command

Test the new MEMBARRIER_CMD_PRIVATE_EXPEDITED and
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED commands.

Add checks expecting specific error values on system calls expected to
fail.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Link: http://lkml.kernel.org/r/20180129202020.8515-2-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../testing/selftests/membarrier/membarrier_test.c | 111 ++++++++++++++++++---
 1 file changed, 95 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 9e674d9..e6ee73d 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -16,49 +16,119 @@ static int sys_membarrier(int cmd, int flags)
 static int test_membarrier_cmd_fail(void)
 {
 	int cmd = -1, flags = 0;
+	const char *test_name = "sys membarrier invalid command";
 
 	if (sys_membarrier(cmd, flags) != -1) {
 		ksft_exit_fail_msg(
-			"sys membarrier invalid command test: command = %d, flags = %d. Should fail, but passed\n",
-			cmd, flags);
+			"%s test: command = %d, flags = %d. Should fail, but passed\n",
+			test_name, cmd, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier invalid command test: command = %d, flags = %d. Failed as expected\n",
-		cmd, flags);
+		"%s test: command = %d, flags = %d, errno = %d. Failed as expected\n",
+		test_name, cmd, flags, errno);
 	return 0;
 }
 
 static int test_membarrier_flags_fail(void)
 {
 	int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid flags";
 
 	if (sys_membarrier(cmd, flags) != -1) {
 		ksft_exit_fail_msg(
-			"sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags = %d. Should fail, but passed\n",
-			flags);
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags = %d. Failed as expected\n",
-		flags);
+		"%s test: flags = %d, errno = %d. Failed as expected\n",
+		test_name, flags, errno);
 	return 0;
 }
 
-static int test_membarrier_success(void)
+static int test_membarrier_shared_success(void)
 {
 	int cmd = MEMBARRIER_CMD_SHARED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED\n";
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n", test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EPERM) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EPERM, strerror(EPERM),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d, errno = %d\n",
+		test_name, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_register_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
 
 	if (sys_membarrier(cmd, flags) != 0) {
 		ksft_exit_fail_msg(
-			"sys membarrier MEMBARRIER_CMD_SHARED test: flags = %d\n",
-			flags);
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier MEMBARRIER_CMD_SHARED test: flags = %d\n",
-		flags);
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED";
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
 	return 0;
 }
 
@@ -72,7 +142,16 @@ static int test_membarrier(void)
 	status = test_membarrier_flags_fail();
 	if (status)
 		return status;
-	status = test_membarrier_success();
+	status = test_membarrier_shared_success();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_fail();
+	if (status)
+		return status;
+	status = test_membarrier_register_private_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_success();
 	if (status)
 		return status;
 	return 0;
@@ -108,5 +187,5 @@ int main(int argc, char **argv)
 	test_membarrier_query();
 	test_membarrier();
 
-	ksft_exit_pass();
+	return ksft_exit_pass();
 }
