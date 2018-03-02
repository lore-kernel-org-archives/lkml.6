Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujsBxAXbTexZFmdn35cAgZptMgC2sOxUsNn2Zfho4XZRv2z8omYcnzKNaQJom1Jod88xGl
ARC-Seal: i=1; a=rsa-sha256; t=1519981435; cv=none;
        d=google.com; s=arc-20160816;
        b=nQCcthTGzirqiJKzgl4wmZUM9woaKTORixwdXIPOWTEeduE9JvfH10yUIuw1q4Y3Nc
         TNtvvnapq7ai4/Rx/Isnay6/NV2h4/ZMcAr9NnuroNRd+RSRt10qH1ljDNrdouw6TWPQ
         p5J4Zl0GL8Nam1I8ITpu/tkRPWfJxb//XnZWZ9Ya8Q3TphJy0YuSEMpNdM3kfq72dEOM
         4BRIrv0q1dk1AzM2oqx1YGFbUzlnnq/EBpLPTiUbawjd+vOCIC2QW99aQg9mkPgeabeE
         K6ISNDknZEU1DUMDZn+ZZc7zIimy1F39Zydi0bjSOh/HihObqX9ZgDL7gi89ZBw8Q/EF
         lNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4LFQSXEb2UUWr02nr/TLsy3IFGu66IPBuVHR9Ap2O+8=;
        b=gD3Bw7snwIYsfY1axM0llJ892/dHfMvuDCEjnI92uc6cF4M/xXa8L8Z8t/CoI7LCoK
         L60SFImlABtRBpjMRDtJWmfpvP4a/ubt6XUMYDIj1gwe8FN6cbWI0+nc6Yhbv3rVEMJf
         0iBCM5ATxdxsDZlnxR9pZLFi9AjjpsTj7ijTtXqTkvTKk95A9mqId0eeYQif4Syzd/js
         gqd7zHh2ED97HQwULD7y6slp8U33wvA1iP2oOzosBoiJqvkzYbBcs4poiDYrfGiHJB9i
         v9mNEKugw087HPi99E+5TSSgLpM6bNwMa0kK2lWzLKYZQ3fc7a8btF9SC+BWA2jGYmeW
         obcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Valentin Ilie <valentin.ilie@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	fenghua.yu@intel.com,
	linux-ia64@vger.kernel.org,
	tony.luck@intel.com,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 089/115] ia64, sched/cputime: Fix build error if CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
Date: Fri,  2 Mar 2018 09:51:32 +0100
Message-Id: <20180302084507.455791996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816054354807627?=
X-GMAIL-MSGID: =?utf-8?q?1593816054354807627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valentin Ilie <valentin.ilie@gmail.com>


[ Upstream commit 7729bebc619307a0233c86f8585a4bf3eadc7ce4 ]

Remove the extra parenthesis.

This bug was introduced by:

  e2339a4caa5e: ("ia64: Convert vtime to use nsec units directly")

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org
Cc: tony.luck@intel.com
Link: http://lkml.kernel.org/r/1515193979-24873-1-git-send-email-valentin.ilie@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -88,7 +88,7 @@ void vtime_flush(struct task_struct *tsk
 	}
 
 	if (ti->softirq_time) {
-		delta = cycle_to_nsec(ti->softirq_time));
+		delta = cycle_to_nsec(ti->softirq_time);
 		account_system_index_time(tsk, delta, CPUTIME_SOFTIRQ);
 	}
 
