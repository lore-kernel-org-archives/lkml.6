Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656EBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15982208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqU3NKR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15982208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeFRPyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:54:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43240 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:54:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id x13-v6so9994774lff.10;
        Mon, 18 Jun 2018 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3hKAVLzfIifDOnQ5GcUZCgn4Xvs5h8QJDhIf9NJHqt8=;
        b=XqU3NKR84B6Vy5NNZWJSYcwKvsh8uZcVYsIoycQ+d3iTHe/s9wOVGTLtGU0AnM2Xfz
         gZ6TvdDrBw4yeZHe1YnuCtLF2V/kodzzGdMIjKOCzTXO0r/j4t+Jm8XBuMGm/My8D+D5
         gpftF8Np9cT7Dpcm1Ki9p8OW8I4lptL9ptrUKvNSYxMlwSqCG4qLAUCIAIOMqpr4gKwX
         6T6I1UxxZB2ZLRglWtUIXOyTlcD39H3fwSEG4iKzkuIb3JTSUD4IGeqlp1VBX0b5nxVA
         WShedKKEd4I61QSFxeoSU+emv/gfQWzrM29tMXzSppLGcuyjdSI5Tl90SWLaZPqAjKbV
         j44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3hKAVLzfIifDOnQ5GcUZCgn4Xvs5h8QJDhIf9NJHqt8=;
        b=cZWmbYth1LY5WMJbyAyHHEtXQygZ8olSjWe4XUBvca0LX9O9KLxnTWdTBq7P76BKjZ
         5XRCkGRMnv+1QCQCY0sFgb4F5DjQ4O86gH4CbVWdMmR5Jt7SzWgJFNQc2E/9F9vV+FOE
         foSkfDettdHMssn4huHnwEV4rbD/tavdZRR7jCu8pGCfPCXQOLHd7TvcM53ScJjdKs/p
         lpMtzs7oKBuzK2XLJn3j0SIG9fWYlmrrQYgrIyP9RhkI9jUFeYIxHBL2VnkHXcgvFb1U
         rY4bqd7EnsWorxenzRe1pf09Rwiw0mVAXFOUoHo3PjG4tezJU5FxwFyfWWeAYu+vE9F8
         78hg==
X-Gm-Message-State: APt69E2geZ965IhWlDmjVrtm5fKA+DG8Qp4Yprbvv9DUx3MgBz8wCD3h
        Mdu35IJPPICNeWoHkpc3TFpHkcHHpk6q1surv+I=
X-Google-Smtp-Source: ADUXVKJItGfsISV6O5mIM15+fGQ2ue1fHU9i1ZcNb/IB7pBOr9ZIIgxEqLhh05CsbSTHA1pwx0yak181fqTI2cEhtCM=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4-v6mr8542682ljj.60.1529337247509;
 Mon, 18 Jun 2018 08:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:54:06
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9OD6s24Aq1bLBr-yq_tn6wPR0TAkddO+VTwM7jR76dOQ@mail.gmail.com>
References: <20180618141811.3353245-1-arnd@arndb.de> <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
 <CAK8P3a0dP+zvucn=_um1zRgBYQCskrhqa2KNSDtnpSu199baWw@mail.gmail.com> <CAKv+Gu9OD6s24Aq1bLBr-yq_tn6wPR0TAkddO+VTwM7jR76dOQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 17:54:06 +0200
X-Google-Sender-Auth: SJkqwjjQWb-hW8abZFQwZnEr2u8
Message-ID: <CAK8P3a0xkPrDhoHaUzcN++b7TEh3v_a=VkP6VX9_FD56pG1A6w@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: avoid using get_seconds()
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gengdongjiu <gengdongjiu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:50 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 18 June 2018 at 17:49, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Jun 18, 2018 at 5:47 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 18 June 2018 at 16:17, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>>> -               atomic64_set(&seq, ((u64)get_seconds()) << 32);
>>>> +       if (!atomic64_read(&seq)) {
>>>> +               time64_t time = ktime_get_real_seconds();
>>>> +
>>>> +               /*
>>>> +                * This code is unlikely to still be needed in year 2106,
>>>> +                * but just in case, let's use a few more bits for timestamps
>>>> +                * after y2038 to be sure they keep increasing monotonically
>>>> +                * for the next few hundred years...
>>>> +                */
>>>> +               if (time < 0x80000000)
>>>> +                       atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
>>>> +               else
>>>> +                       atomic64_set(&seq, 0x8000000000000000ull |
>>>> +                                          ktime_get_real_seconds() << 24);
>>>> +       }
>>>
>>> Given that these values are never decoded and interpreted as
>>> timestamps, can't we simply switch to the second flavour immediately?
>>
>> I considered that, but the downside would be that all future filenames would
>> come before all past file names.
>
> Won't we have that same problem in 2038?

No, it goes from 0x7fffffff00000000 to 0x8000000000000000, followed
by 0x8000000001000000.

       Arnd
