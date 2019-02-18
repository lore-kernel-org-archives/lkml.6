Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6553C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D0121479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfmONUNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfBRM3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:29:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfBRM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:29:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so16786425wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MRzmTEn9G8kwM20BMcAVcDRHrXJ3gBe2p0nBD+YMJro=;
        b=xfmONUNSh0hOZbxqpkLcUrMqFonwDGkiq7gydIXoj42z/Gb5HT1YcUJLifIQzWTLRh
         GJgrv9gs5/p39PWaUPyVLGO4IpPHPxExIHO3RNX2MtHkVzk5Q+VYC00tQbb6LUMCaDK0
         /C4P5p5mrYvVulsNYXenT3ywd7lByEAC1S5WfrYHgzdXhy3WGHFKpKpko4f8vB80YroU
         OrepEqlRm0CG4sc549aFHTaZ4Bo1Dc37aRbmgiR8n0pQkxVA8MeMBwgO2geLNA41aUrH
         o+ueQgCTi254uj0tB/6ygVPeFf8Kxb1jGFni4aVjLETBBp58gVhsBdFI/nlruuJpNP3R
         N5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MRzmTEn9G8kwM20BMcAVcDRHrXJ3gBe2p0nBD+YMJro=;
        b=lndTNpz3+xzvpQ7r53f5o49tIWBgL641WgyXhT2bCLF5c1cG7PIzPpfRFsZhPVNEuV
         BJgovTIPCGrjOQArKz8TMqCNNuJlVTjdaW3yFcUHdVWX+5w0Ofgbif682NeDKzMHtika
         VMnsk78SMJu4a/qF4VKG9d8CimLIFFW+pY785a8ydzb0dUcYcDswQtyuaOncR8eS/C3h
         tUzeLqJwjnghacP7pxKpucTDn2w7JlaPLLki0GChoVT5syKyT5VYfVBY8Ijctigb/42n
         HgT5eeLEa9TsjdjFJxIBDcB9saH23OxM9W3kkJ4ymmVBkwt5Eqom5YzKggUVU+Zfn0hR
         kWuA==
X-Gm-Message-State: AHQUAub81ApOaVL1HxjYJjdmagZqZNu157cdGTjqaMSpXbQypY73Q2xS
        Tcn0uChQ6K8La238p/B9r0vdrw==
X-Google-Smtp-Source: AHgI3IaWwB7F0Gq3PtNhGGuTd0bA3jVnrHb0zcpRv2/sVP8qXGbPFPDEaQ4O+kOCPSRcyB3zrni5TA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr16453075wmj.0.1550492969297;
        Mon, 18 Feb 2019 04:29:29 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
        by smtp.googlemail.com with ESMTPSA id v4sm5034268wmg.1.2019.02.18.04.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 04:29:28 -0800 (PST)
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V
 SoC
To:     Arnd Bergmann <arnd@arndb.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <10a0375b-0814-6b7d-97d5-ed2c2838c4b4@linaro.org>
Date:   Mon, 18 Feb 2019 13:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 13:20, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>>
>> Here is the series of patches the initial support for SC2000(M10V) of
>> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
>> source code.
>>
>> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
>> computer vision. It also features advanced functionalities such as 360-degree,
>> real-time spherical stitching with multi cameras, image stabilization for
>> without mechanical gimbals, and rolling shutter correction. More detail is
>> below:
>> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>>
>> Specifications for developers are below:
>>  - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>>  - NEON support
>>  - DSP
>>  - GPU
>>  - MAX 3GB DDR3
>>  - Cortex-M0 for power control
>>  - NAND Flash Interface
>>  - SD UHS-I
>>  - SD UHS-II
>>  - SDIO
>>  - USB2.0 HOST / Device
>>  - USB3.0 HOST / Device
>>  - PCI express Gen2
>>  - Ethernet Engine
>>  - I2C
>>  - UART
>>  - SPI
>>  - PWM
>>
>> Support is quite minimal for now, since it only includes timer, clock,
>> pictrl and serial controller drivers, so we can only boot to userspace
>> through initramfs. Support for the other peripherals  will come eventually.
> 
> I've looked over the platform once more. Overall, it looks very good, and
> I'd still like to merge this for linux-5.1, but we are running out of time
> there. If you send the patches to soc@kernel.org quickly, we can try to
> still merge them in, but if anything goes wrong, it will have to wait until
> we start merging patches for 5.2, directly after 5.1 is out.
> 
> I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
> in much detail. If you have an Ack from the maintainers, feel free to
> include them in the series, otherwise let's merge the rest now and then
> you can send the updated patches for inclusion through the subsystem
> trees in 5.2.

I'm not in copy of the clocksource patch but I acked it for the initial
post.

> I have sent a few comments. The only one that is really important
> here is the missing platform check in the suspend options. Please
> try to address most of the other commentsm, either by changing the
> code, or by explaining why your version is correct.
> 
> 
> 
>      Arnd
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

