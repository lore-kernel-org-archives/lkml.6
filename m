Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F27ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFB22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvGz+How"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFB22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeGQP2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:28:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38259 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:28:15 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so1229398iog.5;
        Tue, 17 Jul 2018 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=szx/nSR1dGeta11uELTh5CIGAFncN4ADJuAMlD9mwSQ=;
        b=dvGz+HowV+2BCs1gLv3U/e3Wl8IR2ojjBzKPvV4pBj9VU9V1leS7hvnqrQJqBpITdX
         FJwbydM0BwEoeAh0Yd6s993u7cABo1IcUxlV+vAcnpqDMCkL6VONDezeKxYtQE+UXTF/
         5+FwVtJy5OnFBwVBvK1ZNu+VfYw+uDkmZpe437cXoFv2jHh7drYAeQeXveStFJFJcKOJ
         zPswupLIOhmt/XDYdebQUlwJdjiJCyWJhji/zJJKKiWpqSeLlLUWwg5gZaCL0B/4mpf5
         tVUIawziRWNoaNxTLLf7XWKThbrMX2XUo+5YUQhzUL9AHJlyaU97Qg18ARbYnGo4KtR8
         nJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=szx/nSR1dGeta11uELTh5CIGAFncN4ADJuAMlD9mwSQ=;
        b=LmShSuMPU5kNh0JlVk8yegyNjm96IuX6vy7dk9eNDvz5+LdnOtxdGOCrUhrxXUtBYp
         HwlhsrTWk82MrSwnRGqvLOR5W4YoPpOdU99nFD2tPhdkP2LOpM7pv0tSO5HfONki3lJ1
         KWw2i9+3+XHoXWFLfiGPeuYNE+ItRyNTuaT9pZzAkoUvPGSVgAKcBEF5oswhzXYhqP5Y
         5JGWBitYidQg/+DloETFHMoKq9azuLg5yS0QPjTYjXCooRgPS/2790H+Ixm/zDPM0kP2
         w1pctfWvAy6YusHXf0fCA4ZEbXnEk4w+ebygJ/5X+bHq5+vbFCvskQxqbpuke1/b6ZBK
         bd3A==
X-Gm-Message-State: AOUpUlEYm2huxrn79FEwbhiFHbov/MBjimQ154xATm5ff6fiw+8ErTwH
        ywDArUpMMV3X1TOa64GAasEhotYiBAqJB59fxZA=
X-Google-Smtp-Source: AA+uWPy+HhBjd8+DcT9/JwubISy2ptVszxRiFBtpMHecAC1jtjNjuFRbbyqG0d4UcAJp/OGLGMgB+8NBqZP7SLr1Yv0=
X-Received: by 2002:a6b:5408:: with SMTP id i8-v6mr1746822iob.46.1531839312785;
 Tue, 17 Jul 2018 07:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 07:55:12
 -0700 (PDT)
In-Reply-To: <20180717144638.GB16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com> <20180717144638.GB16320@lunn.ch>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 17 Jul 2018 07:55:12 -0700
Message-ID: <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 7:46 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Jul 16, 2018 at 09:06:51PM -0700, Andrey Smirnov wrote:
>> Add support for Zodiac Inflight Innovations SSMB SPU3
>> board (VF610-based).
>>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: cphealy@gmail.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                |   3 +-
>>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
>>  2 files changed, 345 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index bea41b129493..e331b2c16539 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>>       vf610m4-cosmic.dtb \
>>       vf610-twr.dtb \
>>       vf610-zii-dev-rev-b.dtb \
>> -     vf610-zii-dev-rev-c.dtb
>> +     vf610-zii-dev-rev-c.dtb \
>> +     vf610-zii-ssmb-spu3.dtb
>>  dtb-$(CONFIG_ARCH_MXS) += \
>>       imx23-evk.dtb \
>>       imx23-olinuxino.dtb \
>> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> new file mode 100644
>> index 000000000000..b692117d7839
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> @@ -0,0 +1,343 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +
>> +/*
>> + * Device tree file for ZII's SSMB SPU3 board
>> + *
>> + * SSMB - SPU3 Switch Management Board
>> + * SPU - Seat Power Unit
>
> I think this is the first Zodiac board with mutually recursive
> acronyms.
>
> Probably a question for Chris: Does SSMB specifically refer to version
> 3 of the SPU?
>
>    Andrew

SPU3 is the third generation of seat power unit.
SSMB is the SPU3 Switch Management Board.

So, SSMB is a backronym.  This naming scheme breaks down a bit though
when follow on designs (that are not the SPU3) also use the SSMB, but
that's what it is... ;-)
