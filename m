Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tpAbLxTnHFv4JAAAmS7hNA
	; Sun, 10 Jun 2018 09:13:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B49C860850; Sun, 10 Jun 2018 09:13:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu4PuiwR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0482D600D0;
	Sun, 10 Jun 2018 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0482D600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeFJJNB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:13:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37988 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753563AbeFJJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:12:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so8710774pfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uNujDm1Mhh9QHKutQwvaKDAjPKgxVSfEW3ZGt5pmi/U=;
        b=hu4PuiwRATMg8dvu8XkkMTuZH/cLYdaoqAb4xBngH4MZLWGtcnKvoK5RCK4f0aQ6sP
         rcmrzqU4OJ3q7/P9dckLJYG/Xk9QUdST3mjVZwBlRwccR4b3XTsh06VOZHf9MIDppalq
         l1i6pIqh2N/Ks+m+qLOljUAI1bdDAZirV91dLrzQv59PI8tLrCIj34algZ2SycwPtCXn
         VgA/du1c5HeF2PiryJgHO3/9OHfhTbse3Q7/sJdaYCcc78VV4Iub2xu8Z4/njBFpNRKV
         6rGJZHw4LdqP1wkCstPkvmD5OmFn4BPSq2QxP/USPfe0RbQppbtl0Ih11Gc+GYGqgVsb
         lr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uNujDm1Mhh9QHKutQwvaKDAjPKgxVSfEW3ZGt5pmi/U=;
        b=qu8aQHLhXFQX+TVJlQWLya6PyvjcCG7/TEOu9IkKtwSBwbnNJ1HwUdeYeXO6Z5JhQ9
         bFW/GqBdjBrkvnOaV3mghLuy/aq8MHqY1KjmhXcEIH2hKac7iOgHIhXXVFFy+s3s2clP
         gNrLX9FxLrGBcEvRlLhAZfJLkGq+5nfPyUmWKThY4HhO4L2iR10PFiPPFWkPo8LcFyMj
         gyZVrQ7Gy0DxXSMnEJhxAas38KWduOzRtHQ0KBC36jsLgUcJ5CXjzS1Qz7LyhRjF1qou
         2zYN16O544+apVAO67NtxktZnKS9Q+Iwcsn5YHa+wwDB1qg0oxyNwJIwozBTJOUgfzxv
         V89A==
X-Gm-Message-State: APt69E0/yGpUoQ6tc3U0hIoRqjpi/A1pqIYXyl9qagudomggSVwI+37P
        EZ1Jbha9DU9d0Y6zvp/Nk8T1wZZ9
X-Google-Smtp-Source: ADUXVKIsC3mKoWyvQ+s/R860kx77L/PrRlXcBxCotX5+f2GhZEXj2cuKNgbcnCz0CdGFTAqz9XZGug==
X-Received: by 2002:a62:fb05:: with SMTP id x5-v6mr4578429pfm.210.1528621977924;
        Sun, 10 Jun 2018 02:12:57 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id z4-v6sm74000245pfm.28.2018.06.10.02.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 02:12:57 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
 <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com>
Date: Sun, 10 Jun 2018 21:12:50 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am 10.06.2018 um 20:29 schrieb Geert Uytterhoeven:
> Hi Finn,
>
> On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>>>>> Is this enum used by any user space code? If so, perhaps rather
>>>>> leave the PMU_68K_V1 in there to avoid upsetting that?
>>>>
>>>> It also changes the value of PMU_68K_V2, which is an ABI break.
>>>
>>> Yes, that's what I worry about - but do we know of any users of that
>>> particular interface?
>>
>> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
>> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
>> series will make these UAPIs available on m68k, and for that reason I've
>> chosen the value PMU_UNKNOWN for pmu_kind.
>
> While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
> include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
> unless we are 100% sure there are no users.
>
> If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
> needing to check the PMU type, it would have a switch() statement with
> all existing values defined in <linux/pmu.h>. So that would become broken
> by your change.
>
> Hence the enum is append-only.

The PMU type from pmu.h was never exposed to user space on m68k via 
/proc/pmu/*, and /dev/pmu is used for ioctls to the PMU driver on 
powerpc only (the 68k PMU driver doesn't have ioctl support). No way 
that I can see for user space to make use of the PMU type definition 
from pmu.h, so I suppose we can be sure there are no users.

The m68k PMU types cannot be said to be exposed on powerpc either (which 
has ioctl support to interrogate the PMU type), as these only return 
values up to PMU_KEYLARGO_BASED.

Applications like pbbuttonsd or pmud don't use the kernel PMU type at 
all, but go straight to the PMU via the ADB bus to interrogate the 
hardware type, so won't be affected either.

Is there any other way besides procfs and ioctl for user space to 
interrogate the PMU type that I'm missing here?

(I understand that breaking the ABI should not be done as a rule, but 
this may be a case where we can successfully argue the definitions were 
never in use, so the rules may be bent a little).

Cheers,

	Michael


>> New pmu_kind values can be defined as and when the need arises. But that
>> would imply a useful classification scheme for pre-PCI powerbooks, and I
>> don't know what that scheme will look like because at this stage there is
>> neither userland nor kernel code to support backlight, buttons and battery
>> for pre-PCI powerbooks.
>>
>> In anycase, the "v1" and "v2" scheme is obviously inadequate when you
>> consider the range of m68k powerbook models. Also, consider the
>
> New values can be added at the bottom.
>
>> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has
>> this ABI break:
>>
>> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
>> index cafe98d9694..9882a185a52 100644
>> --- a/include/linux/pmu.h
>> +++ b/include/linux/pmu.h
>> @@ -90,6 +90,7 @@ enum {
>>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
>> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>>          PMU_68K_V1,             /* 68K PMU, version 1 */
>>          PMU_68K_V2,             /* 68K PMU, version 2 */
>>  };
>
> That's bad.  But as long as the NuBus-PMac project is out-of-tree, the
> enum values it uses are not part of the Linux ABI, IMHO.
> During upstreaming, PMU_NUBUS_BASED should be moved to the bottom.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
