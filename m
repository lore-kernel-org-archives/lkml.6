Return-Path: <kernel-hardening-return-12729-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs7vJeDihdn4pzrff/k8Pig2Zk27oO0TW+7AKGC6I7+UEAb94agf0EbGcQPBcizZezxpqz7
ARC-Seal: i=1; a=rsa-sha256; t=1522055316; cv=none;
        d=google.com; s=arc-20160816;
        b=MYJQN99p6AUPPTwiuU2RmDZ2On9GbC8NIQD0Stlw1lrG7ADMQw0Ml1OqxkupdLEAyI
         V3WCbkz5fE4VqfvcaTXAhN7jFO6FdHM7TwbuNWrZV0li+QTp0j66oTvO9DbEdx54hlPq
         5ezoSmBPA2zeHiteQPLwN0Nl9XnbzK5f4iacXM5wbBPMrS0iiXuTRQYWkLCdOYj0trls
         m1R7Hw/pjSD27mpv1OltoQUuZ9D4W40ajfosin9urkavnarwfBefIVsz1iGEbRJ4ns5W
         f3uXS9AIf61UJQmNGDz+mhA6Ha1ojwWAGjXGbEr4enz4pPlNcv3WuaXaxpzqkqYijl4c
         Sfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=pZz4pHIntayTBIeP8adljNiy84lmjh7DaHS+BHknIWM=;
        b=HOAQzSbFg2dmyemoK7Ky8Sl3akkCRKtjAfevgTNQ65L1u1Iu4aXm9XMUbsm6WMiluQ
         VvUE1yESl+MHl8Dtz/rSl0RlFqyHqpdQbgNGT2Zd5EXmiDt8fluELkMUMv35ruN0kX4A
         v4uFjCRGN4YAuqGsUuj2D/Titl+KCgVojmsIgpV9J4+efCtT/7gILAfk/w/qikxEzTcj
         ly5cTGid5F8CiFb5YvjNgklSzKVyW7zXDmaE8g88lExd+NURN7Qrp+1im5JwNXVRc3hu
         haGkUdOuP0T1QeqUnJBnxLgLCUTGFL7QcKLUS7KGGD07AmnvM3ukEH68YDP4znn0s6h3
         3WTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KTM+Q80R;
       spf=pass (google.com: domain of kernel-hardening-return-12729-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12729-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KTM+Q80R;
       spf=pass (google.com: domain of kernel-hardening-return-12729-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12729-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-3-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com> <20180310001021.6437-3-labbott@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 11:07:57 +0200
Message-ID: <CACRpkdaOJeEJTH8xtDzwbOjoONp=M7QvEfF_bO5pTQJ8KpnMdA@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: Remove VLA from MAX3191X driver
To: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507311207261604?=
X-GMAIL-MSGID: =?utf-8?q?1595990675294129988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:

>
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
>
> This patch replaces several a VLA with an appropriate call to
> kmalloc_array.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Patch applied.

It's very simple and straight-forward after all.

Yours,
Linus Walleij
