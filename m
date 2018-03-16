Return-Path: <kernel-hardening-return-12668-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsABRlGpwHcZL5y2a7Tx43QbkeKO0MWr/uqhZJ+yQEm2vHP9H32/jGaNEuqNVHDXF8jRJD+
ARC-Seal: i=1; a=rsa-sha256; t=1521222936; cv=none;
        d=google.com; s=arc-20160816;
        b=RbKbCmCOHJxg+E8INqMPo75eEhX2n/3BGwH0fuup6QuZ5FLtegjD9BpkVWyQudE+OU
         42FQ14QU+pUzddWEukdBPdbqxPYlh9+ysakBbIvOQBth8yf980T5e+SFAgir4BSWLlUi
         lxXR7MOfBYYOKTzXbWnJE6vFCzzsVUjksewshAE7YHQduq/J/ykqQrtkpnR8QSVuotZa
         F1ozLQ9lccsPLJSo1LFf7Da9rDwfIxyJIgOl9TqAhw6a6acRn/0EZ29dAqlYc/EgQQNZ
         y5kEj9ai2SADnpgsqmsXdIHLIMu2zztlHhTwfP9C0HbZHJJgpYtvUEgBlPeOmul5J8cy
         i0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=iER4zW0pEvjByyiW5Z2yip4eHODY+XiNg+gnvBUhfy8=;
        b=tDjHekbPR7WR6+2+/2Y3e3actXKDGiI6PsIIWm8RNRJrsZp2Jh1D+2CUlPvk9UyHrh
         S9hSh/7HBk7r+Ka9P6eZbGAVeBQzD+am+MiatpJsSGwTht0oLeJrh65iUckTqwOy2PsP
         88iF1UMhHfQO0EZaqqEXL9HUtHslN9lneph3SHbEpTQXYyrZwm0A4dwkww9rDwfuP4m5
         4aFTIGr+JJ0hRFI1iKVFX87Ioq33l4T2R18Is+RR1Ot3RN04E1vW+4YqmnVxh6mKmhZ8
         XMrsHvVpG8ilph6HpE+FXZ/LCpYiyuZPOglTrdic8gl65fzIMslM+jnBPPJ6bEI5tHj0
         mTcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12668-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12668-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12668-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12668-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 17:55:02 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Message-ID: <20180316175502.GE30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595117862352897160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 10:29:16AM -0700, Linus Torvalds wrote:
>    t.c: In function ‘test’:
>    t.c:6:6: error: argument to variable-length array is too large
> [-Werror=vla-larger-than=]
>      int array[(1,100)];
> 
> Gcc people are crazy.

That's not them, that's C standard regarding ICE.  1,100 is *not* a
constant expression as far as the standard is concerned, and that
type is actually a VLA with the size that can be optimized into
a compiler-calculated value.

Would you argue that in
void foo(char c)
{
	int a[(c<<1) + 10 - c + 2 - c];

a is not a VLA?  Sure, compiler probably would be able to reduce
that expression to 12, but demanding that to be recognized means
that compiler must do a bunch of optimizations in the middle of
typechecking.

expr, constant_expression is not a constant_expression.  And in
this particular case the standard is not insane - the only reason
for using that is typechecking and _that_ can be achieved without
violating 6.6p6:
	sizeof(expr,0) * 0 + ICE
*is* an integer constant expression, and it gives you exact same
typechecking.  So if somebody wants to play odd games, they can
do that just fine, without complicating the logics for compilers...
