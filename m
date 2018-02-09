Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AH8x224/ZEiHkwfCaeLjoIQEHY1udO26I/9EcZ7nS+NpgkHlYqtBK4HglCC/UCx4f0Ep8/gOyk73
ARC-Seal: i=1; a=rsa-sha256; t=1518203218; cv=none;
        d=google.com; s=arc-20160816;
        b=XMekM45bbRMoihG8Mb2+P26v/GAIlqiCh6kZkMBDji29i0hNp2s0MAVccj8kx+HSql
         1yU9Q6QWczFt0hb5rj+q9BzMz7Y1+0skg/YkQH0P98gKrdfWwEBS0gh29fIzgKJhoKoX
         Tc9k6AE2XNUOIEvKu9EjQy4Nf5hDhaXgb0irWtJt6kyM0nvVZqZYw5kYdBNkCFrvhSaW
         rc84EsI2eRWU2OySuQ1PZrMMMe88qD8AHW1uo2esmCH0P9Myf+KoxwxxkMNQKe+Sttql
         QdmyouhITYFiXyd46W/qUyFbQRhCbHuRd6uNS3+UZ7IDoB8Ej+gf7wvW8lKz0RyzuTX8
         YTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VOZoRlX6Ah4SMldH1YNr8s8Qz1NWz7gzFpvNpcr7GRM=;
        b=gNMsjrt1owsXptjXsz7ZCncz5uKMc+momzfl7gQsiYNFAOoqIAEWca5ZhjHPUUW8br
         zdQz8V1w0I/xCNI3lQr3AAtpJWsanImbZtjmEOTExUULMAR6UMxOZyv89tUPRxc/uDvN
         pCAR4nf2Z4McOaT1rxJcEVZ3mkEIBCvmuhCaLqrDI2eJ4M++D1h1Bb1Q+u1tEKWnwudO
         /ndPQGTGf34ltaSJpDmva57lSG9v3jsGS6fGziy5Jy60HysHRHPRBLuHlkNThIg0hrbX
         bNRzdtYtFer9FytFqoCPpdUEeKziYjNkHZ3rL44IT8tHGZnvS/2n/SpJBV5b2qm19IXM
         gA3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Fri, 9 Feb 2018 20:06:54 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20180209190654.cvlrp22ly5gbxbxr@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <CALCETrUfMk67QeubuujbzKXeJFT4hBcq6kuAX3r1bOOeU1bNSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUfMk67QeubuujbzKXeJFT4hBcq6kuAX3r1bOOeU1bNSQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591951458089088018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 05:43:55PM +0000, Andy Lutomirski wrote:
 
> The 64-bit code mostly uses a bunch of push instructions for this.

I had it implemented with tons of push instructions first, but that
doesn't work in cases where the stack switch needs to happen only after
everything is copied over.

So I switched to 'rep movsb', which in my eyes also makes the code
easier to understand.


	Joerg
