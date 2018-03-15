Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AG47ELsTFZ1n/N7kVr+zDpQF0tNsvri/QmcckhM5DXEUzR75LSJH0LcMJmwLLnRgxYMYoOhg4FAp
ARC-Seal: i=1; a=rsa-sha256; t=1521109119; cv=none;
        d=google.com; s=arc-20160816;
        b=qkkH2MVdoJq1SGacZuGjS+/3c4zbpDkQ3IIZq0tb/6zzTgzz4PAlV0LaRhXxU4N/0a
         5fElB/QLKmv3eAaNtpGR1Tt6xNqJ7LrCSHB2tPF+DBWw73sSc03IaYfE8jSAv2LLx46f
         VIN7VDqnPEOFuyu5VZ5OGkNy/Z0KhNSbk72IFflTm1Zzhy/4eAiJH9kW8ScHJLpo/FuR
         XWD6slvuVd68fyxY5BBC+oaY9WpOWZNlpm403VK7k2EkBUtYVbARji+FsmA+PB1T5dPp
         1BsMPYQ7U5v2hhmVeOt0++xm7meqKfznJWS+w7OvuWWHm4fmbLdn3LR2xx8ZE11b+/pD
         axlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=FZRIPdk/XjSQs7mAEC384B3CjgBxEPa+UlZiasNNNk8=;
        b=fe7fPeAwYokeqdVVIhWzsjdS/AmFasXzxbA0fIx0u3PHg5dSftWrF2JXv0nQGyua5k
         wl61brpvn/RE/s+CYl5Sg0jCgMpqJyPvv6ZFe1IqWDg1bN+ymIWu/jKh0n7JCYgqGOGs
         HBizOLx4BzmZhBiey5eoCKgUUh/Ily8J2q90uDkZTDKwH8R6Sw4XaNP2FtAsPgKVLRwh
         +MsUWsIXhq8hCeWrO7MUBqzQuqOempY5VenJnRBkdDvoyHILpnmX4aN74LmVqtGmTZ6s
         OSO/2BUwZrmQWdX5ypuVFGNL0WtDSNMPVaPKzrFpKb0V88Cjl7urmQZJ4shcdGyVBofs
         jW/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH v2 06/27] x86/entry/64: Adapt assembly for PIE support
To: Christopher Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Matthias Kaehlcke <mka@chromium.org>, Kees Cook <keescook@chromium.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>,
 Alok Kataria <akataria@vmware.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Luis R . Rodriguez"
 <mcgrof@kernel.org>, Christopher Li <sparse@chrisli.org>,
 Jason Baron <jbaron@akamai.com>, Ashish Kalra <ashish@bluestacks.com>,
 Kyle McMartin <kyle@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Cao jin <caoj.fnst@cn.fujitsu.com>, "H . J . Lu" <hjl.tools@gmail.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Rik van Riel <riel@redhat.com>, Jia Zhang <qianyue.zj@alibaba-inc.com>,
 Jiri Slaby <jslaby@suse.cz>, Kyle Huey <me@kylehuey.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <mawilcox@microsoft.com>,
 Michal Hocko <mhocko@suse.com>, Rob Landley <rob@landley.net>,
 Baoquan He <bhe@redhat.com>, Daniel Micay <danielmicay@gmail.com>,
 =?UTF-8?Q?Jan_H_._Sch=c3=b6nherr?= <jschoenh@amazon.de>, x86@kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
 linux-sparse@vger.kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180313205945.245105-1-thgarnie@google.com>
 <20180313205945.245105-7-thgarnie@google.com>
 <20180314102951.GQ4043@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.20.1803141051210.14471@nuc-kabylake>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d14b321-debc-5bc8-8c1b-14150052f5b8@redhat.com>
Date: Thu, 15 Mar 2018 11:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803141051210.14471@nuc-kabylake>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857697760354422?=
X-GMAIL-MSGID: =?utf-8?q?1594998516227715312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/2018 16:54, Christopher Lameter wrote:
>>> +	pushq	%rax		/* Support Position Independent Code */
>>> +	leaq	1f(%rip), %rax	/* RIP */
>>> +	xchgq	%rax, (%rsp)	/* Restore RAX, put 1f */
>>>  	iretq			/* continues at repeat_nmi below */
>>>  	UNWIND_HINT_IRET_REGS
>>>  1:
>> Urgh, xchg with a memop has an implicit LOCK prefix.
> this_cpu_xchg uses no lock cmpxchg as a replacement to reduce latency.

That requires using a second register, since %rax is used as the
comparison source.  At this point it's easier to just push %rax twice:

	pushq %rax
	pushq %rax
	leaq 1f(%ip), %rax
	movq %rax, 8(%rsp)
	popq %rax
	iretq

Paolo
