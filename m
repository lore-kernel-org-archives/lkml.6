Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227UxgvPpIeRhiJZuO8oVGKeeC8qKF3NG7o+TpuWuXTffAFpozIS0SbFLirEttqfHduN4met
ARC-Seal: i=1; a=rsa-sha256; t=1519217799; cv=none;
        d=google.com; s=arc-20160816;
        b=VTiPHZTSp4PsT0BcW8CFJlM3hlypgnHHL6YZdOgrfEEew1NKgXiYEVewFZqwsA5wmr
         n+A5QlwuFn8j9pudXCm7Mmb6XXl1BOP2s4CWL3wgvLjM7sLTXPlsQ6LRg4/P6RwrOlfT
         uL8hCIc08JvsOx4lF94lzWCq9UI+NfEZz4yo1kKrNz1Hh/uy3wZAQ7L/sS2fXVu/mnRH
         mN32bQ3+HRr6fiheEln7Hr3zegh304c3YFSZ8WASfXCKjGOTmWyO07TIGxpu7vWOvnhI
         sUJ8k49hvCGakJBCwaqNHee79qoZfGhgK1BnJg9Dy+SSD1x2VKplk7DoT+zQV/E6dlKE
         +YeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jW0c0fpBLDpDsmq8oT5HrKiMSCo/ECGuEc+xRommPXU=;
        b=k9wW31d7NV2M3F6CWVE/msVnizOdRZFfSP1vWx41mTWTlWuqUfJdi3KI3YwJmFf4FO
         ZaCXLWPP9m7JrauCZypoKHSmhhT68H3F7nBb/JjxYW+UFcPOK7yk9ApKM5260iYveYdq
         3yjCtsyxqZ0Q112CAN9hhYGVRAjisEXisAugGM6lE3ZKu8lJERGZgvuZvKCZqEa1EOBv
         u+HUZOUzGxfrjrnWOZ1+S4jnDnzXI7DC6NVW0B4G8i6Uw2swgwv+aCPO8YNXDWvnYrGq
         eQlrPPmwPLUH8enBemtgA/ogMmL1odiSRmiImL1sRsmukPcjW2HXCUiBkuqNcDe5TXV1
         7plw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 58/77] selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
Date: Wed, 21 Feb 2018 13:49:07 +0100
Message-Id: <20180221124434.659368600@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015323232886251?=
X-GMAIL-MSGID: =?utf-8?q?1593015323232886251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 2cbc0d66de0480449c75636f55697c7ff3af61fc upstream.

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled).

Without this patch, the move test may succeed, but the "int $0x80" causes
a segfault, resulting in a false negative output of this self-test.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/test_mremap_vdso.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **e
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
