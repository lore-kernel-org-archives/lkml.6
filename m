Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356950; cv=none;
        d=google.com; s=arc-20160816;
        b=IA7Sobz2nfQDqM09UyuRKysQq3hp4+1mcnRoQqpCFOiuKn1IIu3JJ/lg47fiAHcNcx
         WtaCuI9pAF8dRbLvh9xiTeivHpJ2bv5p1cvgd/C9RAc9FGU6a5bUN9wYhejAu9d/dLhS
         EsqDnsZWN5RGHmgL+yZOqutmcVI88MHQs7wxv6w91XulVjoeOSlGLITFNKCbx+n/N6zT
         yrLwmyw8L/vXDXI27DFz2AHwG4tSuBgrJNv98L2Vy8EexLf3eTEZ87yksJpabw1LV3sx
         eZECSRWbg2b0OXAMKQovSmnEkqdnR1YOxpiBEifs13GqFVGqdbPv2lCHdiag26sYoLSq
         Rsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xUzcMaOTF1xTWiYdFgJJTAKZY8fgLS4Wayk3qwMg3og=;
        b=rFc6xrq82YM0QQwILsevMmjvKd3l7VFPLNGs4rH/9aYXnO4gNECHpJEHnDCW+B979+
         pjvl1xwxIinoFuvdccswiMj2NXtGazS8tf4nhanDZ/z1HdUt2ntRPKhghBZmx+tOPRbK
         yv+3IO3JElT2kgA2w3/u3Pt3ol4sg3sTsaQdDxZ2lyU5bTwEnu4WaRXmGzVzPPXinnXG
         X0525M8D6K17as+s1/RHc2TmoataLOUAVVOhWvA4fDsKObxKSfL/fJ/yKbIGhkW9swzi
         rW50pOn/keaYYNxWZwGY7Q8Nw3n+/QEgOl6waRdXpv/i9chvKuSDgp48HFjnVF7x9smn
         Kolw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Gaf2Gpyx;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Gaf2Gpyx;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrm/imnlmPwzpExlXduL2x4spddcr4ddWYXxEzYjIk+xY0vq8dipS9QYyUmHsWZ+eYk+o2xjA==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 1/6] arm64: add type casts to untagged_addr macro
Date: Thu,  3 May 2018 16:15:39 +0200
Message-Id: <54622375c498b1e0037e26074cd2ba500ca7cbd6.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599452689725902604?=
X-GMAIL-MSGID: =?utf-8?q?1599452689725902604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..2d6451cbaa86 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -102,7 +102,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.17.0.441.gb46fe60e1d-goog
