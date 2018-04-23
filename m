Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AIpwx4+glpe9x8ChESHeAbiehzM3tPRZskHTGu28oBjRTYTuGjxuecWYfgpi96oig4Sc+Dn11Ioi
ARC-Seal: i=1; a=rsa-sha256; t=1524505734; cv=none;
        d=google.com; s=arc-20160816;
        b=ByaAs6urdsm5kIZWVArUZeTyIqRLRDvadMPY3QUmkRvv0e+DJ7etJsW3tDdbla7iAv
         E0Q0gzK/AmXBq8n+3B63IoPEgflgsBzbb/LUMnJcVCBg/8UcJWxYusSyXJSSu+xchss4
         r/nUZULCppB9uU+LACmUWSFNTmSsZALzRpN72lkzCgRJH104KfVb6mJ+vfOEnLKKz+UK
         DI0sfu+/yBNE/Djm2ezs+wJlaeKiI5F6fbPSOD2V+Tg6F5Gdpo/QdfeQngdCzh3UwnRL
         HN7fda/P7IUrUg1jSXASzX+un7nv4ERX78peveO9SsBmcxqYfWZw3HhjICnxhBDnFepM
         bUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aOq9JaGUNJFdbhoXvn47RkGh1x5tWgQqU3lHE866bdg=;
        b=gNQWAFpPkbJV2t1F38T6m6HFQ/bRIeNrR00I+0/OmZ7/904wyY77jm/4vwFYSDPjog
         V1YJDS4akBXfe6keJZ+XCJK44AKbAQ4t1KKI+7KZDGkaSx+/QTpddTZ9js5I61eF1s5Z
         /XdFZsWr1BhzcibrIo7V5zdhCbZfjsbnUrlkFx8+wkavzr++Bktd3wkrVYQJZrpVElO9
         AArroIn+QNpiAZDFutCWooAn/noEd6/T7cSacvEAR6Tqj+IcphyzmvGtZv4V/HldDlBk
         TenT5KfAgcMysJba/G/pYYOx1/w/CJCLIjRodsyvky8tdmjTP1nrcwcYAmPCfUEnczVi
         7UvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Mon, 23 Apr 2018 19:48:50 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Kees Cook <keescook@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
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
	Anthony Liguori <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 28/37] x86/mm/pti: Map kernel-text to user-space on 32
 bit kernels
Message-ID: <20180423174850.zjpx2mcs6dtfkgl3@suse.de>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
 <1524498460-25530-29-git-send-email-joro@8bytes.org>
 <CAGXu5jKYhqvgooq8q-2NoMC_Cqh-SR8J0y0c1x9LteinDfQELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKYhqvgooq8q-2NoMC_Cqh-SR8J0y0c1x9LteinDfQELQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552514601150146?=
X-GMAIL-MSGID: =?utf-8?q?1598560125287009580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 10:09:19AM -0700, Kees Cook wrote:
> On Mon, Apr 23, 2018 at 8:47 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Keeping the kernel text mapped with G bit set keeps its
> > entries in the TLB across kernel entry/exit and improved the
> > performance. The 64 bit x86 kernels already do this when
> > there is no PCID, so do this in 32 bit as well since PCID is
> > not even supported there.
> 
> I think this should keep at least part of the logic as 64-bit since
> there are other reasons to turn off the Global flag:
> 
> https://lkml.kernel.org/r/20180420222026.D0B4AAC9@viggo.jf.intel.com

That patch you linked is for function pti_kernel_image_global_ok() which
is used on 32 bit too. So any logic implemented for 64 bit to turn off
the global bit will automatically be used on 32 bit.


Regards,

	Joerg
