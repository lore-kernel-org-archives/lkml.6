Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518069080; cv=none;
        d=google.com; s=arc-20160816;
        b=Bit1OZ2dAfntrrOWRnV41IXP4mZAAgld+Phqj9v5KcMbGhHqCBoCNs+fNPiKPcRGe0
         viQdDUok65u3lI1A0jbHGVP/k4u8dchiJaQuh5Na6VtT7GTw2uHJnD1duooHQdi2y82X
         NlGln9PAYR2V/63m0CGvWS4aB81W2jgTFgubw/RnlXQz7aJgiKVvYNNxKS4FfVSODzew
         tOV2tnj8BWql5MMdOVp5TIlrszMp8rH8k0dWrBpYp6rFvSkbma8IUFl+q5aGGPON7C+y
         2EI4wWDi75mQux1mY8qGwMzusZz1MfKpwNGihK7PY/Z7zFDj72qrN4vDMrg/Q8FXwI9E
         P7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=wIt6kyFnAckOMA0oTtoea/6OIgG7OylPKyDa4AgqUO4=;
        b=y7uJ+1jmk/it43p4cKDiUu21wQKRor2qfa9Ff9OdVV/RxXugLDONuia0G41jjEM/iZ
         j04SbEtFw5aINQQHiy9RyH0GKZAed0HU1FwW8b/4CeZwl67Y8j9NTk1PCEBwO4ftuBzp
         NR1OZM81gk4ioO0w95qBsai7sntMx9sM86MR1dsqRCZQe7K/XGSIzg8IcxWdlaYmk//S
         hniMlRVo8241VT9eCAXNdBccp1lzaHyewqyaJEWPadq27L0s62iVqXK16W/vKkHmHxqH
         PPFVPLBfrL4zDBlFrrqpDUdFfUCGlcCxyxjpIgeX6gi0L9N/abUE48BePi2vP+i2jyPY
         TCMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Sbau/OCb;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Sbau/OCb;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224LKDP6oX778nMmISaH6cne0Q7aJdDzca7nxigjF/jHHleg/Z+X039Mj7Z0j88GNvUtk2xGtg==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	=?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dmitry Safonov <dima@arista.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/x86: Remove 5lvl test from Makefile
Date: Wed,  7 Feb 2018 23:50:28 -0600
Message-Id: <1518069029-22457-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591810804203183380?=
X-GMAIL-MSGID: =?utf-8?q?1591810804203183380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 5lvl.c test file was incorporated into another one in
selftests/vm (va_128TBswitch.c) in commit 235266b8.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 10ca46d..ce2615a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_sysc
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip 5lvl
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
 
 TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
-- 
2.7.4
