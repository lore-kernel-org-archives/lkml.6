Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520630132; cv=none;
        d=google.com; s=arc-20160816;
        b=RH+BPgY5gnHl6BQqGi/WeWzKqzmYVPG/qHN4tuOHExyIxch3yQ14jx7t0J43TZL2RE
         ZqChwFcrPoZlSrT4VHK8B5eDnwfVovS4Ukm5j52b6antMuytWl2RDtm+CJigiLBJxCWg
         LK0ldcXTTKYNRCH3EsDWpwwZZ1hQJn/yaYe3/OFn9x7V3U0M6EuH/LNE/mpTHRTWNl47
         PLS+PIswzgfUKctrqx9LmkI+kpYCSDX53FgTtCcRh84CvS1uKDfk+m6ljaLbA7lajmMX
         6YKtbTvKUAZSllGDjfvHVVeYetxsI/7ckqjVxKaitqdDI1c/V8fgXTgHJRIFRAA8H2sB
         Xgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4ZjmX0TK1ENqLidS6E/rBXdBjtyJFf2GLte8k5P5JJE=;
        b=wH9nVfJZe4DuNhaW2VKkE4chRzb8jmHs7/ohdd3Gl4cfv6IfI2Z4T9D3EVgIvK3JaF
         amyq+SUg43myhsG3ObFujsN/HQv5xASX1ySVzmFOp2La6+pJG1K9sT/bGdI9DaHbTETD
         u/fJ3Ij+Wd1eM3FTxOHLCd2FWObkcMuCciwoX+prSkjnJhCCiLCdFFo/B5fzEtE6B+lY
         XjENatzppy+oQ3J5jMApPkiw/XmW8nfLLIgLfFxeg2K4KzcudDifSOHtmJuGKKYUzm7/
         lDL9VHN1cSpfsmT101IIOL2YPJ3pokzKTdvfMEnlKR0bbldrFrKbEssxoAVP8MBe8JBb
         g7NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MF3hvXOU;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=J069GZjP;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MF3hvXOU;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=J069GZjP;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuHJ2AclS7MZZj6lAYb4elzN+xd0R2OahsnPqJW/e/7xd0626suIh8EXtGtpf/oTosGAkxOSGp/MxSMdJseo8g=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180309204526.56301f43@alans-desktop>
References: <20180307214624.D4361772@viggo.jf.intel.com> <20180309204526.56301f43@alans-desktop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 13:15:31 -0800
X-Google-Sender-Auth: Nd8ovk0cP8IJpxiYL-sUbOo-_Gk
Message-ID: <CA+55aFw5+KjVqKUpAMF+-BfE6NuXSNb8qdRtmAWDq6apK2v+sA@mail.gmail.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>, Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594496261275103233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 12:45 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> If you want to be taken seriously then I think minimum you also need to
> - Give a GPG key for messages to the list

Oh, I don't want to be taken seriously by people who use gpg encrypted email.

It's garbage and should be shunned as such.

I keep quoting this:

   https://motherboard.vice.com/en_us/article/vvbw9a/even-the-inventor-of-pgp-doesnt-use-pgp

and anybody who thinks pgp encrypted email is fine is a clown.

> - State what security is in place (encryption etc) to protect the list
>   itself

That could be stated, but it's worth noting the other rules.

If you have some long corrupt vendor disclosure period and are worried
about any good guys finding out (the bad guys probably already have
it), we're not the list for you anyway.

Keep your "we'll keep security problems under wraps so that they can
be exploited for a long time" emails to yourself, or send them to
/dev/null.

                   Linus
