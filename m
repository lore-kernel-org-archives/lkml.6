Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELukdgy3qL6CfN3WQ++8HY6aPxpjlTVVsgb1e5QPZZ0QO6CZzjwxzCB0NUZzArKvEW1yWox8
ARC-Seal: i=1; a=rsa-sha256; t=1521023429; cv=none;
        d=google.com; s=arc-20160816;
        b=VYT3Bt21EqpkLlMX93v0oNXithg4xpQcIKxODtsh7F5qXxfHbM7/VChY1yZ4omoNQr
         6UBkHAUugOWJGWCaSigbN+AE1tDYHSDTnRoz4o7M65bIESWI7Yo5n5VZKV/+iEBMxFX+
         gwn47EiOLJii66qQWtAr3ZRB4oyfwioNwKFm8z5uDLTgkEDoiZnMuqzElAYQ20gpe0mf
         Zcpi8xyBbdlRYH2Q7VaKqvDpZ4+YDm4krDzIdQN31bGYsI99fkupnt2IXwDoldFwZ3ED
         1REJg1kZCqndLJ6N30E3WwjxFzG2tYr2f9zJSGACUhJKxMdBjObCRc3p4Cxc67MhZDjX
         m9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RiGhaVs0dIJpZsRPXVRUiBSeo/C9S0P1dfLd+aakGwk=;
        b=MOqQ/k31NGqINNfrHZAnfabRcTUcblfRcX95lhcgLfa6V3iDf5g6s3Zr/UDsz33wWy
         Dix1rJy2sWfHqkeyZ72MPC6iDxV6YuyewhAjw9ix44+pj0Ra+8bdAQUvZaD+hxW/coa7
         hWpA/yfhjdcR9TUhI35XcckpBmQayE+M9/lSdrv1gjBYoKyAo3lxIFYDLu6MQarMJXtR
         g4sG0FIDO9NjMax5BABVDdkCwccg+ZKJeZRlB8+UTE4eWn+rczfKphH6/m2uOXM2RChD
         I+H68tw7ijWqy3LOilCdp0a+j1mwFHasG/h9KMFa11Ppz9xGcaSU4wtvKXndp2y4jhOl
         lG3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oAwKGIiU;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=oAwKGIiU;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Mar 2018 11:29:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Garnier <thgarnie@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>,
	Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>,
	Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>, Jiri Slaby <jslaby@suse.cz>,
	Kyle Huey <me@kylehuey.com>, Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michal Hocko <mhocko@suse.com>, Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>, Daniel Micay <danielmicay@gmail.com>,
	Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
	x86@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
	linux-sparse@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 06/27] x86/entry/64: Adapt assembly for PIE support
Message-ID: <20180314102951.GQ4043@hirez.programming.kicks-ass.net>
References: <20180313205945.245105-1-thgarnie@google.com>
 <20180313205945.245105-7-thgarnie@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313205945.245105-7-thgarnie@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857697760354422?=
X-GMAIL-MSGID: =?utf-8?q?1594908663840845402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 01:59:24PM -0700, Thomas Garnier wrote:
> @@ -1576,7 +1578,9 @@ first_nmi:
>  	addq	$8, (%rsp)	/* Fix up RSP */
>  	pushfq			/* RFLAGS */
>  	pushq	$__KERNEL_CS	/* CS */
> -	pushq	$1f		/* RIP */
> +	pushq	%rax		/* Support Position Independent Code */
> +	leaq	1f(%rip), %rax	/* RIP */
> +	xchgq	%rax, (%rsp)	/* Restore RAX, put 1f */
>  	iretq			/* continues at repeat_nmi below */
>  	UNWIND_HINT_IRET_REGS
>  1:

Urgh, xchg with a memop has an implicit LOCK prefix.
