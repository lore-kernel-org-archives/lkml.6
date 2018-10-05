Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C91C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cfLl43/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BD92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeJEUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:04:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJEUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so695599pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kmNpzrPUwSJEcrF2MnaX0RUNEoh+3w1XDK35HodlZJ8=;
        b=cfLl43/iORKobz/NffaO7PBhTxQuegVdT+moQw2dCaKHjVBhLmMKG2CKdmjHmpBziL
         AUnnoX1tt5CijIdi5Ht8OFgV8BisPH7sqa0FTcSH+TgU5sHTMPlZ4L6qcha4QdinFIse
         7F8pm5X5Lrx6krWaDnO3CTpVDpvuan+7iaXqH4PIn/CYoqNMTvFbTjY9D9feMWD4hMB1
         rUpBrEQMjd36qQ2zIDSvT/a2+xGoZp3mvynw994zg3DnQCXS3cE2Ju9xuayV/EtyaBAy
         Y8FUuye0fXQU1dpqZg1KtLrM7NwlyuawwfMaUY8fxLri4iye3LYWCumEv8hgSI9/dmDc
         akfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kmNpzrPUwSJEcrF2MnaX0RUNEoh+3w1XDK35HodlZJ8=;
        b=g9nU/tGcp8n+kGsGNlOUfY63UJTJuHiEuvGx3olrzTuT4jL7Ncu39cqqAQzbzujqow
         gWycX2XbCPkesNXBLtJxQIqFyYYUrVeFHCH0qj7PxReuBPBV66GkY2dBXXH01QDfXGdx
         kx4YHrG7Bv5pdTdczxXyY6f/cvm/LZvrdFxSgRS9JxTAbNQSDPQCzV3IoisHYEhcl2+P
         iqfyMtHA40N3blIzdIkAoeyHv4/CjFju7GJ0nvemKNw+Lz1gsiUUI4PxiZ3oojB3hBvP
         YUBeV0PVgFHZqpuNSgbJBHYDj/CeXUcSYNd5Jv8bcGRhjoeZbAoWyyplPUqV6kgp9ykS
         tu8w==
X-Gm-Message-State: ABuFfojoQjU+pom8lxCIUmZV7qBgwESo2ST4PPmXgkooeG29Nq0FfTHN
        Raq/jgQTb3mjSjIbD8BsYJ/IWSqlJek=
X-Google-Smtp-Source: ACcGV61d5yR7x3VlYXyCUkkg0kE0I2GBusBr1lP/Uz2idt+1tQ1HoekYcCs4OZxSe2FjVAIS4Eoj/w==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr12059229pfc.240.1538744721729;
        Fri, 05 Oct 2018 06:05:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d01e:eb5d:f949:e221? ([2601:646:c200:7429:d01e:eb5d:f949:e221])
        by smtp.gmail.com with ESMTPSA id n17-v6sm13340882pfj.84.2018.10.05.06.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:05:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] x86/vdso: Rearrange do_hres() to improve code generation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <alpine.DEB.2.21.1810050758370.2876@nanos.tec.linutronix.de>
Date:   Fri, 5 Oct 2018 06:05:19 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CF548E6-37EC-450D-A670-7826BC9F7F08@amacapital.net>
References: <cover.1538689401.git.luto@kernel.org> <99e93a6be59916959ad259482f4cf347e8af9bac.1538689401.git.luto@kernel.org> <alpine.DEB.2.21.1810050758370.2876@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2018, at 11:00 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Thu, 4 Oct 2018, Andy Lutomirski wrote:
>> index 18c8a78d1ec9..419de7552c2f 100644
>> --- a/arch/x86/entry/vdso/vclock_gettime.c
>> +++ b/arch/x86/entry/vdso/vclock_gettime.c
>> @@ -147,10 +147,9 @@ notrace static int do_hres(clockid_t clk, struct tim=
espec *ts)
>>=20
>>    do {
>>        seq =3D gtod_read_begin(gtod);
>> -        ts->tv_sec =3D base->sec;
>> +        cycles =3D vgetcyc(gtod->vclock_mode);
>>        ns =3D base->nsec;
>>        last =3D gtod->cycle_last;
>> -        cycles =3D vgetcyc(gtod->vclock_mode);
>>        if (unlikely((s64)cycles < 0))
>>            return vdso_fallback_gettime(clk, ts);
>>        if (cycles > last)
>> @@ -158,7 +157,7 @@ notrace static int do_hres(clockid_t clk, struct time=
spec *ts)
>>        ns >>=3D gtod->shift;
>>    } while (unlikely(gtod_read_retry(gtod, seq)));
>>=20
>> -    ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>> +    ts->tv_sec =3D base->sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns)=
;
>=20
> You cannot access base->sec outside of the seqcount protected region. It
> might have been incremented by now and you'll get a time jump by a full
> second.

Duh. Let me try this again.

>=20
> Thanks,
>=20
>    tglx
>=20
>=20
