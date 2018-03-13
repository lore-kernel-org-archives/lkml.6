Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu6kasgjLLdMU4hccN0gJBbOVZ5TaHpJvfDlQuVXf/H3ueiICty3zsb4Lr61/zlS8ThyQ2x
ARC-Seal: i=1; a=rsa-sha256; t=1520955085; cv=none;
        d=google.com; s=arc-20160816;
        b=a5DTjcTr/vxsC9HIYi5Q9aLq5EGU6GJ32lomq1q6oZUkOhKY/DKnExNO0wN2o1433t
         bD3czCsG8pbSfBKQNTGtRC3L4G8E7iAO6jYyGxJ8p29U3VfKo3VGFJKRg336VXQyDkCj
         e861dqcirJ3GSGQOTJ7v73/RG7POtimUxjGMZicD5Y9RXG/ZW8OVYZNGfOdkRfTzzoP2
         a5KdgqhOicg678RoA/2UeHXqRIBL7szU5xxB1qgKNYoy2Lv+sbzfGzoAVOEVcH7Uh1Yj
         J8KG3XZzjQzQDEjqL5zYfqyT4tyjugcwraImGCk/ILJyZLFtea7e4kzOY+jbYe1m9Mtj
         npSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=96JPtcrfuam8tPFLk5rLV0VNZ/S0Tz0Ri5QdUY0k82Y=;
        b=wNW4hkMgb2M4Qjii4OgOG39/iMK9+0XQQG7Z3nUEGPt52gdXdKacALLerNYIACdWOV
         8+AK6pDp/HWaRewVf7aQ2YXxDq3Xpip/YJg5TjQLPZAEXXeotT4v+40l5HpVBA8RFFgL
         KmSkm0MGyFhZrGkd9QKVnLXSDwEj5UTsIN+YthvJAqii76ChuqArEZBF/0fA++wnVOwn
         2kZLErQJBYHzVC+7hxeHdXqzC7thN1XhWm7MgXaeP8m7Mzq9oS3LcdWTvKQt+snKF/vk
         yT0lj19RJy0gAeKJZC29XCRce2/olCU5Q6Wm+siD5wYlqqvPWSsh+0drHadV2iuU91lz
         IJHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
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
Subject: [PATCH 4.15 084/146] x86/mm: Remove stale comment about KMEMCHECK
Date: Tue, 13 Mar 2018 16:24:11 +0100
Message-Id: <20180313152327.298574843@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836999611273830?=
X-GMAIL-MSGID: =?utf-8?q?1594836999611273830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 3b3a9268bba62b35a29bafe0931715b1725fdf26 upstream.

This comment referred to a conditional call to kmemcheck_hide() that was
here until commit 4950276672fc ("kmemcheck: remove annotations").

Now that kmemcheck has been removed, it doesn't make sense anymore.

Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180219175039.253089-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1248,10 +1248,6 @@ __do_page_fault(struct pt_regs *regs, un
 	tsk = current;
 	mm = tsk->mm;
 
-	/*
-	 * Detect and handle instructions that would cause a page fault for
-	 * both a tracked kernel page and a userspace page.
-	 */
 	prefetchw(&mm->mmap_sem);
 
 	if (unlikely(kmmio_fault(regs, address)))
