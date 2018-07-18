Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA538ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1agXNsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EBE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeGRQN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:13:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40551 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbeGRQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:13:27 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so4883808ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=He4vNQKX8oC642qSp1p3CYf4pfQMdNTC3BpNRAtzA3Q=;
        b=b1agXNsj3vOjMJf1hIDaY7rJFTEtc3fwMIpqoC7SiQGf1kWNkGsSx0Wji9fs25hE5+
         UuQxKAtcq2sVrbUnpFRWegiz6BkLSPtY/P3+aetamsHJgfYM5RDpyXRbvdYcwppmUDCb
         loESN1bkreIsYS6h79+UpEzTjNVQspvxD8R1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=He4vNQKX8oC642qSp1p3CYf4pfQMdNTC3BpNRAtzA3Q=;
        b=JG4BDMsO1lhcQnp7smzUTfL2+YMtH8VvQ7jBM1zboiZ49/U0Fv988Ej8Lp5VtW75+Q
         uIZ0/hezWvZ4K+eocEzUTUx/4ukk87JH2xVPZ00j5OpVgs8TPQcSk4U9Q1zKZA88qgmo
         D3/Pp5K7imukD5SHe6ROQQeRCvMbja96N/EEKwDHmedHwCVgrPnuPfUiDOUdP0p/ZXq9
         ou48AN57/38lJA7mT94t0rvhacGzcPV/rJk3p0YP4IsIJUZMjkeciVYMwnqUbW9TW/fL
         Mq3WU4QECVTs/Rj4VZ4/DEVpUc6O/Vd8FFuwOfOe9DFS6A4l07Nds6J5C63XEPprnKvs
         xx6g==
X-Gm-Message-State: AOUpUlHtapm2GOzDUZFV+JwH9vnpluxaN9Uw3t0eJKrCucqcWLTYkzQv
        MV9uOXKwjoylfyM8C14jVZjEy6jw7rYBTZWbq4zQtA==
X-Google-Smtp-Source: AAOMgpfDmegNVT3cfWOeoIWNIXSysYZt0zfG5Iy6WMt9R0T6rsO2QWSoidyfJOtlFAaDKbHArwJbHFmiFHgpDEv+lTU=
X-Received: by 2002:a24:d7c5:: with SMTP id y188-v6mr2417126itg.50.1531928100360;
 Wed, 18 Jul 2018 08:35:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:34:59
 -0700 (PDT)
In-Reply-To: <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com> <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Jul 2018 00:34:59 +0900
Message-ID: <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Alasdair Kergon <agk@redhat.com>,
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

On 18 July 2018 at 19:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jul 18, 2018 at 9:30 AM, Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
>>
>> I tested the performance of software implemented ciphers before and after
>> applying this patchset. The performance didn't change much except for
>> slight regression when writting. The detail information is as follows.
>>
>> The command I used:
>> cryptsetup -y -c aes-xts-plain -s 256 --hash sha256 luksFormat /dev/sdd1
>> cryptsetup -y -c aes-cbc-essiv:sha256 -s 256 --hash sha256 luksFormat /dev/sdd1
>> cryptsetup -y -c aes-cbc-benbi -s 256 --hash sha256 luksFormat /dev/sdd1
>>
>> cryptsetup luksOpen /dev/sdd1 crypt_fun
>> time dd if=/dev/mapper/crypt_fun of=/dev/null bs=1M count=500 iflag=direct
>> time dd if=/dev/zero of=/dev/mapper/crypt_fun bs=1M count=500 oflag=direct
>>
>> Performance comparision:
>> --------------------------------------------------------
>> algorithms      | before applying   |   after applying
>> --------------------------------------------------------
>>                 |  read  | write    |  read  | write
>> --------------------------------------------------------
>> aes-xts-plain   | 145.34 | 145.09   | 145.89 | 144.2
>> --------------------------------------------------------
>> aes-cbc-essiv   | 146.87 | 144.62   | 146.74 | 143.41
>> --------------------------------------------------------
>> aes-cbc-benbi   | 146.03 | 144.74   | 146.77 | 144.46
>> --------------------------------------------------------
>
> Do you have any estimate of the expected gains for hardware
> implementations?
>
> Would it make sense to try out implementing aes-cbc-essiv
> on the ARMv8 crypto extensions? I see that Ard has done
> some prior work on aes-ccm in arch/arm64/crypto/aes-ce-ccm-*
> that (AFAICT) has a similar goal of avoiding overhead by
> combining the usual operations, so maybe the same can
> be done here.
>

I am having trouble understanding what exactly this series aims to achieve.

Calling into the crypto layer fewer times is a nice goal, but a disk
sector seems like a reasonable granularity for the dm layer to operate
on, and I don't think any hardware exists that operates on multi
sector sequences, where it would pay off to amortize the latency of
invoking the hardware over an entire bio.

So in summary, you need to explain to us why we need this. It is
really very easy to convince people if your changes make things go
faster.
