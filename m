Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mLHwzgMlbi1YNU8PtOHMImZz4Xu0RNHtruE8BFMqb850TSD5npJmf8kFRWbogzTb/j7OV
ARC-Seal: i=1; a=rsa-sha256; t=1519218066; cv=none;
        d=google.com; s=arc-20160816;
        b=eCgL8qNOJQq2gTCRjLK1TB5fij2fMkaKjKE815mTKki0f+I9+vLfOldt5OR9P2KhxX
         E9z+hc2vD3aqCSCZgd9xPN4PjH3iRmwDLfD+ql81NoJpcfZ2V0PplaCB5pNjZBomPi12
         xuxnxNZACTDPDHGEeeNQf2ehxh3QiA0SV96z92R20Pxwe8DA/2RTwNvS7JSnXvaFwThT
         EpNXnYAzxdUqnznBPj3Mekq7Ha7+YPpJPbZL4ac4wgwisNaLbfZgyg5iRjXZ9u7EZHQL
         bSGQLG7mM7WQtSXKKJDWukhI7pZTIl2O4zdamnOZTn0QILIuNQ6uRxWpaQtp8Xx93j0E
         Ap9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FJIojE1tdp6BNS6GY3xEFe0M7oYwH4u/hpw1bUm72ZQ=;
        b=guIHztQNmgPtQPyY3/Ey7vgu3TG6hEhGcxg/rY/SChr3JU7DlkZRI+i77NBTJr45kZ
         llcv6BhFhdWcEZx69ZJL5S1XYxy+rcgOqgxWSJb88tcyn/waXo5v5bewt0z+bbupAUU8
         +S3vk9DzO6z6Q5scToAH3hPbuUtnATpWObbRoVZA/vI3C2KuwB50nez6zSLZ+/r/eqdR
         n5p6l1aGHTUXJmZ7juNXD2bvRFcJsjOP+yx6i7hXIDTYdJW+S2nwMh15IVnWdheY8Wnw
         N4/v+2I88LOcwA7Gu79R3KrJcJEgTFOrx5TLA+nli81ryQ27Qo54Syc6bP5wNSm4eeXy
         Spog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux@dominikbrodowski.net,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 066/167] x86/entry/64: Remove the unused icebp macro
Date: Wed, 21 Feb 2018 13:47:57 +0100
Message-Id: <20180221124528.124865774@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015603424118021?=
X-GMAIL-MSGID: =?utf-8?q?1593015603424118021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit b498c261107461d5c42140dfddd05df83d8ca078 upstream.

That macro was touched around 2.5.8 times, judging by the full history
linux repo, but it was unused even then. Get rid of it already.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@dominikbrodowski.net
Link: http://lkml.kernel.org/r/20180212201318.GD14640@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -159,10 +159,6 @@ For 32-bit we have the following convent
 	.if \pop_rdi
 	popq %rdi
 	.endif
-	.endm
-
-	.macro icebp
-	.byte 0xf1
 .endm
 
 /*
