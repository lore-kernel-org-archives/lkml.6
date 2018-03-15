Return-Path: <kernel-hardening-return-12652-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvAuBwOZpAPH/4QgKw5CPvskmUhksgHT8jdANoWInpmyN2lg0AWQgVLkpE/SwfaTqHFqAsE
ARC-Seal: i=1; a=rsa-sha256; t=1521156872; cv=none;
        d=google.com; s=arc-20160816;
        b=YKi3mPS2u7xsU4KvhXNMjo89vHKFRzS9GcXjUGgEfgySeRW7/OSQpfmkO97kmbGiC0
         LXtG4QkseoVk6YN0nPJWACQtFs5LQ+JZcBORruD+9P3lGcFSG4mr0ShHVZf0fXi2W60W
         ftw0ePu9sanzwl0qW3bgm/cMzAlH7UNDFwrV3614CJlL8NtBaw8zfKwHp1pW8WmBOGeQ
         MzewwbiZC/T70HEHKhkbZQ/eU/RZS4wMrZjClfxFBiG1iLjPckYPeBhz6bD7rD4piTMW
         IkemTm7S6YevnL+RLN4JB0eJcRvxgIljPl+ABXOhRJIyAlaXDqYflPWP+GEXSH0duEXe
         WeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=X9P+LUmQLqE0ilVk4ITwIZDAOy2LhAi9vKi1gKT7cEA=;
        b=X5LySwMG51sdWkDdUIfys8z2fZIhVKvWqkFQ0jEtq3a4AFmCBR8pHmmaC+GfKYH+Q0
         CFQcXQPBOK9rtfPmGZ+CalBdqUnJr3l+Rrrn1ZkEfTAWpoZOIMATfBTmGq4nAL36qmYv
         TJctItTPUriwqu9U+L+KMt9hCZH5jirP+j1VwzICxpx0jinacqO4vhXXzsUZPMpFKVAG
         B0LK6IIxnJN3P6OeE/nSp/Ly8cSbZJ/bipwxgCkvtIZsyOnneX1d3LasTEk7x8JOp5Go
         V+RRBsyzcJ+rp5o8nNMEza2S4l9hLoFoWiJdO/0wE6lPqIoraJf41dzPHPepcBamanmP
         /eeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7aKaoJA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=RHyGjHmj;
       spf=pass (google.com: domain of kernel-hardening-return-12652-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12652-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7aKaoJA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=RHyGjHmj;
       spf=pass (google.com: domain of kernel-hardening-return-12652-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12652-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com> <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 16:34:13 -0700
X-Google-Sender-Auth: olMylVb_VRnNGg0kYPrHa8GseWM
Message-ID: <CA+55aFzO12QMFJHe8osoWfph8jnjgp_jLUQWmgbNmth_KwPxXw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595048589056540258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:46 PM, Kees Cook <keescook@chromium.org> wrote:
>
> So, AIUI, I can either get strict type checking, in which case, this
> is rejected (which I assume there is still a desire to have):
>
> int foo[const_max(6, sizeof(whatever))];

Ehh, yes, that looks fairly sane, and erroring out would be annoying.

But maybe we should just make the type explicit, and make it "const_max_t()"?

I think all the existing users are of type "max_t()" anyway due to the
very same issue, no?

At least if there's an explicit type like 'size_t', then passing in
"-1" becoming a large unsigned integer is understandable and clear,
not just some odd silent behavior.

Put another way: I think it's unacceptable that

     const_max(-1,6)

magically becomes a huge positive number like in that patch of yours, but

     const_max_t(size_t, -1, 6)

*obviously* is a huge positive number.

The two things would *do* the same thing, but in the second case the
type is explicit and visible.

> due to __builtin_types_compatible_p() rejecting it, or I can construct
> a "positive arguments only" test, in which the above is accepted, but
> this is rejected:

That sounds acceptable too, although the "const_max_t()" thing is
presumably going to be simpler?

                 Linus
