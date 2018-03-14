Return-Path: <kernel-hardening-return-12569-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtkcqNUARjo4ctBrkwrTJ5Qv802OWPManuCSn/Ibrt5PPWjpq9ZtGdzWtKGX+1kQrnc2Upi
ARC-Seal: i=1; a=rsa-sha256; t=1520991563; cv=none;
        d=google.com; s=arc-20160816;
        b=HAvhJmane1lvxlGsWnWiEdg7FO66OLsbk47WDpOxlblS6VvTx9QhcA/mcsqwiInhgt
         4kAZO7xejUMEk0rJttlMACxsUzqVadS5GwZ4dQOuLEC+Y4bd8VdSqcvnxYGgF16pfXvk
         Re8p6lXmZzvEFFoftD6ewmiJyRCvXOjorbhqz49lxfzofOawqqackjNYt5LGvg3vQIul
         Ew6pJj3Q5RrTYTqdUOWGQ/0FI8CK3UhtlAfbzSM+mj/JO6MlWJUidSz7R+NdxUXXNaaF
         /R1asCufU56fwOuskb3eL3AeTiWHhxPX8m2A4TWsB8oBq0kO1Zj9+DAUt3YjdN+zOrF3
         3M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rdtU00V4kLWXQWN/5JB1HiCYLlrSTWq/nr276BwKXmI=;
        b=junHsCBMp8yIef6oJED97CLp8PeF2kyoaGmJPCcViYGg7W+cHXNlQFWLQPKfFRWZZm
         dJ0p2rOb0U0gP5vhKOHbds8JkAHJPQthzY7onLaamIY29Trfj5JvIuJLppSHGM+05dvB
         62CUScWRUnH36fMwcpBw9Sqw1tjacJaWfkHq57d77YmmbG7CdG9Jm1uxU2htzMdsj/jT
         tq0seEADopHdajW0QQVKLWHasvUK27uo75x5AtIGzIubfkzvVoUfGOYADcU9OrM+bTpr
         Nex2aje6RCV9TkZ+QFe+QyhEWZeQi+V7bRMaDKSDRvTE95t60dIUB3gg6V3w4/OkLo8a
         ZXDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LQfHBrcl;
       spf=pass (google.com: domain of kernel-hardening-return-12569-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12569-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LQfHBrcl;
       spf=pass (google.com: domain of kernel-hardening-return-12569-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12569-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKDA=L5E6Cu_oRe-M=ouuhrccCZHyM+z6_UMAUqe9xnRQ@mail.gmail.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
 <5AA464DE.90100@broadcom.com> <CAGXu5jKDA=L5E6Cu_oRe-M=ouuhrccCZHyM+z6_UMAUqe9xnRQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Mar 2018 02:38:45 +0100
Message-ID: <CANiq72=W0=DwZq_SGAHTnbvofPPKUgSOXhJtHDj0CReu5d17hw@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Andreas Christoforou <andreaschristofo@gmail.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594875249662923307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 12:12 AM, Kees Cook <keescook@chromium.org> wrote:
>
> The problem is that it's not a "constant expression", so the compiler
> frontend still yells about it under -Wvla. I would characterize this
> mainly as a fix for "accidental VLA" or "misdetected VLA" or something
> like that. AIUI, there really isn't a functional change here.

C++11's constexpr variables would be nice to have.

Cheers,
Miguel
