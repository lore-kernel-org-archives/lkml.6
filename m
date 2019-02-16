Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255C222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AjNPVpbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfBPJVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:21:04 -0500
Received: from mout.web.de ([212.227.17.12]:47777 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfBPJVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550308843;
        bh=EH+17vM2pzr/NBvHE391GAdAuRQ2TcvnN88Kxz0zv1I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AjNPVpbmK2B/S9OJpHm1izYwHYbQymbcYlWHq6C/t2dQZbQXp+e/Nto6/pklIEBSs
         eCirHqY46sdNM7gF+SsFwArW/y1FcBgx84ggNjc+DHlnIqTpnvBJNxExrfKATLM4EH
         mwH33wEiVede5nLNqggvagus47GSDqX/RccEcKCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.154.45]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0Q4-1gXmYh2dSW-00W1gX; Sat, 16
 Feb 2019 10:20:43 +0100
Subject: Re: [Cocci] [v5] coccinelle: semantic code search for
 missingput_device()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <201902161633004137519@zte.com.cn>
 <alpine.DEB.2.21.1902160934400.3212@hadrien>
 <992b8c6f-614d-b379-6352-30b36ac9d0d8@web.de>
 <20190216090658.lsfhvtllwnzj3675@ninjato>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8ba4643b-496e-597f-32e1-c14b8e46880c@web.de>
Date:   Sat, 16 Feb 2019 10:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190216090658.lsfhvtllwnzj3675@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrzBZBlgopxDKwrstj6Q/rJuw+Clt5b78Ns2ep8cooUWrZLcFAb
 idR0B3LJGBNK5MeRkR6nWReNbMP6gvy/Ib8VO4kJ/GOdCnVDJYnEWzsayH25vO8QwP8JGz0
 K30bzKvSnSFIIj9yc0CVEyp5MlMXmHny2WaPF1Arzb5gQmfbAmqiVjeeS813zzbjA2SUUOr
 ZfnhXO2pZHgFpQDTgmzMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M9DtXFU6SZM=:305za60KRohbnNaigdjF/4
 7j/WsQCtX0TKK2m4VpZVDY2a1bO6dzNMMGAY76og5z31xA3epLf0AXbVVU32PG5Lu1qHmZueS
 igS0sUuZpRvgM7Qzr+EIHqApOy2HSeZ7/s2Ladc67rXPlUUVlaSohiI4B6ULWBWvEgB/Z0Mf/
 jehiGpvJJDr8rRnG960W95Jswh7cWWekGi7v8i+8CgKMkAeSH6pJN/NiGh5hAUL5TTPWEAx0A
 I67OT0QndTCcJ755JdCKaSeSKMC8mROMW4kqbH9qthyeBxB+b/445W0HPD2LkZ0yhBoQRD3BE
 soAwDrpZnMQP0FgiGiml8k7LWPz7x0IemFEA8fRc8n1ga4xZlmUQp0ZOZZj/QCaNYk7WEkn6m
 SADdKW4TQj7yePRLSB6ZI4gH/16yztTganJKpF1gFOFMy9tfNSCfF4L76YyuiIBfHbCHU8ptH
 F/SIvKzGGXwbxS1q5TH9Wthiro0tMInG3ujaWGvVWJV6l/0yjMNTGFaLz2RXsA+H/FWhduJPp
 kpDypqwcG6hMlA80TY3GBjETvYeX0aFxjFLX8NKPnka/SeeOFwZrTtsjI/pVmCo+Ou2NuF4Qg
 vQCANsh40lk+MxVuA1PqlGCqNP2p+efhpV1mMCguPOyZ5wItMkthygJjAbBieuEDeEWOSrZnp
 u8zPljT92uzV//abF2xWbxk9zb3efmhKtHDu1G7Ydrn3WY1b5IADnKRpH2z7XTH4GaYZYkMD4
 N7InrF83KBHiKVHC8iX5sqdAAS68IW4mRMFmMDFkxu4yXkHadnpoBS+LWangCT9x2Dn8KiLtg
 gpe+tqwQsStX3qOmiMBN1rhMOLEW3isWSJ7rONiDYyBF1Er5yUno/p/zLn1cJgL7xPvJk/XZX
 BaLcVIfS9jaGt1KGTn7gyvXP344kMt2jIs2oUkEb7eGYFWRXSMKfFgR2ybZhjnPnOYAbHWGbj
 xfTeYumq3+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> We don't need perfection.
>>
>> I guess that you noticed in the meantime that I dare to propose
>> more software development efforts in such a direction.
>
> Yes, this is noticable.

I am curious then if remaining change suggestions will be picked up
by more software developers and reviewers.


> It is your choice, however, other people may have their reasons
> for other choices...

Yes, of course.


>>> We need more to eliminate the memory leaks.
>
> ... like this one.
>
>> Will this view evolve into further helpful and constructive clarificati=
ons?
>
> Given my above, what is the evaluation of the same question to yourself?

* I hope that my contributions can improve the situation also
  for this software area.

* Existing development tools will evolve further as usual.

Regards,
Markus
