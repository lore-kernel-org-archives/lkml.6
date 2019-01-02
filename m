Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B25CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF212171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="SiP/BPXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfABVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:25:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46239 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfABVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:25:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so15693158pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1R9fDNLKzK/DHJVcx+9QWLyfDT+tFplpDcNxwCy2mIQ=;
        b=SiP/BPXNIKXOen9BlTC8DP6NgotfETsnHbO+KMRRXWx3LCOqbo2/ljKfMGPN88k7Be
         mYdWERme9+9lCOwDob8UohqvYnLBvL3LedIX8Xq68VfB+FgitH6PXMsUhP4EGRHlqEm8
         7FqCggkq2Bd4fkifEzWGRYqxDhnQRqrQx+p7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1R9fDNLKzK/DHJVcx+9QWLyfDT+tFplpDcNxwCy2mIQ=;
        b=I3rPV8RhfeTeJeEVuKBCQ4Z1zB0sWsp+tKzDjdWED0agIEdDp7iLw/nqaaRjLvIV1M
         xVYOxuLO9R5EnhDHAnuYejl4Y+peKg6VVc4jcItk+5kdeoH1jZB+YCCZhpG0doz/jaOn
         5t7P8gURTVC5nr0ucQD4eqyqS62jW2Oyt9ymRzDkz7fM2S8Rbom7jJZTRdRB76kdIUwV
         LmYjzKBGNOcJYroY4WkVCobGz6FAtVNzaU4g8kAkOx4VvCQBlvi1UT0nBuzH6E1AkDO+
         zmbkl/P+vPcttVGmVcn5XR5hv+gtAUtauvI07X5ktWTJ/ORT8+TObbRhCOEaYfkOYkSJ
         od+Q==
X-Gm-Message-State: AA+aEWZoMpT9oX4nq+sGI5ZTPw9F1UV50LuNkR/ZiKgcZR71T6PL4LBn
        tK/Iv7gArs8XcWaBZuOWkCY8sA==
X-Google-Smtp-Source: AFSGD/UcYFRvAl7Cq1y4oxgiVVgZ3KtXfr5rw4DgAeayAvwDvM1Vj+eWGvO8pscQUbnyUzq+G4xuhA==
X-Received: by 2002:a62:fc8a:: with SMTP id e132mr45124147pfh.176.1546464329093;
        Wed, 02 Jan 2019 13:25:29 -0800 (PST)
Received: from ?IPv6:2607:fb90:323d:1279:cc3d:efbc:3e13:b6a? ([2607:fb90:323d:1279:cc3d:efbc:3e13:b6a])
        by smtp.gmail.com with ESMTPSA id v190sm76861513pfv.26.2019.01.02.13.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:25:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
From:   Matt Ranostay <matt.ranostay@konsulko.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20181224095823.GA17061@himanshu-Vostro-3559>
Date:   Wed, 2 Jan 2019 13:25:27 -0800
Cc:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E720BF2-7AFC-4FFA-8FA2-5A403FD5DD1D@konsulko.com>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com> <20181224095823.GA17061@himanshu-Vostro-3559>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 24, 2018, at 01:58, Himanshu Jha <himanshujha199640@gmail.com> wrot=
e:
>=20
>> On Fri, Dec 21, 2018 at 03:26:26PM -0800, Amir Mahdi Ghorbanian wrote:
>> Replaced bool in struct with unsigned int bitfield to conserve space and
>> more clearly define size of varibales

Important thing to note is depending on padding, alignment, and position of f=
ield it probably won=E2=80=99t save any space.

Also for internal unpacked structures it really makes little sense to save a=
 few bytes of data. Don=E2=80=99t read into that packed structures are good.=
. they usually aren=E2=80=99t :)

- Matt
>>=20
>> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
>> ---
>=20
> There was some discussion on this at Outreachy list:
> https://groups.google.com/d/msg/outreachy-kernel/xpQAl-Gn8HA/yqcQRG_qBgAJ
>=20
> I think unless you post some statistics about 'conserving' space,=20
> it is unlikely that maintainers will apply it.
>=20
> This idea was originally given by Linus and that thread of discussion=20
> is worth reading too.
>=20
>> drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
>> 1 file changed, 7 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/a=
d7192.h
>> index 7433a43..7d3e62f 100644
>> --- a/drivers/staging/iio/adc/ad7192.h
>> +++ b/drivers/staging/iio/adc/ad7192.h
>> @@ -35,13 +35,13 @@ struct ad7192_platform_data {
>>    u16        vref_mv;
>>    u8        clock_source_sel;
>>    u32        ext_clk_hz;
>> -    bool        refin2_en;
>> -    bool        rej60_en;
>> -    bool        sinc3_en;
>> -    bool        chop_en;
>> -    bool        buf_en;
>> -    bool        unipolar_en;
>> -    bool        burnout_curr_en;
>> +    unsigned int    refin2_en : 1;
>> +    unsigned int    rej60_en : 1;
>> +    unsigned int    sinc3_en : 1;
>> +    unsigned int    chop_en : 1;
>> +    unsigned int    buf_en : 1;
>> +    unsigned int    unipolar_en : 1;
>> +    unsigned int    burnout_curr_en : 1;
>> };
>>=20
>> #endif /* IIO_ADC_AD7192_H_ */
>> --=20
>> 2.7.4
>>=20
>=20
> Goodluck!
>=20
> --=20
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
