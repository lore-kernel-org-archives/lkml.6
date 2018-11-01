Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896212064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQpaUfaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896212064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKAPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:43:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37256 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeKAPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:43:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4-v6so17094059lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D3bpK1GmB4/nEYAhTMt5b8cAzvVwhRnx8VLexy3aBA0=;
        b=DQpaUfazow9NLSGWrRbS+yzmXeiFQeFGmPVRHwLXt9+zwSjBANPoVYPymUKYAu2oMv
         78Qqv1bHbKoHNvrOYHGsB7BUc05v2+INrFKT+Vv1Zd5pY/unrgEWJMbydgsyWG/afD+B
         AnxIcFpwIDE7C/lK5K+xS2qJrcFAZy17kDSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D3bpK1GmB4/nEYAhTMt5b8cAzvVwhRnx8VLexy3aBA0=;
        b=HPbEn41P6pupUNyfi228DhVeluWXNXHcacaNHhaogfGlL2bhXV2WlfexVtZAOlRLZF
         z1994Kc9TgPqM8UYme+W+x6gXQ4wvNB6Lto0RK3oeh15EApAqHv0uXkZORDi2B6SLvT7
         6wmc0UVDljZ8prdEKkTVynYjTbGoYNjB9QqV7IPrW2qGVAuHnDO0QlRAk7t0WDW8sRft
         iIcGiZmq8+y8e1rOYLENSpjCZcENQO/H7c5xpnzymyGUNEig5I0GNLDdgyj5frctU3nd
         Anvwhzyoosvl8glFabRX7isV0vEv3QvejaXbx6IPl/ptRH7Wy7jMCzdWV+3fGMFDv+/x
         AWuQ==
X-Gm-Message-State: AGRZ1gIDB+QH07fKDYAPEgPFKDCoDGEpk2bbDKYhcn5HOe4xXHZPFDFG
        Me3hzzw0oCLdNoRWz7jLPhNo/0vzzTBeRoRhHBgomw==
X-Google-Smtp-Source: AJdET5dV1FDMOZ5IZUEy+nlfC9mOH5i0dXBAIupFG40OSCGW+XX/lq5mn0hdyEnPtoxU001kN7ONgjV9PbSQhXfh/ck=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr3397456ljb.52.1541054533786;
 Wed, 31 Oct 2018 23:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 23:42:13
 -0700 (PDT)
In-Reply-To: <CACRpkdaDB2f5FTY-sk6Ak49GMtqFzV_5Jkway49zSLA6XJkq0A@mail.gmail.com>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <6a4c15368e0bf34f8e6aad4d788bc899cfb9d61e.1540189330.git.baolin.wang@linaro.org>
 <CACRpkdaDB2f5FTY-sk6Ak49GMtqFzV_5Jkway49zSLA6XJkq0A@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 1 Nov 2018 14:42:13 +0800
Message-ID: <CAMz4kuLwmk+F8w=3QKTn29OArMfCpZc-429m_nFn8bqFVQekgA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 October 2018 at 16:56, Linus Walleij <linus.walleij@linaro.org> wrote=
:
> On Mon, Oct 22, 2018 at 9:44 AM Baolin Wang <baolin.wang@linaro.org> wrot=
e:
>
>> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
>> which is used to calculate the battery capacity.
>>
>> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v5:
>>  - Save the OCV values in micro volts for OCV capacity table.
>>  - Use devm_kmemdup() instead of devm_kzalloc() in sc27xx_fgu_hw_init()
>
> Hi Baolin, you can keep my ACK, just adding some nitpicking:

Thanks.

>
>> +struct sc27xx_fgu_data {
>> +       struct regmap *regmap;
>> +       struct device *dev;
>> +       struct power_supply *battery;
>> +       u32 base;
>> +       struct mutex lock;
>> +       struct gpio_desc *gpiod;
>> +       struct iio_channel *channel;
>> +       bool bat_present;
>> +       int internal_resist;
>> +       int total_cap;
>> +       int init_cap;
>> +       int init_clbcnt;
>> +       int max_volt;
>> +       int table_len;
>
> Can  the above really be negative or should these int:s really
> be unsigned int?

 I think the table_len can be changed to u32, but for others, I'd like
to keep consistency with the power supply battery information=E3=80=82

>
>> +static int sc27xx_fgu_adc_to_current(int adc)
>> +{
>> +       return (adc * 1000) / SC27XX_FGU_1000MA_ADC;
>> +}
>> +
>> +static int sc27xx_fgu_adc_to_voltage(int adc)
>> +{
>> +       return (adc * 1000) / SC27XX_FGU_1000MV_ADC;
>> +}
>
> Would you maybe use
> DIV_ROUND_CLOSEST(adc*1000, SC27XX_FGU_1000MV_ADC)
> on these?

Good point. Will change in next version. Thanks for your comments.

>
> Overall this is a very fine driver and really pretty compared to some
> other stuff we have in drivers/power.

Thanks.

--=20
Baolin Wang
Best Regards
