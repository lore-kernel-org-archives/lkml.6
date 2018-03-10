Return-Path: <kernel-hardening-return-12357-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuGghpWjx4PeHthEGul21GaMFU+Vkk7g5lwQ+bSAtOI6AuK1vTCU/wiAApyjo851mgZC2d5
ARC-Seal: i=1; a=rsa-sha256; t=1520642330; cv=none;
        d=google.com; s=arc-20160816;
        b=rZt5/LO4qFjZ9zdDdCNdwFesjvwry1O/8LDm868dgoJhrAGDJbixafNpYCRM3bBus/
         TksVn0Q4hKX8UTtH8XAFR2T84LfCLbhAScztAovWTfEtfC2U8ksaK76krmjIVClOlSht
         jKSSh8McnN1e6OxwPjIMUEjw80Qo4sEmMxKV7Gqay3Rm2sy0YToBBQT17RPZP6VGTV0h
         gz2AxoD8ILBXIk2nTXcgGelb3WxOns4h4YQC7m3PpnxT01j3dE/CERHmiX8/2/nJCDDO
         yj9r6WtNYSqQDTFYp0dP5CP09ka+Esg9jm18AaPJsWmHnuhN04LCZ0RCUxh3fIJFLciS
         0yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=XE3awYrBT4FKbp/+eia6ESpXddLeWnWYRb3qY+T+7yc=;
        b=eZcY7MKD11gcY3kr+AsQbWBVXggQlG/yg1XlXVnvYkb9WZkDHhx8tnEj44vJrXNEXZ
         jhEBtkpIc4PvrNHwxfGNvqsQbYNhHSANlZEGkjoWuvf80lmQLW7PrH715lBHC5SJYn86
         Osm3VDxelbHPmgQksjc4jY8g+eXlN/RuCNtn2yAT9eQqydlDUSoFhf4Cx0oIGWPKCnK/
         GQNEqW5/z7PXbTZ7kmYx8Fp1CKzdResbZglnKrKDA6Dj1iRZ4lvQf0gERrrV6F50RFfn
         jxbmqhBXvUwJYTCtRAXWUD3SVY3t1cyxgzvLC7mggZ4UinfUNJVBFN4Yy72FwsIZhUpC
         DTQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dHW07pQJ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=epzq0NVS;
       spf=pass (google.com: domain of kernel-hardening-return-12357-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12357-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dHW07pQJ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=epzq0NVS;
       spf=pass (google.com: domain of kernel-hardening-return-12357-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12357-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com> <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 16:38:30 -0800
X-Google-Sender-Auth: ZDW0YnZbRXcW_xRtN_AN-HDpNfA
Message-ID: <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594509052271498991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 4:32 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> I wonder which gcc versions actually accept Kees's addition.

Note that we already do have this pattern, as seen by:

  git grep -2  __builtin_choose_expr | grep -2 __builtin_constant_p

which show drivers/pinctrl/intel/pinctrl-intel.h, so the pattern
already exists current kernels and _works_ - it apparently just
doesn't work in slightly more complicated cases.

It's one reason why I wondered if simplifying the expression to have
just that single __builtin_constant_p() might not end up working..

              Linus
