Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F93C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3F22073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fEwBHzDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3F22073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIEMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:24:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35102 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeIEMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:24:29 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so8347196itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l9YJO1Zwfcb8E9Wb1AT+mgj1kVqO2qUxnWmgLJML7vI=;
        b=fEwBHzDUGo/QtUhgB8xM03D+1BTLfiGlRqRMDOfvRnFEYBOhu4KjDxsWLSjd5f0zqS
         BpeFDrdfSQShQ3vMecZo8RVDuQ1w0wluoYiBPIxQCVVJ34Uiazxy0+fj01vZ36/iTjdH
         9fE2BhDKCvzrxn51C9psmL9jtV9K3+mN3dMVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l9YJO1Zwfcb8E9Wb1AT+mgj1kVqO2qUxnWmgLJML7vI=;
        b=TnZUBJLTXS++Sg/eLb87HCE9eFyagY2OLpT25JUlmfq1xEDw1KzLTinf2m9tKM6XmX
         CsELvEadFGbCrqNJbme1iXXlmHDNauTe96Q1gQqpuwV1YMWfXGuAUh7+8PK9aqVaiFHs
         H4PWt7UW3Iynkyf7fp1WaKATqIBe20lq/bDSxCbb4sooXp6VBFHqsPomq8DPZSBOE6JF
         3qh3RyMGVv0y57cpAtIz+BUB6jXFTW3fs6KiKLsxevhv4lTyBhBdYwDrGDD5NeT/jgOA
         KnOCOqjQHobXwq5S6k/KyZCXnxLktxMLOjU5KVwQp6kuWCysKARS0pHRoN/zuQ2TpoP9
         aQFw==
X-Gm-Message-State: APzg51B3WmZI6Nk8jD62hWe2quDkyvwWuBU/jYtD3l9OFS95uX6bXuPP
        p8R+C1z/jVTMD4u52X8Rs7KmX7ahjExW2G405yi+7w==
X-Google-Smtp-Source: ANB0VdbFtzR1obFzr5wz3JUwdpAk9++B+ZAuznOHd3xNh8jVCteBBfV4oZQtcybYIy34D0f3vADZ/Tpao3jza821Kbw=
X-Received: by 2002:a24:4dc1:: with SMTP id l184-v6mr10188729itb.20.1536134130840;
 Wed, 05 Sep 2018 00:55:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:55:30 -0700 (PDT)
In-Reply-To: <20180905070335.dclhpxjld4vdkdu4@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com> <20180905070335.dclhpxjld4vdkdu4@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 13:25:30 +0530
Message-ID: <CAMty3ZDVnsjJ0eRx1LxFjX+ti85=jRy=1x_sZ5d3yCHsVCD3HA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
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

On Wed, Sep 5, 2018 at 12:33 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 10:06:06PM +0530, Jagan Teki wrote:
>> Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
>> as default.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v4, v3:
>> - none
>> Changes for v2:
>> - Enable for MACH_SUN8I
>>
>>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>> index 826674d090fd..e20182aa9748 100644
>> --- a/drivers/clk/sunxi-ng/Kconfig
>> +++ b/drivers/clk/sunxi-ng/Kconfig
>> @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
>>
>>  config SUN8I_DE2_CCU
>>       bool "Support for the Allwinner SoCs DE2 CCU"
>> +     default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
>> +     depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
>
> I don't see why there's a dependency on the DRM driver. I'm pretty
> sure this would even break simplefb.

Ok, got it. I will drop the depends on just add default.
