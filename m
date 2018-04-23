Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524501939; cv=none;
        d=google.com; s=arc-20160816;
        b=b1xeWsDRC8h9OD5AHzlJHi6hwilNcSLmpjINr3QSMjuWl8aLl3HX5S4KL5Wkx2dAKc
         8QGE7zNhUbwzDBCTTz7Ah3Wvs5gNMOcv4OkcHfVVaOnMC/Z2bSpS3YkaA8PNAx+T1HK/
         qatnvoEXg7tyEYo41cD4+3VylM43ukMgFk9nc3SFZHGUVFa/6VOBTG4pAQkn+gOlkn/X
         3aeztE7CZpLOUQ9sVXPegEBeaoSg0LA7NW475KnmcVyDWFj9eVDwms7DvpTQYYec2tO+
         ir3lSWJhO6v1zNhsVUXURbiShAEJODiCNqzheBb1Jx7zU4lYdSY+nghrrWTuTGJH7DoQ
         Yzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RWvP0Cedm5k3Or9whVee6CaXtC9f1npeNxM8zlWRKS0=;
        b=brF4HfRlHkQ983A210LucozdiP8/U0cVNdlegURmv+o/Aqb6rzi7nxn60pOKye89mV
         4F78B3JVUGwKVrw4Zy2QsNVkI3KlKuh7EdbmMy1FO/qFgpfymiKle3zuZUCUU4Qq5hVn
         SD/22ZY7Bp0u0TpDlcDaHU3y2s3pkVp2oJpC9W8WGeL/lJegtu864iDeQUWJ0noPAAbQ
         85Kksw3uY3v/cDAznOS0n5M2Ozu0AV77jHN+9JHah/E5MPn7+ycXDymmMkSdYA+MIp2a
         4GRLwefipC5V5Ih30UKOmyESJBgtZsyzv/LjcqjZVaB5ppfpkAejC/6a93zviexEExAC
         AIgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VC5nhG65;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MpmR8R7q;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VC5nhG65;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MpmR8R7q;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/jyOw9OlwR3q8pnIrskv3/Ss4khYckGqB4pRUDA1AcfFh+zN8he6f18mQqvgXREEvZqy6JcrAiPu6coguNMK0=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Apr 2018 09:45:38 -0700
X-Google-Sender-Auth: TlbvovYHSWEjlVL20G2w1ydYTP0
Message-ID: <CA+55aFwg75rOXN5Q0qHf_GF-hnVo8mjxnTo2FbM993fuc8x7Gw@mail.gmail.com>
Subject: Re: [PATCH 00/37 v6] PTI support for x86-32
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
X-GMAIL-THRID: =?utf-8?q?1598552504711746562?=
X-GMAIL-MSGID: =?utf-8?q?1598556146379477375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 8:47 AM, Joerg Roedel <joro@8bytes.org> wrote:
>
> here is the new version of my PTI patches for x86-32 which
> implement last weeks review comments.

Just one question: have you checked the page table setup for the
basics wrt the USER bit in particular?

No global pages should be marked PAGE_USER, with the possible
exception of that nasty old vsyscall page.

And it would be nice to verify that the page tables for kernel
mappings also don't have PAGE_USER on them, although again that
vsyscall page can cause problems.

                  Linus
