Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC7219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0Q6FcGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDC7219E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeHFKjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:39:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37976 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeHFKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:39:52 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so20733822oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pG4YbU/IINrULhPLQhHaYcTCt0yYRQ3J8bfMTKVcN6w=;
        b=C0Q6FcGS8tovnTQ4EncHz+fYo7trPOPaJwjSFkHBBJlONrFJAy+lFqwNHq+4qFIIXb
         JUtWXt0be2/jzVZ2ElsQMgaOErJlXey3MzyQ84dsIr2NUuLQjBMKAHcVBRBMH40ZbTPQ
         vZ7ODLfxsGc4GW8K4RTFZC6mfX7vC1zrb8yAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pG4YbU/IINrULhPLQhHaYcTCt0yYRQ3J8bfMTKVcN6w=;
        b=TN8xR2YUQAZyC0gJNmZXgdkSNxcJBfO5YccuzHL9HA2rb8tLxxQqsVC7yNoS67RoMd
         N3/bG/JHxltN5Z+zC2eToIEWfqqgAVEl4IU4Pal1WAk7Mo840Ui3Q+oW6NMdCMTna/Qn
         cH+VI8hwhjsGfol77SVBECZJ5bjX9+qvTIv+SlNFtsHgUA5+g9fF3KQ2TLb02YY3Te4L
         11ZKrzXOoUHc/c7Naa038EKEkanFppUcV3FZCbNZMut1/vCx38wzgjb+rQ1zbTD3/OHK
         eN+YxRuhxpcVzFlLLY+4pjwKRpqKTdnMHUEkeb58JoY1i2HIJVbGnAuw8aJyv+y9OP5O
         iWcg==
X-Gm-Message-State: AOUpUlFP/CXNgViMtw8OxaTl5WSaF2Rueeva9AmPhe08TyAQNlHaKTkV
        8KKUKFvXJA6MpyCPjytSeBWFzL1to9M9qdpNhA6D1Q==
X-Google-Smtp-Source: AAOMgpdq8huxZp2Njr9yZwRXRF+i6WX+0XBQuNw7wACzOkJhGOPDbhCaxcARs11te4d8lwwhyHam/LY2a+WH600qDDY=
X-Received: by 2002:aca:c5:: with SMTP id 188-v6mr12960731oia.128.1533544315358;
 Mon, 06 Aug 2018 01:31:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:31:54 -0700 (PDT)
In-Reply-To: <20180806080617.GA19523@amd>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com> <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
 <20180806070958.GA5231@amd> <CAMz4kuKdtFDfvc4Lrx6yG5yu=qYRPj8MS5phxcLBkdKAPwXZyQ@mail.gmail.com>
 <20180806080617.GA19523@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 Aug 2018 16:31:54 +0800
Message-ID: <CAMz4kuJMPc6bVZZbJif2cmx3Ea0xc1Bc4JYyEQjaskppGNddtA@mail.gmail.com>
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

On 6 August 2018 at 16:06, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-08-06 15:33:12, Baolin Wang wrote:
>> Hi Pavel,
>>
>> On 6 August 2018 at 15:09, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> > In current implementation this file on read returns the number
>> >> > of remaining repeat intervals. I'd add that to this description.
>> >>
>> >> I saw Pavel's comments that he did not suggest do this. So I will keep
>> >> the original description?
>> >
>> > If that is accepted, the code should return originally written number.
>>
>> But I think it is more reasonable if user can know how many
>> repetitions were left. So for your hardware case, can we add
>> pattern_get() interface back to get the repetition number?
>
> Well, I'd say that we are mostly seeing "infinite" repetitions, or one
> repetition.
>
> Yes, interface could be added to the lowlever driver -- but I'm not
> sure hardware really supports getting that information; could be
> tricky on N900 for example.
>
> I'd keep it simple for now.

OK, I also like to keep it simple. I am fine the repeat file returns
originally written number. If Jacek also agrees with this, then I will
update new version.

-- 
Baolin Wang
Best Regards
