Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755124AbeEaNXI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:23:08 -0400
Received: from imap.netup.ru ([77.72.80.14]:42439 "EHLO imap.netup.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754820AbeEaNXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:23:04 -0400
X-DKIM: OpenDKIM Filter v2.6.8 imap.netup.ru 68ECFF86D19
X-Google-Smtp-Source: ADUXVKKy+gnNZYjBK8rT/Cf2gGS58D7NDiS0GLnn+JAbila5yDBHJ5ykwcmAzDUBaO+X9TOc6O0r/1reFgaBoOTNUm8=
MIME-Version: 1.0
In-Reply-To: <004201d3f8bb$629d38c0$27d7aa40$@socionext.com>
References: <20180516084111.28618-1-suzuki.katsuhiro@socionext.com>
 <CAK3bHNW8=z2WH6xCijAP2XCX94iE5z-HwHRYNhbJwZvbOav10A@mail.gmail.com> <004201d3f8bb$629d38c0$27d7aa40$@socionext.com>
From: Abylay Ospan <aospan@netup.ru>
Date: Thu, 31 May 2018 09:22:39 -0400
X-Gmail-Original-Message-ID: <CAK3bHNWTw72sMB-X6ChtakAKi2TmJ6K8ZJZdjMoiMpVqPPBMoA@mail.gmail.com>
Message-ID: <CAK3bHNWTw72sMB-X6ChtakAKi2TmJ6K8ZJZdjMoiMpVqPPBMoA@mail.gmail.com>
Subject: Re: [PATCH] media: helene: fix tuning frequency of satellite
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VDOZFx012369

ok, got it !

2018-05-31 4:43 GMT-04:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> Hello Abylay,
>
> I got a mistake in this patch.
>
> DTV_FREQUENCY for satellite delivery systems, the frequency is in 'kHz' not 'Hz',
> so original code is correct. Sorry for confusing...
>
>
> Regards,
> --
> Katsuhiro Suzuki
>
>
>> -----Original Message-----
>> From: Abylay Ospan <aospan@netup.ru>
>> Sent: Wednesday, May 16, 2018 7:58 PM
>> To: Suzuki, Katsuhiro/鈴木 勝博 <suzuki.katsuhiro@socionext.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>; linux-media
>> <linux-media@vger.kernel.org>; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
>> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] media: helene: fix tuning frequency of satellite
>>
>> True.
>> I'm curious but how did it worked before ...
>> Which hardware (dvb adapter) are you using ?
>>
>> 2018-05-16 4:41 GMT-04:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
>> > This patch fixes tuning frequency of satellite to kHz. That as same
>> > as terrestrial one.
>> >
>> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>> > ---
>> >  drivers/media/dvb-frontends/helene.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/media/dvb-frontends/helene.c
>> b/drivers/media/dvb-frontends/helene.c
>> > index 04033f0c278b..0a4f312c4368 100644
>> > --- a/drivers/media/dvb-frontends/helene.c
>> > +++ b/drivers/media/dvb-frontends/helene.c
>> > @@ -523,7 +523,7 @@ static int helene_set_params_s(struct dvb_frontend *fe)
>> >         enum helene_tv_system_t tv_system;
>> >         struct dtv_frontend_properties *p = &fe->dtv_property_cache;
>> >         struct helene_priv *priv = fe->tuner_priv;
>> > -       int frequencykHz = p->frequency;
>> > +       int frequencykHz = p->frequency / 1000;
>> >         uint32_t frequency4kHz = 0;
>> >         u32 symbol_rate = p->symbol_rate/1000;
>> >
>> > --
>> > 2.17.0
>> >
>>
>>
>>
>> --
>> Abylay Ospan,
>> NetUP Inc.
>> http://www.netup.tv
>
>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
