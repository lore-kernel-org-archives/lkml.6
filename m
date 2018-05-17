Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZoFMEj8L7Z/HSRVF3f/QVz80T2c8dXK7nrORvR2TMC9cYMafRKMcaFuK6sbHOWdcw2gZx+I
ARC-Seal: i=1; a=rsa-sha256; t=1526572692; cv=none;
        d=google.com; s=arc-20160816;
        b=qveU5bPt6NX/K3CG5eYTbuej+1eeu9hzfz68it57i+yPJ2+7hw4OY3HHlU7zAtKu9N
         uWRKmDYfJbskIGKXkxI9BnFfyqAjCb2V+Y76WlzE0ZAOAPjSDbu+Gs3Ek2wT7sFJ2/1V
         7a5xpv/Oz0G/IDpBsuDcNPrgX9jJ1Tf43EHW2EH5xELpmPZVsHPDhKW1JHQ+6o13EdIO
         MKj5tr60f2waRQVoGlBXc5IgDVaRFsQCTNgrOOJCeMU8SwbCtFuMKib9XSlRnUwfw4UZ
         LBdQgt92n/ypsu3BIG7aNxu+ip7kfmHuhyLHxV2lm6YQo1ykpMYMYxlljkMW7hpfWOnu
         WVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=M7LqjYRBgWgJ5mWNDeBvd4VajnNoytgAG+wSOX2rZEA=;
        b=OnVv+kM0d7QxY9mDWvoR1A2F0C3j2V0HU2drRKHf1N/HEYpnyM/WS8Q7NKgv4ub0AY
         ywsZij7DoAivA1YyJZeKmIMVfAE94AF+yedqpTYHJPwwSjHN9M44412WKKAprr8QHzhU
         vZmLy5XhrP3h3f+H/g0rxYzvlQUUC5qQcWrUCtKfcyYw727K+QZwYjbnne4y155zYIXR
         fQ8i4LHlD1COTlflhSxap32PUwbkBc7dt/N2yxsKB6Y4wVYC2Sjr3iyKVy9jtylmq/4D
         St8850cqR0eSp0SIvolyUDXGcL+P839DcolZn7bXTtwtqOft5FIbtggwEwdjvB5OcH40
         E5Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 17 May 2018 10:58:06 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirsky <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Borislav Petkov <bpetkov@suse.de>,
	Greg KH <gregkh@linuxfoundation.org>, keescook@google.com,
	hughd@google.com, Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	David Laight <David.Laight@aculab.com>,
	Eduardo Valentin <eduval@amazon.com>, aliguori@amazon.com,
	Will Deacon <will.deacon@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
	daniel.gruss@iaik.tugraz.at, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V181 35/54] x86/entry: Align entry text section to PMD
 boundary
Message-ID: <20180517155806.77k4zw5n3q6ia4yq@treble>
References: <20171220213503.672610178@linutronix.de>
 <20171220215443.503537377@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220215443.503537377@linutronix.de>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1587122604399937200?=
X-GMAIL-MSGID: =?utf-8?q?1600727487243514771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Dec 20, 2017 at 10:35:38PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The (irq)entry text must be visible in the user space page tables. To allow
> simple PMD based sharing, make the entry text PMD aligned.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

With my config, this patch adds 2.5M (+~25%) to the kernel text size.
Is there a more granular way to achieve this?

-- 
Josh
