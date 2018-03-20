Return-Path: <kernel-hardening-return-12709-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuIgssrQ0K3KqKXIk2XIrItfCovLc3iAHYsMxUdY3jM7CfxdnvfPuZ8QSyHhPb/+8Q8E317
ARC-Seal: i=1; a=rsa-sha256; t=1521588260; cv=none;
        d=google.com; s=arc-20160816;
        b=Ki2nFyuCN0wXU+i+BDSq2MVBKboRYnodBBuRsna78dBSrrl1T+Bcw5ApFENtD1+lo3
         PKUJ+Fpg7XCF1SeZ6jpYidyo2WFaj5Q1j64iqbVXfJvOjz/4/qFSe51ha6Sbz0hc5r4a
         azKPcnFIUxa4WPH5We6nJJU3WJLfaO4iJdL5CZJtN3EjWvkEX1XifSK1wNXsKUmIh6pY
         uvu7JKnbimUalmCD8QTUhabp9vRAXymU/SERae3pYHnIJ7cc8VjgetYH5JmWJxhp15tq
         hRZcQP4fOzaDEH4Mfyu9A8G5KotwErpm64Hd86u24Yyp69XA4JyYgBYJ8i7X3hhy0j40
         ezWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=JXQo/eczRFK6vIJ3/MAaFpWi49YGyxghOqpSmAi8d0A=;
        b=nrLAkbL0wMAVEGg1MD55Qnh4DhDN64NQNSJvTTzeDPLw1SMOTfu3tKrxRlUqlJqjRh
         hnp7xhijqNLhG3CtXv2iuJfh3gHOmkip+Ll5tGQEYI8Z30dwz7PaYxpRCM3JLvo8dWxI
         kPlZwS0CgzfVFXxRXlKe5ltQujVHMy2lXXGDKwcVHzVwHOgUWIIdutAMMVwBJUpavOto
         +9m4Q8eCAUUvVxpM1FxvdQQ3vJNIW6FQZ5l1n02fs9jmDlbzFI08Cn4Rp/eCOTOTi87I
         yfWqJDqb79Daz2wLikwzrBZNCiWUVBY4Jstf6i99RxE1yRZotbaRBaf5/XrNCPruNPUR
         tI+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SwwysnbG;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NsbKEteM;
       spf=pass (google.com: domain of kernel-hardening-return-12709-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12709-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SwwysnbG;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NsbKEteM;
       spf=pass (google.com: domain of kernel-hardening-return-12709-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12709-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com> <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 16:23:54 -0700
X-Google-Sender-Auth: RTmoocTBjIQJOsC1ZJPU02y0V84
Message-ID: <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595500932103027627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 1:07 PM, Kees Cook <keescook@chromium.org> wrote:
>
> No luck! :( gcc 4.4 refuses to play along. And, hilariously, not only
> does it not change the complaint about __builtin_choose_expr(), it
> also thinks that's a VLA now.

Hmm. So thanks to the diseased mind of Martin Uecker, there's a better
test for "__is_constant()":

  /* Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de> */
  #define __is_constant(a) \
        (sizeof(int) == sizeof(*(1 ? ((void*)((a) * 0l)) : (int*)1)))

that is actually *specified* by the C standard to work, and doesn't
even depend on any gcc extensions.

The reason is some really subtle pointer conversion rules, where the
type of the ternary operator will depend on whether one of the
pointers is NULL or not.

And the definition of NULL, in turn, very much depends on "integer
constant expression that has the value 0".

Are you willing to do one final try on a generic min/max? Same as my
last patch, but using the above __is_constant() test instead of
__builtin_constant_p?

               Linus
