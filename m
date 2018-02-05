Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227zcJDdYGtZCrmIDiE5osyTR3iUIFK58B5IiZTO4CMOZvmoBZcocHfdKNTH+4GXUrjDkefm
ARC-Seal: i=1; a=rsa-sha256; t=1517866750; cv=none;
        d=google.com; s=arc-20160816;
        b=fcgeqHZwssfluC7Pj3IA1O3MzMESLAE0xKQRq+B6XT3/b1b+gsUpQ59OC7h11nVRgR
         iHv8h7y+5YwO+LYo9NPGHr7E5OGkpDfP5YDaE6tPN02srWaH8dScNT0L4Us0ORJRLlfc
         8B/63oKlzdyoTcPEsPnqONpq2T2Y64tfzyJu9tzF/0mT2c0ze3xdT4f1PZk2fo4tN3Ub
         jdOFUDCFy+gBoZ0BS0UaSgqwhkaBS8BPads4WOuAs/pVGU6sK9aDSZ07bDQTqytaUJXu
         Mp8Ruuh/424hn00O5p7PnWmba/nIEfd9xsXIrA7/JA2eKTSKw+4qlgUXiYYknM5LldKn
         W0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=mjDA52wx2offJieY3+O61FRyXHK1gXdDKs4Az/B9oDQ=;
        b=v/sOKJmKELE+OZeuWJE3jFjjBsrMKMs6k/KRCxdThfpniSfjmlXPw1rsWxkVUl05wu
         NXZ43x6/PnJV6aQyHxjNAwHpO+1PhJ4oy4FyDOG0rGUJakqviTCm0/05eO+a6SCYJ7H5
         PBvjVItphRA4RWl2LTWP5kkcaLVjgeorHhs8+aTXltDxkpLKOpTvy3EInIVWwfsfN5pz
         dEKvQhRF2DK2AD9FR9/jyOCqd/i8E51KDeWDO6Q9ASpU+w/AxsjGTzIOh9O/CRtsauOH
         ncRyuKrhfnXWzjECvqL5f5R9jBLhKy0q0l61tTZu4Dco8pxmvAq6bnxEMd9vGDwY16ml
         AP0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 5 Feb 2018 13:30:27 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-460e8c3340a265d1d70fa1ee05c42afd68b2efa0@git.kernel.org>
Cc: alice.ferrazzi@gmail.com, paulmck@linux.vnet.ibm.com, paul.elder@pitt.edu,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, avi@scylladb.com, parri.andrea@gmail.com,
        benh@kernel.crashing.org, mathieu.desnoyers@efficios.com,
        linux@armlinux.org.uk, shuahkh@osg.samsung.com, tglx@linutronix.de,
        boqun.feng@gmail.com, luto@kernel.org, mingo@kernel.org,
        ghackmann@google.com, maged.michael@gmail.com,
        linux-kernel@vger.kernel.org, ahh@google.com, will.deacon@arm.com,
        sehr@google.com, stern@rowland.harvard.edu, paulus@samba.org,
        davejwatson@fb.com, mpe@ellerman.id.au, hpa@zytor.com
Reply-To: mingo@kernel.org, luto@kernel.org, boqun.feng@gmail.com,
        ghackmann@google.com, maged.michael@gmail.com, will.deacon@arm.com,
        ahh@google.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davejwatson@fb.com, stern@rowland.harvard.edu, sehr@google.com,
        mpe@ellerman.id.au, hpa@zytor.com, alice.ferrazzi@gmail.com,
        paulmck@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        paul.elder@pitt.edu, avi@scylladb.com, parri.andrea@gmail.com,
        mathieu.desnoyers@efficios.com, benh@kernel.crashing.org,
        tglx@linutronix.de, shuahkh@osg.samsung.com, linux@armlinux.org.uk
In-Reply-To: <20180129202020.8515-12-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-12-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier/selftest: Test private expedited sync
 core command
Git-Commit-ID: 460e8c3340a265d1d70fa1ee05c42afd68b2efa0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591598645969427640?=
X-GMAIL-MSGID: =?utf-8?q?1591598645969427640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  460e8c3340a265d1d70fa1ee05c42afd68b2efa0
Gitweb:     https://git.kernel.org/tip/460e8c3340a265d1d70fa1ee05c42afd68b2efa0
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:20 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:35:38 +0100

membarrier/selftest: Test private expedited sync core command

Test the new MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE and
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE commands.

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
Link: http://lkml.kernel.org/r/20180129202020.8515-12-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../testing/selftests/membarrier/membarrier_test.c | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index eec39a0..22bffd5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -132,6 +132,63 @@ static int test_membarrier_private_expedited_success(void)
 	return 0;
 }
 
+static int test_membarrier_private_expedited_sync_core_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not registered failure";
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
+static int test_membarrier_register_private_expedited_sync_core_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE";
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
+static int test_membarrier_private_expedited_sync_core_success(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE";
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
 static int test_membarrier_register_global_expedited_success(void)
 {
 	int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
@@ -188,6 +245,22 @@ static int test_membarrier(void)
 	status = test_membarrier_private_expedited_success();
 	if (status)
 		return status;
+	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (status < 0) {
+		ksft_test_result_fail("sys_membarrier() failed\n");
+		return status;
+	}
+	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+		status = test_membarrier_private_expedited_sync_core_fail();
+		if (status)
+			return status;
+		status = test_membarrier_register_private_expedited_sync_core_success();
+		if (status)
+			return status;
+		status = test_membarrier_private_expedited_sync_core_success();
+		if (status)
+			return status;
+	}
 	/*
 	 * It is valid to send a global membarrier from a non-registered
 	 * process.
