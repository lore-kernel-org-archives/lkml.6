Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518210713; cv=none;
        d=google.com; s=arc-20160816;
        b=KTPQozpz/B1bTG8GOZxEuSpi2v21gMQraKVaPrpIcbHusQVywxv0hoa5URXTgwffDq
         jq8jvxSxyIChLcHZBl5Ac1qQtVM0fwWyyf2QMCnFP3Dv+YsR0Xpd3Pu8vqaqFEzx01Pg
         0WamiDNfFFpSrwmS5sY9209G8soXBxwWwkts5ek3nE4p926fScTz/rGJGe29vx91wh2x
         zPxu6YRLZ5/hF3s0/grIgGbaHmytJmqOo1VQsGKJoXeeInvS6vMo9KtoEjbTdhTUQg9z
         87mIzfln07U7fxf+XAPNa/SZorFbt5hI/cblJHu1xBHMwnyC6KaKxT+FWZsgimgQOXkU
         eNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=NWCzzmAK5+PN39/5/AVPnRubzqgqNfBFcjCucHck7a8=;
        b=JfY1+moM2LMQxVBT/zBWELcknEzzGgOPvQzrh9dv4Tg7Udqx8aQzF3aWZM7CqUMiN1
         Mhihidjbx9FmME8BThpevqO6DfCWUm0AZHosV18no4+PRcHLMiEMsx948+NcSYQ5NAIf
         dmjVX/5+Emu+NvB+hQloCoMRJXynp24FCtY53CZmN4x60SgckuC48csM71Nww6AVx//s
         pKugzQVDmZUz8TQdfFJfhT4skYzlY0Oqnf0ubpxpACTb1Lti8Qt5fv1NbaPb3s5/59qV
         x0wtCmzUFdJ+7yPkq97ms5HZqYEhewWgHuXBDGSEC5cjmyROmj0sed+Y/12aq+N0VpKE
         LF6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7dOqKjR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7dOqKjR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x2269J5fK+FHM7vNCIiBSWrSY6XTn0CR/8CqPNsAnEnqX9/cwj+g5SROknnpQMU1jhO/QkjSErTbzDBdQ/4rrtzo=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180209210918.GA7333@amd>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com> <20180209210918.GA7333@amd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 13:11:52 -0800
X-Google-Sender-Auth: FVne5RTOWomjJyJ1GXNmkiTC9EA
Message-ID: <CA+55aFy7sme11ok4FqZD2upvF+4g3sDK-yQakNnD1LAsALDOUQ@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591959317316598414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 1:09 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hardware supports PCID even on 32-bit kernels, no?

We're not adding support for it even if it were possible. No way.

Christ, even if you want to run 32-bit user code, you'd better run a
64-bit kernel. Backporting the PCID bits to something that no actual
real developer will ever use is crazy and unacceptable.

             Linus
