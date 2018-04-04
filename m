Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522869979; cv=none;
        d=google.com; s=arc-20160816;
        b=SJugAMAkWzb8k38OFtXQB7XHAuGRcHkdNGGIq6VV3PJzJCNKsVztTNh2gDCOTMttnB
         IQuLrW3zL3/TJYPtrL0CDru1396DsQhI3J26H5RKcPrTfgv/cl4n1C1/Bfv3TYQDkN69
         m77XLFMfR7ZbSotypaHU3jstDJh2LlXE2miypZBSj5WaW0rm4wd5bKbYDe3uwwl2qGq6
         cU+/0BAnWHiR8+wiHfDq/Ia3IfVH1mNYvCzMHzDRw4Zjxw/woXorA1mckDPqmM0YI5Zh
         w3/byJ6PgX3sfOaBx5+Z4wkzksX8MGsSiBoWjCkrC5csy4nKnIbcnHYbk9Fj0FJr0DCP
         meJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=b/f9EaiF3LfXEZPcNNIB2Ub982tnLmUyc2KfEepCN14=;
        b=aG8V2eX2tfsZqW8TUAmxNzaTg4FxNSzPfZ3lLH4xBsg+sbiOdYr35+Puimw9aEP2Sn
         PrHGCpkofpUjOH82bCFtDhUid4QYQxL/pXIzNzgPxU6bq4QoHMxgti6i254jZ4jSDau2
         cnoTj4gyfoKlD4Pezo+DRqjAAZJ0Z5JvteM/IpWR9dqo2bVEfSBKGYOu0fwLQy0+WeNj
         U5SU5e9JyMVKpPMqNEtrIiKPgWxuEl6sHZATEwyXNOaoa2rFBDMadnjOQp/GxqddCW/a
         rG7sMHMHgfCMayXd7lCsrc2wnv4hCUJtfRtrf9c41L8aR65dIh6QRzgsSt9GSwyfS/2H
         kK4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UPzveeMe;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UPzveeMe;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/FHJdGJ6RkvJQlNtcWQE4JuNQukN8ZnnEng0Yh+qUFZJhAAHDvl7ZdPJ7+fTP5AHcJuNOzlqK00MUk1aFE/GA=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com>
In-Reply-To: <20180404165914.GA9034@kroah.com>
From: James Y Knight <jyknight@google.com>
Date: Wed, 04 Apr 2018 19:26:06 +0000
Message-ID: <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: gregkh@linuxfoundation.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, mka@chromium.org,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596844911779005576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 12:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Here is another horrible work around that was needed to get clang to
> stop generating invalid code, beaec533fc27 ("llist: clang: introduce
> member_address_is_nonnull()")  That one caused a lot of odd failures by
> users, I wonder what else is lurking in that same code pattern.  It's a
> hard one to debug...

I would note that this issue is an entirely different issue from the
null-pointer-deref-is-undefined-behavior optimizations, even though it may
seem superficially similar. For _this_ issue, the behavior at question is
that the compiler assumes that objects are contiguous in memory, and thus
that "&struct_pointer->member_at_nonzero_offset != NULL" is always true. I
don't really see clang ever getting a flag to stop assuming that objects
are contiguous.

Note that clang does actually emit an on-by-default warning for a situation
analogous to this:
   warning: comparison of address of 'p->sub' not equal to a null pointer is
always true [-Wtautological-pointer-compare]
   if (&p->sub != NULL) {
        ~~~^~~    ~~~~
...but unfortunately that warning is suppressed when it occurs in a
macro-expansion, so the llist_for_each_entry error was silent.

(OTOH, I _do_ expect clang to eventually gain support for a flag to treat
NULL-pointer deref as a legal operation instead of UB. I'm not really sure
it makes sense for the linux kernel, but it's a useful feature for the
compiler to provide in any case, so why not...)
