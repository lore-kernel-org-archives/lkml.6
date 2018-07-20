Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D906ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF7B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc4OUwwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF7B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeGTBsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:48:05 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42962 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:48:05 -0400
Received: by mail-io0-f196.google.com with SMTP id g11-v6so8632658ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=thCmha/x3iDQih8sEVZ1s/JipgEwA3VYYsSrvLe9QKo=;
        b=Jc4OUwwhCL9y+tHR1pL8mppiCewGmws/OWadx2ADrAT/XZcG9IWqeyEubbAnhL8leH
         GB85DaolK7a1mWd096Q75sWCzsnOLKzKHLiz2fngIUFEXcVmAoqBprSnVcFpJG5bM8ks
         JBRf5eHWHIiE2Ukg7z1w6ZOKNiClInQFzml0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=thCmha/x3iDQih8sEVZ1s/JipgEwA3VYYsSrvLe9QKo=;
        b=amjykb7cuVZhbgBPDFNMGIWxDS5Y8w35VVPauhDbn3lv5Xa04Hygxez7OWjJkH+55J
         IpwiBq1Rxj+UWfFm/OFhnEszKwGn6vEkuXXHdF0r097bzhEqDxByE5Js4jRWOKveOhbq
         qVJk1QVUQbL55mrs9Q2W4iBS9YsAbSMmQ/bqdK8omxqyhz5yU/ULFgvpFba36b0LSTUc
         Z26DS3TNkf/Ma8W4yYnzktJtSsBMWWLD5dJ6z1s/rc3kc/N92XpzSi6mD+djO2iJyjQ+
         ucA1hIpJLhyuSmGfwdboe+vr51gH4HzhkcE9s6f+yhjiRwreI57V7OqTw7Gwrhw4AlTL
         q/eQ==
X-Gm-Message-State: AOUpUlFaS3idpn/Gp8tABLRm/D+1JUo6tu73r9kbpkfdGVW3834T9e7p
        oZIvGfN3DfuUghHW8/Aztm4BG8YggUAXU4IwiaGE7Q==
X-Google-Smtp-Source: AAOMgpfE26W+E7892luIALh6sTBDsPP0IiBMW0AHVy3jToYhnK16VM46Jse9IbKaDmveg2TtEQLHhctkyx6+iGNtkbY=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr10320249iof.173.1532048541992;
 Thu, 19 Jul 2018 18:02:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 18:02:21
 -0700 (PDT)
In-Reply-To: <20180719155026.GF27938@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com> <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 20 Jul 2018 10:02:21 +0900
Message-ID: <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Mark Brown <broonie@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 July 2018 at 00:50, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 19, 2018 at 11:08:52PM +0900, Ard Biesheuvel wrote:
>
>> But this will only be the case if the accelerator is capable of doing
>> the IV generation and en/decryption of multiple contiguous sectors in
>> a single call. Otherwise, you are just shifting work from one layer to
>> the next.
>
>> So at this point, it would be useful to clarify what exactly these
>> accelerators are doing and how.
>
> Existing hardware can definitely do the IV generation and I believe that
> it can chain multiple sectors together though I'd need to confirm this,
> as mentioned elsewhere in the thread the ccree driver is for one of
> the relevant devices.  I've poked some relevant people.

As far as I can infer from the ccree driver source, IV generation and
en/decryption are separate operations, and given that each sector
requires both operations to be applied in sequence, letting the crypto
layer handle an entire bio does not have any benefit *at the moment*.

In fact, it seems to me that the ability to use protected AES keys is
much more appealing than any performance argument (including 'it may
be slower but at least it does not load the CPU'), so some background
on how such a change would enable this use case would be beneficial as
well to getting this adopted.

So my recommendation would be to focus on moving the IV generation
into the crypto layer, but conservatively, and not confuse people by
making additional changes that could theoretically improve
performance, but only on hardware that does not exist.

-- 
Ard.
