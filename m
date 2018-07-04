Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63024192
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF63024192
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGDSx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:53:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54355 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeGDSxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:53:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so7454784wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QG758jTUdna2y/Dc60U0ORm+BXPiJr98QRR7Z9IOGkw=;
        b=lfywd+7xeymPXI2jaxcBMuC39C9arVZfSKyJ1ZXMpz6+AG1U9pVNEzULwhqesWMM7J
         pIFeeBmOEKfCfw2SVOtUUEoDV03LXBGG6ouXwzLdG6pKsh47y5gxT2oQjUoVmdrmG6u7
         Dsbzu4clVaxOKYPfh/U1AsXe2fsONWVyjfQGn1Y1Qqvyt6pJyLP0KAOYcfvJil8bNiSh
         X5fBRG4gbWZxYeVtbM3rqFD8dBbfuY7YKK8RO3p6wVVUFMh1bYmD+OMmzNWYZG+0Bb/j
         KeXxm3TkkQfjZarZUefSSw/2FIGY+v9jyLghJvQM9B/VxODBB35xTbqzjYlTYYnDhM3J
         d2FA==
X-Gm-Message-State: APt69E3xrjt6CzZKBsn5oiS4w8FadC94EpKRlaFF4LX7q+KnT6Iu4gdv
        Worh7NmryrdZRmBaMjWsnHQqog7k7jE=
X-Google-Smtp-Source: AAOMgpdB7gTwicGB0+p4ZSL0jZ4dhp56dsBtrPbvy3x1SW4W+8ho3o80AhWqa2jtTA1/Up4B7kMfhQ==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr2469757wrd.272.1530730434005;
        Wed, 04 Jul 2018 11:53:54 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id 125-v6sm8407485wmw.9.2018.07.04.11.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 11:53:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
 <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
 <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com>
 <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
 <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
 <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
 <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
 <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
 <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <77df915c-c80e-be5b-3c02-f3a543992783@redhat.com>
Date:   Wed, 4 Jul 2018 20:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeNAfKF6C1RuMJgHMLDSBFH7=X9YJSzsueM7soMYSKung@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 07/04/2018 06:11 PM, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 4:44 PM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 07/04/2018 03:24 PM, Nikolaus Voss wrote:
> 
>>> I hope you're still not annoyed...
>> Don't worry for that, it's very hard to get my annoyed :)
> 
> Javier, thanks for your patience and nice explanation!
> 

You are welcome. I'm glad you found it useful!

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
