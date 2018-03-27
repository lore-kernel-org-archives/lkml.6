Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169868; cv=none;
        d=google.com; s=arc-20160816;
        b=H1AH3M5j22Q6MJ7SsrC4NW6Qu2XOcGX9CJ0KQAvzAWZwS55sTjVHkFg8LJtgcORKlv
         uhji9X6B6kObkDgSAWl9aXpVenrQfBUd6YvlqGOAnvQ6TyBIOCsrTD3OgZdR9pMyhtA/
         eYGSOLAGaBfb6deQ0PyfV43iHmHWFhJfCjCLFewVtfRftPjBpOhXjV9W7PQQ2TPA04B8
         B910KMWrNoj6JLK6vq25m42QQHChGZnXnV3XlSdT9zUuQE8A4loS6T6xWVBXHQFpVDWH
         rZ1a2BInW0r17trdPPfakKPRlmkN2iDIlyqWN3E4ekf37BR9/feGoHxznDK6Gwc/penK
         cmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=16zO1fZlfRozQmZA0XwO/F+8TDPyjWmWtXbmZBvVg9M=;
        b=lwu0T2qUIppArVPhTI8Q00RZ/Va7vJEpCXo8hsYnyECLp0BzJF01xyRXEL/3QC/v46
         qiRC6ySyuLws7fIDFUFTE03dVy7MtOQt81P8Y6IzTcVrlvT164x6TykcVal22cm/upAl
         iWI7gSOWqUuUroPwQdIbjpkXXM2irGOuybj7GQaqMkq4G0rCVoMs6kgSIi9omzNRc9Dv
         xPkER7i8WlU4SeMI//drsZyXSl5dt/b6UGSpKmxj3OVlczLRMiaKoeOHVkA4MjimKNmV
         Xy2D33G/+rdZm5wZQAQbRQJBbDT5622tUipL1ow26Hzkc2Eshz9uXLsd6qFNPq3t6wCB
         wGPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TC0a80Yr;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TC0a80Yr;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/+PlMoTXyL3X99J/NO1BvfdIk8E5OZI/edo9QrrTbdJ9nLf1NSk4SSfQkVN/3eIvmvXQf2lg==
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
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [RFC PATCH v2 1/6] arm64: add type casts to untagged_addr macro
Date: Tue, 27 Mar 2018 18:57:37 +0200
Message-Id: <64234f64bde32a3f58466a74445848bb7f8cda83.1522169685.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596110792172731978?=
X-GMAIL-MSGID: =?utf-8?q?1596110792172731978?=
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
2.17.0.rc0.231.g781580f067-goog
