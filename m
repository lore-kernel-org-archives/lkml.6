Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9925C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7C1w/n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C6C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeISMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:21:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37703 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeISMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:21:08 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so6365943itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aV1Ozf88ecoVWHYRdfc+TJlDsrWV1uPqcN7yLnvsnYM=;
        b=p7C1w/n6Vvl32ys5JgrlAIR+Z4+un+/SqHyhYA36mM2TX6KejXa3hkoimNQy97cVp3
         /9ccM4d+bPfZ6pAJb6N6say8syrSbh5VW0f/DADJRR5ZrJYfCUwPQwWQ549TiBMzrWvQ
         nQQUEqavJEQFpqAZPDdaByV+QBV4xGqJWHe65Ihvvn78HfP62RLok63bscmh459vW/Ch
         C2VwXljaMi8NrP+8oYzg+EAUnzNiqfGZHTRFtGZjJciPk/9083ZWu9ACM5nBktEak1tA
         iMrsnrGxyT0529qS1XnMoKvMys/suox1PwCR6OPCNJNGJ9Nry9aac0n/xrnfNjgr3d92
         mofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aV1Ozf88ecoVWHYRdfc+TJlDsrWV1uPqcN7yLnvsnYM=;
        b=pvpHTygOg2Lu5Qj9b3hKzfFju8Q/L2YZIGpxXmP1Rrmf+RiHKC3MkYRbyM19K+IpZo
         IhVl6Qnlw1UcRXSXfAzPRXR6UEq9QzH5yxyUWKEvzPWSrJvUnLwIGb9x74eErgzM5LPM
         1b33bVBIEg43LYLNo401y1j7a8W2W+heda8lhMgIfbi2A7aa8o+4LMuEOBnfwtEUZwZL
         ZsX6JfrkSSxcdD9nuMAH4d+76OmdUmURKq/RRcUWqIdR/SJtyV8XzmrMRo7lxoIHC8UI
         I8++5gzh0enXYKzGJR3b6ikTVP96imf79goFgqxSkxjzQr1QkZmylwHHWRcDuzyjRFHd
         RkCw==
X-Gm-Message-State: APzg51ClsY0HUl1a8WcnN5eMd7BsP2HswNjVcEhJtfvyAS/LNXJd2qKx
        U7GLLKgsmVZvIuB2586kWGtLfpBxsCiOLPx7cag=
X-Google-Smtp-Source: ANB0Vdbz3PtUPLx9YXzfqYprbzH0e57nfNk+M2HDWHkB+RDe6F2SnlVmb7r8HV+GNdjp/+w2hvBTsod4ufWsERa/lpg=
X-Received: by 2002:a24:4c90:: with SMTP id a138-v6mr19649152itb.138.1537339480278;
 Tue, 18 Sep 2018 23:44:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9157:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 23:44:39
 -0700 (PDT)
In-Reply-To: <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
References: <20180918230756.26035-1-joel@jms.id.au> <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
From:   Oliver <oohall@gmail.com>
Date:   Wed, 19 Sep 2018 16:44:39 +1000
Message-ID: <CAOSf1CG3bFHNWS8hQVy-VrpfnwjLWBHSrr-c52AMQbsBRqeyZA@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:52 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 19/09/2018 =C3=A0 01:07, Joel Stanley a =C3=A9crit :
>>
>> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
>> polynomial").
>>
>> The cleanup added a dependency on include/linux, which broke the PowerPC
>> boot wrapper/decompresser when KERNEL_XZ is enabled:
>>
>>    BOOTCC  arch/powerpc/boot/decompress.o
>>   In file included from
>> arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>>                   from arch/powerpc/boot/decompress.c:42:
>>   arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>>   linux/crc32poly.h: No such file or directory
>>    #include <linux/crc32poly.h>
>>             ^~~~~~~~~~~~~~~~~~~
>>
>> The powerpc decompressor is a hairy corner of the kernel. Even while
>> building
>> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid
>> including
>> files from include/linux.
>>
>> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> We need to clean up the powerpc boot decompresser but that work will be
>> more involved than we would include in a late -rc. Please consider
>> merging this fix for 4.19. Thanks!
>>
>>   lib/xz/xz_crc32.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
>> index 25a5d87e2e4c..34532d14fd4c 100644
>> --- a/lib/xz/xz_crc32.c
>> +++ b/lib/xz/xz_crc32.c
>> @@ -15,7 +15,6 @@
>>    * but they are bigger and use more memory for the lookup table.
>>    */
>>   -#include <linux/crc32poly.h>
>>   #include "xz_private.h"
>>     /*
>> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>>     XZ_EXTERN void xz_crc32_init(void)
>>   {
>> -       const uint32_t poly =3D CRC32_POLY_LE;
>> +       const uint32_t poly =3D 0xEDB88320;
>
>
> Maybe avoid capital letters ?
>
> What about adding something like the following in xz_private.h instead:
>
> #define CRC32_POLY_LE 0xedb88320

The problem is that it's pulling in linux/crc32poly.h. To support old
systems with a 32bit Open Firmware we boot wrapper we build the boot
wrapper as a 32bit ELF even for a 64 bit kernel. The headers generated
by Kbuild are only valid for the 64bit kernel so we have to avoid
pulling them into the boot wrapper.

> Christophe
>
>>         uint32_t i;
>>         uint32_t j;
>>
>
