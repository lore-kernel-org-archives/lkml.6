Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520457711; cv=none;
        d=google.com; s=arc-20160816;
        b=Z6UYGWLdQ5ZWcUphFF91OpNHFEd6x+HX+FSxGoMLjBSTofGPlBEiTzVUPmYethgNBr
         G3sifBZaqsMnJVLDt2PcEANEYWrBmQWXIpqEyh6dM4Obg1Smr2b+VtIocV445JorZPrA
         LFXpimyhOywC8lrUrJ4iTKfWIwkLgK2moYZlQVJOapg4WEjbAt+KNRrcu/Es5N1Z6XZ9
         X6MkNgDICQEaETjOWWYtsxbyOQKTtwTxIiD55+sFBrth8YLUENtM5l+SyiQ4cibfV60C
         PIi7BgExyi3LIPgPyWBR7F5ld3/05O1+z8+FryR2LrjAtJJ0L/s/Rkf7bSJcex6AO3c/
         elcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=utmY/k038HyPTCNrCTex6Od25OwxnXy4wd8Gc++7/+w=;
        b=T0OXqxza934COlnkUjZPZG8TgYfLB3VxPOnpn093QsRTVSySjBahiCLAF+OwqC5L1T
         oK3owedRW6e6QRpQMyGC/PThT4Bu03Bbs6louGZAfQZrVAU9ddzcB0GFeLF90iF6GO2v
         8usio6e2ODLKJzIqx3o5bfUpJfcZWPQ1+peU09cnzpyKYKS03Tr1WhRGZM3+5dCX+7jz
         6tpPqPPqiqHL1pN/Bi/SjeeDogAxTyo6Fmi8VVJRBS4Lh3Z5xm2h3ooopP3F3mi0RhlS
         aA7byElm3uVj7YX+D0mDiU93HPsaVwuPvkTPXLNGv2BCHUZkmDY364s09PAg+8kTb9Ls
         W9HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NFg+Zd2q;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AZyy2dkD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NFg+Zd2q;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=AZyy2dkD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuYy+yx+pLr4bHPXxeSkLEY9dTEylRNfpNajEESbPicav53ZJtJKxy5rnvGOnxc83AqAdkvBmHhToJ0C0ROeOw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180306233140.268BD8E1@viggo.jf.intel.com>
References: <20180306233140.268BD8E1@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 13:21:50 -0800
X-Google-Sender-Auth: A5bZ84qW7lafWqAwLnUulmPvf6M
Message-ID: <CA+55aFzGgtnkKpJEDCvzDmEn7JE6DnOKuHwtkTkeN3AeHjt6dw@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify security-bugs disclosure policy
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594233094195809494?=
X-GMAIL-MSGID: =?utf-8?q?1594315465524060881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 3:31 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> I think we need to soften the language a bit.  It might scare folks
> off, especially the:
>
>          We prefer to fully disclose the bug as soon as possible.
>
> which is not really the case.

Ack. What we do is definitely not full disclosure. In fact, we often
actively try to avoid disclosing details and leave that entirely to
others.

We disclose the *patches*, and the explanation of the patch, but not
necessarily anything else (ie no exploit code or even any exploit
discussion). We also don't explicitly disclose the discussion of the
patches or the report, although part of it mayt obviously become more
or less public for other reasons.

So we should probably avoid using a term that means something else to
a lot of people.

And for similar reasons, I don't think the fixed verbiage should use
"coordinated disclosure" either, like in your patch. That usually
means the kind of embargoes that the security list does not honor.

So I think it merits clarification, but maybe just specify the two
things relevant to our disclosure: the fact that the patch and
explanation for the patch gets made public (but not necessarily other
effects), and that the timeframe is very limited.

It's not full disclosure, it's not coordinated disclosure, and it's
not "no disclosure".

It's more like just "timely open fixes".

                 Linus
