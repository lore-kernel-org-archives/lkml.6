Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523892767; cv=none;
        d=google.com; s=arc-20160816;
        b=hqWg+/gLGk1DOJL5wB0TgZJ2F8TzCfGYc8m1I9n7i8/BaL1zgZbpTsq3PT3sK/7Yba
         FwMbVCtEVdO+ccJRqC3Biok+2cDSMvT4SaSvzpyT8yQpO6gwaDHB8ZdgB7AGDYgLbaMB
         DpvPtQv0cKMdJz4290y6W6HCg0LN+YUjq+gyjhD6n+eRDwb5hb7YifcyYVYUeKT1YAw2
         iolGnCRo+DvLpe++vFYaBEQquTNOzlFFn+MaEz44Diq3dLJQ15dcfX4scaVGCGkAjrWL
         33xvyr8U5YXAMDShgkRry1ruem5/nnUcTHW6s6OFwDGZ+UjUgNJlxbGnHOygCnZVzOKr
         hiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=G7bty3BCZGYI25B5SICPh69NWhfT5kriTR2GZL3Bs4k=;
        b=zNGBNnwKQ8mER+iZExMBA9Jn93C0mvwlELbW46tfpT9REJROTY3gwNnRXeG80dJ4uF
         iwBmTqaeG22Os8tDd5H8e7aE0q9IN/0i9lWN/NvN0SxgkunXGe8hAwCidyV1rL4xlw+7
         wVXgQDiz3wHfArT+viqn073nbe27Okafv7OATG77PlgPkVWCxxvCvkcQxtjd9cIlc/qi
         5b2rHTv9hAoOCS9KWUCLUEmbvBWRQvnCeayhTxNjiCzzqciE81yL/eKG8q4L+BXaRlAA
         sOImf+VJ3hoa+wr+ZSyyls19Lj7QBIHqJtY3dvoTJK+bcddf7KA/O/e3I7jjB08EXHfy
         lltQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HD2OaUK9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Mcwtzksb;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HD2OaUK9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Mcwtzksb;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4+xJZRATJOPSEVUfJx3t88/S6b1NyJmG+OmpIiUdnEW5czEeXjN5kSgu4oV46LnaL7c1xkTmv7b6PjkvCNhvV8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 08:32:46 -0700
X-Google-Sender-Auth: vqfuHzt-F4-oIvClB-Qt62519L8
Message-ID: <CA+55aFwGTOgSonVquab63PZG5z_NfgVF2A08iHaNeeqY5pdfnA@mail.gmail.com>
Subject: Re: [PATCH 00/35 v5] PTI support for x32
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916931664810234?=
X-GMAIL-MSGID: =?utf-8?q?1597917382735892069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 8:24 AM, Joerg Roedel <joro@8bytes.org> wrote:
>
> I tested this version again with my load-test of running
> perf-top/various x86-selftests/kernel-compile in a loop for
> a couple of hours. This showed no issues. I also briefly
> tested a 64bit kernel and this also worked as expected.

Andy, can you send your extra x86 self-tests to Joerg too?

Also, it would be nice to have performance numbers, and check that the
global page issues are at least fixed on 32-bit too, since we screwed
that up on x86-64 initially.

On x86-32, the global pages are likely a bigger deal since there's no PCID.

                  Linus
