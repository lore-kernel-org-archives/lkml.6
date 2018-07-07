Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39745C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D907520862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqwq+y7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D907520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeGGSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753242AbeGGSdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:33:15 -0400
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4413820BF2;
        Sat,  7 Jul 2018 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530988394;
        bh=wpGjR8XYFSElYvvebuSq8hB0vWCBnIR2v31nDH7JXU4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Aqwq+y7mELICjw+3STyKh/XofCuUOJ/RoF8PsjAejcJLg8ZIhYVPitd0CmAlDHEbj
         veP47hMW0NMRtKQuvpZxlZe4J8RiNV91+fw4Jy6xJv9ojj0KAPGKb65nDgKeClDIL+
         LbjUfnm1ZZnVlMQIvg9ODK80/0eOIrAIjxPg7D8c=
Received: by mail-wm0-f43.google.com with SMTP id z6-v6so7728353wma.0;
        Sat, 07 Jul 2018 11:33:14 -0700 (PDT)
X-Gm-Message-State: APt69E221ueABNnmwDUyjCPYOwrvPmD1Sd71mzRO3zu33LYs2lPM1ByD
        5Z3B/PrFP2b+uJJ8BAOfBowGihyfBjpctBKn2hg=
X-Google-Smtp-Source: AAOMgpcIQTOHeh4YXbPA6T5wL7VyTUHv6kbhZurKy/pCeJYCwPtY/Nj/RsAi1q8rVMNa7RQDILPoTHiNc1I/SQ1wuwM=
X-Received: by 2002:a1c:8e54:: with SMTP id q81-v6mr8468884wmd.135.1530988392731;
 Sat, 07 Jul 2018 11:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 11:33:12 -0700 (PDT)
In-Reply-To: <20180707170848.GA29870@lineageos.org>
References: <20180707144527.6662-1-simon@lineageos.org> <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
 <20180707170848.GA29870@lineageos.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 7 Jul 2018 20:33:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdYrBDuiZCpO06doxeAbcZthncgAKbBmNJazVCxTSx+iQ@mail.gmail.com>
Message-ID: <CAJKOXPdYrBDuiZCpO06doxeAbcZthncgAKbBmNJazVCxTSx+iQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add max77693 irq configuration for midas
To:     Simon Shields <simon@lineageos.org>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 July 2018 at 19:08, Simon Shields <simon@lineageos.org> wrote:
> On Sat, Jul 07, 2018 at 05:34:08PM +0200, Krzysztof Kozlowski wrote:
>> On 7 July 2018 at 16:45, Simon Shields <simon@lineageos.org> wrote:
>> > Currently, we assume that the bootloader has correctly configured
>> > the interrupt pin for max77693. This might not actually be the case -
>> > so it's better to configure it explicitly.
>> >
>> > Signed-off-by: Simon Shields <simon@lineageos.org>
>> > ---
>> >  arch/arm/boot/dts/exynos4412-midas.dtsi | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > index f35176a35a15..30760bf2eb71 100644
>> > --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > @@ -156,6 +156,8 @@
>> >                         compatible = "maxim,max77693";
>> >                         interrupt-parent = <&gpx1>;
>> >                         interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>> > +                       pinctrl-names = "default";
>> > +                       pinctrl-0 = <&max77693_irq>;
>> >                         reg = <0x66>;
>> >
>> >                         regulators {
>> > @@ -1117,6 +1119,13 @@
>> >                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>> >         };
>> >
>> > +       max77693_irq: max77693-irq {
>> > +               samsung,pins = "gpx1-5";
>> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
>> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>> > +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>> > +       };
>> > +
>>
>> Please put it before hdmi-hpd (gpx3-7).
>
> OK.
>
>> What about the interrupt for max77693 fuel gauge?
>> Maybe another patch for it as well?
>
> Yes - in fact, it looks like most interrupt pins are configured by the
> vendor kernel to have PULL_NONE, something which (as far as i can tell)
> mainline doesn't do.

The interrupt line of max77693 is marked as open-drain and there is
200k external pull up, so AFAIU such pin should have internal pull
down disabled. Mostly it works with pull down so no one cares. :)

> Maybe I should just prepare a series (or a single patch) which fixes all of them?
> Or would you prefer I added the (remaining) eint configurations to
> exynos4412-pinctrl.dtsi, and then used those?

Series will be ok but leave them in midas.dtsi.

Best regards,
Krzysztof
