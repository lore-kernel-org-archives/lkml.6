Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4988208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="czfYyrC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4988208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeGPLfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:35:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35102 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeGPLfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:35:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so74000558oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zjxeIBvT9PBh5bwZXeniTtztxDo1NPD2AJgFiKLinMo=;
        b=czfYyrC5+C8qU77FNNnnj6Q1FHOTbg/Hw1+uvjZryO0+/RHcm+wLaLPGgaqscKNHKf
         GOeT3btUzwfh1O6RBEeLBEQZ3eoBm5yQ6b26/jQmvsNyUzQcDV5Byd1ARAaacJCdwvIb
         lnTFPyns9mdHiUQ4GYe/DFfQelOEpaQu6Csh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zjxeIBvT9PBh5bwZXeniTtztxDo1NPD2AJgFiKLinMo=;
        b=Ib6zimUVOJsbrur9mSNJ5Se0QIiXJsyJfi4/Yfu4460wA6db30iODwNccsgZvXEOgc
         rtAkjQk5ZKlelMwC4zqlh0y4hlMWQSxyolVTFap+UpGxIb/lUC+sbs3mMTZAAMyCP4Hx
         6uv7lv0P3YnZ0DsPgp3xFBK972trqqB/2QyzMhpqYG1MZoHOv1j7i5Y9ol8kLYvHiQAN
         M4PGECzUtRV64w2l0S25ANFgbXqbuGgNLGoARRGvqN09rZaczoGXGZNecHdijPWBdvM7
         E8KR3B8qDRP6WqBGRYEtNTRkC20poBYck+0eoV0HoBBxmK9jc/uM9KrDl9Y6ntyCI1Xs
         DolA==
X-Gm-Message-State: AOUpUlHw/Pk1Xkrp6clISj01ekwFQtABUev4Lx0Eir4BqXUE7zPX7UlE
        5H6AdNAjk8Q1+xEI98s3iZ5zdxeeNyzyVmCVu9Cbewxe
X-Google-Smtp-Source: AAOMgpd3TRbOx0t+hqcLuLvJMBpT5EKYvbhp8lT1dE39XdwGwJ0MfWQSrOYq2BdUTvWwsFK7laEJC5MfD2F9bTOeksQ=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr18113264oih.31.1531739338755;
 Mon, 16 Jul 2018 04:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 04:08:58
 -0700 (PDT)
In-Reply-To: <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
References: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
 <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com> <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd> <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 16 Jul 2018 19:08:58 +0800
Message-ID: <CAMz4kuKw+nQp55w5XeNYE3TVq1KnQFG3-yEsG4vANqu4yC3CTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 July 2018 at 20:22, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> On 07/15/2018 12:39 AM, Pavel Machek wrote:
>>
>> On Sun 2018-07-15 00:29:25, Pavel Machek wrote:
>>>
>>> On Sun 2018-07-15 00:02:57, Jacek Anaszewski wrote:
>>>>
>>>> Hi Pavel,
>>>>
>>>> On 07/14/2018 11:20 PM, Pavel Machek wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>>>> It also drew my attention to the issue of desired pattern sysfs
>>>>>>> interface semantics on uninitialized pattern. In your implementation
>>>>>>> user seems to be unable to determine if the pattern is activated
>>>>>>> or not. We should define the semantics for this use case and
>>>>>>> describe it in the documentation. Possibly pattern could
>>>>>>> return alone new line character then.
>>>>>
>>>>>
>>>>> Let me take a step back: we have triggers.. like LED blinking.
>>>>>
>>>>> How is that going to interact with patterns? We probably want the
>>>>> patterns to be ignored in that case...?
>>>>>
>>>>> Which suggest to me that we should treat patterns as a trigger. I
>>>>> believe we do something similar with blinking already.
>>>>>
>>>>> Then it is easy to determine if pattern is active, and pattern
>>>>> vs. trigger issue is solved automatically.
>>>>
>>>>
>>>> I'm all for it. I proposed this approach during the previous
>>>> discussions related to possible pattern interface implementations,
>>>> but you seemed not to be so enthusiastic in [0].
>>>>
>>>> [0] https://lkml.org/lkml/2017/4/7/350
>>>
>>>
>>> Hmm. Reading my own email now, I can't decipher it.
>>>
>>> I believe I meant "changing patterns from kernel in response to events
>>> is probably overkill"... or something like that.
>>
>>
>> Anyway -- to clean up the confusion -- I'd like to see
>>
>> echo pattern > trigger
>> echo "1 2 3 4 5 6 7 8" > somewhere
>
>
> s/somewhere/pattern/
>
> pattern trigger should create "pattern" file similarly how ledtrig-timer
> creates delay_{on|off} files.

Yes. Anyway, I will submit V5 patchset with addressing previous
comments, but did not include pattern trigger issue.

-- 
Baolin Wang
Best Regards
