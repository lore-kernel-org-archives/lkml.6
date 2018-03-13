Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsughJqXJdvjmPthVfcrZtd7d9NYHtVRfFJD7w5a1e7hE1xylkAUQus9xoyhIVlN1qTIgzQ
ARC-Seal: i=1; a=rsa-sha256; t=1520955091; cv=none;
        d=google.com; s=arc-20160816;
        b=kWAS2lLZiT3YcgKgTLcbyiIJ5MvUqG+r8183tA7tY3FfOrO0xMtKv4UYHcBnLYF246
         Zc2HXBl+JsO+JfUt1EwfYe7p0zLvqEu8VOnedeqjgKcZMPSoMv7D96PbLrta6hij0goF
         i31wiWexUgebA32ioCdymYZf9FCDLWx7y3xjlt9ZScPz8BfUp+PnFGQfj7gWiu1DMfBR
         I/HYGO8j9ptvR9wbJUjFnnRR5TKzejhWM3Xs7uMmYMeiCDAeElDtmNdBm0+K2IYX0oSU
         CmcrFKorrkWsFvZfkYQa55q6LmrVhA6xU7fB+OgEUdKBVHHKTLointbICj0rbXbVRprV
         mFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gOiYXRoU0XC3Dg/2+v/wvDG4oSVxRZzcZOpmfiafgaQ=;
        b=QVLkhNwchPDDKf+Rwf2fFHFU1s6PudhIeYunukOPw60MjfN9CwA8euHuppyz0A9KH6
         ltQklBomhOW7CuoD5Zd0BLBihE/RCl6KGcE7JWv0N6/Bg9gUqzVa0NRmUSvYtZM/g8aE
         za1Gagkh4xARdPWxCKAPyxobFAuBwZq31liuqZyqr+iAKsa/EI8xLCEwG+s54Y0yP+5b
         imjX9l1gdd4kp9Bp00pq9OeH3JDj2MGWRConXwLqKJ4TdwLTUuKb6YeENwi9Ne0lEi1N
         GUY4IyqQEmjC6e75UDLTdgWTzDA6NvArcVzSZIrSLjvg19OD7TbaWVol3tdbld9HZ2Va
         OAmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 086/146] x86/IO-APIC: Avoid warning in 32-bit builds
Date: Tue, 13 Mar 2018 16:24:13 +0100
Message-Id: <20180313152327.419691915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837006153068827?=
X-GMAIL-MSGID: =?utf-8?q?1594837006153068827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 6262b6e78ce5ba62be47774ca80f5b0a6f0eb428 upstream.

Constants wider than 32 bits should be tagged with ULL.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF23F02000078001A91E5@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1603,7 +1603,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000UL / HZ &&
+	} while ((now - start) < 40000000000ULL / HZ &&
 		time_before_eq(jiffies, end));
 }
 
