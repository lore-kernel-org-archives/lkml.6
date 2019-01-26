Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E8C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A329D21903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="robQn/ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfAZPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:40:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42952 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfAZPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:40:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so8948449lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9uOtldaAXYfuOBU0y5lop4byvLK3ttHaozs3KcP+28=;
        b=robQn/mlJrzL8bQrIx2coDl2M7m1naNuvcnK2zR6nWwMnuO9AuNqRbf0ZkhWTjckZq
         udGIXRDrO6Kd+9Iw6qFzFynnycJE9OtUeFdzEqn/11I8f+ObacbPeWMUPIvoce9N+CVW
         2l9+1nH1Nujpf8wSgoHYXWd/tmLV0m1YJix+s+Joe4I2/DtkdedGklq/pUf8GUaDihvQ
         7qqOf9/9rdJyLC7cH8/lfLtwZpxrLKMzV/h+u+4+HZ8+6iDNTzqEZPdqbm6USDIOGPBC
         fDZRzzgzA7hyg1mUI24NIigsiKeFVB/wTrUFejrgl2yEtUzhklLRglptIsaZ6YFQGk84
         HaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9uOtldaAXYfuOBU0y5lop4byvLK3ttHaozs3KcP+28=;
        b=iqGolhI8oCZQ2Oe9sVFIVXwEA7aK7P8/+EmwF8LkJFKm3CawvCGHQoMPnH7OuPuWuA
         T6EObhQLlkdfn5bt6Ld9vxdsMTyjH9/Qb3K27Bq8yyK7hGcFjprjWYUPGrXzsziyW+d0
         7Ifm5ukHiF8WdyEz0tMX7eAbWOIx3+B+xzoiYjrPzFXETl79NxviJ/mAZNjLgzx2TY/9
         la27/C6E269WLxiOvkTdu0aof1bAI9Cjpi/J4LIBtnkWYXNzFb46zDpQoX7+rVsUUFaG
         +VfWm+o0hDBGLiiF79aoExd0q9tNX76IpSdcIJ6vv8hpOn5PL4BY6PHO6dtIe3NUHDZI
         ONLw==
X-Gm-Message-State: AJcUukfttbOXq20tRwXIREPlYCo35Liu8xPWXzjzs8y8oKIQz1WtvktA
        HoB6EXGPGvhbR5psoQfhchSPFA==
X-Google-Smtp-Source: ALg8bN4TebDFHIrCtXmy+tGMYOFG0w/dA/UQl3UZj5R18g6QygUcjXre81p4ESxNdb/MMBgwYiuiZA==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr11600705lfg.117.1548517208179;
        Sat, 26 Jan 2019 07:40:08 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id 15-v6sm2379774lje.18.2019.01.26.07.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 07:40:07 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
 <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
Date:   Sat, 26 Jan 2019 16:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26/01/2019 11:25, Geert Uytterhoeven wrote:
> Hi Jonas,
> 
> On Sat, Jan 26, 2019 at 8:53 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>> On 25/01/2019 18:50, Mark Brown wrote:
>>> On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
>>>> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
>>>>> Having this as device property rather than a transfer property allows this
>>>>> to be configured one time in setup() rather than having to fiddle with the
>>>>> configuration register for every transfer.
>>>
>>>> That doesn't mean that the coniguration should be done in DT though, and
>>>> given that this presumably is a property of the device there seems to be
>>>> no reason why we'd have it in DT - if every instance of the device is
>>>> going to need to set the property we should just figure it out from the
>>>> compatble string instead.
>>>
>>> To be clear here: the suggestion is to add a parameter the slave device
>>> can set in spi_device which sets the default word_delay similarly to how
>>> max_speed_hz works.
>>
>> I'm confused... isn't that exactly what this patch does?  It adds a
>> field word_delay to spi_device in the same manner as max_speed_hz.
>>
>> I also added the ability to set it via DT, which I can break out into a
>> separate patch if that's an issue.  Or is the problem that it's set via
>> DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10
>> other slave-node properties related to transfer characteristics;
>> word_delay is just another such characteristic.
>>
>> But again, I'm having trouble parsing your response  Is the patch wrong,
>> should be broken up, or you just misunderstood it?
> 
> IIUIC, Mark means that it may be a non-configurable property of the slave
> device, and thus should be handled (fixed setting) in the SPI slave driver.

OK, so given that the "compatible" property identifies the hardware and 
there is no other _hardware_ configuration detail that affects the 
required inter-word delay, then setting the property in the device tree 
is not allowed as the driver has enough info to set it properly.  Fair 
enough!

> 
> Compare this to CPHA/CPOL, which are properties of the SPI slave device,
> but which may be configurable. E.g. many SPI FLASHes support multiple
> configurations. See e.g. commit 9c5becce21af35e5 ("ARM: shmobile: koelsch:
> Fix QSPI mode of SPI-Flash into mode3").

There is nothing about the hardware referenced in that patch that 
enforces either mode.  Why does the driver get to defer to DT here?

Looking at Documentation/devicetree/bindings/spi/spi-bus.txt:

spi-lsb-first:  used only by MAXIM DS-1302 which is always LSB first; 
driver should set this

spi-3wire: again, only set by MAXIM DS-1302 which always needs this 
setting; driver could set this

spi-tx-delay-us:
spi-rx-delay-us:  only parsed by RMI4 driver... no DTS files in kernel 
set these.  I hardly see how these are "hardware" settings rather than 
message settings, but the driver can set these in any case.

Anyway, the point is, looking at the current documentation, it's pretty 
difficult to understand whether devicetree is restricted to describing 
hardware or is also for configuring drivers...

> 
> Again, max_speed_hz is something different: while both the SPI master and
> slave may support high speeds, board wiring (capacitance/inductance) may
> need to force a slower speed than supported by the devices, so it makes
> sense to make that configurable from DT.

Yeah, that one make sense.  But if the DT is only overriding the maximum 
device frequency that the driver should otherwise be setting, why is 
spi-max-frequency a _required_ property?

Thanks for taking the time to provide the additional explanation.  I had 
to ruminate on it for a bit, but I think it's starting to sink in now!

/Jonas

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
