Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/tYmLxnY5SIPqmWT2eb5iwAKdL7tdICe+sqQ2muQ6d3g+svgrhAEJk0/XhYHIptMdn9Vje
ARC-Seal: i=1; a=rsa-sha256; t=1523894515; cv=none;
        d=google.com; s=arc-20160816;
        b=tBiUPlA/zdUmCnj0ySVPN6BGWoFtOEXLzuBzE0V91MRx842v83Eszd2YkeVZGWt0Iw
         nKPkLVcHTD9Y+CII8xs5qp11P0Fo6cwhvXedU3RJ0C1Nk7hzJaFxTrSnBiRdrGZcJMUc
         8jVfcHz/zgSr5O5zlTdv3vTVrCyZ1nXET8DrHHOOCye49mZOaB1fe8nMPVilHYCFqKkG
         UoZr01S9x3dn4inXJOg7nB4iCbkiK/EfguQ1QGXnnnXbYImNjANH3FDVvLt3SHJlv+ML
         FhhsRjPPEV8DFhGoB4jC2+GFsVDatHhrSeP/5MvSwouYQ8LI5CEBYcclg+HeUL18u9fj
         LRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=OzLpdeJMh3cUXJJFtvawC0yROyp1Ga6v5f0nDs5eGsg=;
        b=ee7LD3z4NE4I4599CwuCZroWo/u3Z49O6CpbpuQLBp7cnLvOUPYOY80tgqT0D731Wo
         d8O7h5Shbh0AChYh1gOwXliEA2CNiwM5GKGyExAOCCBC9ff1Or1HRaohGlsqgQNbPoz9
         l/VGYARunfz66LvSt6sThxE9adR/CX6fyeOMzSHFeqoTchnH483nnJPXWXa41o1unhGP
         AyJvfm512hrrdyjElerwqVCh2sE7k7MTVxMfFgSDtybLQDBxtjZ7TmtJ3xX1vpW7nvfj
         zEMLvtceehSDjd+jfSLmU3O1VSe/1jcGk49TTckvt4DW1TwAFVDa1XH2TS1eeUYf/Ddg
         Jmww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qGrRrxpR;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qGrRrxpR;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Mon, 16 Apr 2018 18:01:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
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
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 00/35 v5] PTI support for x32
Message-ID: <20180416160154.GE15462@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <CA+55aFwGTOgSonVquab63PZG5z_NfgVF2A08iHaNeeqY5pdfnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwGTOgSonVquab63PZG5z_NfgVF2A08iHaNeeqY5pdfnA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916931664810234?=
X-GMAIL-MSGID: =?utf-8?q?1597919215948843398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

On Mon, Apr 16, 2018 at 08:32:46AM -0700, Linus Torvalds wrote:
> Also, it would be nice to have performance numbers,

Here are some numbers I gathered for Ingo on v2 of the patch-set:

	https://marc.info/?l=linux-kernel&m=151844711432661&w=2

I don't think they significantly changed, but I can measure them again
if needed.

Besides those, what other numbers/tests are you interested in?

> and check that the global page issues are at least fixed on 32-bit
> too, since we screwed that up on x86-64 initially.
> 
> On x86-32, the global pages are likely a bigger deal since there's no PCID.

Okay, I verify if there are any global bits left in the page-tables.
According to the PTDUMP_X86 the cpu_entry_area is mapped with G=1 (which
should be fine?) and another 4M range in the kernel mapping. I need to
check what that is.

Thanks,

	Joerg


> 
>                   Linus
