Return-Path: <ak@linux.intel.com>
X-Google-Smtp-Source: AIpwx49uYFgxGcRMhiKXr8pTcGCBi7lMkQq4RtPbX34itbhbOPBbYHA66ZQUpc0+jHPTz+DZ6aZh
ARC-Seal: i=1; a=rsa-sha256; t=1524098314; cv=none;
        d=google.com; s=arc-20160816;
        b=Yq6hAko8zUK/+vlpJrJLHsu73USeCApRXolA5Lq+bqX6zvjZ9Zc1wVfJRzVQiBYrsd
         Ey72BBMYseqGfNQt8zijXZ/QofFq5ztMhXiswiXbae5zhWBihQDQdfImemHCgfLAdiqe
         bIUPt5CVJ4hgRD8C24ZMZ2uv8TGWvufaWZFkHgGRFNrLDosm60EUofpRtwF8MCpI9SCw
         pa4KuXDMB77heEWyNIOg51RfqqsuWUFHzlMks2pW8N6wQ4ZyEdNtklyvHfucTjRVn8DC
         OCCBJzp6Br2DllBO5XHCOIr3p5z4fhtV204JQX4G2tZbRvYounU6BqBEwV4LLHD/ALbp
         qYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=h5o7YIUqfn2NaaSmqeJv4RaYe3QXqqjQ9oFY+IPL3lc=;
        b=efLDi/KBT0FTOKnM5BAInfm9beF4NYnWnMtwzYlwk6ZBAS4il6KysbrOwiW8N9Un3u
         ikuEVYmCfgnYPHBuT4jrhh04vObwQhDGdSS04nZrX8w9WMQG+33sUxAiOFXw79GJ9uP3
         cIaK0Oabwel0pzYYpu/NnpmS9tsR1r2UBGgZkIvmabKywv+K/tsPUayalcRdsd0d3DXH
         nzVF1gLFy13bMx67SQPMTs0o4q137X3U/k98GkzSWbmZJQb15CqJBdeYNXVBK5iEUSkS
         WvAMFuqfNh6OhcpZ2Dk1fwwoCwNioqGy8Meu5e+liMEpC1BqD3/Na540iw03/cnpXJBO
         I17Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=ak@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=ak@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="44385100"
Date: Wed, 18 Apr 2018 17:38:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>, Waim@linux.intel.com
Subject: Re: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
Message-ID: <20180419003833.GO6694@tassilo.jf.intel.com>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <1523892323-14741-4-git-send-email-joro@8bytes.org>
 <87k1t4t7tw.fsf@linux.intel.com>
 <CA+55aFxKzsPQW4S4esvJY=wb7D3LKBdDDcXoMKJSqcOgnD3FuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxKzsPQW4S4esvJY=wb7D3LKBdDDcXoMKJSqcOgnD3FuA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916934570630846?=
X-GMAIL-MSGID: =?utf-8?q?1598132914215193718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 05:02:02PM -0700, Linus Torvalds wrote:
> On Wed, Apr 18, 2018 at 4:26 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > Seems like a hack. Why can't that be stored in a per cpu variable?
> 
> It *is* a percpu variable - the whole x86_tss structure is percpu.
> 
> I guess it could be a different (separate) percpu variable, but might
> as well use the space we already have allocated.

Would be better/cleaner to use a separate variable instead of reusing
x86 structures like this. Who knows what subtle side effects that
may have eventually.

It will be also easier to understand in the code.

-Andi
