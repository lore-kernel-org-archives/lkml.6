Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9EFC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335A21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sUI5oNxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A335A21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeHNFcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:32:33 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43938 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeHNFcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:32:32 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7E2lQHJ022372;
        Tue, 14 Aug 2018 11:47:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7E2lQHJ022372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534214847;
        bh=UVwSNJrYBSPE17Cbuoekxk0q2h8WBPBrNFSCVglw7pI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sUI5oNxoaBrcwvefxeWZxO74wzP0Q3DGipo33UVD0tAsW45jB+Cge+7Q6QDgp3riS
         RSX97BxKU0lcAXNphfa59J8wSixs8+P4nxnpxW768LVXEMhBCnMvnxtoreNTrdDK28
         HignGeJ1N1J1Mu+FWTzdsNIQqeFWy+VIrs/xZfn5xAOvM7Oh56MGhX1dhFuaQLMYyq
         qi7zLQ2GI70foFjuScFOU4nGpWw+i3DGS3DiLpEEnCK4x0P0MJbpY+fiNgsY0A4y9W
         1OAZYhimKqWIg3wKzM1jX3uflxmese+8LWsREVcgsUpi6fwUE8doRggEEeonlZ/Acm
         9Kq+scfoaWHUg==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id h1-v6so11558099uao.8;
        Mon, 13 Aug 2018 19:47:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlEPxApSfqCpzl0BeaipAHEoNv8+Vl5b43Dtt+ZdaVpnT6p0AGgp
        0OH9T+XGeUFlRczS1k9yxTgaooeTyfh80Bfcy6Y=
X-Google-Smtp-Source: AA+uWPyMPoXOg67vk1pSd2nHo5WHHcCgz34oK09XpyxvE1/m0gqFGUZdQUR0nfe9wV4uU3MUbuvzIe6S+7/DGV8ii84=
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr12915383vka.42.1534214845942;
 Mon, 13 Aug 2018 19:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:46:45
 -0700 (PDT)
In-Reply-To: <CAGXu5jLMr1+M7Xnt5HFi73fkhgh2YEwJyaPrFb0tQ2i8T0-i-Q@mail.gmail.com>
References: <20180813101435.17016-1-arekm@maven.pl> <CAGXu5jLMr1+M7Xnt5HFi73fkhgh2YEwJyaPrFb0tQ2i8T0-i-Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 11:46:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzA_X90g0if98U5jRrzGGYQkiqgN1+T9z84WWgDMi9Cg@mail.gmail.com>
Message-ID: <CAK7LNARzA_X90g0if98U5jRrzGGYQkiqgN1+T9z84WWgDMi9Cg@mail.gmail.com>
Subject: Re: [PATCH] Support mksh as /bin/sh.
To:     Kees Cook <keescook@chromium.org>, arekm@maven.pl
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 7:32 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Aug 13, 2018 at 3:14 AM,  <arekm@maven.pl> wrote:
>> From: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>
>>
>> mksh needs space between ! and ( to work properly. Otherwise this
>> happens:
>>
>> + make oldconfig
>> scripts/kconfig/conf  --oldconfig Kconfig
>> ./scripts/clang-version.sh[18]: COPYING: not found
>> printf: =E2=80=98__clang_major__=E2=80=99: expected a numeric value
>> printf: =E2=80=98__clang_minor__=E2=80=99: expected a numeric value
>> printf: =E2=80=98__clang_patchlevel__=E2=80=99: expected a numeric value
>> init/Kconfig:24:warning: 'CLANG_VERSION': number is invalid
>>
>> Signed-off-by: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>

I could not find this patch in ML.


Arkadiusz,

Please resend this patch to

linux-kbuild@vger.kernel.org



>> ---
>>  scripts/clang-version.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
>> index dbf0a31eb111..e65fbc3079d4 100755
>> --- a/scripts/clang-version.sh
>> +++ b/scripts/clang-version.sh
>> @@ -12,7 +12,7 @@
>>
>>  compiler=3D"$*"
>>
>> -if !( $compiler --version | grep -q clang) ; then
>> +if ! ( $compiler --version | grep -q clang) ; then
>>         echo 0
>>         exit 1
>>  fi
>> --
>> 2.18.0
>>
>
>
>
> --
> Kees Cook
> Pixel Security



--=20
Best Regards
Masahiro Yamada
