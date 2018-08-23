Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56522C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112A208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAesA3Qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1112A208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeHWSUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:20:48 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:37428 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbeHWSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:20:47 -0400
Received: by mail-io0-f176.google.com with SMTP id v14-v6so4515912iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3xdGfv5IO4vf4MeFqzUj89i8v0HKqF020ZnmHzOlO6Q=;
        b=KAesA3QvKrd40+OxzUd7AA3CtVyt4iKlpkZrJyZOWfLsSCxj380B/WmubxjnbnyB4+
         Deb8A5D2YXlS3afK7h3eP7LQtKGiDTtudp7qR4vc1jwMwXq90FDtuxry9B66a/RLbl22
         3pNl/sEySAsFz/NdS0Vd56gBl2b02efh+yXxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3xdGfv5IO4vf4MeFqzUj89i8v0HKqF020ZnmHzOlO6Q=;
        b=i+mDCUw3Oag1f699PNc2AqpSxcZiEtSFNMdrfCkWv+GNck/RYQluWMYzei2Q4q58G3
         XwO8hlOZ5muTQJK3mK9UpgHStRq8TQBHiCH9HXjjJiDp0VyuCb3HRt4JJ+B8LS/OfY6S
         22hQO0l/2I4NpwvIkh8gmGX5lBC3IUl7hgxMlSzoQqmCp7NN90IkdW96oGaqdo1IQPl4
         sXPq/HVjp3F0JowEttQefJqiig0fAinMHOkVg3CeCs2YNdupLzy2YN8G8OP4UphFG6nu
         7adZ1nnQjhhRrYvLMRfBxHVvNLxzPMqy14nmnwCXpGRK9k5u/tuJOVKE/HvWHJwvRorf
         ItmQ==
X-Gm-Message-State: AOUpUlH3tnoA0CeXosVWCIenejqpL3Ln/EjS5cbFq8IeJYoL/Vp8SOQj
        L7Nvy4Hw9v4yOi6jPWrIBh+0PdOkzomhgta61tZDwA==
X-Google-Smtp-Source: AA+uWPx0PDF7pmGH483XpBloizk4zXxcboOeyDKJ5Ky6qdUCgUgATpiqLdbEnYjv73uBzbTV+gBlLkG9W4mhrPzq6nE=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr49209910iof.173.1535035846270;
 Thu, 23 Aug 2018 07:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 07:50:45
 -0700 (PDT)
In-Reply-To: <13ebec39-6656-ee60-58be-afe56adfde7f@molgen.mpg.de>
References: <305249de-7892-fca4-b462-a493aa65d177@molgen.mpg.de>
 <CAKv+Gu84h2+zofb4v-QrVE7rqCrGC7MaHEw7tB+z2J8DczjoKw@mail.gmail.com>
 <f94af2ed-3492-4db5-c1bc-30c4c1855947@molgen.mpg.de> <676c44ce-6909-f002-4ea3-0c6f68b6b781@molgen.mpg.de>
 <13ebec39-6656-ee60-58be-afe56adfde7f@molgen.mpg.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 23 Aug 2018 16:50:45 +0200
Message-ID: <CAKv+Gu_8kUV_EkeLfm986TPggQZKo40xgBS_1ab3eycDAfYzfA@mail.gmail.com>
Subject: Re: efisubsys_init takes more than a few milliseconds
To:     Paul Menzel <pmenzel+linux-efi@molgen.mpg.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 August 2018 at 15:18, Paul Menzel <pmenzel+linux-efi@molgen.mpg.de> w=
rote:
> Dear Ard,
>
>
> On 03/25/18 17:21, Paul Menzel wrote:
>
>> On 03/25/2018 09:41 AM, Paul Menzel wrote:
>>
>>> On 03/24/2018 11:35 PM, Ard Biesheuvel wrote:
>>>
>>>> On 24 March 2018 at 22:10, Paul Menzel wrote:
>>
>>>>> According to `initcall_debug`, `efisubsys_init` takes more than a few
>>>>> milliseconds to execute on a Dell XPS 13 9370 (Intel(R) Core(TM) i7-8=
550U CPU @ 1.80GHz).
>>>>>
>>>>>> ```
>>>>>> [=E2=80=A6]
>>>>>> [ 0.144474] calling  efisubsys_init+0x0/0x2cf @ 1
>>>>>> [ 0.144474] Registered efivars operations
>>>>>> [ 0.173690] initcall efisubsys_init+0x0/0x2cf returned 0 after 27343=
 usecs
>>>>>> [=E2=80=A6]
>>>>>> ```
>>>>>
>>>>>
>>>>> To get a vanilla Linux kernel to boot in well under one second, it=E2=
=80=99d be nice
>>>>> if the time could be improved. Do you know, why it takes so long?
>>>>>
>>>>> According to `bootgraph.py` from pm-graph [1][2] it takes even a litt=
le
>>>>> longer.
>>>>>
>>>>>> efisubsys_init: start=3D690.841, end=3D720.493, length(w/o overhead)=
=3D31.250
>>>>>> ms, return=3D0
>>>>>
>>>>> There are several dozen calls to `virt_efi_get_next_variable()` all b=
ut one
>>>>> taking around 0.335 ms. This path needs to be optimized. Is that poss=
ible?
>>>>
>>>> That depends. These are firmware calls, so to make these calls faster,
>>>> you need to modify the firmware, not the kernel.
>>>
>>> Yeah, unfortunately, no free firmware runs on this laptop, and Dell doe=
sn=E2=80=99t respond to these kind of reports, as they think, it=E2=80=99s =
not important.
>>>
>>>> We may be able to make more intrusive changes to get rid of this
>>>> delay, e.g., spin up a special kernel thread, but I'd have to check in
>>>> more detail.
>>>
>>> That=E2=80=99d be great.
>
> On the MSI B350M MORTAR (MS-7A37) it takes even longer, almost 50 ms.
>
> ```
> [    0.204009] calling  efisubsys_init+0x0/0x30a @ 1
> [    0.204009] Registered efivars operations
> [    0.252262] initcall efisubsys_init+0x0/0x30a returned 0 after 46875 u=
secs
> ```
>
> If a solution could be found to move this out of the hotpath, that=E2=80=
=99d be great.
> But I am not sure, if threads can be used that early.
>

Could you narrow this down? Which call in efisubsys_init() is taking
up all this time?
