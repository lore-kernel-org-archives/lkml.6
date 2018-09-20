Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA95ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D422150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ex2JSk+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D422150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeITVpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:45:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40609 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeITVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:45:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so4639602pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ODB4YhYAlxF9IdUC/cpQTQpHH585NORYuHoXcvqB5iA=;
        b=ex2JSk+qgrnfhhFZFiuc1VjksHvB3Cn5Xz8U033W1GQH7sLr/JwqITHbJTjpemUsUf
         k1vLNOws13HzrwkhpxyDpBaBEk2y2gVpnx6dCVQATztifcfyshmfeWEQIIVY6b8NhZsc
         R0A4wjt6RLC1nnMXAuPUhXRnwnBM7YW7fOvJCFBIzpQIEGWNirA0NIiCwfKkOKsqEM2N
         KfIQ3eqRCamhsgLhVFnjQF4kpab/zL4bgPXbRAZO1gr+mT9qsLAygU1Iw/1GUs38+Zkn
         tXPKDV6UWkYGGsgNE+U6irTD9l3Pd51761dYHGPHV50bKMbdVXibL4QoVel0iqjowihr
         SnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ODB4YhYAlxF9IdUC/cpQTQpHH585NORYuHoXcvqB5iA=;
        b=iEMWmQFmF7huWIXs4e16K9OwmsEhW1gtn6+GaF6ciGcSZqPa9q2i46nnZo6bYqK1TZ
         pbrT6Y+dIYMdKh5GA9UxFZ/of3/vZhhtz022RTI4Jlm32cT765Ak4W7VdloPyI9dMUMS
         KPbKVjInx4XazF3s7Wh+OjWNCXJcrUYq2FVsty8uIyLaFg0nPdx5UYC3Nkj3PODbnSmM
         SVpv2U8TkmOvpazPlIZrPIk68MbPoX+EqA4nKqzeAnG4+mm7/YjSbyvS06oUxLWdHQoV
         2P3FQYd5tORfbg2tbO8lxfa/75gaT6AUXZDPzojx7/TfLE6fq6sMpL+GqCPqK2VKOU7t
         ZwuQ==
X-Gm-Message-State: APzg51C4P54J3lgSktOiGzHQQ9XrH36dqr6zYUkDS4IrOqlvbF2248g+
        hU15GDtmdXhyotz+r/+Te7wuAw==
X-Google-Smtp-Source: ANB0VdZ28oqBXJl+qT/Z7++CeVx/j0lfit3ZYxSf1sLzmeWTVCOsnS5oRLcq0HkZUNqYgTSn5zFMFw==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr42563390pfj.9.1537459298126;
        Thu, 20 Sep 2018 09:01:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a59f:b13a:b56d:725f? ([2601:646:c200:7429:a59f:b13a:b56d:725f])
        by smtp.gmail.com with ESMTPSA id f62-v6sm34654312pfg.74.2018.09.20.09.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:01:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
Date:   Thu, 20 Sep 2018 09:01:36 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <043F588D-4F40-49AB-9F19-1C6180F0393E@amacapital.net>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com> <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 20, 2018, at 8:41 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> (+ Arnd, Eric)
>=20
> On 18 September 2018 at 09:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:=

> ...
>=20
>> diff --git a/lib/zinc/Makefile b/lib/zinc/Makefile
>> new file mode 100644
>> index 000000000000..83dfd63988c0
>> --- /dev/null
>> +++ b/lib/zinc/Makefile
>> @@ -0,0 +1,4 @@
>=20
> Apologies for not spotting these before:
>=20
>> +ccflags-y :=3D -O3
>=20
> -O3 optimization has been problematic in the past, at least on x86 but
> I think on other architectures as well. Please stick with -O2.
>=20
>> +ccflags-y +=3D -Wframe-larger-than=3D$(if (CONFIG_KASAN),16384,8192)
>=20
> There is no way we can support code in the kernel with that kind of
> stack space requirements. I will let Arnd comment on what we typically
> allow, since he deals with such issues on a regular basis.

To make matters worse, KASAN is incompatible with VMAP_STACK right now, and K=
ASAN is not so good at detecting stack overflow.

>=20
>> +ccflags-y +=3D -D'pr_fmt(fmt)=3D"zinc: " fmt'
>> +ccflags-$(CONFIG_ZINC_DEBUG) +=3D -DDEBUG
>> --
>> 2.19.0
>>=20
