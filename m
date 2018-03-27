Return-Path: <kernel-hardening-return-12744-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELupbxvpiSsUfba0DF6OdpgIboucrNrKGFr/7MdBqDw6TykCXvGyud9qssG3XCpSBVsF3jxH
ARC-Seal: i=1; a=rsa-sha256; t=1522111944; cv=none;
        d=google.com; s=arc-20160816;
        b=Ab5oWqKavxsLULhGcqlMBWIuwUjSVywB54VvOvu/HClXk0DFnI5tgoX9JxBEuUEv8X
         IOuhY8ufTnMF8X85kDvAuUYqkeUWX3AbrMm1EWQ2obzvEIAnr0lu5iOzVVAgoDfFbKmS
         xf3x3kBimrhUcxkPf2SjKdeKw8kbN2jFahHiKFyOxg/rGo4lQamegkKCOEYPXJ2T2lhH
         qiy/h67N3HYelgF9bSPhAS2fVrynEVPrW3COP+tv/a8zWloa91JvKvHVtlVVbSxmBlVE
         LMfozzTbHdlgfz91doDxMuR0i+o+LnLGuI02U14S4O/h0b87+r7hw/xBgIikQyMvNq94
         Sw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=bifGKAdaX095XsI0U/2odiX4ME3yZBvMWzlAenmxP34=;
        b=gghuMAFbz4Nx8pJvR755j2q2ZlKwCcVW09PY5ZxZN4YCwEVoTKnOBLsp2EjqsFdZ/e
         XH7n6NML8qDMg1qFLoaY/TvOAUz1ZB57b/sKE3QHWtILXajQzsn9gvCYhrgu8Uaj/YqZ
         mKuVFLI1u3g6oSvjs13UVDJYsIn7wYfqh6eWSDZbNy858xf1iPKB9aQ1VUBf9kGXBdw1
         6f1zctymONNvOzaYMDZHCUxmlvlTA7I1NjH3h6TI6qv9sS7du3h1rlRJfY8aS1pkDXdM
         rtWwpLV2RVsWcbuk2rBp1qHA2zRcAYGHbcnkJ3KmN8syLxos1/9ex4Q6m+djNuowhD4a
         VWvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ap6gbHZ2;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=X0B4tbnx;
       spf=pass (google.com: domain of kernel-hardening-return-12744-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12744-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ap6gbHZ2;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=X0B4tbnx;
       spf=pass (google.com: domain of kernel-hardening-return-12744-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12744-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180326221554.GA45166@beast>
References: <20180326221554.GA45166@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Mar 2018 14:52:06 -1000
X-Google-Sender-Auth: Jk-g3JU_EFTPcTzMeoC9eZ26AMQ
Message-ID: <CA+55aFw2Jn=ispuj1Xzj_RwPPMR3-1eYTi+BFo+2-d07AJBQJw@mail.gmail.com>
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for max()/min()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596050054390412607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 12:15 PM, Kees Cook <keescook@chromium.org> wrote:
>
> This patch updates the min()/max() macros to evaluate to a constant
> expression when called on constant expression arguments.

Ack.

I'm of two minds whether that "__is_constant()" macro should be
explained or not.

A small voice in my head says "that wants a comment".

But a bigger voice disagrees.

It is a work of art, and maybe the best documentation is just the
name. It does what it says it does.

Art shouldn't be explained. It should be appreciated.

Nobody sane really should care about how it works, and if somebody
cares it is "left as an exercise to the reader".

      Linus
