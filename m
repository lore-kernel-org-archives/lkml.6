Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CBC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D371A208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzyzaU8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D371A208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeHZR1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:27:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43851 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:27:09 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so10719533ioa.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bG1Z2Eu4SyRsfux84w6+MYyRpTfIANjGli25X4CloaU=;
        b=YzyzaU8xpjMjwWLOvrQylbUsuGLvsLmMYDssRnjUJzl8O36HRWjpIVLNFspGsd4LOD
         ghUyGGqX3xJA27P6FjHe2RCbjPENx0HFvqE5yidBr3Gt7UatqI7NoEzuGx69FEDCUaWT
         ENstdZ+ToAok6voJx0z6+eOvEcgtAvdrr0sng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bG1Z2Eu4SyRsfux84w6+MYyRpTfIANjGli25X4CloaU=;
        b=Qkw2nw/DdLUJGm7kNoJhZPKl3Xz30nlOSLikxY3wTJOFjF5/d5Peu+95pa/rXE68Wy
         z7iCYy8lvw8VP9Tyh9VtRCZN8r/7qQuaDihymaa5Wnk5Hdolqy7mb9BvbGplHxOS3b2i
         0rUD3AM++XhPZQQlXbpn3bRTdpToWXCZUnrN2W/yYrWxayrK//0hzuiGfh+jHarF1Jd0
         /0D0uZUuL2Rt0Jchd3R3eynyyKef4/9AtZT2/DdHKOrhVlEO0iONtElPCCVVp4f+9yyt
         5CtaUHEg83IszfL6PVsk4lXBoeJmpY0DYipmnyGCgGQlpGw4NShaRK2mySqPgHo+HF7i
         6ZMQ==
X-Gm-Message-State: APzg51ATC096p3DpmCS57oHnkMhs88ttOy+CY7XWylX5KhD6Gqh4yUTV
        Xw1jL/rltytUpLmSZZCPDN0iJWQh3i3VV91TYvrvAg==
X-Google-Smtp-Source: ANB0VdYNcEcWS7G52dgi9sN3u618/GwFEhK/fIF3UTr3NkwWhRQcVcp7PD4jne/0Ga7HyZsfTGdy9eHvyUy3W1SSrn0=
X-Received: by 2002:a6b:450f:: with SMTP id s15-v6mr7628751ioa.60.1535291072309;
 Sun, 26 Aug 2018 06:44:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 06:44:31
 -0700 (PDT)
In-Reply-To: <yq1h8jh6yrk.fsf@oracle.com>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com> <20180826024006.13800-4-martin.petersen@oracle.com>
 <CAKv+Gu92yj5Cuz36bRS7wz3Lg2srp8OFJC6QVO0UWYSjm8eEeg@mail.gmail.com> <yq1h8jh6yrk.fsf@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 26 Aug 2018 15:44:31 +0200
Message-ID: <CAKv+Gu88A8OmVGV3-9YGkgNKOtCRmN70Ys2WL+F7au=NB4vydQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] block: Integrity profile init function to trigger
 module loads
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        David Darrington <david.darrington@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Furlong <jeff.furlong@wdc.com>,
        linux-block@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 August 2018 at 15:30, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Hi Ard,
>
>>> However, since the dependency for "crc10dif" is already satisfied,
>>> nothing is going to cause the hardware-accelerated kernel modules to
>>> get loaded.
>>
>> This is not true. All accelerated implementations based on SIMD
>> polynomial multiplication are tried to the respective CPU features
>> bits. This applies to x86, power, ARM and arm64.
>>
>> E.g., for x86 you have
>>
>> alias:          cpu:type:x86,ven*fam*mod*:feature:*0081*
>>
>> which will be matched by udev if /sys/devices/system/cpu/modalias
>> contains feature 0081, and so the modules will be loaded automatically
>> at boot.
>
> If I can avoid carrying that init callback in the block integrity code
> that will definitely make me happy. However, loading crct10dif-pclmul
> does not happen automatically for me. crc-t10dif is linked statically
> and every user of the CRC goes through that library. So nothing ever
> requests the "crct10dif" modalias and no accelerator modules are loaded.
>
> <fresh boot>
>
> # lsmod | grep crc
> crc32c_intel           24576  0
> crc_ccitt              16384  1 ipv6
>
> # modinfo crc32c_intel | grep cpu:type
> alias:          cpu:type:x86,ven*fam*mod*:feature:*0094*
>
> # modinfo crct10dif-pclmul | grep cpu:type
> alias:          cpu:type:x86,ven*fam*mod*:feature:*0081*
>
> # egrep -o "0081|0094" /sys/devices/system/cpu/modalias
> 0081
> 0094
>
> # modprobe crct10dif
> # lsmod | grep crc
> crct10dif_pclmul       16384  1
> crc32c_intel           24576  0
> crc_ccitt              16384  1 ipv6
>
> It's interesting that crc32c_intel is loaded but libcrc32c is not. That
> matches your description of how things should work. But crct10dif-pclmul
> isn't loaded and neither is crc32_pclmul:
>
> # modprobe crc32
> # lsmod | grep crc
> crc32_generic          16384  0
> crc32_pclmul           16384  0
> crc32c_intel           24576  0
> crc_ccitt              16384  1 ipv6
>

That is odd. On my Ubuntu system, both crct10dif_pclmul and
crc32_pclmul get loaded automatically.
