Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518314092; cv=none;
        d=google.com; s=arc-20160816;
        b=use9UAHAHha9SqZ9BiWhE6xu1TpE9Ia6a9vDC53CgF49Ba0s+hOyqCr7X/LLViN29E
         7jOdEmD0psZchKAGrSmvEAXVoxjphsAhHMjJQjUBpZ7Myts8058n7RV1gBTbGas7OEZx
         EvEAnEW9asnAQQi5Jn1LGsnJfcZTLWxRH8nxxpo3TsNOkseQWw2VWwMAlwDgeNnEJA9q
         OTIDzJt8sFlbB8mjj8jxEVU5mPILzrn7NG5CIc1PzL7Iv8Mm3byZBlEr5kMY61BOKvaj
         cTTtu0OpLvUFVnoBsOdVCLxek+J46RjNAhQ5bE1dp99bVvIEsVV8MA3a/viVM/kJ+WiA
         +smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=imnet78Me5JbaOvc0AUP5mChTCXF+fwDvLNVLnpYreE=;
        b=Kjlw7rAielUhycoKEVnZl0LmyZjhZJBeiRrnGWxhIaBXEGgHoA0DudWTdcl7Bq51vH
         MCx/kFnGtJq9QNW3BZj3PZ8dvUqBM6v/1GrRP5fsBTcnOr4jS4ZvpsUb5rJdKzFPr9TX
         mtlNMyV/enTcATmTcM17X0+aH7PXaipHlayvMoGiB+8i6WOyfkikaQf3WcEGZf4fReYt
         /LFYkal23E5dj82evA4gD53cWnLL8VACp6VnPGCxPnrg6MHdEaxa/nbFtmJ5IbSlpz9x
         uvQS/Jq/iXp4csoeNRzLbLmMSPVOZAm0vPY6xfm5MsN5YbvvDRO4pfCTmcvn7l+wwG3C
         lZvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ca53fvbF;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ca53fvbF;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x227pv906uX2wk/2Bj62GlNQJXvzXLMF6vu8VGC7mXZqUx4O6j8TcxGc6eiL5fFdQqFCzq8yfmuQgKkwbqcDRuNM=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcJdYh8fKpqkRXxegRkESaN2Cgxybyei1NVwf_1C7rhwQ@mail.gmail.com>
References: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
 <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com>
 <CAMz4kuKb8g5dAu5WQ847CODtVgJQBa_svbeQGGDsYpCjipBp_g@mail.gmail.com> <CAHp75VcJdYh8fKpqkRXxegRkESaN2Cgxybyei1NVwf_1C7rhwQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Sun, 11 Feb 2018 09:54:51 +0800
Message-ID: <CAMz4kuJjLDGrrHyd2xQ1+ojxjtbVoyX=9OA1sB9K9oVqM7D3xg@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592067717541649859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 9 February 2018 at 23:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 11:23 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 9 February 2018 at 14:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>> On Thu, Feb 8, 2018 at 10:08 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>>>> be triggered by level type.
>>>
>>> How do you stop the interrupt from re-triggering as long as the key
>>> stays pressed?
>>
>> We will set the level type irq handler as handle_level_irq(), in this
>> function, it will mask and ack the irq firstly.
>
> Wouldn't be ambiguous?
>
> 1. User presses the key ->
>   a) we got edge followed by level signaling;
>   b) IRQ core masks line, calls handler, ACKs, unmasks;
>   c) somewhere here Press Event is sent;
>   d) we still have level... We get IRQ fired again? But see 1. It
> obviously not the case.
> 2. User releases the key ->
>   ...
>
> So, the main question if I understood Dmitry correctly is the period
> in time where IRQ line should be masked on one hand, and on the other
> it will guarantee that user didn't release-press cylcle.

Yes, you and Dmitry are right. I realized my problem. When I tested on
Spreadtrum platform, we use Spreadtrum-special EIC (external interrupt
controller) to trigger button events, if we acked the EIC irq, it will
drop the interrupt line and never trigger events until we set irq type
again. But this can not work for general GPIOs like you said.

So I think I need disable the irq until reversing the level type. Thanks.

-- 
Baolin.wang
Best Regards
