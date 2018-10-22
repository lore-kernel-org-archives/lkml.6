Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18FEC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DFF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBkVLBwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DFF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJWBlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:41:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbeJWBlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:41:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8-v6so6340164wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0kxlVNP/eQiUbzjfgGFdxCTXDzlqKmKDPqXfqoOJr4=;
        b=ZBkVLBwErLxXqvNdiuJngBoEr8fuNhY1PitnjzI2SbWXkN+naB1xlzeQClRjssAd6o
         IOqHb5KcWdeRsUCuntvLpO19A+EtscnfU1mbFkht20HVGskfgfqkccfMePoZhUeD0Dc9
         NTr9/gaUdvfewVyAea29MGjoInlzODdcRcGIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0kxlVNP/eQiUbzjfgGFdxCTXDzlqKmKDPqXfqoOJr4=;
        b=LSJGbPapzlOvt3zvZhMVwwZc+tfrx3ALB3eRhbO18ifAYYY9u5AwFVbvc9dntud9PW
         /a1DdLzdZ+1aKRKtyy75FQkSZCxNZw/BVKaNWnYAHFDkMBOiiij3Vvp8CVcTLMWQqGYL
         9ecQ8Vqk3khnReyj5eFT8DYgjjClWcz4ERqHfALqgxZZJY2WpmjkrqbyF6orZ/xUFqLJ
         h7i0WVHVjqrhNMr701KKRYMxxfnaGOUSzAFVWctYgaq1Wvevs7Kb6YXASCff9ERbJ0+Y
         mo0y7sTIyWfFEkGVqY7gUQ12sALzjttSAKRFmR3O/sv7/WAv4HRv9zaiNJYo/KGaXGu9
         ILFQ==
X-Gm-Message-State: ABuFfohaBqAV2aPQnFRlatrq6OYn4VkqbNGRUtp1NCM4PWY1eESbw8Iq
        Fy7qqPqcd4TEchy8en80ykrCB5Y0gnYt9C2UAeTMmA==
X-Google-Smtp-Source: ACcGV61xK7EBtH3Ky1VUbckS6sVvW68OjPPpu4TE6P5Qvuge6RQwSzg0/dPnJlxk4OcSCdfEI9iHhABMJoR4b9umzGQ=
X-Received: by 2002:adf:ba06:: with SMTP id o6-v6mr21097597wrg.249.1540228896313;
 Mon, 22 Oct 2018 10:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 10:21:35
 -0700 (PDT)
In-Reply-To: <CALAqxLX0Q3Yo-75CDdG4g7i5G=i5OPi01ApYyJO6wTn4CSCkPA@mail.gmail.com>
References: <1538434698-1042-1-git-send-email-john.stultz@linaro.org>
 <yq17eiiwobx.fsf@oracle.com> <CALAqxLXYTZZ12haKHGwnTBqPgkv_JF8=fiiJrD9OWRFdcXf0Sw@mail.gmail.com>
 <CALAqxLX0Q3Yo-75CDdG4g7i5G=i5OPi01ApYyJO6wTn4CSCkPA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Oct 2018 10:21:35 -0700
Message-ID: <CALAqxLWv1v+JiLjwJpQ_rFkwM4d86YRr1WeMLjg4=Wvwpd5MGw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:50 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Tue, Oct 16, 2018 at 3:48 PM, John Stultz <john.stultz@linaro.org> wrote:
>> On Mon, Oct 15, 2018 at 8:41 PM, Martin K. Petersen
>> <martin.petersen@oracle.com> wrote:
>>>
>>> John,
>>>
>>>> Hynix ufs has deviations on hi36xx platform which will result in ufs
>>>> bursts transfer failures.
>>>
>>> Is this specific to the particular implementation on hi36xx or all SK
>>> Hynix implementations?
>>
>> I'd have to defer to Wei Li on that question.

So I followed up with Wei Li and it seems its something specific to
hi36xx that the specific hynix chip brings out, which most other chips
don't seem to trigger.


> Just to short-cut things a bit, as this is probably an obvious
> followup: if it is hi36xx specific, how would you suggest a such a
> targeted quirk be added?  I'm not sure I see how to get to the
> ufs_dev_desc from the ufs-hisi.c code.

So yea, I've already reworked the quirk to be specific to the one
model of hynix chip, but I'm still a bit confused on best practices
for handling these quirks on the controller side. If there's a pointer
to similar controller side quirks that are device specific, I'd be
glad to rework the patch in that fashion. Otherwise I'll just try to
figure out how to get to the ufs_dev_desc from ufs-hisi.c

thanks
-john
