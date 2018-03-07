Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8DZB50yoIltsx7dNLQ6ftTwPeZ+mOjDJfVEGlhhj4MLo+R+tNKZinD16k1I23wosmhfaB
ARC-Seal: i=1; a=rsa-sha256; t=1520452084; cv=none;
        d=google.com; s=arc-20160816;
        b=gLf3s6aGQjSwaPDEsBES+THcZN06dWWLZe+RUmlTlGPI3esB0ZZ6CWEcPzSORJaXui
         m25Lak8nT5zIAisMOkxR0e+/As9QmsS2Eq9G4GABpqYuMqahoF0aoGxV3YUz3u9a61wt
         cWAizlzSA1EcCeGKs6HzqM87Bx47PHUH1lPrywuB2VtbWA5L17sI40t7t/XZkguU7tBo
         C/b2naZ+KnGLoIbB1vAEYpb3mTdz4KV9uHh6RjIBV8G+mGaN6XY99qNOpgHG101NzTQ/
         1cXLRW17O1vQhz8R84ltOHLup5aCNaMfQskelAVx3Cet5KBzs58C0/V7LZWLmzmaem3w
         I72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZGLQE+bnaJbVhmmDQFlQEpenVg4tM9Z10/ZeUdsBZZg=;
        b=yvdOn7P7dIg8fM67VjXd2O479TVe9AwjQPfz0Gf4XSq8eaQkd4hJHmLw9rC7z8HljZ
         qEV0Hd3XiYAaU9b6h8jUIJiE5hNPu2kp+S7LAMzsjTe3GDjcIgBf5+8MR0f5xQ+NQDO3
         tUT8Y+3pSbHR7K0KWtSR5y3f3WYbIg3H9yA1wC/oZ6NomnwmV30hYJCmVvmXAV4DzTdJ
         P7GgpMeFvC+4F6lAELRCX58So4O3iViGpUIMoeRri/mVC4LlO1xMKQtWs2KFHyDHWcmJ
         H+GbtY1w1FPy1bgwAueBNb5ujaCP9ZgrmnfyCqIt0ePNCxSMkfqtXV7LudGHGzxT733e
         Eyag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 104/110] KVM/x86: Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()
Date: Wed,  7 Mar 2018 11:39:27 -0800
Message-Id: <20180307191053.275076210@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309565155508930?=
X-GMAIL-MSGID: =?utf-8?q?1594309565155508930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tianyu Lan <lantianyu1986@gmail.com>

commit 37b95951c58fdf08dc10afa9d02066ed9f176fb5 upstream.

kvm_valid_sregs() should use X86_CR0_PG and X86_CR4_PAE to check bit
status rather than X86_CR0_PG_BIT and X86_CR4_PAE_BIT. This patch is
to fix it.

Fixes: f29810335965a(KVM/x86: Check input paging mode when cs.l is set)
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7482,13 +7482,13 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
 int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG_BIT)) {
+	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
 		 * When EFER.LME and CR0.PG are set, the processor is in
 		 * 64-bit mode (though maybe in a 32-bit code segment).
 		 * CR4.PAE and EFER.LMA must be set.
 		 */
-		if (!(sregs->cr4 & X86_CR4_PAE_BIT)
+		if (!(sregs->cr4 & X86_CR4_PAE)
 		    || !(sregs->efer & EFER_LMA))
 			return -EINVAL;
 	} else {
