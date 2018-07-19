Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD75ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5994D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGdPGBLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbeGSOwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:52:14 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43717 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbeGSOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:52:14 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so7171550ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dkWjQNn9a0ArV0jfLRsfivyiS66V30i3wp2Sc6sigk0=;
        b=BGdPGBLrt70E4JJN+eGtksCbauerKrYCySEzhONBz0acxKMngSryvU1WyGX6sGB6jE
         JP3GsGr2xZ65xMzMgHNsz3yV69od+MDbfHwC8neOwN7M+MOnrt25NaZ2iPVMFWq4xRPg
         ccIwOj++nLxuBBZV6YAdTo6bO4YAcMFh/XDYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dkWjQNn9a0ArV0jfLRsfivyiS66V30i3wp2Sc6sigk0=;
        b=GnZsuBvwZ9NugKOaH7FSiKG9d9mJzc3VP3yV3Q1F59KEpfWShngLvcAeZZqp4pOET2
         xCf56cVpMNWdocK/kh1MnD53SEMMcQdiqtAGUHIOua/1VsNjCOBeef9FcsGWker7XpMu
         YGIgOpaNPAKvlyP1cl8Cj3iLHRg1sENn40Sre/wUu1uNi74oYFvS51jXfzgyLw0OZGQO
         hJDJ5PqebiPl8qJceLMeGJrilk4xc+sE08f3fBMv9imeFOc8LAJhHDf56cReatNINMGC
         P8JIVRSvLsi8tFwTdGoK/P1qaApfKOyH/YxPBRhK049KIaEzRMBK71lzYaMQFaDryBYl
         6BwA==
X-Gm-Message-State: AOUpUlFn9ah1mjKqBJsM0TCWyDUe8hyhuqLrbfKpvML+QBrDbfTEbtiY
        jxaSsYiHPp6fE+Ts8Gb0vOiV9ZJ3SpQaM2HNWiXFXQ==
X-Google-Smtp-Source: AAOMgpcOIK6pqAbhN6ZAhLb2f8krzHPi+go43U7rLg4/br/N6zrsGz+k2zjd0iPBcmZZ0XcgNCj37cUye/waiaRewJg=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr8553453iof.173.1532009332906;
 Thu, 19 Jul 2018 07:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 07:08:52
 -0700 (PDT)
In-Reply-To: <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com> <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Jul 2018 23:08:52 +0900
Message-ID: <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 July 2018 at 19:55, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
> Hi,
>
> On 2018/7/18 23:34, Ard Biesheuvel wrote:
>> On 18 July 2018 at 19:59, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Jul 18, 2018 at 9:30 AM, Xiongfeng Wang
>>> <wangxiongfeng2@huawei.com> wrote:
>>>>
>>>> I tested the performance of software implemented ciphers before and after
>>>> applying this patchset. The performance didn't change much except for
>>>> slight regression when writting. The detail information is as follows.
>>>>
>>>> The command I used:
>>>> cryptsetup -y -c aes-xts-plain -s 256 --hash sha256 luksFormat /dev/sdd1
>>>> cryptsetup -y -c aes-cbc-essiv:sha256 -s 256 --hash sha256 luksFormat /dev/sdd1
>>>> cryptsetup -y -c aes-cbc-benbi -s 256 --hash sha256 luksFormat /dev/sdd1
>>>>
>>>> cryptsetup luksOpen /dev/sdd1 crypt_fun
>>>> time dd if=/dev/mapper/crypt_fun of=/dev/null bs=1M count=500 iflag=direct
>>>> time dd if=/dev/zero of=/dev/mapper/crypt_fun bs=1M count=500 oflag=direct
>>>>
>>>> Performance comparision:
>>>> --------------------------------------------------------
>>>> algorithms      | before applying   |   after applying
>>>> --------------------------------------------------------
>>>>                 |  read  | write    |  read  | write
>>>> --------------------------------------------------------
>>>> aes-xts-plain   | 145.34 | 145.09   | 145.89 | 144.2
>>>> --------------------------------------------------------
>>>> aes-cbc-essiv   | 146.87 | 144.62   | 146.74 | 143.41
>>>> --------------------------------------------------------
>>>> aes-cbc-benbi   | 146.03 | 144.74   | 146.77 | 144.46
>>>> --------------------------------------------------------
>>>
>>> Do you have any estimate of the expected gains for hardware
>>> implementations?
>>>
>>> Would it make sense to try out implementing aes-cbc-essiv
>>> on the ARMv8 crypto extensions? I see that Ard has done
>>> some prior work on aes-ccm in arch/arm64/crypto/aes-ce-ccm-*
>>> that (AFAICT) has a similar goal of avoiding overhead by
>>> combining the usual operations, so maybe the same can
>>> be done here.
>>>
>>
>> I am having trouble understanding what exactly this series aims to achieve.
>>
>> Calling into the crypto layer fewer times is a nice goal, but a disk
>> sector seems like a reasonable granularity for the dm layer to operate
>> on, and I don't think any hardware exists that operates on multi
>> sector sequences, where it would pay off to amortize the latency of
>> invoking the hardware over an entire bio.
>
> I don't know much about crypto hardware, but I think a crypto hardware can handle
> data more than one sector at one time. So I think passing the whole bio to the hardware
> at one time will decrease the overhead in passing each sector alternatively.
>

But this will only be the case if the accelerator is capable of doing
the IV generation and en/decryption of multiple contiguous sectors in
a single call. Otherwise, you are just shifting work from one layer to
the next.

So at this point, it would be useful to clarify what exactly these
accelerators are doing and how.
