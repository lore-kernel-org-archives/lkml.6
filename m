Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78A7ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E7A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1ndMvye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeITGVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:21:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42052 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeITGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:21:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so3013070lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hBXNT6GaMJBAHPm60Zmb4YbdbErp7ZiwzOnj7m5xz20=;
        b=I1ndMvyex1yCLmvb9bwxPBpTV5gzVEWfKR4AfeHcAJ3eL065B4jWbWJ92g+6ce8y2x
         jmpbURx7bjYzcSwu8KzW8EMp6C0Vr6kphOfzRuacuUuNfbooVqRRxJ49PshMUxUSnUlc
         PUeM83jqYrUgtBWREnbRQsl2i2AYSkdJmbLHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hBXNT6GaMJBAHPm60Zmb4YbdbErp7ZiwzOnj7m5xz20=;
        b=cuYhVkn0KTHlYeFAF4kmP+7Jor3FrMtdoXFAffHj758edzevHCMFINTJeYTCGYawZj
         uJejH2f9zCq9rRJbsyPIveGAgMQKGxYeWKeUM8KVpQ/br8kr/uLa3yhaBoVh94RKr2bJ
         y/0bMh2ZaSCeeF/GYU8IzdEpKq4qIBvCcnKEx8z32lTnD61ncJwl+QiaGSU4UEP772/k
         y5siiEb18TjvnQU5qUUO73xYrb0c1yrruvcubhT8dva8hhxOOB/zunUCZWJlQFqkwwus
         flijc4RfbMsvG7q2DctfOu20bfl9T6ILnVW0KTiERuyF/y3If3TgMVM4Bt8fU9W5PoH6
         Fdpg==
X-Gm-Message-State: APzg51AO4ptR3D3+7xP//E/+6RL7e5U1Z+0jRt13LhSGV8uHcMJuC1m5
        /kXwUZlYLJO7xm5MJ6/ytFoP6KoRHMBbcW/IJqCAhQ==
X-Google-Smtp-Source: ANB0VdYWQYtMPfVyEDgeShZBRf9cJHFvMjFGeF8DzsgYrYGRfTEwNa7ZAiDt6HE+7Z142NZsa0ZUZFbtpyDcYybIMj8=
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr23792842lfe.89.1537404047569;
 Wed, 19 Sep 2018 17:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9045:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 17:40:46
 -0700 (PDT)
In-Reply-To: <20180920003630.ygvjnuutmd5n2vre@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <1295864a38810a6db6c97e298c6663ae2b1350c1.1536736399.git.baolin.wang@linaro.org>
 <20180916143552.3oxjqpo6vravh5cy@earth.universe> <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
 <20180920003630.ygvjnuutmd5n2vre@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 20 Sep 2018 08:40:46 +0800
Message-ID: <CAMz4kuKboR+QBJ9sQoiSA0SQHGioufpjgv7nKYCugfDewx5PLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC27XX fuel gauge unit driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

Hi,

On 20 September 2018 at 08:36, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> On Mon, Sep 17, 2018 at 12:01:51PM +0800, Baolin Wang wrote:
> [...]
>> >> +static int sc27xx_fgu_parse_dt(struct sc27xx_fgu_data *data,
>> >> +                            struct device_node *np)
>> >> +{
>> >> +     const __be32 *list;
>> >> +     int i, len, size, ret;
>> >> +
>> >> +     ret = of_property_read_u32(np, "reg", &data->base);
>> >> +     if (ret) {
>> >> +             dev_err(data->dev, "failed to get fgu address\n");
>> >> +             return ret;
>> >> +     }
>> >> +
>> >> +     data->gpiod = devm_gpiod_get_optional(data->dev, "bat-detect", GPIOD_IN);
>> >> +     if (IS_ERR(data->gpiod)) {
>> >> +             dev_err(data->dev, "failed to get battery detection GPIO\n");
>> >> +             return PTR_ERR(data->gpiod);
>> >> +     }
>> >
>> > According to the binding (and the remaining code!) this gpio is not
>> > optional.
>>
>> Yes, they are not optional. If we can not get the detection GPIO, we
>> will return errors. So am I missing something else?
>>
>> Thanks for your comments.
>
> devm_gpiod_get_optional => devm_gpiod_get
>
> The _optional variant will return NULL if the GPIO is not specified in DT.
> The variant without _optional will return an error instead.

Ah, you are definitely correct. I missed _optional and thanks for
pointing this out.

-- 
Baolin Wang
Best Regards
