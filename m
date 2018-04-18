Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524077600; cv=none;
        d=google.com; s=arc-20160816;
        b=cxt8WqyQAOf+mRSxUbXeVVO7iay6Nt0ppeNYJbzt0Uhw8Ds+aq9nPtGOSlDgVxyGtS
         2yhe1cDlVjoaO62Z+8SI388Amb1LHbYGnxy/LfvBDr4sxRmhVLIRqcAWnndBc1d1R33p
         dkHolwKuNdRZvm9jQ8lEfW23qOdh6A5iiE9tTPJTYzXKn/uvK+0EXRp5fMWTayCXiSI+
         qBS+CG+u0tyHXzuvq8uE96ZfVwIutIACzZ0ODYtyX4i0CM+6FP7iOpUjlrJx0IceG7Ci
         nXkLTw+BUb9kOTTNwi3oJAwGfhDtQfg2khDBiuUpfZfOLJ/YyG6lGoemXrxbOJbMroQS
         y+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=upppdIDGgX4DchLqIIxDa1ACj7PSs1Jc4nEJzkc95m8=;
        b=osECpnxH+48rvBWuYfPbA6ggNnfN7iRvRfPEvK0l6xIluY7kTKu0uJcxE6Shi9CfNQ
         2kOFNKr0w2hlPNesIOXw3zTno0hIAPItZ7jqqMc0Br2J+zdsw/90Lc6hG2lgRYGwY4ex
         oIckFL4RQvm7ur64diYsGhv2F4tgrmEH00+gMk5MqkA+fDYupGkEa9g+sNVcvA5RM/SV
         Yh1o9hi/c874RRKySLXmnkWgMy5Vicqqk9kSOmKl0VQXpnEa7xJzclcIOlbryl5GvNyL
         4NS1RRIyWWNNLq/yu+PbhVwl+xOYZZzvDktf/H2VsUxObsnbEu/gmqEFLbArzmLfkVyP
         05xA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YcvbuTuH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YcvbuTuH;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+mCNu3FKyFByPV3u1yjEnA8QViNl6fr0SMUnpjf3SaNtOBhM1DMB4b84D7rEhq1vAwSLRQ9Q==
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
Subject: [PATCH 1/6] arm64: add type casts to untagged_addr macro
Date: Wed, 18 Apr 2018 20:53:10 +0200
Message-Id: <f3557f02473500f1d8baa7c0fa6bde21a9a13c8d.1524077494.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111194098442837?=
X-GMAIL-MSGID: =?utf-8?q?1598111194098442837?=
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
2.17.0.484.g0c8726318c-goog
