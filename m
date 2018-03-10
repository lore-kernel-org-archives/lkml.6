Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520706742; cv=none;
        d=google.com; s=arc-20160816;
        b=KdyFsJ99JrwwfXqp6apYH3CxNCXsVmfGvBqbmeXNKdGcZnjmlbB4LyjoINiClxwGlF
         Cr7Q7ZD38ucqvcsvEHnKTllpz+At4ZuderXjknEyfndO8x8fAN+Os4MdP1UHMeaYVFk1
         cfu8ZSfepR7s/AsfDq7UzQJUMFP4DzaCKkp1h/mph47BxLGNOV4/lyUtwbMuznDh/M+n
         nTJuE+HZRX9DsOD3Hx4SwjoB/OhkKokkLkI+LZQtW0BlOF4YfiKyMiEaq00klSugxIWh
         6QA48nV7Zlb6COUiFZQmmKwwcncTL73cSVqfQ03Duao8FgEsp77Xt+UrRg7cWOzOVe3B
         ItBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=R8FBQr2wCOhhu1GVhovejOhyMXM66VFH4uJo/Bm48Og=;
        b=R/goo5dr6GkVUIvmyRADuyEROp+RqJ7/GnVMP7lSmPhxIwctc69HJ1X3/pDAM8dqNj
         lNKO7ZTiqsLAdWYOzckkBvklx9jUcVcUy7AXhPxpOLfvQxq0tuhbLP9zX+W1JWTuco+P
         8aSKbgd9gpNmnSNrmdUti+FKdLZAA2i6YeqAouxDdH/XdXOVuicJmB9ut+iFzGRAgrMN
         7Tw8d0fmyUFVoWH+f5QAzcEk5ESNVuKRNvMhikJwDQFJaIo39saAEBx40Cp5B3fokBj3
         6QjWauW+VfPCZkWUsgKfSfGNUrqd1aEIiHZKJbIUvXAfhBQFdw4yAnttwJCFmmmzWeDU
         MERg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g9mqvIGi;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g9mqvIGi;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuQOFe0G2LA4QSceIfxjPi27Oni0wcPsJSYxxoymE/8dqNlnOKPDaDDLbwjqnopNuUgUdBBOrXTyJH4gcqmB4E=
MIME-Version: 1.0
In-Reply-To: <20180310181509.GB260013@dtor-ws>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com> <20180310181509.GB260013@dtor-ws>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Mar 2018 20:32:20 +0200
Message-ID: <CAHp75VfOUSd0WquVjpkyxqmcmm2XUshAy0b+2fC0uO=S-+ZudQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event action
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@google.com>,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	Dmitry Torokhov <dtor@google.com>, Douglas Anderson <dianders@google.com>,
	devicetree <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input <linux-input@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594576592646077030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 8:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> +       while (--i >= 0) {

Just in case

while (i--) {

is slightly better to read.

> +               bdata = &ddata->data[i];
> +               if (bdata->button->wakeup)
> +                       gpio_keys_button_disable_wakeup(bdata);
> +               bdata->suspended = false;
> +       }

-- 
With Best Regards,
Andy Shevchenko
