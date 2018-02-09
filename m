Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518188635; cv=none;
        d=google.com; s=arc-20160816;
        b=LP00TYjMJr61wlzyOI9YHxk/BWYkD32MVPXPaNbbyV09zgjWY+a13CHBEM6lu+w219
         HuO23zLkpScBGtGZpPNNlWL+fa614SkYS5IFeht1hGQV25PMEmRgbnLn4c9aLaCPpL9u
         Ba4uPb4XIkRk+2+goI/KSvnd/IIgsfnoF6I8dYBp8Q1YpOVxBFJkSVlZOV+QdE7aDIyF
         LFtZ5Q68fw4VD9LdrUKTFe0I+mguGLgOyoJdfMAN+9iHp3qjlIXawoRe1AlDiq03A9NO
         KaZKBKilBTGwGs4fPfBhuA/tNDyeYueqqJMPwOahFUmaIHsL4o2hoOefZF10HQqOCU7L
         gpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ysRx6sK941MISEW19RNANLKTUh28TEmCSo/sBE3n+MM=;
        b=E8kcSnPMhyAfYMuO3KHE2nIlFmNqR2ZPpbKHzy/9/KhZa58PZJyzNOMvLVOsFASY5h
         minuaT4cR66tYLZdZqNIfbh1/qrH947lMMhkmRlBh/AokinFcFHVY6+yQftpvIJwFaNC
         0DtYvwzLnLTuXIiGwJpJszHzj2Lo+Nix60S9w9ndAYEUpbd69E0KtgbakcJCdvCs2nz5
         z3BWUSa34QcgYK6eRljTsXiVMKqY/00YRdKM7B8roabaybb6YgBadBnK7Stl74bX5l9H
         KkJ6YsjPvCLlqzhfM+QxWwAnGR/C5q4E4nczbe1NbMqL6YIn3Z7fZEm01O0aE+h8TNep
         tyiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yzoh5g6c;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yzoh5g6c;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224x/Rpfoi3bB0Wq63uXBuFdDva/Ahbbf3vGr6N4HVMgnUR9tCzAZcFbBUH50f7yvHQUzjL4rLhBFjojytR32Ao=
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKb8g5dAu5WQ847CODtVgJQBa_svbeQGGDsYpCjipBp_g@mail.gmail.com>
References: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
 <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com> <CAMz4kuKb8g5dAu5WQ847CODtVgJQBa_svbeQGGDsYpCjipBp_g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 17:03:54 +0200
Message-ID: <CAHp75VcJdYh8fKpqkRXxegRkESaN2Cgxybyei1NVwf_1C7rhwQ@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1591936166629840017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:23 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On 9 February 2018 at 14:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Feb 8, 2018 at 10:08 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>>> be triggered by level type.
>>
>> How do you stop the interrupt from re-triggering as long as the key
>> stays pressed?
>
> We will set the level type irq handler as handle_level_irq(), in this
> function, it will mask and ack the irq firstly.

Wouldn't be ambiguous?

1. User presses the key ->
  a) we got edge followed by level signaling;
  b) IRQ core masks line, calls handler, ACKs, unmasks;
  c) somewhere here Press Event is sent;
  d) we still have level... We get IRQ fired again? But see 1. It
obviously not the case.
2. User releases the key ->
  ...

So, the main question if I understood Dmitry correctly is the period
in time where IRQ line should be masked on one hand, and on the other
it will guarantee that user didn't release-press cylcle.

-- 
With Best Regards,
Andy Shevchenko
