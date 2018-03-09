Return-Path: <ak@linux.intel.com>
X-Google-Smtp-Source: AG47ELvmTPsA3wbQWIXxVNWZBlNt9lF26C4Q7Vxt7fd85xi1AvI8SHBOKhr+jNp3CHfAYXbSHuqF
ARC-Seal: i=1; a=rsa-sha256; t=1520608485; cv=none;
        d=google.com; s=arc-20160816;
        b=fCQ66lB/lp1Q1LKsRBsY6Y11/Rsy9U/P/D9lT/O/KWF/HOcS8dbs6yVDLkOoIiD8E0
         OdMkOX52PrZVXME8MFlOSClOLaCf/p5vVGWR5BYt02Wx6bWK15VW+Bk5UCMC+r1JYnYX
         pn4howrDZStKEI3WxNavul4kM27Dy4+h7CFgFvjy0ydGxhwHbfi+T6qBT3yOURqLfFKQ
         N1qQVoEKoSsZfwjuB4oCPjF9kel5QUZmXcnGHGFdH3o0LP2bkVnhdQLkSAJUlWj+kZ9i
         SqrMDsrDnvnvOSCweKksNi9MDj4Dl+0ntZjlNvfXbKyyWcAZOgBfY+KUo/k9S66UvLfA
         c+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Mfh+ZfDiVtzgd5WBEUrvVtEebF8XQt8cmebld6Yhgt8=;
        b=qjDo7kQ9yvqU9VY/f888ZV6BNFZmqMuOEoRk5FGNU4oKnw5D5Rvd0vgyzw1K+lxsbw
         A/AEWWYgxJHNv7eAhXKmjhCSa6GrGLvdzzrtgsnfrfIAzLqZGp610/ZsLBKuyfoI+PR4
         n2RKBbuGs2xXmiqO5TC9jDq0k09uCmrKYDvTUESYbkJq+SB2RY56Y9TTEQ6UOre6kVw7
         sU0F4rygReeuDaMv6OTI7Tidh6HVadV5kZTFfNfvGVXu+T+++hpXRojjXI/tSYiZzhX8
         VTWdSXROOxAuoEdrxNvg4xbHVs4CLG0VxPRnFRiUa5RQCEsXlzCyu2i02b1vtH57qe/x
         ECJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=ak@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=ak@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="23052795"
Date: Fri, 9 Mar 2018 07:14:28 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>, Paul Turner <pjt@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
	Kees Cook <keescook@google.com>, Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Jiri Kosina <jikos@kernel.org>, gnomes@lxorguk.ukuu.org.uk,
	x86@kernel.org, thomas.lendacky@amd.com,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: x86/retpoline: Fill RSB on context switch for affected CPUs
Message-ID: <20180309151428.GE22087@tassilo.jf.intel.com>
References: <1515779365-9032-1-git-send-email-dwmw@amazon.co.uk>
 <f2faf9ff-8955-d8b5-c521-91b9c273128b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2faf9ff-8955-d8b5-c521-91b9c273128b@maciej.szmigiero.name>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589409875989472083?=
X-GMAIL-MSGID: =?utf-8?q?1594473563532194214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Shouldn't the RSB filling on context switch also be done on non-IBPB
> CPUs to protect (retpolined) user space tasks from other user space
> tasks?

The comment is actually incorrect. There's no risk to hit user space
addresses if we have KPTI and NX (which is fairly universal).

It's mainly needed on Skylake era CPUs.

Should fix the comment. I'll send a patch.

-Andi
