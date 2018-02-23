Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucISTbFtE1XNiVjsqMzY+oya+1gI3o/9nGvvIdeiNhQxRZK58VtDHZL1MYAsT5fB/7DiJ4
ARC-Seal: i=1; a=rsa-sha256; t=1519411742; cv=none;
        d=google.com; s=arc-20160816;
        b=s0XXY4S9VkcLjp+K5IduiV+SbDUPxOAxSFDfpQ+2Xp4e2LG5RNzkp6zuVw1NcR/lm0
         piPow5vxNZ22LMZwZNPpfE5WcNb0ngz39OGg9b+eFIzlv4iLoZXmBYL8QX1h+gXRXev8
         /XSrxHCdvjPCeHwVJl37P54D+tTdsQPKE+jHM837i9yYB2tvKsKT76ijzUzzT7xqLMv2
         KKQpHtxz81lySQMGBHBZSdqAUcSyKDVNaxbB7cIMcFcSIRf+4Gr5pWEzLTAdtyB8MxfC
         p8DYvoMniS/1WZXqNaQ0bTZIaLBL7nn2Fm4DEbbij4eBzsydNeLuRsOrdkP98/qlnvpG
         TGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gz+1GRVhlxnOQnPLd/Z8/UBdi1sVEaEUsoPtaG3Yne8=;
        b=QRu8w4Exx2XTfRoIJHo0sBiuylbIEzPxlctfb+BbG2u4klDqf7BGvZUBZV1ZG0JwN4
         v4Y4rHy7Md+poKBmA54mGpbMKbzuKqSy+Z1qLWHmLx0gu/rZuN8sT/mgCCO35af3Ok6h
         tMXdSX6u68P4mmYttH1LazXpicTJLj7WMFB/CQy2yuTvpLGM0aMBhAe8CgwqqC0so/15
         BPA57ZHbqgY7kFFg01wAFgA/Z5oMLWpHZyVjyVARGn+rSh9OCL3ESqgAl6Ur9xNjx4Im
         VIu6M1yFV+VWQNDDAGAxMwqvkeVmi4imjAiFSAA/2+56VnR4PTYuqlB8drWbWNrMuxg9
         F4tA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.9 125/145] KVM: add X86_LOCAL_APIC dependency
Date: Fri, 23 Feb 2018 19:27:11 +0100
Message-Id: <20180223170740.969473222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218049468964929?=
X-GMAIL-MSGID: =?utf-8?q?1593218687948120505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e42eef4ba38806b18c4a74f0c276fb2e0b548173 upstream.

The rework of the posted interrupt handling broke building without
support for the local APIC:

ERROR: "boot_cpu_physical_apicid" [arch/x86/kvm/kvm-intel.ko] undefined!

That configuration is probably not particularly useful anyway, so
we can avoid the randconfig failures by adding a Kconfig dependency.

Fixes: 8b306e2f3c41 ("KVM: VMX: avoid double list add with VT-d posted interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	depends on HIGH_RES_TIMERS
 	# for TASKSTATS/TASK_DELAY_ACCT:
 	depends on NET && MULTIUSER
+	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
 	select ANON_INODES
