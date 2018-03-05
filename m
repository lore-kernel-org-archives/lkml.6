Return-Path: <brgerst@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520270497; cv=none;
        d=google.com; s=arc-20160816;
        b=a8EW1FON1URQea0ReOcYb67dlfd6Kwva/V0hRasgpOmB7UNtn5/n3bXuvKHYxL43wC
         h9MgfBtgWpgH/kZRYmZo5Q5BZhvRQBJb6FZrg2Grobl3k9WRVMS/nac0+kzc2+kOu+3q
         FelIYyC4q1RicXZflvORqsFEZRaroLrRFi8uga6i8KhVGUqqfMpgOgJQ8r7HuraDNRsZ
         D5NUVbQpXiHUWs2piHBygVmrFIJZbNpHqKF39RUuBxkLgBbGJwFtUN+28vXB/I79wJH9
         zdz6waVJsZcQn1L6HVp6POafUU6x2VdY8oo52LSiNWCV15fLNjIAzyLMQenaLZvWNjEV
         bO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mrp+Wh0z2gT/Zi88cP7fAjz8VKTEMszGmyl9+rEPY/Y=;
        b=rCAlaYZDmGDqCAbhIrERw1Lz3KU9WoUtwl2VsNGNcigZ+FHAN3Ig18upIBTDW+cjff
         y245MOYYSDaRcoQMQSiEUApcnLlXKmCzLL1m41cZ25GYpbf/XK6msd0GOuGznQPZX727
         /k9akx7fuUKzBW8GtEJY4AsiqxM5hKpilrNEFTmr7wk9LmaiSVayRRmK5KORuw1Nu6i8
         nJCfJ2OVO6Z6wS3wz06WyQXPsLSDpwvgcVYyJ0lv6X0SXie0RT1OAeuu/cUPD7jAooWD
         L1KRLuuMmEDNhN9HlyzFjewLVin5+79IjbGaZE7FlqrMtf+HmqXdRhpGLwdZMRYq4aWs
         3mIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p4gox/sV;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p4gox/sV;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuHqR5lfcqheRNqvgMFVKlPnspJMK/W5nbBfsV7bXA2Ebivs88LQhszgSriYmQXsatr/X0WPC+rJCtnFi4Kul0=
MIME-Version: 1.0
In-Reply-To: <20180305164448.GS16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org> <CAMzpN2gQ0pfSZES_cnNJSzvvGxbzuHdP0iAjx5GG5kJ6FGudbw@mail.gmail.com>
 <20180305164448.GS16484@8bytes.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 5 Mar 2018 12:21:36 -0500
Message-ID: <CAMzpN2jnaYSqEwuad5jsi=FJc_BNd_NyKWcjXf7QGq1ugLLrNw@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	=?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594119157287133030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 11:44 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Mar 05, 2018 at 09:51:29AM -0500, Brian Gerst wrote:
>> For the IRET fault case you will still need to catch it in the
>> exception code.  See the 64-bit code (.Lerror_bad_iret) for example.
>> For 32-bit, you could just expand that check to cover the whole exit
>> prologue after the CR3 switch, including the data segment loads.
>
> I had a look at the 64 bit code and the exception-in-kernel case seems
> to be handled differently than on 32 bit. The 64 bit entry code has
> checks for certain kinds of errors like iret exceptions.
>
> On 32 bit this is implemented via the standard exception tables which
> get an entry for every EIP that might fault (usually segment loading
> operations, but also iret).
>
> So, unless I am missing something, all the exception entry code has to
> do is to remember the stack and the cr3 with which it was entered (if
> entered from kernel mode) and restore those before iret. And this is
> what I implemented in v3 of this patch-set.

I also noticed that 32-bit will raise SIGILL for all IRET faults,
while 64-bit will raise SIGBUS (#NP/#SS) or SIGSEGV (#GP).  The 64-bit
code is better since it doesn't lose the original fault type, whereas
SIGILL is wrong for this case (illegal opcode).

--
Brian Gerst
