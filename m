Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Ki2bt6DED+BpiboxnFMleoij5lksMCCWS7ZJYd1CQkiZ8dGyEi2NLHw6YmIKhTC9ss7dN
ARC-Seal: i=1; a=rsa-sha256; t=1519218525; cv=none;
        d=google.com; s=arc-20160816;
        b=JGiySRLgia4fFbldDfR83Cbly8erM/zYl9+HDxECeARYZCBMSGUtObgUJGXn+Fal8Z
         xDUTY0tzWHNkuQ20gKR3Pot7+iOpGzHL1N7ReZFMPCF+qeIQYvAvqulD9yMbiUPSdyj6
         Vn8C9O0ajmyVcLC2O6NNeeOOF54h37HRyH+WlXdkMqRZXXOsY6q+Zq5wAvtSZ4lGjXQf
         sZdey2SChyUKVrahNJNMoUqqadqUyh8RCdkVU3t0ZZfPlMulxD5m92nmMxAz82Iyo9fN
         XHCHkWcS5t55OrjvYVGi74J+S0RzXG7RHxCKy1UsawIMn5jsEDbA1oc9tRPB6NmxbDqM
         AP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5yNl0+fMmcMT8fZ3hf7cH6mQckbbmeNOtvHeAiVhNaM=;
        b=Dfz5jh/BDQhdrEgqgsdwzjYSbS+1Uzqdn+kjqbBotXgCt3AAErM7J3U9ArEbtQPi0N
         S5x7aQXyafklxopJC+RMXr11w2pcNoSOsR48VUXt6M9kvRfFTtOvt22LQ4WBDtAjnZkP
         rbYqRGc0cKDEIfOn45Tebgfy7KnTJJRn/uI/wRqK5KRg6pyeZuiPvnYQlH+v/pxTWc2C
         iDnaZ0X1Ye2HcYjV3Bb9sSkp44xkY37GNmuYtF2UfUb3gNMTQPsKE7Pk7JZJMfL3maEZ
         fqV4i/Afb3FlTX0bLz3S2OiBLGdH3Eo174O2MRrAWjj5fE5/L/iMPHNGy0GqFvl4+i4O
         4X6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 071/163] selftests/x86: Fix build bug caused by the 5lvl test which has been moved to the VM directory
Date: Wed, 21 Feb 2018 13:48:20 +0100
Message-Id: <20180221124534.416192368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016085281418652?=
X-GMAIL-MSGID: =?utf-8?q?1593016085281418652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 7f95122067ab26fb8344b2a9de64ffbd0fea0010 upstream.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Fixes: 235266b8e11c "selftests/vm: move 128TB mmap boundary test to generic directory"
Link: http://lkml.kernel.org/r/20180211111013.16888-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ TARGETS_C_BOTHBITS := single_step_syscal
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip 5lvl
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
 
 TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
