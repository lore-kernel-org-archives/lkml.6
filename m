Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELsZTHuNdmPt2pulhoJzG7syCr4V/bWnjPUTAWBKMHWv99Wmd3owXt+eWjKtARZngQmZN4Lt
ARC-Seal: i=1; a=rsa-sha256; t=1521023765; cv=none;
        d=google.com; s=arc-20160816;
        b=b+bMGlGnMKM+7qvIbrJNwmEwi6CtBbR2HbMoXtDN/RKX+2mZ253Xfbs6TxDcF7yLxe
         BbvSl9f3d1W+g3c9V/DYOMKdZEjIZVW33Z0BaZzNh+2LpmelewP8B599Fr3w7lj/1smy
         aUC3pUyfjOpWNTELEkoo4jud2cpdtBvQ45Njq835tvn3pxYj+pKNo+eK+wmZtP2lG+g2
         K9oiz8dF+efur2CckfX8UzLviMraQd2PUktGMLz4OLAwtFYaLxfLNBNHVGoBId4egsjt
         Gotd/ssA5Z+M6O/Xw4/1sFxb0E/8EaSGi4mxILEXWYfYm8y2DW7UmjF8TvQki+b6hB/j
         A63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1+bD0hmtzlCQGKdeMmJTJ571KhgL2Xq+8fpVFAxUgII=;
        b=eLyjRe1mk6QTg8BdLTlUB68wVbipoRFOknPBY1sX6iy2oFIsp+fUu0rF8Mk5mDWmzW
         BJ73NlFQtdoRsI2ICI8LeFZxMJpxbthViYDZRUIoCk1zA3CiiXqMr8afPDIXjpMDV799
         YibmTnZtWFlEz+h91pao/MwLVmzKrFzibzztv1BVaeK31Ge27vh8ojVwBQT4onrxsrtm
         ahEI7Wi4FDyvtVDaEUxPtEDxAK7wIps1GrLaxEUvXAC8oQJdFdNwKPK8RxQ4Xrsmh47z
         FFLFLIpL/j70Nb7LG10XTm5t70O12d0D38hftAMwoJdxhlixB4mBWLHQrnOyPpMitfMf
         C8sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WrBfxKrf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WrBfxKrf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Mar 2018 11:35:37 +0100
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
Subject: Re: [PATCH v2 21/27] x86/ftrace: Adapt function tracing for PIE
 support
Message-ID: <20180314103537.GR4043@hirez.programming.kicks-ass.net>
References: <20180313205945.245105-1-thgarnie@google.com>
 <20180313205945.245105-22-thgarnie@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313205945.245105-22-thgarnie@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594858062425792867?=
X-GMAIL-MSGID: =?utf-8?q?1594909015412706925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 01:59:39PM -0700, Thomas Garnier wrote:
> +	/*
> +	 * If PIE is not enabled or no GOT call was found, default to the
> +	 * original approach to code modification.
> +	 */
> +	if (!IS_ENABLED(CONFIG_X86_PIE)
> +	    || probe_kernel_read(replaced, (void *)ip, sizeof(replaced))
> +	    || memcmp(replaced, got_call_preinsn, sizeof(got_call_preinsn)))
> +		return ftrace_modify_code_direct(ip, old_code, new_code);

The predominant kernel style is to place the operators at the end of the
previous line, not first on the new line.
