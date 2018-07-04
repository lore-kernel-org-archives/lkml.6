Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6FC2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6FC2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDNYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:24:10 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:45472 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeGDNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:24:08 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id C46D941C87; Wed,  4 Jul 2018 15:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id C153841C41;
        Wed,  4 Jul 2018 15:24:03 +0200 (CEST)
Date:   Wed, 4 Jul 2018 15:24:03 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Javier Martinez Canillas <javier@dowhile0.org>
cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
In-Reply-To: <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com> <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com> <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local> <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com> <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
 <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com> <alpine.DEB.2.20.1807041420160.9872@fox.voss.local> <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
> On Wed, Jul 4, 2018 at 2:31 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>>>
>>> On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>
>>
>> [snip]
>>
>>> But this discussion isn't really related to your patch. I think is
>>> correct but just said that (b) wasn't a justification to leave the I2C
>>> table, points (a) and (c) are though. I won't really be convinced that
>>> the fallback is the correct thing to do or even a good idea.
>>
>>
>> I didn't want to annoy you, I just wanted to understand why you think
>> fallback is such a bad thing that you call it a bug. And I see, it has its
>> drawbacks ;-). Anyway, thanks for taking the time to clarify this,
>>
>
> Oh, I'm not annoyed, sorry if I sounded that way. What I tried to say
> is that I've a strong opinion on this and won't be convinced otherwise
> :)
>
> So for me is a bug because that would mean that either an entry is
> missing in an OF device table or a DTS has a node with a compatible
> string without a vendor prefix.

Yes, I see your point (and your strong opinion :-)), but AFAIK vendor 
prefix is not mandatory... At least for vendor-agnostic drivers like 
"regulator-fixed" (very popular in dts files). My point is not bloating 
drivers with large redundant (from a driver-functional view) tables when 
one table could be enough for a properly working driver. Having three 
different names for exactly the same isn't very beautiful IMO.

I hope you're still not annoyed...

Niko
