Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96740C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FCB214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FCB214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJIWhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:37:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJIWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:37:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXH3e-1gBX7k3HLy-00YiiS; Tue, 09 Oct 2018 17:19:14 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXH3e-1gBX7k3HLy-00YiiS; Tue, 09 Oct 2018 17:19:14 +0200
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu> <20181009151641.GB10149@cisco>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <409c22e3-1df8-cf7f-2462-ead2bb3020cf@vivier.eu>
Date:   Tue, 9 Oct 2018 17:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009151641.GB10149@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1lWv7EXFY1qMZY9QnuPkxO1sDbefPZW/u9jn3jNEJIRY/vwsf0R
 Ru0x2yPMtssUJNHdVi2rMDDDSXkVP9fUUJeUU8b/CQzSnlLioLRt6ZH1LjQ6YkdfNHkO3qJ
 ZJ7XF9TO+biKG5xmJhOKun7ruUqiSZLO4x4upq8LAU8TSy6T0BTrR3epzE9dKVGD7Iz788u
 OuYRUXXPpYBP6LU1aUTvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zJ+6wh+SzL0=:1il2LgUdeY8UxFm32KAERs
 elH0xjC546g3sfv84VuomsvBDf7nKnBZ3hxd9vO/QCiU9/5gyCHuliFdeg9HYuWvhBhsImu7P
 nhcwSE2d8Ieib85NRSWesFhwtsxEbvIIDdDQtiNePQy2dbed3/aUk5cEftEF+KCcYWGZvgrEA
 QWx6tQLPJGNW0Yyp+/bcha9mKA7oYCyLdsUalr7dBCKjX5jcYjzCACFT0sSW6D7lETmpLAEfh
 UKepKkHCpPzkQKXQpEuBkDr+OMAJS6RInm5NQWRV+qScbHCDh1Hp2VZd0B1sqHUH7BLJ3s4xR
 lNUoMQBpb30y9kzY/E/LINc4lx5Ixm8HK9bH23oIP+RZW4inEl5sOqLfPWQw0ovBxB9CwEJaA
 iDkzfhqCojwR0ObF+Uc38XkRkm8qB3Ir1DuVWwMkKKqEQCYmoWli8m+8+DSW+Hr2ivTpGWzCu
 SKfDD1ctISr6ujkyx8/rYdchb5kxvLdSNvnfjCPEXqL6PYv9eNsy3QLdK/xlZEy3YISI//uQG
 poRCYsn/rB4hdRYG6PeS2FhfnW3003CEcbbERNwOl9uQDnwgCcZNIOLTuF5CVrhDae6iFDR91
 1HNpgFolGo5QQwvzTJzjGKQcD1m3tSZsw/kSaUu50XTYK/c4pypcldUzLm+nLZz3G+itKNzJJ
 ezHwXelLb7AViHX1oKdO+zhAn++enQgR8jYLPe0nv4501MYPXbwnbcwzYyKt+3Prb0V28KE2H
 35auY5icm+fAbbs/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/10/2018 à 17:16, Tycho Andersen a écrit :
> On Tue, Oct 09, 2018 at 12:37:52PM +0200, Laurent Vivier wrote:
>> @@ -80,18 +74,32 @@ static int entry_count;
>>   */
>>  #define MAX_REGISTER_LENGTH 1920
>>  
>> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
>> +{
>> +	struct binfmt_namespace *b_ns;
>> +
>> +	while (ns) {
>> +		b_ns = READ_ONCE(ns->binfmt_ns);
>> +		if (b_ns)
>> +			return b_ns;
>> +		ns = ns->parent;
>> +	}
>> +	WARN_ON_ONCE(1);
> 
> It looks like we warn here,
> 
>> @@ -133,17 +141,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
>>  	struct file *interp_file = NULL;
>>  	int retval;
>>  	int fd_binary = -1;
>> +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
>>  
>>  	retval = -ENOEXEC;
>> -	if (!enabled)
>> +	if (!ns->enabled)
> 
> ...but then in cases like this we immediately dereference the pointer
> anyways and crash. Can we return some other error code here in the !ns
> case so we don't crash?

My concern here is I don't want to add code to check an error case that
cannot happen. The first namespace binfmt_ns pointer is initialized with
&init_binfmt_ns, so the return value cannot be NULL.

Thanks,
Laurent

