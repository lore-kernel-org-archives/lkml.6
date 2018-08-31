Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDCE2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 05:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahtpR0Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDCE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHaKFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:05:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:47019 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeHaKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:05:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so19698296oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8muGaDI945QsT1p4KhJdcCzxJAlaPKqdK1QFtC4MgNI=;
        b=ahtpR0Jmdp9bXRcS/QK8xhN768LAuGkylv+WoLKlcsIdG+xu9RX7MniAwZ8lhW835K
         uNH6UMJsYvXsgcR3VnvatSYJ6jpJXqQm15VOSGwuz9Bhzyku6tL6520DDY+ZSi5eEzP+
         Xs4OmktvBwCdcOJTqGQThmrOFUcUv7WxdmpvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8muGaDI945QsT1p4KhJdcCzxJAlaPKqdK1QFtC4MgNI=;
        b=OIrJ6yBUpb+EJIBmii4OqeO2JaLbZivFGTW/VpTBsioB3vSyeod3HuYSIe9/0VhOxa
         jnQvQryLFu1xp+DYfsfCLMWtWlsm4DnGuOJGIWfQW8eXRFSms9qs2dpXboyaSebEj2sH
         NxQiiwgnCOLUqVMwbE2+kjbmPoW395GXVOTwq09Ku3hCftuwg+EaOvKLJuwwSzCAa8gN
         ELQksh1efe2Fo5zhkHyDjcVj1LU3dvVR/gp3PdiCD7CByOHJx8XUWiESFgB1QTyeg04H
         dkrK2zQnSzT3fPJdUP1/z4ooYmOs6Ks/kZgHVurPeo87NPmQGl+hLpkADUZ+SlWief0+
         XslA==
X-Gm-Message-State: APzg51DohIIRZfL6BCd/L1j36aQ4VK6evCV28CGYoqF90nn15tvVRF1U
        cVICHC+rqp3tt6ed6PWGT22qF5VrqlLLK5DLfEyETQ==
X-Google-Smtp-Source: ANB0VdaieOSFhaey9Rk0+6s16NxZuFAyFVKdmx4PpHYimJnYOahCOFwtMWdtTBS96lRs0tAH/Ra5NN+uASiggPSpW8Q=
X-Received: by 2002:aca:d706:: with SMTP id o6-v6mr6136037oig.45.1535695151637;
 Thu, 30 Aug 2018 22:59:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:54a:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 22:59:11 -0700 (PDT)
In-Reply-To: <20180830212710.jhpxjdyuifjxr6t6@earth.universe>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
 <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
 <CAMz4kuJGbvKKVvXmGKaEMbu87bY1nQqB+Zvo5UTpv1gwCG41mQ@mail.gmail.com> <20180830212710.jhpxjdyuifjxr6t6@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 31 Aug 2018 13:59:11 +0800
Message-ID: <CAMz4ku+nPOtr_hWLswB=iwC8iCJ_cTCn1EjX8DwzVR97G_mGzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC2731 charger support
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 31 August 2018 at 05:27, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Thu, Aug 30, 2018 at 11:08:59AM +0800, Baolin Wang wrote:
>> >> +static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
>> >> +{
>> >> +       int ret;
>> >> +
>> >> +       /* Enable charger module */
>> >> +       ret = regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
>> >> +                                SC2731_CHARGE_EN, SC2731_CHARGE_EN);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       /* Set default charge termination current to 120 mA */
>> >> +       ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG2,
>> >> +                                SC2731_TERMINATION_CUR_MASK, 0x2);
>> >
>> > Looks like DeviceTree property.
>>
>> OK.
>>
>> >
>> >> +       if (ret)
>> >> +               goto error;
>> >> +
>> >> +       /* Set default charge termination voltage to 4.35V */
>> >
>> > Looks like DeviceTree property.
>>
>> OK. Thanks for your comments.
>
> I did not review this in detail, but had quick look at this.
> Please make sure to derive battery specific DT values using
> this:
>
> Documentation/devicetree/bindings/power/supply/battery.txt

Sure. Will look at this file. Thanks.

-- 
Baolin Wang
Best Regards
