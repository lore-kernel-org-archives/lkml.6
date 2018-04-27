Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6gRUnXvY72tm5eWoh394BhS98YgX3KMcus5LFuBJskpQ7uMAZ6QnGU1qLibVj3bFn3fH3
ARC-Seal: i=1; a=rsa-sha256; t=1524837936; cv=none;
        d=google.com; s=arc-20160816;
        b=AV4pW1F9Tcyct01ivdUJelTwO15Hwa19QmMJnbpYl3q9rIYMGv/+3YYvmCOIRwr+Ck
         mG5Ev/+c78ZfCL9Znu0XeF0PyBkh+4OZdKxSUZAncan9Ha929KVFlxvYW0/N4yKD36fK
         MkwHxnisSlIZGUHgd7BjBQcRoXKNPWB/yuW2rpOM+iWyLGbAZSmiZCwtIFCFY1BBN8V1
         YHfNflSQT3DA+3Mr4u78KhsGKK6kvi+bY4IUi4MsXqdUSyCdOTH487Z/tnA/d3sv13F5
         Nselna3sgVyUIhuroQ+lC0y8Qle1OLdhVwVt2Th9PIq1diJUlnl31sCuO6TChxLe+yzW
         sm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/OzJop9wY36B/cL5gxNmQSqpV0PFRq3jp0du8QVUawY=;
        b=uB8twVDe7Cljuo3dq85nyp2RxXZ8NcGRk/8YocbLUJPVfYb9owvDsxX76qorKCh/tG
         mHKCKH9aEqLfL3lWT/HqwJZY1S9zZx9Xg0gz8ObX4W63aQGb4sjHFpt4gCiy3AtWC2Ai
         qcAah62yspl6m8hcA6T/k5l3BOfm4vp7N5H3J5XF8sxLAqneewzlEWnI6T3mAAgm0we3
         35iNrYZugJtX3cJgjdIjyBgANy39hIUSCPG+atf7v5Y4nWxTGY9bawJZKJ1bX09j0oku
         pkPa8SwHehNVuzG+6gF2+McsZRSGW+o+2ioLuPIvfdxcSuBYA2K9gS8BbUibn/tTznsJ
         Y6Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A2A21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ziqian SUN <zsun@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 73/74] s390/uprobes: implement arch_uretprobe_is_alive()
Date: Fri, 27 Apr 2018 15:59:03 +0200
Message-Id: <20180427135712.969357908@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908281426362601?=
X-GMAIL-MSGID: =?utf-8?q?1598908463841347553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 783c3b53b9506db3e05daacfe34e0287eebb09d8 upstream.

Implement s390 specific arch_uretprobe_is_alive() to avoid SIGSEGVs
observed with uretprobes in combination with setjmp/longjmp.

See commit 2dea1d9c38e4 ("powerpc/uprobes: Implement
arch_uretprobe_is_alive()") for more details.

With this implemented all test cases referenced in the above commit
pass.

Reported-by: Ziqian SUN <zsun@redhat.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/uprobes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -147,6 +147,15 @@ unsigned long arch_uretprobe_hijack_retu
 	return orig;
 }
 
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+			     struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return user_stack_pointer(regs) <= ret->stack;
+	else
+		return user_stack_pointer(regs) < ret->stack;
+}
+
 /* Instruction Emulation */
 
 static void adjust_psw_addr(psw_t *psw, unsigned long len)
