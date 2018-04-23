Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524505754; cv=none;
        d=google.com; s=arc-20160816;
        b=D8pc2Cbd24oC8XPV+iCfxrO2Yp+ilYtIDI1oKFPB7e1cKYShkLj79qWNH0m6lpW2+Q
         42qretWeilY7hUWs1ML9oZ95E1rKcAgc/+7Y2P6fqe9QW6pAHnNogbpiuT4vv4cAU0VW
         AF5KYn/lk90BmzGX47Ou765kKWQBSiv/UveQG9r1yNGdWiOImp4Otf4TF1liw9KrqLru
         KNzLsWHiMbTEarDPyFvi6PR/QRII33AH3ZQJvCil2Rrmz8xhJfve8En7Wtier1f3TulG
         Py0+f9atjHZmZI/GZcGppwOs6arJWuhrwKY0AEUZIfneQ3PYfBJ/B5dboZSsksxEMMw6
         ppjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OWBBHy0W5f9I8vBQlT4V0WQiRCI9cYQ8sT1koP3hce0=;
        b=rqOJw/Eu/4zhFwXVl16/0ckf0zsnZBJr4QqN6WHfIyqoQ7VMgvwIk+PVWsqhwcJUKA
         B8vr5jh4Kmzf0xbaf+w5pNBF4hGULdVHVOIG+a/kDmCca1da/hzjpfxriK2owOJ6W4sf
         vfOeliUYZf3g5zCc3rBWiKRiJ3bhzD0b5xXqC7zFTesn8TyCTKfW0z9J3TS3kUFbTtq8
         yAmRfiwVE5fTWJjQh92x1HmsWpP8BU653NeZN22mziDSJ5l5u4pRbZ/5xX2h+18MITSb
         Rb4sR390Cn7oOKZRAqzShSIpWyXFD3WgtXCHcnwDMac9BPWm1vIVjBWlS9/7iXtXnLJJ
         6Ogw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O4tBr90o;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=L9LnBb/7;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O4tBr90o;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=L9LnBb/7;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/pTEvX/CC91TQN3rx9NUs6A9Esc2jh5csGeB0eQeN32zHMSdvCruMryvkNXjBD7wO+8gBqFMv5szMQ2U/1PBo=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180423174506.mpbpnvfzv6fmpbzy@suse.de>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
 <CA+55aFwg75rOXN5Q0qHf_GF-hnVo8mjxnTo2FbM993fuc8x7Gw@mail.gmail.com> <20180423174506.mpbpnvfzv6fmpbzy@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Apr 2018 10:49:13 -0700
X-Google-Sender-Auth: nleSs3pfA4hHA4anl8fTxVjjsZo
Message-ID: <CA+55aFwt+o1kjgkVcxLbO_558J5zWMg_XpfmEkW2LW2eq1CiDQ@mail.gmail.com>
Subject: Re: [PATCH 00/37 v6] PTI support for x86-32
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504711746562?=
X-GMAIL-MSGID: =?utf-8?q?1598560146168112820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:45 AM, Joerg Roedel <jroedel@suse.de> wrote:
>
> Just checked that and there are no pages with GLB and USR set, not even
> a vdso page.

Thanks.

> The vsyscall page does not exist on plain 32 bit, no? All I could find
> there is the vdso page, and that has no compat mapping anymore in recent
> upstream kernels. To my understanding the vdso page is mapped into the
> user-space portion of the address space. At least that is what I found
> while looking at this, but I might have missed something.

I guess it's just the x86-64 vsyscall page then. Thanks for checking.

                 Linus
