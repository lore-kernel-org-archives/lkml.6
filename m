Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0322EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A7C20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSfwB35Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A7C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeKQUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:45:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeKQUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 15:45:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id e3-v6so27302259wrs.5;
        Sat, 17 Nov 2018 02:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1ng/TF1sMWoJhNF1mPxwGzV2gbUWNY12aGtvGPgT6s=;
        b=dSfwB35ZTI+Mo3TURQpdPH3ywXeU1S7vOyFsgEkJMD2TCmVXGVxKahPzFQ5kDH/Yrd
         DCYVU5PDvHzfq93LbSGwf4y0rMoHcQGXm9GSlOZ+CYpl3qZJ2xKkQHUKvNxRBacSutwN
         gRR/35qd9uf8C1ti/meGrEJu3EB8uO/M9xRZL8pVoMnXamtc7FHPVYe1jNskBJ0BaRSP
         0+QOFOrn0OuoRx6pdVKvOHp9nhsfWAH85dYz3FsXXKsy8Z7vFyPvXx9gSmROy2VizLe/
         Thai7y23jaykOrJoWxAwrp/PPXtdt1WMvB2elugLWdzCJTjNtsszmoagiJ81PCSp/o5/
         jd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A1ng/TF1sMWoJhNF1mPxwGzV2gbUWNY12aGtvGPgT6s=;
        b=hUMBy1lns/BOI4b083ZHbzvBNxBFuUFaGZjDfu2eosGu/YL0NPO6+/PB5lNUx6dMVq
         dcLq48ytyiHHYgWgDTMNsGkjiqi0ya+eflyPnAJ+CIAq/v2fSsKAWAOEHHPy30CUQI6B
         +gC8YYLSc3B5mTHYMHvyYLBbkyEMS9A/0iGTGsHPbT6S6Ij6okgFqSfnLV8/Clm4s9Cp
         gr93ndo/TnX+Zcb1G7/dlI28Zz5AHlFkdpKQsKf1RLn5VtBsnq4sU9lPTs3xaIhr0zWX
         +Q21nmKk7vnnVpf4WR85DmXeipKRbN9QU5Mu4gfRa0Peoc9QlPEmKGoP/1hi8knmyiW9
         EjyA==
X-Gm-Message-State: AGRZ1gIYMxpqsR3KNk73VvwMx6lLEC/+YkeziS6ZkO6n/tlk6NwMVyM6
        pE3fcbuEKWEljbK5f1rcTFKxCKkq
X-Google-Smtp-Source: AJdET5ddbpXWkjJbiegFewPkyfS0JuC5znpbJMUFgby5sUtPfv0IYonw1UoTYnZ1HHkKQYYoQsvrzA==
X-Received: by 2002:adf:ba8b:: with SMTP id p11-v6mr12673244wrg.203.1542450565712;
        Sat, 17 Nov 2018 02:29:25 -0800 (PST)
