Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F4C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D38206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAEn5N8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D38206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeILNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:45:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeILNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:45:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so1085517wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cdzXHeIFeBzs41NLH9B+3flVQODuHYwCbb1mrqSVS24=;
        b=MAEn5N8vJSJMOKNGUDQ/fuHs11uLucbW91K2SVIr9q8XUpIAVgLy59kwJ+h8y+UYSp
         oadZpD9yQdFmkLuePLivBd2JWe7JZTseG+MQprowtXVilF8Co4pYrucn5Bfj5JumkM/B
         bbpcoiNW8ra98W1dbSBsqFANVUJjp8ot0CXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cdzXHeIFeBzs41NLH9B+3flVQODuHYwCbb1mrqSVS24=;
        b=dqTT9tHehMWAVDl6Q2JmNJ0cnljiRnstPOTJbVI+WdBnXOekeZjj0uRPZqMHjsmKNx
         cIpd1iIjuqyQ24fH0vLFB6YG0rrZ3x3EHHmFEbXV8nj8KIJC1FTuKp0Curl5RGANRkKL
         rCWLlyHHjmKV+bKmL000e8x2mzhio2kl5nSZqaQJQMfhgSGV7K2YLGik126E+2ArEq3K
         6saWnO8b1VyrILvqqM4qu4tucpgbTKr3Z/GvJw7dt1AueR/OkRUulJaOQ6lpqfilcsmO
         buyBlgfj3+Nf3Xy9nH9K/IAgUSb+Za/PW7gocLmguHBMz9D1hDq2g8QIlscDShZ9eBNZ
         p2bw==
X-Gm-Message-State: APzg51AfnAx8BfvqhfiIn/sd0TEoWJ1MX3UkvvUE+JsZFNVaVu2kIDr5
        BJV+saSrxMO8ic5+oA0pKOhxZw==
X-Google-Smtp-Source: ANB0Vdax+omjCwocb9QLLLD2chwLGGz2+TmwM6YsEob3OIPPdHerUT+iIruFJV8fDiZ1roEs60iScg==
X-Received: by 2002:adf:f1cc:: with SMTP id z12-v6mr654025wro.214.1536741706618;
        Wed, 12 Sep 2018 01:41:46 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id 94-v6sm657763wrc.10.2018.09.12.01.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:41:45 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:41:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180912084143.GN4185@dell>
References: <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912073355.GB2557@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > 
> > > > USART doc starting p572, registers p621.
> > 
> > After looking at the datasheet, I don't see any reason why one of the
> > two drivers can't be selected using different compatible strings.
> 
> Because there is only one IP and we don't use the device tree to selecet
> linux specific drivers.

We do it all the time.  There are loads of MFDs (def: same IP, with
different functions) which have separate compatibles for their various
functions.  If you wish this IP to operate as an SPI controller, it
should have an SPI compatible, if you wish it to operate as a U(S)ART,
then it should have a UART compatible.  It's what we do for most of
the other MFDs in the kernel.

> If you are not happy having that in MFD, I guess we can move it out
> somewhere else.

My issue isn't pertaining to where the hack lives, it's that there is
a hack in the first place.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
