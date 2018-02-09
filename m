Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AH8x226B0alKU5LLcf61V0uZABJZl7MB/v4VvQ49/OMXPfi+Bgq7P58p0A6mQfgMUr8tElLnrpXg
ARC-Seal: i=1; a=rsa-sha256; t=1518202953; cv=none;
        d=google.com; s=arc-20160816;
        b=mljBnWSNyxOt4XT0dD5pIfXiNNy6hPeuT9GFuFsuIjAiIcCgOcOoLVNjZPmQ/O2aQK
         y7QfPeViN0y0NGct8Nh7lgzH13EpJu/mtdVVKGp/JY9OO7F0jvODszmcefg0LiydzONO
         cMoTMBUrYG92IQUcLN9e5kQnUwAeDzZCNqFeatMRHbxItvWXA02cJWFLfxQcjRFfJ6d9
         o8Lyp/g7KFTVlXhSWTtZ5KeVaGdlj8afz3qhMAfvK9wtVs2Lhzfb8jSQTPlVR3HS/Ntd
         qs9/krHKYcau0l4KfYjY+hLb9EPKsfnJ6Lkc4LC3bmfmREWlpQkMmcVK8bEcRwZ0gZ/p
         K0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fH+cy3t31i3Dkxm/+r8yWAn0O5AHgUeFZFT6foFNEj8=;
        b=JdlHhxQVVeVbG+CGAXHokpapLSmEXbKl6S5ElywTNa8vK++vy2prSBYhlBiorInljQ
         tP3z107KKe/0sfZW4JeJ8wN7BoSXp1OmBIGGlQuuOH8PnpPYGf2L6cS0WFIYjrKTJLqw
         4U+HPyQ+GYhJSu1iLp/E2jmI+K4LJLguQCd/F6u9kky/MsRrp1UkI2sU5wdtjiSecKee
         gxu3g3/tXEOfIWtzE24jdJsllBZ2x0uUt/54UcLIyu+Szv94XGu0i1XWrwUovQKbbERF
         1rjVokF3wiRS6yodmfc6y32B1lRuaSblZUxXbLQRsV1LAYnb0j5pxEN62qbxt23VqDl5
         Rj0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Fri, 9 Feb 2018 20:02:26 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
Message-ID: <20180209190226.lqh6twf7thfg52cq@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591951180330843357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 09:05:02AM -0800, Linus Torvalds wrote:
> On Fri, Feb 9, 2018 at 1:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > +
> > +       /* Copy over the stack-frame */
> > +       cld
> > +       rep movsb
> 
> Ugh. This is going to be horrendous. Maybe not noticeable on modern
> CPU's, but the whole 32-bit code is kind of pointless on a modern CPU.
> 
> At least use "rep movsl". If the kernel stack isn't 4-byte aligned,
> you have issues.

Okay, I used movsb because I remembered that being the recommendation
for the most efficient memcpy, and it safes me an instruction. But that
is probably only true on modern CPUs. I'll change it to use movsl here
and in the other patches.

Thanks,

	Joerg
