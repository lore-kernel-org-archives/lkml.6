Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E41DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967B2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KanZtFng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0967B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeGQUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:30:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42326 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeGQUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:30:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so4335726oib.9;
        Tue, 17 Jul 2018 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LEKJH3GiZO3wO6Vls1dPT3BOYoMaoTMFTBVViZdJThA=;
        b=KanZtFngAFTqfCJln/lF2RTSheos02BmTlkvdz6Vk7mBKFo7dn+Nmk8m50rmrXHBnT
         ky0fvWc73loar0b6cWsr9qL5hi+mWGRy9h/l5VkibxMTqdHeSle2Cb3fLkEbjiYgpxrW
         N6hABbbfVNtmejB4EIUfB2ViTXYVabhbEqqCtsf00h1SGFDGMPR1i+ncnuO69sP+2WgH
         Zk89x+k2VEUjvQ+ZXHGSt3UqDvs4adr7vebVtYG4/1bir3BV/sY7G09+xOrbHDEobUuc
         lT/468z2LFKxgofnCrLc9AeMZDsapFUG/nUwz9zkOZJ8bL8szXxkXFjLZNI9qptFVrnr
         Ak6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LEKJH3GiZO3wO6Vls1dPT3BOYoMaoTMFTBVViZdJThA=;
        b=AVpmu5rxy2vTrow8MojCYMZSTs/0Qcelqt0ybeXqy5P/ySkxQ1wH268Vbzg5JkaU2w
         b4CEahaOkSkk8xj+2pDu8pXzLsK1xglYwX0DtF7fjHH9qeCV/gFxmOO9XvNK06A1bfDC
         pQOFl/RkCdbf7dD6/nQn/KiAfaNlEl/x3h0dR8GZk8VXaCcqEI4vKjy1mJFMimBnusdT
         Rdp0jyZphxpKoQjba/mlyRjHD8kO9IfvJUPay7i7QFYVfv7F/SluTEKpeZUDH5Izgp9b
         twnfF7hGX6vRbbBv10L/GobWLKGA5jH8Xk5zohz0DqRqtAELku2yCi94L+FMxIG/Pfbf
         9Fdg==
X-Gm-Message-State: AOUpUlFcVgVWAvserYQD5I8lYtga1Xo/NE/qTY5ii4S1z0taYD1nJeme
        SLryygaR/qluSiTqpZwjCnp33f4fE66YCPA5/bw=
X-Google-Smtp-Source: AAOMgpeytJtPn2P3UG3xLp9hUjtVYbsN8MwWbPNnQ8m2fZ8Vw8GbvtIGsqqnBwfKOaxCbEq9gTxvhS5KDZXQDLcoWD8=
X-Received: by 2002:aca:3805:: with SMTP id f5-v6mr2978403oia.310.1531857390955;
 Tue, 17 Jul 2018 12:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:56:10
 -0700 (PDT)
In-Reply-To: <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com> <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 01:26:10 +0530
Message-ID: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> add tmuctrl aliases node for exynos542x
>
> Please use full sentence, starting with capital letter and ending with
> a dot. Also please explain why you need tmuctrl aliases.
>

As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt

For multi-instance tmu each instance should have an alias correctly
numbered in "aliases" node.

>>
>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
>>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
>>  6 files changed, 32 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index 57c2332..ff79f0b 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -1061,19 +1061,19 @@
>>         status = "okay";
>>  };
>>
>> -&tmu_cpu0 {
>> +&tmu_cpu_0 {
>
> This looks irrelevant to the topic of adding aliases.
>

correct, I gone through the binding documentation and hence update this patch.

Best Regards
-Anand
