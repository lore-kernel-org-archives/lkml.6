Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsi7TNybrPKeo8cBiwjG//E+5l16eZbizbDyXrcjRb6o1YKL9Lb+qyYWR4TfUszodipNs9V
ARC-Seal: i=1; a=rsa-sha256; t=1520955094; cv=none;
        d=google.com; s=arc-20160816;
        b=PcUZg8HIkgSBZABNQA3Yq+6v+Vp2zf6wukq//STPDPCyezJbR62GLNueZViJEYgj7U
         j11CNUgbe/ZTI2bqKnSiMjh9tzroBo/cAHCb6JSdL70kSRTEEqu1/iUBnHOUpXe+GgvP
         Qgpove30qMCX7F7QbH2+NR7VNGkB5UESmVbhHHmJ6uPsJ1jH1qJdDj94F9ev/NlHd8v/
         RewZ1MQaVWjDlgJGPKEqzqoH0IsrHd6SH0a+lmwzrlaKwKoX1sBV3zyHkITanV11+Gkp
         ppT/zBb/+PgCX+ANEaGcqShpqUoU9moT5OIgx875mRvQECA7kqOF/kO1tv2weSB+0iFt
         JLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ukRKcFprn+4V8+DJGRWFlTQ7imqJ0N6vKtkGavP7bkg=;
        b=WZNOaCRkL4/IfDQO9foTYBynwf8zy9m5AD4ujYKkzk7IxGGi2yhJqq0MyJzDLeqK2c
         ngPoZVlEwJATFTYIqCkBa3EVjOvm/9wGfhRTG2qIGko/W+koeOkMgC+sakBdimeqc9Io
         mMN6DsXTfwDQbrGTOXO+7kEppia2myEDgK3LxqtTVzvJcAQWrqRziHtDCZ7XLX+655MZ
         yFUc5GDOI2dI95aR3J3rqkELGNwvbA/VoTgejI2n0zyXairzLlY/jBvvZT9NYc3p0eZB
         HZVNsyLpqsNzsgCBxEZQT91Q0y2OZR7m11ThLfwFwCDLTZOXP6vVXr+1LZ/bSi2MPY16
         T5Cg==
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
Subject: [PATCH 4.15 087/146] x86/LDT: Avoid warning in 32-bit builds with older gcc
Date: Tue, 13 Mar 2018 16:24:14 +0100
Message-Id: <20180313152327.476871213@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837008892044685?=
X-GMAIL-MSGID: =?utf-8?q?1594837008892044685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit f2f18b16c779978ece4a04f304a92ff9ac8fbce5 upstream.

BUG() doesn't always imply "no return", and hence should be followed by
a return statement even if that's obviously (to a human) unreachable.

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
Link: http://lkml.kernel.org/r/5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mmu_context.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -74,6 +74,7 @@ static inline void *ldt_slot_va(int slot
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
 #else
 	BUG();
+	return (void *)fix_to_virt(FIX_HOLE);
 #endif
 }
 
