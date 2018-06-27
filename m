Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BDAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19A5256E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTbbuih2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19A5256E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965484AbeF0Rx4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:53:56 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34482 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0Rxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:53:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so1833262uao.1;
        Wed, 27 Jun 2018 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JQSAHiz3vgWm5u0WtmxgZsiEbgd+Ag7HGqtiMnG7AbE=;
        b=QTbbuih2T6ARZq2qO3YT0Vf5c+FiU5Lo7ZvG2WkTkHHlOOVCARCvUrJUZCHh5uCGQK
         sfoYXkHPXJa1mEyCAjBKcbpHZ3SBlO/9f0oEqfrxV/Zl+Opo/hET6767bmVKuV2nRtd+
         VnUP73QI47iRRO3z6C239miAW4b5t7IAJRtktk7MvDaWY3fVEjyA0ZhuSFlahcZuoujK
         VrBaShWUtWQbfhI5cKIHbP++iD99OKD9WyjTvzywNQ6u8z+O8gGRjn73WUYvaEkojg9w
         /EE+4oOxkLGfRty7lBMxCLlSPGemvCdG+BjsII0jNb38vSZS8/W4gdyL+1rrBkDQtsaL
         iK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JQSAHiz3vgWm5u0WtmxgZsiEbgd+Ag7HGqtiMnG7AbE=;
        b=Io0BQ+tjb99955MqwXzDMxLazdGKqZxKsFOre25MlMJfJzF+oY8RSfr4EhgMwc28Zi
         ZGpj0t81VercK9p9YXGGWP2SHwlbnlouwhJ3DgI2Fynu24nHUnlNcEWy33uoHtHLNi2/
         8B5w+4TvFskLQ5MKHDYEMq0LoavubvjpXKqrcAlGumdG9OXwGUIqsLAnjckNHTjDFCCQ
         rRkGbrH8yCdf7Yej2P0EyxHALKFYQqONRyoAKLxBSmPgtloeuWmLSun9EzoOz+CfuHJb
         sEgCYQ2K/dZ1wB83RBAFRlMrKe+sHXe+82erS/FfoquSKa7pKNzkPMrrDieoBJNeSd0u
         0SKA==
X-Gm-Message-State: APt69E03EuZRrwSBuRuXhD4GijWa3mRX0mJzjIAawgquMT2ECj8Z3QBz
        l5sMU5TWiJl1vr/Nzf2PxD7TgqEo5hw8PAKkqjk=
X-Google-Smtp-Source: AAOMgpdrhUt1CzHg+BFrHs8ks+MU4Vp1P9edFTNAY47JWXQkw3QzgIPEq7+zbLwm2QcIroV4H8gRMFo2N2buc1sNWoI=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr4361511uae.199.1530122031864;
 Wed, 27 Jun 2018 10:53:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:53:51
 -0700 (PDT)
In-Reply-To: <20180626234638.076fb816@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon> <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
 <20180626234638.076fb816@bbrezillon>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 20:53:51 +0300
Message-ID: <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:46 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 26 Jun 2018 23:44:36 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Tue, 26 Jun 2018 22:07:03 +0300
>> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> >> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
>> >> <boris.brezillon@bootlin.com> wrote:

>> > I'll say it here because this is not the first time I'm pissed off by
>> > one of your review.
>>
>> Like 'I like offending people, because I think people who get offended
>> should be offended.' ?
>> I'm not that guy, relax.
>
> I'm not offended, just annoyed, and not because I have things to change
> in my patchset (I'm used to that and that's something I comply with
> most of the time), but because the only reviews I had from you were of
> this kind (nitpicking on minor stuff).

OK, point taken.

>> > and most of the time your reviews are superficial (focused on tiny
>> > details or coding style issues). Don't you have better things to do?
>>
>> If your code is written using ancient style and / or API it's not good
>> to start with.
>> Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?
>
> Come on!
>
> - kzalloc() vs kmalloc_array()
> - for (i = 0; i < n, i++) { if (BIT(x) & var) ... }
>   vs
>   for_each_bit_set() (which is not even applicable here because I'm
>   not manipulating an unsigned long)
>
> Where do you see ancient style APIs here?

Both. kmalloc_array() and for_each_set_bit() were introduced quite
long time ago.

On top of that you are open coding, if I'm not mistaken, cpu_to_be32()
and be32_to_cpu().
...and more I believe.

> And that's not even the problem. I'm okay to fix those things, but you
> only ever do these kind of reviews, and sometime you even act like you
> know better than the developer or the maintainer how the code should be
> organized without even digging enough to have a clue (your comment on
> the fact that mask should not be a pointer is a good example of such
> situations).

"sometime". Yes, I admit my mistakes.

>> On top of that you might find more interesting reviews where I pointed
>> out to a memory leak or other nasty stuff. But of course you prefer
>> not to norice that.
>
> Yes, sometime you have valid point, but it gets lost in all the noise.

Btw, you forgot to call of_node_put() on error path in one case. Did I
again missed the details?

>> > I mean, I'm fine when I get such comments from people that also do
>> > useful comments, but yours are most of the time useless and sometime
>> > even wrong because you didn't time to look at the code in details.
>>
>> Calm down, please.
>
> Why? Because I say you didn't look at the code in details? Isn't it
> true? Did you look at what I3C is, how it works or how the I3C framework
> is architectured? Because that's the kind of reviews I'd love to have on
> this series.

You got me.
I have a copy of the spec, this require a bit of time to go through.

For now I can offer you to consider IBI implementation using IRQ chip framework.
It would give few advantages (like we do this for GPIO), such as IRQ
statistics or wake up capabilities.

>> You would simple ignore them. Your choice.
>
> That's not my point. My point is, maybe you should do less reviews but
> spend more time on each of them

Good point.

> so you don't just scratch the surface
> with comments I could get from a tool like checkpatch.

Perhaps you should run checkpatch yourself then?

-- 
With Best Regards,
Andy Shevchenko
