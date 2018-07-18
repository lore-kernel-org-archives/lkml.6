Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEE6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0CC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXeM1ZqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0CC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeGRS2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:28:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39347 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731201AbeGRS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:28:07 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so10391853oib.6;
        Wed, 18 Jul 2018 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iLNs65kdj8im6eWNn8ZEbJrnXxlvAUgn2c+2Xhzfbvc=;
        b=XXeM1ZqR2PELW5N0Ak8nbojV34Q7k3U+AlKDK1s0iBgvDe2Amoo3ri5NcRgYtGlesL
         9We7XMwbnnm/bUfCfbQ++vssISl1+AIsUKe0BsjwalvGsRmSPQ7uIZJOmGmriGWQr2TA
         FmtFhuBg5jrCbYS1B3EcWeeE9xklGxYSIkVF62ZJVBUbdGka8HqJwzZR5NuIiMssQIln
         gG8muX+eOqGdIMYAOO1zzY2n0HynKW67/Ilw/XcloY2kNHhDoQgbhkDAyFBG8qtasSFi
         teX3VH8p5FFc3ZR/pBaQ6YErzrOgkLTMarPFmTpsdMJ+T74Rj5pOPPWvkHKCOSaLhOrZ
         WWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iLNs65kdj8im6eWNn8ZEbJrnXxlvAUgn2c+2Xhzfbvc=;
        b=Yi/k0i3O9AlqpKBeUsYQtSpwJCsaTp6jo7bSDRZCkRAXucloCdJgmzVm15MAF1Z5Zu
         FNBLJylcQ6F3K5tEARe6eeMbC13VP+LWlPqA6IYXxxmTfh691b9ID1Ptdtm9btvCSoaE
         fvVMH9543tzC15m/AkXWih5DdpQP5pj0ZBPcNLsnKPNw9y8Kj/Xh+/PG9qwj1GTrgllt
         C4SPKxMRseeLRA02kDqaEoU/Lw/oJTXX4G04tz0Hvdo/nGQYpC+gJ7JjodjlLtlejIv0
         ZqLHxOZ3+j9y8KWyRC2R7wT1/L6Man6cQ0yBGBfB94zL956ttD3KpNiOXiIRs+JsbNyg
         JsEg==
X-Gm-Message-State: AOUpUlEccTaZI4LSHvs7HcChymDZFjBIOf465kzDwLACgJf1ufY50rsU
        zCpU1HBA95d4Z296O3CvKEEcJhPlkaOjoqeIrYo=
X-Google-Smtp-Source: AAOMgpcek2bVXRKe65S32SYmYg77bCjj56gPRhfpkJS8pagwGss1qP1vje9lFxeuOLCwvfqUOaXMho7kMJTkoUGW2FQ=
X-Received: by 2002:aca:6885:: with SMTP id o5-v6mr7957896oik.208.1531936146073;
 Wed, 18 Jul 2018 10:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 10:48:45
 -0700 (PDT)
In-Reply-To: <CAJKOXPdAEp-7jw-AqPfmqq+ygY_p4BGt92voCNRc3z57KU_-ZA@mail.gmail.com>
References: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com> <CAJKOXPdAEp-7jw-AqPfmqq+ygY_p4BGt92voCNRc3z57KU_-ZA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 23:18:45 +0530
Message-ID: <CANAwSgQTJE4hRFEWhKQ3zbbnxUarxx=ieLHtn5qODUYyMj1O3A@mail.gmail.com>
Subject: Re: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 18 July 2018 at 19:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 14:59, Anand Moon <linux.amoon@gmail.com> wrote:
>> Add missing GIC interrupts property for pwm nodes.
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>> Fixed the patch indentation issue with all tabs.
>> sorry checkpatch could not figure out the error.
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>> index 5d2f0a0..f48fb9b 100644
>> --- a/arch/arm/boot/dts/exynos5.dtsi
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -169,6 +169,11 @@
>>                 pwm: pwm@12dd0000 {
>>                         compatible = "samsung,exynos4210-pwm";
>>                         reg = <0x12DD0000 0x100>;
>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>
> OK, thanks for v2. Now only tabs are used but in previous mail I
> mentioned which example to use - the rtc node which nicely aligns
> continued lines. Why you did not follow this alignment?
>
> I'll fix it when applying, no need to resend.
>
> Best regards,
> Krzysztof

Thanks, I follow the tab protocol otherwise checkpatch would have
complained of tab/space issue.

Best Regards
-Anand
