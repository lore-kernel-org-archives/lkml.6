Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZrQuR6iUoJWGK6D+Av8VnuPnskOd0SzG8i3d3Nk1CXJKcj3m3vPVScg7z1sQJHw/yeuE2kZ
ARC-Seal: i=1; a=rsa-sha256; t=1526432939; cv=none;
        d=google.com; s=arc-20160816;
        b=A3WZBLay70PQV9lIqcpST22P+bU8rCFU0Wt2p1sgLy9C8+7SiriJSOOJdqv29c/0XF
         GyzE+vAaItH4HCNUaTcCUaqP2tfE4OfP7uul98bDK4aYxVVgCcN4ztp73ZbePEntDsoz
         YNcXQbiMre7ZCVvhPTlqyFMeFJd2nAzck1X1Y831TQslAFOr6b42XyiLwgau3xsqAFgT
         m2SIqf0+jmz3JletQ74ZJLZ23PJ+jnCwMDLaSYqtqml56Fbor4EWpGrf+gS52nKKPbF1
         Kq+mxZKKt7Gygr30e5avdbw1C1YYfkbGMy8XZH2UnOh7TTBdhDrRpCP4MnuvYglQky9j
         Cdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=HgjWSodwE1ryvU+XnOER1GR0YBqtRlWZ4b9nPekPibI=;
        b=p/uI/HE0eL4RjdMDrMpCCEBIV0ANVIp3LrO6SSwqt/Ll/NUl4n2fjY3O9lBhjf/UHj
         nTuqHzU//NuNCvEbkDNBdYCWRXAFgaKRGURC8YMPRSGbvhDgfIOu8NYl/5q0SExObsSr
         BXqMG5UJM2JyY1rujw+pckqBmuihHyWzJ5ehjIZCqZ0gQ4+DKegGScut9n2LrprQXFtz
         N3+Sie8VTr6/jEPnPRxs7mJj7nqjnqFUht38T1aqYFmTg/GAEiomTza70oNvnDlhyFKX
         xaw4sR5UKzG3aQvfxpaH7Q7oPHpsiMpLDTWmJRSNEZK9OVdO2QCIwbQ8HYXVtu72CPZS
         S9KA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qovFTJIa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=qovFTJIa;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4G18V1s028366
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <20180515155925.9c16962e2b416e5f507c07b1@linux-foundation.org>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
 <1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com> <20180515155925.9c16962e2b416e5f507c07b1@linux-foundation.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 16 May 2018 10:07:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJA2WJ6QO8H7dGi3D3=pHFfXLU=o8eBPcC+wxq-v7TqQ@mail.gmail.com>
Message-ID: <CAK7LNAQJA2WJ6QO8H7dGi3D3=pHFfXLU=o8eBPcC+wxq-v7TqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] types: use fixed width types without
 double-underscore prefix
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lihao Liang <lianglihao@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pekka Enberg <penberg@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600495013490118173?=
X-GMAIL-MSGID: =?utf-8?q?1600580945648355305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

2018-05-16 7:59 GMT+09:00 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 15 May 2018 11:22:05 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> This header file is not exported.  It is safe to reference types
>> without double-underscore prefix.
>>
>
> It may be safe to do this, but why is it desirable?


It is shorter. That's all.
If it is a noise commit, please feel free to drop it.


BTW, a large amount of kernel-space code
uses underscore-prefixed types.
I wonder if we could check it by checkpatch.pl or something...


>> index be15897..9834e90 100644
>> --- a/include/linux/types.h
>> +++ b/include/linux/types.h
>> @@ -10,14 +10,14 @@
>>  #define DECLARE_BITMAP(name,bits) \
>>       unsigned long name[BITS_TO_LONGS(bits)]
>>
>> -typedef __u32 __kernel_dev_t;
>> +typedef u32 __kernel_dev_t;
>>
>> ...
>>



-- 
Best Regards
Masahiro Yamada
