Return-Path: <richard@nod.at>
X-Google-Smtp-Source: AH8x225ZaYRvu1ExHDqFz5d0CoZfuq2uF7YOCXEJt0IkQArLuvzcXEwyWFHCtVwP+aXwJHvYd1ST
ARC-Seal: i=1; a=rsa-sha256; t=1519140254; cv=none;
        d=google.com; s=arc-20160816;
        b=wLZiR4a5nP6LIYO9nGlA5VJHv3/0aJZzo4lyM4E0mhQB+CH2veXYeWa5Y+jp5EQDW8
         sJAkFe0HbilTJUV63w765qci9BmzJGxihl4+hTxQYJRSRA12Ml+87jkZjnk5GGzj64oB
         OqKojSZKy705J4COj8RQ0dgYBBU5wPLIR1CxU/FbdbVzhgS+BKBI2cDy0WAZsr0LHxIY
         5mMMsJ5DLnKJiES18jMGs7KR1qSWNUYegPoOl8d5sy44z2BjDGSir4kmY+28nTnPf8P1
         /XzWe6g8CQGSNkZ8HgQLMBC4MlfF8vUMzo+8EPdUIbwIRt8Y6EkcXGlLJKV48bXxIX2z
         3M7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=iycGVMbZrD1ENAlQGuP/XYNo7jFRz+jAhIyLfa0nV78=;
        b=i5s2jyd8KZl8GFvO5DQJMYiyNp1G6yENtSO1UD3MAKjAiBVNJxYtv+IW2WeHIxAGtG
         mgSsB0WZT6zHr3o+cXOxZWRKi721Z6PwdhvJ8EBUWm3bR/Xwl9lvyk3qdVscsRwH9iyb
         j2P7Khda3JqiJ4Kp0Pkx8muFFyvbdpHEObt73vgwI1XJZkD74cARnKyC/Jc5ky7CvuqG
         GvKdoZInDDOh81EGD7nfLcN7ARTaAMVvEsjB7V3UUWgw+h/uTaf/ibBFtGmvv4D7UoC8
         i4PoLyTdlk1WvYVEaqhbcPzlQ2anXmVZWE2bKUkRFbWizJwCTMBnOYFJuhNK6BszLsnH
         GbeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at, kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>, Arnaud Lacombe <lacombar@gmail.com>, Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>, Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
Date: Tue, 20 Feb 2018 16:25:32 +0100
Message-ID: <14335276.CH3Xr2i6I8@blindfold>
In-Reply-To: <CAK7LNASLQnWFO+qA94ifX8Gv1vMxGE-BOEhh1x2P-_mMUWRbAw@mail.gmail.com>
References: <20180219092245.26404-1-richard@nod.at> <CAK7LNASLQnWFO+qA94ifX8Gv1vMxGE-BOEhh1x2P-_mMUWRbAw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592934011257562394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, 20. Februar 2018, 16:18:11 CET schrieb Masahiro Yamada:
> 2018-02-19 18:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
> > Don't source the kernel config file in shell scripts.
> > The config file is not a shell script and often imported from untrusted
> > sources.
> > What could possible go wrong? ;-)
> 
> Please enumerate your real problems.

Build a kernel where the .config contains something like:
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="`echo hello > world`"

I'll send a v3 because I forgot to convert one function in the shell script to 
the new bash array. kbuild bot FTW. :-)

Thanks,
//richard
