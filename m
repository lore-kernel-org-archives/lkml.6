Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF6AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F2206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O2o7iF30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2F2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIEMua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:50:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55129 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeIEMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:50:30 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so8765667ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=88d3+eVnrVFJ8RBWcRGJ3VmCAyyySk9Wj/nnDf0tvKY=;
        b=O2o7iF30GZCgJUsWdPsIjhAQ2JreBdU23+34FnUSC6Zn243iPkfqZ2eCj06vvJFhXU
         kVDjDd5l4kn/TnbT4LzOxFsHPZAXVTA7YuDVzxIsUn8uoM5hP9tdPjl+1PNJW4HHRiyT
         F0HhG5G0g715kUlX+THXG+RCLfxvnjtI//3DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=88d3+eVnrVFJ8RBWcRGJ3VmCAyyySk9Wj/nnDf0tvKY=;
        b=Oi8TkglC4iPDI3yW0qsq66RrqIT+hS+NzcQlJO0bEkpO9SjRJXoOh77W2BrGIfwpEq
         NcaHxCo2EPfKRYjggeLB2YU90Z/IZJjxI3OyONqgXDs3VpV7An+Qa4I6JkXhz64dxR8I
         d26T6J3wuKZ+u5aV6sWztARYpNzyX8DsjJXAXDMM4IMh9bzxf7uyYiPjh95quEGt3tiu
         BJ5+TU7YScbY77mnoBTbvLbhqQCJZF4jW4skQ5c94OtCoLuI0y1bD5i+lUQ2oDiXVlOD
         /XJyCIZ5YAVyq+5cd9kc1IfvAynEyU3MtrEVxLS5UEKvzhFMYeHm4ZPYGFUGoRpgZ3+1
         kupw==
X-Gm-Message-State: APzg51C8lNFcUqc18Krrft0u46cbAkHLsZ6vvLtTDA43Kg275BG32UBO
        /TvSll412JoWADFaJb30Aq0OjZP6XKmQNujwPikuHA==
X-Google-Smtp-Source: ANB0VdYg/dKVDag8SU6gwPrgwHtcMhlvnN+6/a8lcpUyN4T2y8jrt6R7tVtt/IOqKqk8zTFVsyouhdUYrMPTrFylroY=
X-Received: by 2002:a24:4dc1:: with SMTP id l184-v6mr10244817itb.20.1536135685716;
 Wed, 05 Sep 2018 01:21:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 01:21:25 -0700 (PDT)
In-Reply-To: <20180905070748.g43lfdqdhmoci6pk@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-3-jagan@amarulasolutions.com> <20180905070748.g43lfdqdhmoci6pk@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 13:51:25 +0530
Message-ID: <CAMty3ZBYjq8VBnwSqKhJgag1ARRvnPTVSpYT7SWu=A6pMwKEiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:37 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 10:06:08PM +0530, Jagan Teki wrote:
>> Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
>> so enable them as default.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v4, v3:
>> - none
>> Changes for v2:
>> - Enable for SUN8I
>>
>>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
>> index c2c042287c19..cfa8b96273fb 100644
>> --- a/drivers/gpu/drm/sun4i/Kconfig
>> +++ b/drivers/gpu/drm/sun4i/Kconfig
>> @@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
>>
>>  config DRM_SUN8I_MIXER
>>       tristate "Support for Allwinner Display Engine 2.0 Mixer"
>> -     default MACH_SUN8I
>> +     default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
>
> I'm not really sure we should put it as a default. We should just
> enable it in the defconfig.

What would be the difference in both cases it would be build as module
since DRM_SUN4I=m for ARM64
