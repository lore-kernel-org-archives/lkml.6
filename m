Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85A54C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305F62086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlA9shwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305F62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934960AbeFMQaM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:30:12 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42068 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934372AbeFMQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:30:11 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so2125126uaj.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MzuxUJA/lcU8TWHfSkOpzEUCwhITPcNDYNOBMzqkdIg=;
        b=JlA9shwl9M51thqq7C4OdPGGD4omF9QDodBgN89bbA6hvutaz3+aL7tFwLMokhgC5W
         KlwToD15pxrY/7T5j3emyByUW35ftI0J1TLWu0hJ3rax16cTsNo8YM3FPatSMKVsnk7Q
         PtIHtrCeZ4YOLDw3Kj+Pn3Cri7ovS0OzEIEhYrlrbP5lE7K+Bzz/EqdJbDY7mQkZhQoA
         mkSlv7VVrvRIHl1urCOrFWM7+ArBe+FSfc4rKZoc9H+XMaZL3ec4KYq4GN8ZWok1ENeH
         QFqBdzjmIJca86m8gto7zckM7KYEj4SJO8pycGfKjhBmGwGquUll7p074PNhlQegYr6F
         jiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MzuxUJA/lcU8TWHfSkOpzEUCwhITPcNDYNOBMzqkdIg=;
        b=JS9ZJP56YJ6L5yycnQCwkT7NOw/4pePrylQhkSP0wgRblbL+74tQ/nd7q1qbxox/do
         oSeKKoFGpv1L8TxhtZWtr7GNnr92vCPHkMvHDrSq8os4C5oIEDP9KA1T6UIOvdb3d6jh
         kQ4/laP3Jw7sk1+19j0DTsPcoAK1LGRsfsc2jPauHTinSCancM1px+fyJrBShg6S57vj
         jmfvCpJb7etamsFYD2UyrFk7+3KcubK8HWPIpWlIGa4EQC4g2tS/O3pTbpY5LHgT+Noc
         HBcq4ikbXOTMApb7x6hMmjlKzbVECOOB/VMBSO7RY+xK8Pp6/TesPfY18p1WZw3SPENn
         ZE+g==
X-Gm-Message-State: APt69E3XDv9bmsGGHPPgQzk1bpP/Ot28Y/oc+9FDTvXisbrQQhTiJ6Vn
        kiajN6kD52MKvpcPdnvw/b9TSFoSSTAOJ1RGLNU=
X-Google-Smtp-Source: ADUXVKLBTDk3tbHrs6IK2WNZMVO66/LUtkK2u18eU5C+i3/3wWKUKCHsPi1GqGBLB2Orgng+8O4II873W2lpBdNzFjA=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr3848973uai.122.1528907410723;
 Wed, 13 Jun 2018 09:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 09:30:09
 -0700 (PDT)
In-Reply-To: <d663916f-ebbf-3177-cd03-8d1175912f53@linaro.org>
References: <20180613092919.24075-1-thierry.escande@linaro.org>
 <CAHp75VeXGT3KG9HXQstFJVyHFO8o64Dk0LSo43FzyR0SvPUONg@mail.gmail.com> <d663916f-ebbf-3177-cd03-8d1175912f53@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 19:30:09 +0300
Message-ID: <CAHp75VeiH+FvT7pbCpx75kxxeC5huxKRtXQvzfVjX4OyCaLLrw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/test_printf.c: call wait_for_random_bytes() before
 plain %p tests
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:59 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> On 13/06/2018 13:22, Andy Shevchenko wrote:
>>
>> On Wed, Jun 13, 2018 at 12:29 PM, Thierry Escande
>> <thierry.escande@linaro.org> wrote:
>>>
>>> If the test_printf module is loaded before the crng is initialized, the
>>> plain 'p' tests will fail because the printed address will not be hashed
>>> and the buffer will contain "(ptrval)" instead.
>>> Since we cannot wait for the crng to be initialized for an undefined
>>> time, both plain 'p' tests now accept the string "(ptrval)" as a valid
>>> result and print a warning message.
>>
>>
>> There are two possibilities:
>>   1. (ptrval) for 32-bit case
>>   2. (____ptrval____) for 64-bit case.
>
>
> From lib/vsprintf.c, ptr_to_id() puts "(ptrval)" into the buffer, then it
> gets left-padded with spaces by widen_string().

Which kernel version you are trying to fix?

What I see for a long time in linux-next:

static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
{
        const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
...

brought by the commit 91efafb1dd8f ("lib/vsprintf: Replace space with
'_' before crng is ready").

-- 
With Best Regards,
Andy Shevchenko
