Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920F221535
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+S+4Bsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920F221535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeHFJk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:40:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40070 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeHFJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:40:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so20470924oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tog5QihY5HZr3YM7ZTKVV2+JHbHYnlrshz7ucJgx+qc=;
        b=O+S+4BswuYpsfOtrEuMFQjan83//DzTEmECBXQdUxc6Vq/GZpBKtMcfq1pwNiEytWO
         Uj2xxNpDNg2/ujikf9qM2FPbyVx1hUhA5P4zizwfvsKmfdb6uaxaxRFyvIcRQNoyi0Fv
         AIzfF99zwhVSq/OyB3vN9RTsHrZQgpwRhkGqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tog5QihY5HZr3YM7ZTKVV2+JHbHYnlrshz7ucJgx+qc=;
        b=YW/TGCKhOJfTln4aVujgg7CO3utOEkVc3EuZbU2xR9IQlz4m5AWl14FiuL126Afs/a
         fw1F05z1x/YcSBBcNtQ1AoSLdd9Q1F7Y4JbCM8t7SZ1q+kmWD4vMuwqfiN8vWorhuWFz
         4kpfvoKvnaPjEEsd49BT2WoKKZelhlBvRpy1eUDLgSYgXbR2TL3LcLtE4vjFIRo62QBy
         pbi39Qr8fw/7rLAJOKiKFwJDcJBReXjJPoeXRsYTt4vuTBqSOoSnrnTjyXwZcAmdJdcI
         8kWpdv8jAZrR/8TGtLktSvwRrnus9/wPk5o2438c7jKKxiQYRsXg97S6yz9LwciREqBT
         3N2g==
X-Gm-Message-State: AOUpUlHvJwLo0pn6So6C3K9VDTF9IpVFUa7KvyKef3C4IPNo8pjgEDdR
        FxZcgTypEKNcwq7KCLCmutvqcjK+1ogkLy/rhBWieQ==
X-Google-Smtp-Source: AAOMgpcXkF7AHm2VuwTQzG5VB/45PkKDUfpvjtpi10RG21Yjd1kZOPC4ZTfvwm8o1T77AKgJoTc1X1WJlMMIEjVFH9k=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr14456362oie.168.1533540793168;
 Mon, 06 Aug 2018 00:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 00:33:12 -0700 (PDT)
In-Reply-To: <20180806070958.GA5231@amd>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com> <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
 <20180806070958.GA5231@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 Aug 2018 15:33:12 +0800
Message-ID: <CAMz4kuKdtFDfvc4Lrx6yG5yu=qYRPj8MS5phxcLBkdKAPwXZyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 6 August 2018 at 15:09, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > In current implementation this file on read returns the number
>> > of remaining repeat intervals. I'd add that to this description.
>>
>> I saw Pavel's comments that he did not suggest do this. So I will keep
>> the original description?
>
> If that is accepted, the code should return originally written number.

But I think it is more reasonable if user can know how many
repetitions were left. So for your hardware case, can we add
pattern_get() interface back to get the repetition number?

-- 
Baolin Wang
Best Regards
