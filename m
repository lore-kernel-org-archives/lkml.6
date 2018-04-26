Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AIpwx4/x3AslF5cGPUO17GrUNNPW5BZGEuTRnNOcEeYKNQ2D8bwr9nQLL0bCZWsV9mnwC7LFBaNy
ARC-Seal: i=1; a=rsa-sha256; t=1524765421; cv=none;
        d=google.com; s=arc-20160816;
        b=hAkzRJWzp5SXPzqp9fYa22GMGujICU5ulN6O36b4Nk1f9e7S8rm0nTpfnF06RMDKMK
         kEuqBSqMqO5pXFzcAK2McXeyYSIVF2Neqen+fYrE4VFEFylrmudqR1Ymuk8ghGE+E6I9
         hjlg/AjJgPSpJsvPsZv1LMilzOA9UyJW72I8RGRvseh9gABJ5ZXq1WWrs+s9/D6K/EEv
         utd5CWCb/j2+dWoqW1pY4v5l8D7/YpfWggO2UzyEaOXtIuMI6iqcKzKxWTHLQ+BPSY1p
         JMINuambkBZ36GBRVjBYvLT8VClu+1l3InZ+V3UtgZeYH8qranWvw5WS71QjHKgin4L6
         3yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WaEmkeCNDAO77F4Wan/PzEPLkG3yuC/BhrHXyUrV+9c=;
        b=v9r24h99Mv2ex4AOimpqqqV5ukxsOuTUlv9Enh0iBjNriL2x6T77C7QX1eU2z4DQQw
         RAz1/nloiHMHSBjxCTEaLWpEee/2YA7XNTR7MQjNj/FqVEDlfTMYZiQy2ZYdwPwEslBS
         7Im2Rnn938/ol09TbxGjPQTGZ9aYOcowWEbYVGr7lfj8GG6XMbE9fdc5+xjZ6yIw46i+
         A1iuY2uuhufU3XOcJ/kFmxBTykOaUJbxdoByxWDCX5hqiHL5QaKJQXePyifY5ox2ca4h
         Im175I54SrZ2S1YaWQkIw+7HWqgDpssBZuRhvrqbXIbQGAY2+uNyUOeMaKszO2+ODscC
         L6eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Thu, 26 Apr 2018 18:56:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
	Mark Rutland <mark.rutland@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dan Williams <dan.j.williams@intel.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Kostya Serebryany <kcc@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	James Morse <james.morse@arm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/6] arm64: untag user pointers passed to the kernel
Message-ID: <20180426175653.q7mqzzqvdoihn5so@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <20180419093306.rn5bz264nxsn7d7c@node.shutemov.name>
 <CAAeHK+yb-U3h0666i3u3fF3=8XVcZUo1nxZ5CnOd9oUiDFP=Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yb-U3h0666i3u3fF3=8XVcZUo1nxZ5CnOd9oUiDFP=Ng@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111192269135822?=
X-GMAIL-MSGID: =?utf-8?q?1598832427068591226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 04:45:37PM +0200, Andrey Konovalov wrote:
> On Thu, Apr 19, 2018 at 11:33 AM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > On Wed, Apr 18, 2018 at 08:53:09PM +0200, Andrey Konovalov wrote:
> >> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> >> tags into the top byte of each pointer. Userspace programs (such as
> >> HWASan, a memory debugging tool [1]) might use this feature and pass
> >> tagged user pointers to the kernel through syscalls or other interfaces.
> >>
> >> This patch makes a few of the kernel interfaces accept tagged user
> >> pointers. The kernel is already able to handle user faults with tagged
> >> pointers and has the untagged_addr macro, which this patchset reuses.
> >>
> >> We're not trying to cover all possible ways the kernel accepts user
> >> pointers in one patchset, so this one should be considered as a start.
> >
> > How many changes do you anticipate?
> >
> > This patchset looks small and reasonable, but I see a potential to become a
> > boilerplate. Would we need to change every driver which implements ioctl()
> > to strip these bits?
> 
> I've replied to somewhat similar question in one of the previous
> versions of the patchset.
> 
> """
> There are two different approaches to untagging the user pointers that I see:
> 
> 1. Untag user pointers right after they are passed to the kernel.
> 
> While this might be possible for pointers that are passed to syscalls
> as arguments (Catalin's "hack"), this leaves user pointers, that are
> embedded into for example structs that are passed to the kernel. Since
> there's no specification of the interface between user space and the
> kernel, different kernel parts handle user pointers differently and I
> don't see an easy way to cover them all.
> 
> 2. Untag user pointers where they are used in the kernel.
> 
> Although there's no specification on the interface between the user
> space and the kernel, the kernel still has to use one of a few
> specific ways to access user data (copy_from_user, etc.). So the idea
> here is to add untagging into them. This patchset mostly takes this
> approach (with the exception of memory subsystem syscalls).
> 
> If there's a better approach, I'm open to suggestions.
> """
> 
> So if we go with the first way, we'll need to go through every syscall
> and ioctl handler, which doesn't seem feasible.

I agree with you that (1) isn't feasible. My hack is sufficient for the
pointer arguments but doesn't help with pointers in user structures
passed to the kernel.

Now, since the hardware allows access to user pointers with non-zero top
8-bit, the kernel uaccess routines can also use such pointers directly.
What's needed, as per your patches, is the access_ok() macro and
whatever ends up calling find_vma() (at a first look, there may be other
cases). I don't think drivers need changing as long as the in-kernel API
they use performs the untagging (e.g. get_user_pages()).

-- 
Catalin
