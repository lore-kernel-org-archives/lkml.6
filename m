Return-Path: <kernel-hardening-return-12952-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/LH7mGJMNGgkwI5BQ2YkMRi5VKEdMY7alih1att66kSseAqewdHuzUMFvf8zzp8oHN0VAU
ARC-Seal: i=1; a=rsa-sha256; t=1523347754; cv=none;
        d=google.com; s=arc-20160816;
        b=qcfsOj/+Tq/z4ZJPgkmsnpM2GCwDWw1pNmSPBy/5zIZ4gROp4MSwikVzIbhQPypS1a
         n843DSvpd9zVqCD6XhGYPegx1H7jQOFDouwUFfqxfvfFKhpsFQZrjWzm4AmJUjpAurk8
         gcAKEjITeqPAb+/syFjgFMUluS3znNOIHNw/t+hUZ+/nrTXLqlLewIPlv8FOWo++UPHP
         p11gNXv7rTLcX4j0XrrTYHAmvsNvCuBoqMovTDX2+VlR1BG3RHlprZVMNtY6eQ67wnoR
         1GAWi8CV5fTA7Ly2zt2WeHV2Lq4Fkonc9v9A0TDsGfY4/CB0vb4XgG4bWxOzVcazWXmq
         vfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=2f5rHh0E/Rlu479F6N6wLZP/WfJxeUAtyKXCnNq9Hao=;
        b=S6VTDl3lIpl56EPAFiJ9gxmWCFpPdjvTLqV15cRnbRMYN1e+uFsjJtOt9LSQgNLRrk
         QQcX+kF94PSaaVFqrykpN59tr/9+mYJolBzirCNndQDz3sfmjIwoIiuXcg3g7jmlZkid
         xxK/zBaXO/2csjIHQRSTBKfvAE1VbtyorR9iC60DxzRTwD3YUQ3uVmN+UJi9kFqJkCJz
         oRiQN6WS24guv5uX7vnpYdLkE4GNccOYGwHpkrRZIVM2O9MWmsCah0d+pxyoFbNXbzsu
         5zjSqPJOxWI7TmGgE9+CEeKj7uAeeS5D7MRJlsQXVyk5hJ+9wZYiRJBUUoAMCkxgbCDG
         w7tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eJBwdRCM;
       spf=pass (google.com: domain of kernel-hardening-return-12952-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12952-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eJBwdRCM;
       spf=pass (google.com: domain of kernel-hardening-return-12952-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12952-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180409210717.3852-1-labbott@redhat.com>
References: <20180409210717.3852-1-labbott@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Apr 2018 10:08:56 +0200
X-Google-Sender-Auth: 9xpVFHFS5qHOtuIypTyVsjweHy4
Message-ID: <CAMuHMdVnXc+SrUEteb-v4Kb9FtXJcaWmdK63-oTK0f2KxBThsQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: xra1403: Switch to a fixed upper bound for registers
To: Laura Abbott <labbott@redhat.com>
Cc: Nandor Han <nandor.han@ge.com>, Kees Cook <keescook@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304277503728499?=
X-GMAIL-MSGID: =?utf-8?q?1597345894866193714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

On Mon, Apr 9, 2018 at 11:07 PM, Laura Abbott <labbott@redhat.com> wrote:
> Geert Uytterhoeven pointed out that the number of register was a
> fixed upper bound so there's no need to use a dynamically allocated
> array in place of a VLA. Use the defined upper bound.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
