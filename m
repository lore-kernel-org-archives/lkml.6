Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AG47ELsqqMvL2VKfz1GX+Wt79wlqpHyvlvPX7m4PIpnN+9QbpD8lfSZXt7xhEP3DGbTGnIYL0Xu2
ARC-Seal: i=1; a=rsa-sha256; t=1519862717; cv=none;
        d=google.com; s=arc-20160816;
        b=lvJ5EjKx+hNviZA3omUizfK2fh9a9v6wLt36XypAUKEwRGJxdMIfTGbMs5GO+Y5k0j
         b7sKn7+XHBkbQD5djhd5bDhGKExHYoGdbVTSMjxqusLgFMRJ3LsAcpWGMdU8wb1lxGzH
         y0Rr6b6/klx9yrohoDL6gVV0IlpGY07Gczg+AtyXhp/ZjbvFqUhEVwWQUU+aW0CrISIA
         KS33eMtfoU393p8dmQLwVsfd3eVsupGaDq6Xm6Jc6ZJvgqGpsTs6jeaCTxg8Z+UXRtBR
         HM6np8P/4XA3a3iAPzD7DpGqTKtKVY6jlm2TfEy2V0e5N5h+oy1f74F6Qb+Z1R5I2KUG
         FBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GWv6qu5j5fOQxp9eFYpD09rDeZKU8Isoha/wmtA+P7s=;
        b=NE/rFHP8GUBMUzYsaWTlc2raVbX4ZrdXVa6rUid0I/8QIKdftHtI9NXGy6cWNMCjFF
         GrV7b6MFhTlt6uN1rl+D8GXd+Qk2MVq6SjKR3N4lDLKK19mNLy9EqcPPDOVvZgdcvZEQ
         +qxd9aHVyXv8RaJhLCfhdb/rkwpfxNnzLZ2uKmP5CKZVlfNNJx5wMRdBijdRt24ggl+j
         rxe0gauDH9l+zFEr761wejUl1rK1agQW+PCfQ1h2EDD+Iup+BOkQ7aJ7kPfYixjcJxrV
         RgSJqiD5DVYwjtPf8UMf1PP6BdMmMr2HjOHjvgyUOBwqncuFc7hFPnalHNRXH2zO4KtJ
         Kw3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=v0KHSbX5;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=v0KHSbX5;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Wed, 28 Feb 2018 19:05:15 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] drivers/char/random.c: remove unused
 dont_count_entropy
Message-ID: <20180301000515.GD3862@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180228232247.16368-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228232247.16368-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593688909749149990?=
X-GMAIL-MSGID: =?utf-8?q?1593691568592995604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 12:22:47AM +0100, Rasmus Villemoes wrote:
> Ever since "random: kill dead extract_state struct" [1], the
> dont_count_entropy member of struct timer_rand_state has been
> effectively unused. Since it hasn't found a new use in 12 years, it's
> probably safe to finally kill it.
> 
> [1] Pre-git, https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=c1c48e61c251f57e7a3f1bf11b3c462b2de9dcb5
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/char/random.c | 53 ++++++++++++++++++++++++---------------------------

Thanks, applied.

					- Ted
