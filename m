Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E27C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A7520878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9U7UJ2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A7520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbeGKMnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:43:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46752 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeGKMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:43:08 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so7706874ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sPwiriw5RMFLe9Dd8rKkkDSc9FciTk4lrfjW6jP3R2E=;
        b=K9U7UJ2CFHh9AlgdaX9wacaJTuwdpms5k7PzEQzi/L+FkcDKQ+puDcZHLLEZS0Csx+
         ofsZh7oIqSByCskrlbPjZ5VqsMDhQiIvSAvuYScj/DloFeKID3uzb/Nq4vk2hLxuueVe
         FbdpMAwCIhju5rQMgtukzDOOSJZkEwgbdLfZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sPwiriw5RMFLe9Dd8rKkkDSc9FciTk4lrfjW6jP3R2E=;
        b=TPa3KnBZvwSK4ZSlKfXjZo6fDYdEPg5oKUENyH/oc8Ir8x5IqH+CwgFgTH6jhkktWg
         bXy9jBn/WsliYunIaEGQQxmYRlP3mBT6l1SzuI7/V3fBA9DQOSj3CWhmjXje185yVFsZ
         xEaLjWytTcFLp3vJErUgzcA5Pp4B8fbC954CIZaZVLLB+4piDZAA8Va1DeMgy3Ly4/5J
         JM7WsPHKhu7ADB/LysJCy0Cl0sHFvzN5PL7aYvDljsNasCMknrJ3pLBhQoJp2cS3aygV
         YpUHmoJUDlnQCQn46m+Ld5Cfk8Q9Iv+StOYnM1TX9cPB/b464hxnGHmmoQwSFJuyBUXo
         qrIw==
X-Gm-Message-State: AOUpUlHVcg9qRHTr/8AjK3HqkXVmqSFdfitXFmxlLtutF4vl5l+34Hrq
        xmDU6gtN0aUPgj/Zjs65CpbK3eIcbhxKM8+ZPnURjQ==
X-Google-Smtp-Source: AAOMgpePZ4kOG9po18vBpRZFcRbZ84V6mTZAv0cG0ZHETVFzZH6/aYqahiz/y3B38APWEH54QFtWAa1aQQrYs308KgY=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr23632050iou.218.1531312740167;
 Wed, 11 Jul 2018 05:39:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 05:38:59
 -0700 (PDT)
In-Reply-To: <973d98c5-b5c7-d1c4-1b20-b6a77500adc3@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-6-git-send-email-ludovic.Barre@st.com> <CAPDyKFpwVMX9LoC_abHm09UNhLse8MJBUpCCHkR8NnK7fOU5Yg@mail.gmail.com>
 <973d98c5-b5c7-d1c4-1b20-b6a77500adc3@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Jul 2018 14:38:59 +0200
Message-ID: <CAPDyKFpUbHR4qfm3fDbRi=_=5oyqN9mhubySQ6a-N7msR5uU8w@mail.gmail.com>
Subject: Re: [PATCH 05/19] mmc: mmci: allow to overwrite clock/power procedure
 to specific variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> 2) The clock register will be written to before the regulator
>> operations have been done. Not sure if that works fine!?
>
>
> you are right, it's probably better if the clock is done after power.
> do you agree if I change the order?

If the new ST variant can cope with the existing order in the current
code, then let's stick to that to avoid breaking legacy variants.

>
>>
>> An overall comment, I think we should create a mmci_host_ops structure
>> and put the needed callbacks in there (kept to a minimum of course),
>> rather than putting them as a part of the variant struct. More
>> importantly, also the legacy mmci variants should get a mmci_host_ops
>> structure assigned during probe.
>>
>> The point is, I think it makes the code above (and future wise) more
>> flexible. It should also allow us to better share functions between
>> the variants. In principle, I expect that we end up with a bunch of
>> "library" mmci functions that can be invoked from variant's
>> mmci_host_ops (if not assigned directly).
>
>
> After "Linaro connect" we have exchanged some emails (subject: "STM32MP1
> SDMMC driver review") and the start point was
> "Goal is not to redesign mmci.c like sdhci.c."
> This it's why I'm surprise by "library" and "mmci_host_ops"
> and comment of patch 01.

Sometimes it's easier to look at patches/code, instead of giving
qualified guesses what is the best solution. Try something, realize
what is better, then try again...

The point is, we need callbacks to cope with the variants as we can't
have quirks for everything, and you are demonstrating that in $subject
patch.

Since this is the case, then I think it's better to make it more
flexible, already from the beginning and thus put the callbacks in a
new mmci host ops structure instead.

>
> So, it's not clear for me on where we wish to go.
> Could you clarify the way, if it's with a mmci_ops like sdhci_ops?

Yep, something along those lines. However, we don't want to introduce
unnecessary callbacks and complexity. We should strive towards sharing
common functionality through library functions in mmci.c, rather than
having callbacks for every single difference.

Does it makes sense?

[...]

Kind regards
Uffe