Received: from [192.168.2.28] (218.83.broadband9.iol.cz. [90.176.83.218])
        by smtp.gmail.com with ESMTPSA id o62-v6sm23507307wma.1.2018.11.17.02.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 02:29:24 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
 <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
 <20181116215249.GA27149@gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBE94p38BEADZRET8y1gVxlfDk44/XwBbFjC7eM6EanyCuivUPMmPwYDo9qRey0JdOGhW
 hAZeutGGxsKliozmeTL25Z6wWICu2oeY+ZfbgJQYHFeQ01NVwoYy57hhytZw/6IMLFRcIaWS
 Hd7oNdneQg6mVJcGdA/BOX68uo3RKSHj6Q8GoQ54F/NpCotzVcP1ORpVJ5ptyG0x6OZm5Esn
 61pKE979wcHsz7EzcDYl+3MS63gZm+O3D1u80bUMmBUlxyEiC5jo5ksTFheA8m/5CAPQtxzY
 vgezYlLLS3nkxaq2ERK5DhvMv0NktXSutfWQsOI5WLjG7UWStwAnO2W+CVZLcnZV0K6OKDaF
 bCj4ovg5HV0FyQZknN2O5QbxesNlNWkMOJAnnX6c/zowO7jq8GCpa3oJl3xxmwFbCZtH4z3f
 EVw0wAFc2JlnufR4dhaax9fhNoUJ4OSVTi9zqstxhEyywkazakEvAYwOlC5+1FKoc9UIvApA
 GvgcTJGTOp7MuHptHGwWvGZEaJqcsqoy7rsYPxtDQ7bJuJJblzGIUxWAl8qsUsF8M4ISxBkf
 fcUYiR0wh1luUhXFo2rRTKT+Ic/nJDE66Ee4Ecn9+BPlNODhlEG1vk62rhiYSnyzy5MAUhUl
 stDxuEjYK+NGd2aYH0VANZalqlUZFTEdOdA6NYROxkYZVsVtXQARAQABtCBNaWxhbiBCcm96
 IDxnbWF6eWxhbmRAZ21haWwuY29tPokCPgQTAQIAKAUCT3infwIbAwUJEswDAAYLCQgHAwIG
 FQgCCQoLBBYCAwECHgECF4AACgkQ2bBXe9k+mPxpbg//ZWDcQVNAKOWCviNnNvT315WbDrjs
 J6FApF83hB52qQO9tvjb5ZY54794uwofidOqi0XFoLkoLyiJkkvc3Q9SnM89hyhzrxnh2ym4
 rUr4cL6F9e99uC656er4telMbg9OSPR2iNuqsAzyMhOGMEnnm97YQ2QWOnvbC8QgoQB5VvF3
 nZMgqTPTxctlUfc7t4BlGcIBLG0oINUNDf441KAXgMP05kVK0CDQd02CTPok2Qshbg6aw56e
 SSUTB4aqZM8St1ySJ2ccMDRC9mCqcNFtuuPyAAJAJFmEvlxahd0BA0mwV3ce38JBbTqs5k0X
 2JVljHObgnfp3WDtuY8Lj0u8KvN0CAYJhRuhY40fARh8EPfkNvIx/740ueexsUBW3N1/lCeA
 BaOKtu11kVUxvDxaFRQc2I5vl/sZMunSjJQQiwrWNbrwZgidwkHzvizmLjdgHgCJeEC+tu1q
 ifTCOllufvXagjYmrH4hm/Qz6+91lLksrHooxp3nAcN78d5/E4reamx0+DleOJ2yD1UeP2wU
 DdB23OQU3ipVDYwIuIvDWiZSIVwXyDLhuc64ti4tScUGfucEKMER1eLTJ+zILHZ9R4K7C2Bh
 EGSAyxkeeX/Z8pLNOJ1RdU+B+ZFNXuIHLJbgrAiOOqr07WPbvRT1LvO/w/4m31D9Kalc4Jyq
 n9+pjtm5Ag0ET3infwEQAN6EdXyfw9xr56CJ1asnQ1PSxpzEGlUsEHvn4wcufyC8KN6VGUlR
 3WinlaGvOICzvYOiS06E6PqKDEgbbApBh2//6Ihk1OynS0y4hYepJi+pstdXoiud6NQSNQlc
 FjCfI8WzAT3rensVLmwc3HgRW5qqt5Vc+EWdg9cylZ48QdPyo3WyOd2pyL+yqNZPjMGijE8z
 vzurwZiO9aBkJCjulqXMs1YyyIqfTxKQ1GCUQq4SoIQXjD8HvgJ7T/TpuDf9wFheonGqxiJp
 xb02LMEdkPgugKIgG6iOFplzrsySyoiJsGa0mJ0n0O6rXQxl1mK/zdfgvm4CPDujbgINnIxR
 xPescCVYcmjM8kTlGYJuKp4GgbwbwkCISs4retaAXiP3a2f3eSaJc5SnWWa3JqH5ogkEWvue
 zjNxW5fMpBWszdQEsgnsdlK37V+aB5oWnnkZRlWk1YhGwL1ODz+EZzSsGlkIr7BYakK3xRYb
 xVfQkUr7EeqruXohSOnPAowePYAXCigCfWvIJMlrPLIOD2GOy9eV3UZ/JDn/7YPfFAjNb0gV
 dpqBCQNH/fP2ePC0FzW+3YL1UbR+qMAEbKbFepycg75LbC08jFuQVvauDQta4EAvBkF460Po
 skCzcMuREntjMxipB6IMSoOD74tcGYfUp6/kcgdEaqyK8214couO/u8HABEBAAGJAiUEGAEC
 AA8FAk94p38CGwwFCRLMAwAACgkQ2bBXe9k+mPzIRA//bAf0Ng8dJ+IgydRtdT9X2xYKyukk
 A3HlrOImOoA4Thrv/HVe7U28AkiQt2DxOmNZYIV0BqvL+dWAD1HYCdQgsgVWVLprsFfqOYHn
 AWKsdqyNZHtPC9J6drnwv0vcER0dtDJjMDP4MJMTa4JNjNJYb29WfbImviDRtIcVujYFoZK2
 ZBa1Ec7yPfk4CsyE+Y3Qh9Gy8Z08NrrxIn+MVATBbocKs7j1JAvkFk+o1grGnw3NTXnB8gEy
 gAKHHyUgzr5Nyn5qJ28EZr7Vc1FP2lUiKv0JBcHT/9vVXJ1Grd+VF2cwYftMWRKR66lTaUS2
 BX0ta6IQQSj8nSRsoKapRniCfTm1D4I16j9bOoEfFdVsMkcrYFtfhq97qgR8gZtVCJkrX2CA
 RZ+a1J+NP/erASd6M1A3n3aMF3xBFfFsotzPplmhzExCYwuOCWIBfPerUQh1MughvG/oT8Za
 pR6x/EVE+K90J10XpPi8VMi/3QRC5DpCin3Kc14WAE4uEbyUWLKb3PmfmZaS6qFaJNtf2TyZ
 odT0ACguv9Xs4el0j8FRaCqLvEZS4rKLNxb8EY3Z4LC61QfyAbg5P114muVZ4ro8dzhZ0zwk
 ZLGeEsYPsQpLo6XPT/32PP8aHn/KKX+KM7ouCEhVeWszR20BMK6sxTBR+4aNqSKCdgr42jrt
 vzRmJp4=
