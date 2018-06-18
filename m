Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98226C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535B320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIGxEmxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535B320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbeFRP4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:56:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32811 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:56:49 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so17291322ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J5pI/CLxDk6iMltH+Q33WiPDg4PaCYI66jUUvwkBGwQ=;
        b=IIGxEmxmAIp5t8gd3AUlTEmnh5jXX45p6nl6BYVqeMX208D/f6LBrguDJmMH59otMy
         TvOWWP+1RYXfy52NZzx+jTrzKmYipBt91/aaB2UpKutMLejIl/Ii4VW0jEmm68r4w3TE
         OUsJfzwyAHz8cNoV5XyvosloiqlnoP8Crhq1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J5pI/CLxDk6iMltH+Q33WiPDg4PaCYI66jUUvwkBGwQ=;
        b=mOiChcHzFhoXS/ozDXtUPOznMc2MDwQEk7I38GnJ2HjLv5JEyNq41skJzSAI9E2QMh
         qVwLFi782EXz7ZPnuXeDGxqyeQkA9nccw1T51QupxOg2N3z95LNGSitQnK0wq9eZXlHX
         EyAWjxXU7zmpS/cvXgBsmKZ9Mzz4el666/2DC6cLEZEeOBtEZB0b3h5e8mXN9WVfcnCa
         b46ctNO0lUyyqmsQ8MpxX7/Vgdfpwg+xXOg8RKqn5zgdW52gjVxhrguHlVIFGezBlGOL
         6sVdMDcQBbGFMEtlf0rOFwupaLiJJoNrETam1jEIEVFAlj09DleSwC/fdabYlxozEyEh
         g1dA==
X-Gm-Message-State: APt69E1d508/PgBMQqSDppJKcJatr576oRbU9TF1LDPcuswTbqS36A9Q
        rmj+JhDOpKdGtJpgTJZpuLzpNouKx/uNl7RmOH4BSA==
X-Google-Smtp-Source: ADUXVKI6WyM6NIj+UasgpYH4I2BEK4kmBxTnH0zUJgrLNsA6fk+e6w0uSG71UoviwIQzfxrxlG7t4ofGHp3nvU0f7fk=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr11152129iob.60.1529337408628;
 Mon, 18 Jun 2018 08:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:56:48
 -0700 (PDT)
In-Reply-To: <CAK8P3a0xkPrDhoHaUzcN++b7TEh3v_a=VkP6VX9_FD56pG1A6w@mail.gmail.com>
References: <20180618141811.3353245-1-arnd@arndb.de> <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
 <CAK8P3a0dP+zvucn=_um1zRgBYQCskrhqa2KNSDtnpSu199baWw@mail.gmail.com>
 <CAKv+Gu9OD6s24Aq1bLBr-yq_tn6wPR0TAkddO+VTwM7jR76dOQ@mail.gmail.com> <CAK8P3a0xkPrDhoHaUzcN++b7TEh3v_a=VkP6VX9_FD56pG1A6w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 18 Jun 2018 17:56:48 +0200
Message-ID: <CAKv+Gu9zYJk+ubcn8ngqsXPBbxWM-S5kUWAHfe_zKDm1=FWB4w@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: avoid using get_seconds()
To:     Arnd Bergmann <arnd@arndb.de>
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

On 18 June 2018 at 17:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 18, 2018 at 5:50 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 18 June 2018 at 17:49, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Mon, Jun 18, 2018 at 5:47 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 18 June 2018 at 16:17, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>>>> -               atomic64_set(&seq, ((u64)get_seconds()) << 32);
>>>>> +       if (!atomic64_read(&seq)) {
>>>>> +               time64_t time = ktime_get_real_seconds();
>>>>> +
>>>>> +               /*
>>>>> +                * This code is unlikely to still be needed in year 2106,
>>>>> +                * but just in case, let's use a few more bits for timestamps
>>>>> +                * after y2038 to be sure they keep increasing monotonically
>>>>> +                * for the next few hundred years...
>>>>> +                */
>>>>> +               if (time < 0x80000000)
>>>>> +                       atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
>>>>> +               else
>>>>> +                       atomic64_set(&seq, 0x8000000000000000ull |
>>>>> +                                          ktime_get_real_seconds() << 24);
>>>>> +       }
>>>>
>>>> Given that these values are never decoded and interpreted as
>>>> timestamps, can't we simply switch to the second flavour immediately?
>>>
>>> I considered that, but the downside would be that all future filenames would
>>> come before all past file names.
>>
>> Won't we have that same problem in 2038?
>
> No, it goes from 0x7fffffff00000000 to 0x8000000000000000, followed
> by 0x8000000001000000.
>

Ah, right. I'm with you now :-)

I'll queue this in the efi tree.
