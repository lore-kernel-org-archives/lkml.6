Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtNgBOqqPgedHyD74FXQ6IcxdXd0+s1SeWVniv3AQTnaARio+Eo8ZBHJ0gn+RFb6hVUQpYw
ARC-Seal: i=1; a=rsa-sha256; t=1519981662; cv=none;
        d=google.com; s=arc-20160816;
        b=Pgdmy4PJisQborGVEeKyD5CaG0i3SC9awfPwS6oJ7hfMVd8LBAz/KeuZ0VdQ5sD2wy
         uLblt6MWvIBEVabx6Wi0keCebaMhxjOgNes61PAh/b7sWJrfZXbbC1uzUS1O0eYHLw9C
         PAZg8T2wxS1wZ1PJVFCPyF8RRMkO5yBfXNXR528bRk7DHhWsS156NHsZX3xoBHbYxDpE
         5x7uhR3oz51nb3ok98k7RtxvBu53h5QlWgGDFfS8Aw1AcgsQifxxhRp7zoFv2VWNMEto
         8Sl39qBYMlTofcCQdQNGlC20mG09D+IwV9+3h3Ll3WTjB4aK2WfoeU82G1mp9eEI+8sQ
         HG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PU7EPMVKak34ckKvfYRXb97B5t49eWkZpEfK/TDi5t4=;
        b=eKnrMkJP+858C7AeT4d6X/vqcEydtogjSgCr/1+amCJSagbkHdd7g4tGBDX/ob/lVn
         QA9MqyjjZkF/DzsuAQSRSVFZqMrSqFFuS47faUokoKe1Njajb8egOSWIXIiAx4hknCW6
         bRp66u38vmrdR+Ja2dt3v+ddVJcpS7CoqEZ0hHG5JTUycgU4w6X5fOZSeiXO0Of99FaI
         /b02r5i6MPm85+wil+RFFz8fazTf8yIK+TkYCQFdIAnUzNvnZ9557ff0J1mI1+3jZ3rX
         mNfZqtP4HguDJIvX5RPen64T6PfDl1/Az9xKFxB98Ru1RVwVHjUgO1ccI+UbjXWr7KRH
         8dXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=can9wVTh;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=can9wVTh;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Fri, 2 Mar 2018 10:07:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>, Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
Message-ID: <20180302090737.GO16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org>
 <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
 <20180301165019.kuynvb6fkcwdpxjx@suse.de>
 <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2gxVnb65LHXbBioM4LAMN2d-d1-xx3QyQrmsHECBXC29g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593816290604219939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 01:24:39PM -0500, Brian Gerst wrote:
> The IF flag only affects external maskable interrupts, not traps or
> faults.  You do need to check CR3 because SYSENTER does not clear TF
> and will immediately cause a debug trap on kernel entry (with user
> CR3) if set.  That is why the code existed before to check for the
> entry stack for debug/NMI.

Yeah, okay, thanks for the clarification. This also means the #DB
handler needs to leave with the same cr3 as it entered. I'll work that
into my patches.

Thanks,

	Joerg
