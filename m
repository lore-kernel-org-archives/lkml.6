Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524237836; cv=none;
        d=google.com; s=arc-20160816;
        b=B3RlfOG/Gthb4SAUr5fGSmpTgUQxB5Ek+a3BEjHGteo9duNha/whmm7OTHUp1eY0UK
         Uhp2jp+PTBPhbaM44KjqLxJvtZmhy+EuD5xKQBTYpLZGYP+F9yNpaPMpIXzimDtOCmIX
         zJSS7+08OOfkc6T4ZimIdUuFl7tutwpkopYKnWDUIDll0C7LthtIezkQ7d5V6I/oevNE
         +O00ycbdhwOvjjzvVMxcPaIoFd4YDFuDDJMSoyffgKwIqLTejB8ea7Jue4qv2WIftrYg
         UfGK8mOgPlpBjcLuWX3pMWha6G+ovPaqLrPwkKackCj9+ywQ7V5dJuuKoaIU4b9SPKNY
         f81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZJ1dRl7YEPwHxGxtbaATXB1t2n8SK4j+fZcl0OrogbQ=;
        b=MCQdkpThdhkSNS3mu3CAZOo/YdzJwBjwwfasniizFW7WoOZoEyLoCOKg6fl0f90vsz
         A6pcrtVV44WCSDYIBMb8ojB4HTidq7hAj39q8/HYqwJ/W+FHG1rnKHG7U3vDv+TprsJu
         yQMYLf4JY89ytzqulHS9TLrCMPfywc4WVRfC6wzrKqFw1JiA9io+XlYtJN08TfjNqpBi
         FMep+OrlGxjml4sotZdL+tfYYfuRkr9eQptloBgMCqChe4q9952YnlwcAECjyEdnklr/
         KNvnjjkhkN7E6EhOHRS+5+sjTsZ6UfCLI4WffACduUpUCzF+mIooC6GACX7RwkqWldW4
         xlig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eR+FcmFc;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eR+FcmFc;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4/Y+OoYVB7XVxsyThxiiK+tsTa/1bsYmoLQlkV63zV1QGHjnQoiZK/jYkmY15BlXaR0ZX4Q8xdf8hfKhNz5j2s=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <4914b33abd8969906d2db0ae5c3da4f205f0bfe9.1524120572.git.baolin.wang@linaro.org>
References: <4914b33abd8969906d2db0ae5c3da4f205f0bfe9.1524120572.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 17:23:55 +0200
X-Google-Sender-Auth: aaGFrCfWRvznszzBvCqD9Hhrwi8
Message-ID: <CAK8P3a0PWLG4XZEMU2XoYiKirdq1nnkOVTLyr=S59cxvNvHuTw@mail.gmail.com>
Subject: Re: [PATCH] parisc: time: Convert read_persistent_clock() to read_persistent_clock64()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	gregkh <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Parisc List <linux-parisc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598156395055112064?=
X-GMAIL-MSGID: =?utf-8?q?1598279213874015685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 8:51 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The read_persistent_clock() uses a timespec, which is not year 2038 safe
> on 32bit systems. On parisc architecture, we have implemented generic RTC
> drivers that can be used to compensate the system suspend time, but the
> RTC time can not represent the nanosecond resolution, so this patch just
> converts to read_persistent_clock64() with timespec64.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

I have created the exact same patch a while ago but never submitted that.

If the parisc maintainers want to apply yours with my Ack, that
would be appreciated.

Acked-by: Arnd Bergmann <arnd@arndb.de>
