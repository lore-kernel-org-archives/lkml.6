Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0741CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DF4205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A65+jT6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DF4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIEUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:41:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37725 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeIEUlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:41:20 -0400
Received: by mail-io0-f193.google.com with SMTP id v14-v6so6426427iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5uZKHnXivNKXFPp0+S3F7wcqXy7dhrffCOf5jF5od9c=;
        b=A65+jT6Jpkmhte+9cYqdm4FKcdFFlDMAOPTNtRoaVhMiJXwHnue/qKVPH0LoojUwz2
         xXzS0L0D7oZBEhB1KP8nEq7UfB77Kqs3S4dVz26LzzQ5JhOk53/MGlwi5mS0ZKaUGx40
         mvTyoWaxF792s/+lTPO4+7sjVnMRBrvZ7rGhtuvek445fdjQBfQKRNJHBCReJ5NcROgQ
         LE4MSw3MdJRFx7Q2HnW7B81dAVDFTLXjeE1SUBjSCAdPJH2oWsd3mJhsEJBUUlhLCDlu
         4FwDFL+Dmj9E2HcK6NbszD4ZsnPlywJOGD4I/ljKNb3M1DAlbCuQPrAFwKieW7QeqfJh
         xATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5uZKHnXivNKXFPp0+S3F7wcqXy7dhrffCOf5jF5od9c=;
        b=PzQZMDx+nslJM5+a7ZLxEAE3lJ4VDgwLH3+MNXsOSuUksUdk39pO3fcYb9i16FNpw2
         Qx2QhSHME74vOLo+S9pi62aDFlWWcKELQMW8G+cio6i52TFxiTK6BUOgBc56I7LM197s
         QZD9nJcY/5JyIAZatBG8J8rHLBG93FNBKZxlNKkIq2nGgv/jmy9WkpIX/yXEvLYkbf/8
         +raZhIEYA5UgP0nLsH9nTz7axPVkDmg51QEdWpNSgE09ITy9VJLEVa3OpcqhDICeNcvl
         Q/F2ZzJKKemnPopgNnYONwUgpozp3yitBOrVvJiBhYD8VGn4De4kwmCMcicOkZaEI9vE
         cQlQ==
X-Gm-Message-State: APzg51Cun5LKkyNwH1jj64lJd8Dnfjy9Edz81bGfH1i5VdT1ADZiQ1Uy
        nne/s1EVxGmPu2175ntaaf/Fmiq2hSs=
X-Google-Smtp-Source: ANB0Vdb/kK0Ncj+S3c1hiZfH+8t57P9Sei99hsv02dmnlqgSGez1lZ09RlDiCMA3NIOfhAUAqaFgMQ==
X-Received: by 2002:a6b:1487:: with SMTP id 129-v6mr27848433iou.103.1536163827023;
        Wed, 05 Sep 2018 09:10:27 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g6-v6sm793227iom.48.2018.09.05.09.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 09:10:25 -0700 (PDT)
Subject: Re: [PATCH v7] drbd: Convert from ahash to shash
To:     Kees Cook <keescook@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>
References: <20180806233216.GA6037@beast>
 <CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
 <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com>
 <20180905083320.GA28462@soda.linbit>
 <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a643254-cc1d-0a27-17a7-40651b503256@kernel.dk>
Date:   Wed, 5 Sep 2018 10:10:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 10:04 AM, Kees Cook wrote:
> On Wed, Sep 5, 2018 at 1:33 AM, Lars Ellenberg
> <lars.ellenberg@linbit.com> wrote:
>> On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
>>> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
>>>>> In preparing to remove all stack VLA usage from the kernel[1], this
>>>>> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>>>>> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>>>>> to direct shash. By removing a layer of indirection this both improves
>>>>> performance and reduces stack usage. The stack allocation will be made
>>>>> a fixed size in a later patch to the crypto subsystem.
>>>>>
>>>>> The bulk of the lines in this change are simple s/ahash/shash/, but the
>>>>> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
>>>>> externalizes the page walking with k(un)map_atomic() instead of using
>>>>> scattergather.
>>>>
>>>> Hi Lars! How does this look to you? If you can Ack I assume Jens would
>>>> be able to take this.
>>
>> Sure, I should have ACKed it a month ago already.  As I said, I believe
>> you the crypto. And you added the kmap_atomic as I pointed out.
>> All good.
> 
> Great, thanks! Jens, can you take this?

Done, queued up for 4.20.

-- 
Jens Axboe

