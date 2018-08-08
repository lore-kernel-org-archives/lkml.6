Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A221C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C3021725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HV0aruB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C3021725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHHLwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:52:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35387 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeHHLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:52:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so2652809oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sFZ4kOck4RgdigfgatHXOF9EjHdtjjmGoBjv2TCbtTU=;
        b=HV0aruB5o+wzKgggvWLjl5ZBv4mDgzpP3QQRD8tuk2TspBBw1T9UDAjHtDJsd+9Pze
         D+qb9XqQ7bIQMK8NPHA0VT9lXtDURbZpEcudLrl2ROMzqG72iIkobmIcViF+LzQwyd6C
         59pwQ4+L3dYzJc6oOxHMbtFAJcNNThtji5q94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sFZ4kOck4RgdigfgatHXOF9EjHdtjjmGoBjv2TCbtTU=;
        b=bIG0if3AsECWk9FVf8HT7sQx4aTnGXTCvm2EBu4s6/hzYfi/3TTPM/MgpbsbeBPJ20
         i2syXZTL9oLWAc0SaQrdVRyPt0NdUarSS1/VZTeVIAxWItU2aZaubfxHWCw9w0i3vwwx
         bAIbzo8pjNYD51JAa4xqdP4o34fXs1uCn2cum/KSZr0p5pLitXC6yJzcNO9BAPgtreOy
         n4bIoRvUWVuOniT3dsZQPXJuzcEXsKylsLj7d0yZm3zByovL3SSrka3kNNj50GKmS7+l
         9Fqr5kMV7lAB3mwojtUA5jxhvoN7+L4AeQfO3WmGd0qFvGKh2Gp4nUNzBIRgJydMVeAy
         ysDw==
X-Gm-Message-State: AOUpUlHfW5Dz1eqHy+WkM6XKCQg1yeT/JtmhBT9u/sbdTBl241pDfvtc
        Z+3L8PGpnbVR1g9Ty1EMtD1kuAsl1idryFJZpMC3SQ==
X-Google-Smtp-Source: AA+uWPySg3imVe73vLOMUAyeDqvVE5H6KjEUSvYI8eh/TT8DMPgMZFCiJNi0shGrkH2FGhAsqNrt3Xz6PIL4Z9t8Nb0=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr2277622oie.168.1533720808323;
 Wed, 08 Aug 2018 02:33:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:33:27 -0700 (PDT)
In-Reply-To: <20180808093148.GA9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <20180807142408.GB7958@sirena.org.uk> <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
 <20180808093148.GA9346@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 17:33:27 +0800
Message-ID: <CAMz4ku+EgyjGR5Oo7FQPDUOYXnJ1=tAYBZfJwgfO+44Wkv6m1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
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

On 8 August 2018 at 17:31, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 10:45:33AM +0800, Baolin Wang wrote:
>> On 7 August 2018 at 22:24, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:
>
>> >> +     bits_per_word = bits_per_word > 16 ? round_up(bits_per_word, 16) :
>> >> +             round_up(bits_per_word, 8);
>
>> > Please
>
>> Sorry I did not get your points here, could you elaborate on?
>
> Sorry, missed the actual comment there - use normal if statements rather
> than the ternery operator, it's easier to read.

Got it. Thanks.

-- 
Baolin Wang
Best Regards
