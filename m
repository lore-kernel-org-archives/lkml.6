Return-Path: <kernel-hardening-return-12861-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49Rao2uqWa3USmk9wg61XqPCx7cdkWjglSRF+40HkJlDkjUuHfO1QdrYxWq0GNpIMPs/sqi
ARC-Seal: i=1; a=rsa-sha256; t=1522957965; cv=none;
        d=google.com; s=arc-20160816;
        b=i+58dxer1S4oLEsS2pbEUVP4buY+USfWPbK4y3XxzM22PjTCklzCGsjPdXC5O59Eyk
         mO08drAqo8TvJu5rz/xEbN3I12ZP5jKYJKTLYukWAXVbqZgUX2MNGLfiokFI9Ly8BF57
         OulIRXiBAcQE/LZRj02HSQsOjM34HOXIlK33fYBqzPmxnpX3Q9zgijH/yG4b9WczmOHl
         QB9iTftQLHwkuVmTWHnD1FZrierDbyZuMhLjLphZcN4GSp40HIoQ2NfLnf56qw4S0SW5
         U9w8gDJ5E/Lij3oRUzolc68poPyIVm098OmHWSc9fsZKHhXcySCxJgzvqVFsXCiXMauC
         T6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=fEIfKGuejTj2WDdhCtO/9qz6jtT3sTeJf7hLQrtDZHs=;
        b=gFDSQlx+vEwiLPKlxqVC+dpAtvf2bWKXyyWyM5twct5PxTGgaQ1+/lJvCp7OYkz14D
         CvHkVenvnp3YAAMfZHawNTyA2dyrf3w431XWECQKKDwYkDA3DQrCgs9fQjpjdYOG2xuj
         gGFqwK52Xzc8uFt5/kdausk7LruF743Lnr0QQePAbltQMa7NNhRQi6MMdYsEKVruvbj4
         vQwDvHn+qbfgvRWlOoyLQGyW7qockEzu5fwbazsE5+bcrWO6UHTmlDoZm6Ku5hvrYHSI
         34VwxD6cEeVvARvjOUxk+7mqR2AghIadQW086JLZBKr1x+9olYtcDGYYK5OSHJkPz6pV
         0RBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=AIveOACT;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZU+RMDI1;
       spf=pass (google.com: domain of kernel-hardening-return-12861-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12861-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=AIveOACT;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZU+RMDI1;
       spf=pass (google.com: domain of kernel-hardening-return-12861-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12861-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180331015236.GA3852@beast>
References: <20180331015236.GA3852@beast>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 12:52:23 -0700
X-Google-Sender-Auth: 00eCnoe96nPWpt7cTxk3X5pCmxM
Message-ID: <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596416253887758070?=
X-GMAIL-MSGID: =?utf-8?q?1596937171871085765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 6:52 PM, Kees Cook <keescook@chromium.org> wrote:
> This patch updates the min()/max() macros to evaluate to a constant
> expression when called on constant expression arguments. This removes

Hi Linus,

This patch seems finished (*knock on wood*). Do you want to take this
directly for v4.17, should I send a single-patch pull-request, or
should this go through -mm (for either 4.17 or 4.18)?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
