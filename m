Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9032F216ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DauyOM/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032F216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHHMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:54:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45356 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:54:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so2804699oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Z+Lptx9SBkh42+Z33/t8t7AGgSYtEUgzGmLQuEW0UQ=;
        b=DauyOM/IfnNA25a7rOwEAC5RwIyQjCK6J5vt/90Y0ByTjtIkFn583JO0eghEuyRMlB
         7Skhg5A3AWNz5/wc0fQFCD1TddjPmIJ4GYbvHsbnryvIM/ddViF/SjKdxxZgqUHt4Xwa
         gWLZgLCNsxn+Ltsh+PvUoTz7ODX8i7ckgM0hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Z+Lptx9SBkh42+Z33/t8t7AGgSYtEUgzGmLQuEW0UQ=;
        b=h1ESqmvL+o4zjHFT5oF9weucCVbPvitAIqcgYKSVtDt966ppr4OfAp7z7OYXq8ghEr
         PYeYZ9UtZESL96LLBwLy6fY7xBy1P1DHeYq4uuCICWTopNaqVjQ6gBHKPd3Z6dm5qknX
         MZcnklYjogLuR47zDH48JVDGY6QEhMayoKYQc3/0azdiNvP4jzyYfZcWwbip/3Tf1JYV
         /hXivNjO18ekZaXdlHOTVzUCh1mlzmiIoLLHn0RMA2f8cE9FUlXwDfVrEj43FNSp8wda
         8hNlfdMbm1ZIC5LNHmZbuoYrDKAVLUtiUV4c7Lm6jqYcc6b0w4KxT7C4yfbJT1EugjK+
         Z6Ew==
X-Gm-Message-State: AOUpUlFl2n4KPZh/jV3uWmbt5tlLfKJUN+08MU/iRwsi+OmBaCXUQmtq
        XkNBadteRs10NF8MyTaJwoJjDba+az6vQypqXqT9lg==
X-Google-Smtp-Source: AA+uWPyNaOwXqsZgWzNwkWYA438cEjFUcpTTT2IMP/QLn2uVANy+OvkAkYyiDZSMzNsnl19jNZuT9V9/J6wuUZKCsw4=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr2386516oib.320.1533724529090;
 Wed, 08 Aug 2018 03:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 03:35:28 -0700 (PDT)
In-Reply-To: <20180808095025.GB9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 18:35:28 +0800
Message-ID: <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 10:26:42AM +0800, Baolin Wang wrote:
>
>> Sorry for confusing. Let me try to explain it explicitly.
>> We can set the word size (bits_per_word) for each transmission, for
>> our SPI controller,  after every word size transmission, we need one
>> interval time (hardware automatically) to make sure the slave has
>> enough time to receive the whole data.
>
> OK, so it's an inter word delay.  Some other controllers definitely have
> the same feature.
>
>> Yes, I agree we should configure it at runtime by the device, but we
>> did not find one member to use in 'struct spi_transfer', we just find
>> one similar 'delay_usecs' member in 'struct spi_transfer' but not
>> same. We can use  'delay_usecs' to set our hardware interval value,
>> but we should clean it when transfer is done, since we do not need to
>> delay after the transfer in spi_transfer_one _message(). Or can we add
>> one new member maybe named 'word_interval' to indicate the interval
>> time between word size transmission?
>
> Right, I don't think we added this yet (if we did I can't see it).  I'd
> add a new field to spi_transfer for this, then other controllers with
> the same support can implement it as well and drivers can start using
> it too.

OK. So I will name the new filed as 'word_delay', is it OK for you?

-- 
Baolin Wang
Best Regards
