Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqnMv5XGr09DiCTnC0bv9ONCxhNKpv0jKHGq8nD9ezsUbiIiYUb2QMjFdmiduYQaEL3R2QQ
ARC-Seal: i=1; a=rsa-sha256; t=1524837762; cv=none;
        d=google.com; s=arc-20160816;
        b=mGGiM9ILbuzt7t/nzkm24bd0CZag+aHEf40CmDkdWJkqYYpmXUsIpJEqocwte4mzPI
         MOKZ9JnF/IHprxFlWv6E/L0Yl1Lwf0dMefDaqVRFqUtlqd/ImR5dppJlqroq27rr9MFB
         N/u4AvpUcYMmsjGTu53TM7jShH7JTcAJVBylN1OZrUHLUkvfyQlAAvBGXaswTJuHKprb
         IqIkSBLM2tc+1DxCtJt+0KrGL65UOWem4ER84ziDZBr0muvQ5+h1cmjc8/7ga5IoctAF
         RFP32yFYcgd+9hRJfYZrsDf/J/qJYLcHIm2b7kj6Z69Kud7QBUs1uQwyP3lVRAx2jCfK
         HTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/AfiMOt+whUgi2bZZTMJ7E7o6iV6kZ8sIJVgn29DnE4=;
        b=BfvaM6Ix3wBE/3/KSkJopub6mKHREUIo2t21iCxr7+foQPT4MLDo6iulyXnoa7Raks
         dfwMOLNbtOmyWA9zVh09Xh3QKacFd//2RgjkQB+vUZLROga06OO6MFQZn0BLEvzoFlfZ
         K6FhEVUG3NCvQrV6RLcfJhfqVQ8DadWYE1r9pVRRyr6Tu8TPijjLZI+ZNoTcbPzyxiDp
         F06Vvtf5TXbBgBveOMnc8o4yIjsrbDR2ofcwSXrhoApKgpCbaCQdimjgTaAQbEVJhL5F
         I9jbBj0A0Ic1hv9oKavDdg3Z1B9fKYBH8Rglo2wC/Vmx5JHRLviy8j4EIH1ejr1fWL1U
         AqBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979CC21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ziqian SUN <zsun@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 50/50] s390/uprobes: implement arch_uretprobe_is_alive()
Date: Fri, 27 Apr 2018 15:58:52 +0200
Message-Id: <20180427135658.618854562@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908281426362601?=
X-GMAIL-MSGID: =?utf-8?q?1598908281426362601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
