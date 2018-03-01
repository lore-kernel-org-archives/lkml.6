Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030767AbeCAN3C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030460AbeCAN27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:28:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B6F21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELusvyZiJb6etQMIsIEQy4PoGRTJWr8BmkNfMeDQr5uOvGA+PRnEabIVaAhpl1QLFZz68/PTeP+N/hmVRwr0P6M=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT+_0t4PQxW911a0xL-f54WHGbF8t3rEq2Pfngr3J7BOQ@mail.gmail.com>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-3-robh@kernel.org>
 <CAK7LNAQSJ1uzgmta76rJwDpi08SB5gwcRPxu_TPw0u0XzgGaJA@mail.gmail.com> <CAK7LNAT+_0t4PQxW911a0xL-f54WHGbF8t3rEq2Pfngr3J7BOQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Mar 2018 07:28:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKc=-qyeiQuPy_fnEQ0xUV0Cem=5nwjKn-KQrqH_X-ow@mail.gmail.com>
Message-ID: <CAL_JsqJKc=-qyeiQuPy_fnEQ0xUV0Cem=5nwjKn-KQrqH_X-ow@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: add dtc as dependency on .dtb files
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:45 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-01 13:33 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
>>> If dtc is rebuilt, we should rebuild .dtb files with the new dtc.
>>>
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>>
>> Hmm, I am not 100% sure about this.
>>
>> Is there a case where resulted DTBs
>> depend on DTC version?
>>
>>
>> If I understand correctly,
>> DTS and DTB are 1:1
>> Unlike CC, there is no room for optimization.
>
>
> Maybe I was wrong.
>
> Is there room for optimization
> in 'DT strings' section?

Not sure.

> I guess it is optimized enough to avoid string duplication,
> but there could be different results
> without changing the specification.

What I care about is rebuilding so new warnings get emitted especially
when developing those checks. Right now I have to manually delete the
dtb files each time.

Rob
