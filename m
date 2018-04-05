Return-Path: <kernel-hardening-return-12862-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48dvhMPV2hWmFtE3Gz92/LlD2RnVm5W7B7bAgjrVRq/FNzcsaa2Gbz7vuGQcpZZcMHWUxkC
ARC-Seal: i=1; a=rsa-sha256; t=1522959620; cv=none;
        d=google.com; s=arc-20160816;
        b=FoZlqKKZHlrnaysplBHqcQKr6J9uURoD9gTMWFwDIRmzQn00fgjiyeIR+Au2/3MWtf
         qErJTHqidg8zMmNNBCfXfRvXA49upz8Do829AAn9j0T0s6Ql+POzyZYZqJWC+qtKj8mG
         aVQZWA8jXlc+GSKKwVYoZ6FaUxO6Obh5eUuc3n0hqIM12ZBSb1O9y84jfJbX9i3V6ItS
         ONrvAGDgNzrUsWDbP+aRx+De8fL4N85NbkxIpaAe52GSzKT/4Bxh8UPLt2Q4c+azCMn6
         7yJIip5qT0C9eSDQVB+WN2tzBr5FVdiiLcOnBHmcpw4h2j2PCm44F1VAVJZGRHo7TyMA
         wbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=WbW9FBaaEEd4B7SOAEVRlgyZ4zMQZoV185LlP8Zjdsg=;
        b=eaKRyD2pkAgJvFSfBHiwz5mD/KnLBG7FxWk70h8MSjsox0of1qPcQsSbAtKhQZvwWg
         6ZQq+gk6gCJRHNVz43NvrYSPpejvBOpB4fFbt8i7OHHUPYtMkvTvhivL49L0opCP79AL
         J4zJD/FcOtATXdXM6NDSOWzzzm01ieS7RUlwSc7mUr5T7fFHSRvPhoLMVxfzQF6sF6NQ
         JXbsKI1mctJBnT9yKL8gg3D4aP+nXTBD7IsAQrCvLxpsyQE4L/urFJh9D0Q3YYrwQpvF
         2qY+eqfGakMk2MAEvZCKCPqMp8nXs/D3OWSS30sIWWvSn/M5O0pm7lgYJCz3dUtVWMG0
         qY+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NTjjw7lB;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gTjWIYCj;
       spf=pass (google.com: domain of kernel-hardening-return-12862-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12862-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NTjjw7lB;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gTjWIYCj;
       spf=pass (google.com: domain of kernel-hardening-return-12862-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12862-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 13:20:01 -0700
X-Google-Sender-Auth: k7qGyT6XhNzsBji-uwhBTHFYbyk
Message-ID: <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596416253887758070?=
X-GMAIL-MSGID: =?utf-8?q?1596938907663845392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 12:52 PM, Kees Cook <keescook@chromium.org> wrote:
>
> This patch seems finished (*knock on wood*). Do you want to take this
> directly for v4.17, should I send a single-patch pull-request, or
> should this go through -mm (for either 4.17 or 4.18)?

I was actually expecting it to go with the other VLA removal patches,
but if the plan is to try to just get them in individual maintainer
trees, I guess I can just take this directly.

So if it would be a single-commit pull request, I'll just take it as a
patch. I guess it could go through -mm, but since I was involved in
the discussion anyway, I also don't mind just taking it directly. If
it causes problems, I can curse at myself.

               Linus
