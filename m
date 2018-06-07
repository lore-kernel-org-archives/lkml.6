Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 02DQCmXDGFtHOwAAmS7hNA
	; Thu, 07 Jun 2018 05:32:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E483608B8; Thu,  7 Jun 2018 05:32:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TItQtCBd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7832F607DC;
	Thu,  7 Jun 2018 05:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7832F607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeFGFcS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:32:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42214 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeFGFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:32:16 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so12625807lfa.9;
        Wed, 06 Jun 2018 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tK8dudoPiweUBdvNDqX5okSxvWobIVXaKRjBU+Y/FJw=;
        b=TItQtCBdy3RF3LiO8wG2zMzGY+rGxXEDElraV1V7UwTYizKq63PG+V3EG0922iXg2/
         jTQm37kXuGvC3q9Ple8fjDamg/I7xedBnvJWG75toS4eB9clgRp0OEkKWaHOHB5A3Ub3
         GP8cMj5PdPeeBQXSYuKjeizzoJfmVST7r6wPJqtxk5J+8S30+y6uELGfOTulWCNnmYx3
         VAd5wcEELa4MBJ9UwScgF30Vxy7bwk7T653h3z/Ms8TyNiP1gMaVTWEVpCul1t0r4Tuj
         cdRg8FN1G6VHlTI7Yc+x2xnfMusG94sxaAiRvMKlpijlm9e0rMD39IhF2A+sivpH91Xf
         mXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tK8dudoPiweUBdvNDqX5okSxvWobIVXaKRjBU+Y/FJw=;
        b=Wn0FLoaYo3dtCG0FTZINkI7QUUSTotilclmiZ6E/pat0yCvWVOL5m/tkV0T0qXFvca
         Jg+m1z2oOUkyowTxm5d3urkCQp20moby5WIgNdU12nT7cLpjmfAk8uBvNQbXcf77pjAl
         nRKYWorQWuywC9VYcopnkP3IlnAo3qgDwsP3e+n0dorN6h1hH8cql/5SO+/HoGqiLFPV
         e9bfd/aWqUrpBruw+GSolMBVD+K71/z0zVnPy/53Zy76EHjvtEsoiPrvHibWqMdrfFdr
         cUnH4ielbp19HmNI5UdZZK+1i0pFFoej1CXVGqJx5kKt6eKbybNGLHC4g/Hfwy45NpaZ
         bXtw==
X-Gm-Message-State: APt69E0uTLgAvHi+EXjDKXaKF3X+Mi/iMTP/K1JZ5WNMQrkNj/cf+Nk5
        +kTWqefUTZ4hGw8eA3A0xwk=
X-Google-Smtp-Source: ADUXVKJIgledPGyIWzJNNiBXOxvsnmEmixdKcFj96tsT/bo8yVjds5/SBMR1ySDRJ3X/K6wxsr0aKQ==
X-Received: by 2002:a19:e9d3:: with SMTP id j80-v6mr277357lfk.129.1528349535018;
        Wed, 06 Jun 2018 22:32:15 -0700 (PDT)
Received: from [10.17.182.9] (ll-55.209.223.85.sovam.net.ua. [85.223.209.55])
        by smtp.gmail.com with ESMTPSA id i5-v6sm2197768lfc.83.2018.06.06.22.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 22:32:14 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] xen/balloon: Share common memory reservation
 routines
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-4-andr2000@gmail.com>
 <4fd46fd8-f936-1514-06e4-34c5d3ed8960@oracle.com>
 <05e361c2-c7f3-2f57-908c-e2c9b98b18e7@gmail.com>
 <6cba4317-b517-3e12-ba1b-3ccbe414ada0@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <9298e775-e5b2-b3b3-dfca-6d1ec66efbfc@gmail.com>
Date: Thu, 7 Jun 2018 08:32:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6cba4317-b517-3e12-ba1b-3ccbe414ada0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 12:09 AM, Boris Ostrovsky wrote:
> On 06/06/2018 03:24 AM, Oleksandr Andrushchenko wrote:
>> On 06/04/2018 07:37 PM, Boris Ostrovsky wrote:
>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>>> diff --git a/include/xen/mem-reservation.h
>>>> b/include/xen/mem-reservation.h
>>>> new file mode 100644
>>>> index 000000000000..a727d65a1e61
>>>> --- /dev/null
>>>> +++ b/include/xen/mem-reservation.h
>>>> @@ -0,0 +1,65 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +/*
>>>> + * Xen memory reservation utilities.
>>>> + *
>>>> + * Copyright (c) 2003, B Dragovic
>>>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>>>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>>>> + * Copyright (c) 2010 Daniel Kiper
>>>> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>>>> + */
>>>> +
>>>> +#ifndef _XENMEM_RESERVATION_H
>>>> +#define _XENMEM_RESERVATION_H
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include <asm/xen/hypercall.h>
>>>> +#include <asm/tlb.h>
>>>> +
>>>> +#include <xen/interface/memory.h>
>>>> +#include <xen/page.h>
>>>> +
>>>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>>>> +void xenmem_reservation_scrub_page(struct page *page);
>>>> +#else
>>>> +static inline void xenmem_reservation_scrub_page(struct page *page)
>>>> +{
>>>> +}
>>>> +#endif
>>> Given that this is a wrapper around a single call I'd prefer
>>>
>>> inline void xenmem_reservation_scrub_page(struct page *page)
>>> {
>>> #ifdef CONFIG_XEN_SCRUB_PAGES
>>>       clear_highpage(page);
>>> #endif
>>> }
>> Unfortunately this can't be done because of
>> EXPORT_SYMBOL_GPL(xenmem_reservation_scrub_page);
>> which is obviously cannot be used for static inline functions.
>
>
> Why do you need to export it? It's an inline defined in the header file.
> Just like clear_highpage().
You are perfectly right, will change as you suggest
>
> -boris
Thank you,
Oleksandr
>> So, I'll keep it as is.
>>>
>>> -boris
>>>
>>>
>> Thank you,
>> Oleksandr
