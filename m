Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x226noL2rtlN0r1HGI4hnWcPJqxH0/3HokoFFgSwdITKEkh0oGED5h5CxEB6ZRi5nmTEw1K26
ARC-Seal: i=1; a=rsa-sha256; t=1517499636; cv=none;
        d=google.com; s=arc-20160816;
        b=uvZI0S7E/UmDlp0cmdCNSQVFHw7O0Z7Z/SMp7giF1CXt5oPyJVkyCO2W/yFmeNHgbf
         WwbXS2ZKoRtHCLXXxOoFH4gNTIp4M1t4qEAgXHU1hOgXNCLbz6UPRcBe9+dAcFX6tlMp
         h8RG+nFVGTiW/43gDv873F9t6wgb9ZpsJdQTCzpAtBbsIThZxZtXwfOAnN+cmpV6we0t
         q0tiduyC1zE7iNROjgJc4e1f8lI5pZLaFMVJ7eD9fbqqoaRibJ3HlhLfHcdR1CRsDajx
         xDuwdky8kXswrEXp1RWuylilzoODu6ZRY2eVCzUimlr9+LVpKhV7n36LMo6x0RfwOB5q
         oLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=cn/XixZd03wmuGO6kvPV4xBAxzwWRkcU67Ji2se+rBo=;
        b=RIcZufTPxy1MucN2NDkheVF+Of49PPxSTpgltyHzojS68bYzD+wS9jtYmVfnDZeMEV
         bDFPHc52wv8vix/B+/zDzTii9mS4tBdkdzn10eitWv7rbnN06YGxRr19M5NwAUgtkMq1
         Nvf+gZlqm6XocGWIbR9T3wpZcg+Mvre0uPlL2IBJYn9dBLd0hibg/fVqC4gFRwXcL5O5
         Gc693jKi7X+weg2L53t+yjwzaHgsc8uXhm2+NrR/8S4EWj21E8NaVJFykoBaSw1H3vzZ
         sR+Zw0B8cg7k+JOB2v72HYGLXwaG1SgKmLTEiXa8BGWUs8JOObEhxvQf3IhsgvV2Uyq4
         Bm/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sLdXn7+n;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sLdXn7+n;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 16:40:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201154028.GA2249@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
 <1517499131.18619.317.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517499131.18619.317.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591213698111906543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:32:11PM +0000, David Woodhouse wrote:
> On Thu, 2018-02-01 at 09:28 -0600, Josh Poimboeuf wrote:
> > On Thu, Feb 01, 2018 at 03:34:21PM +0100, Peter Zijlstra wrote:
> > > 
> > > There are the retpoline validation patches; they work with the
> > > __noretpoline
> > > thing from David.
> > Have you run this through 0-day bot yet?  A manual awk/sed found
> > another
> > one, which objtool confirms:
> > 
> >   drivers/watchdog/.tmp_hpwdt.o: warning: objtool: .text+0x24:
> > indirect call found in RETPOLINE build
> > 
> > And my search wasn't exhaustive so it would be good to sic 0-day bot on
> > it.
> 
> We discussed that one. It's correct; we're calling into firmware so
> there's *no* point in retpolining that one. We need to set IBRS before
> any runtime calls into firmware, if we want to be safe.

Ideally we'd have a way to mark the module 'unsafe' or something.