Message-ID: <56883f08-26cb-ecef-5698-1c2948714773@gmail.com>
Date:   Sat, 17 Nov 2018 11:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20181116215249.GA27149@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2018 22:52, Eric Biggers wrote:
> Hi Milan,
> 
> On Sat, Oct 20, 2018 at 12:26:20PM +0200, Milan Broz wrote:
>>
>> Adiantum (as in your current git branches on kernel.org) can be used for dm-crypt
>> without any changes (yes, I played with it :) and with some easy tricks directly
>> through cryptsetup/LUKS as well.
>>
>> I think we should have this as an alternative to length-preserving wide-block
>> cipher modes for FDE.
>>
> 
> Yes, dm-crypt can use Adiantum by specifying the cipher as
> "capi:adiantum(xchacha12,aes)-plain64".
> 
> But, I'm having trouble getting cryptsetup/LUKS to use Adiantum.
> Using LUKS1, the following works:
> 
>     cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256
> 
> However, when possible we'd like people to use 4K sectors for better
> performance, which I understand requires using the LUKS2 format along with
> cryptsetup v2.0.0+ and Linux v4.12+.  But the following does *not* work:
> 
>     cryptsetup luksFormat /dev/$partition --cipher='capi:adiantum(xchacha12,aes)-plain64' --key-size 256 --type luks2 --sector-size 4096

Hi Eric,

actually I planned to test it and then reply to these patches with example cryptsetup
commands, but did not have time for it yet.
So thanks for a reminder ;-)

Recent cryptsetup supports sector-size even for plain device.

You actually do not need to use capi: prefix, Adiantum is a composition,
so "xchacha20,aes-adiantum-plain64" works as well (and it should work even for old cryptsetup).
(It is ugly, but it should be compatible.)

# cryptsetup open --type plain -c xchacha20,aes-adiantum-plain64 -s 256 --sector-size 4096 /dev/sdb test

For LUKS and benchmark, Adiantum need to use 32 bytes IV. And we have these parameter,
unfortunately, hardcoded...
(I guess there is already a way how to get this dynamically from userspace crypto API now.)

So, I already added patch to devel branch patch for benchmark to support Adiantum few days ago
https://gitlab.com/cryptsetup/cryptsetup/commit/bce567db461e558af7d735c694a50146db899709

This allows trivial benchmark (but it just encrypts one big blob of data):

#  cryptsetup benchmark -c xchacha20,aes-adiantum -s 256
# Tests are approximate using memory only (no storage IO).
#            Algorithm |       Key |      Encryption |      Decryption
xchacha20,aes-adiantum        256b       146.6 MiB/s       148.0 MiB/s
...

# ./cryptsetup benchmark -c xchacha12,aes-adiantum -s 256
xchacha12,aes-adiantum        256b       181.7 MiB/s       184.6 MiB/s

For LUKS2, we need a similar change to cryptoAPI IV size (unfortunately it does not
fallback to old keyslot handling, so LUKS2 does not work currently now).

I quickly added a workaround that fallbacks to default keyslot encryption for keyslots
in this case
https://gitlab.com/cryptsetup/cryptsetup/commit/29e87add5aac9d5eb0087881146988d9c4280915

then you can use LUKS2
# cryptsetup luksFormat --type luks2 --sector-size 4096 -c xchacha20,aes-adiantum-plain64 -s 256 /dev/sdb

(Example above will encrypt keyslots with AES-XTS and use Aviantum for data only.)

So, unfortunately yes, we need some small changes in cryptsetup for LUKS;
plain mode should work out of the box (with the syntax above).

Milan
