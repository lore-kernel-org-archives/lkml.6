Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224j06uBtlz4Ivk+WSm8vtlNqbgyelp6XZ9W8dIAe29iqaW3RzLkWxHbXHSREDWxNOPve4wy
ARC-Seal: i=1; a=rsa-sha256; t=1518440861; cv=none;
        d=google.com; s=arc-20160816;
        b=F/alFf3i+K8RLcp15M5pjAL+wJz8qPCec+z1pnK14xl0AEJCwOSSCh06k8Ix11LZUB
         znej2rEM/xYDWeLSz767bw74iSKdpK1mNnSWpzgrsmxZxoMgaJn6x11h6DE19x59EJNf
         ARyAMSIBLROknfIwE3hNiceG/ufd4WIAl6pSP7jFGk096S7t1mMw0m1Ccsb4KnfvYGrj
         C4mxIwquBUYj/1ko9SItzaYYXVHtFqhKczepLnLe9qeHwVFEFh0Ft9CMKdb79ADMtGMk
         dVDHJLq/Bczj6Yn64L7cmXUukTp8sgoSzWNx2hUV1Bb4bz+CNckY/Gb30ExLKHYfY5UW
         IWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5pMSy62CAL4elSQrbjT9wPsr8/WpaGyQtaX5QIePMTk=;
        b=xS34jaHHIpQuZFKBWMKh2nGx8A4H2zSdSb6hNVUG4myNGjZpPz6aG/L9JSOw4cC9gB
         laM/hIBxel2SMCdE7v00OKl3lnTdA6YRmKes50vwTQDBWSDH7d71U/TEE5xx+fGxglMu
         3IS3jzSDXefPVevZ0h3Cif6ZU0ArqIg88L3E9sEwNMZsAgOAsidW6G0YJsi7DXGKJFTr
         V3D8wdjBsdb4nxjG0t8qVSOgQ9PMXNYiiyM5oFwbDqKm0bwQeN83V4WSmDuHiyH5gTPk
         aroFp8K6meNZAXh9cjruHMV4tTVGkVa+T9bQr8XLoPgYIBqOKQnFV7+ZoeXp3fHgpMP5
         pMmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=AaeWJL/h;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=AaeWJL/h;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 14:07:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [PATCH v2 3/8] objtool: Add module specific retpoline rules
Message-ID: <20180212130732.GL25181@hirez.programming.kicks-ass.net>
References: <20180212124855.882405399@infradead.org>
 <20180212125033.397696174@infradead.org>
 <1518440480.6606.62.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518440480.6606.62.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199752031574952?=
X-GMAIL-MSGID: =?utf-8?q?1592200644468347455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 01:01:20PM +0000, David Woodhouse wrote:
> On Mon, 2018-02-12 at 13:48 +0100, Peter Zijlstra wrote:
> > David wanted to not use retpolines in .init.text but that will trip up
> > objtool retpoline validation, fix that.
> 
> I wanted, I got. This is upstream already (66f793099a63) so this commit
> message possibly wants tweaking slightly.

Right you are, I should have re-read these Changelogs before posting ;-)
