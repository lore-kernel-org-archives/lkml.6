Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8F82080F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sFzt0pva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBGUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:10:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:10:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so1191564wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=Ck/ivAOI6YZb4ffmZBEVM0UCgiu1gNXYgsW0Qt7/Rms=;
        b=sFzt0pvanDFTGj4jnduJ9ugaudGws+XUzChJhp1JoJHy23W95TdCCQb7V7BnK2VXaZ
         DvYH7ZiLTvnXmO0uLGA3qW+2m7MCvThnvRMoUHWfu9eZ3UVafBbU2c36+Kv0EgquMmer
         C/TT8rNcnQvCgX5MFqzLw5BKkZSURfa8XFLuicReYga64+FWdkbGm0XKPfkdjcMiTR2U
         9+1JNUNZPfNd/moB3DszZpdjTDdaupgPVZJKkhJMxUvh3a3q2UmwguiKTPooHDRT4DH+
         9v9oWIlV030MCwgThjuNPb6k+e9IsdNpdEQuLmKe7hFENKmlYaU5kFu28pG69WPbikKr
         ceuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=Ck/ivAOI6YZb4ffmZBEVM0UCgiu1gNXYgsW0Qt7/Rms=;
        b=SZe0Z1osipVci0agRCTkIUqxKVwR9uu9gRaXj8bVXYt+LMsrIrxcvF3MCUe+eRkgUk
         jyv03PUkRlszxvF3NGCozbEnxMK37uE37H9p5oAwMF7qSd3GeS6fAccsz5Vjb5Z8cdO2
         49sz+ggu3IsSxh9MsUa5uIvJCkJvwGU8zcx8/JhC+IPipbtN63sps8HcueF05Ku9QOUJ
         HhpuQ8v5/VJVr7LOTII/Jj5Be5+BgrEIBaMOji5vM0XbWd47ODhl72eUMIOm5YhK1aWv
         wBnSYqNEUul72GXs+sIuLd956/Cthg3MJr+bXIDTX6eWdZTa5Xfmni5W8mpVCPxqZQWF
         CFRw==
X-Gm-Message-State: AHQUAuYZbMLrtwbEGRkEKvU4ng1lQOHi/LAYczYDWblMGmMu419EzMhM
        Gu3/qlsO98IDZRAf5hjEY4D3aw==
X-Google-Smtp-Source: AHgI3IZYQqgnqtTsRkvfKurjqv9pgAuxMfR8VAb+RAFqRGCPqUsQCM+FVtobKQXDw9jTbMAlJapfIQ==
X-Received: by 2002:adf:c982:: with SMTP id f2mr8576140wrh.98.1549570252297;
        Thu, 07 Feb 2019 12:10:52 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a15sm12008922wrx.58.2019.02.07.12.10.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 12:10:51 -0800 (PST)
Message-ID: <5C5C90CA.8050409@baylibre.com>
Date:   Thu, 07 Feb 2019 21:10:50 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org
CC:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
References: <20190204091331.9298-1-narmstrong@baylibre.com>      <20190204091331.9298-2-narmstrong@baylibre.com> <2f03298e4d1ca0aa08d683d6db14bc194607b974.camel@baylibre.com>
In-Reply-To: <2f03298e4d1ca0aa08d683d6db14bc194607b974.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/02/2019 16:10, Jerome Brunet a écrit :
> On Mon, 2019-02-04 at 10:13 +0100, Neil Armstrong wrote:
>> Add bindings for the Amlogic G12A AO Clock and Reset controllers.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
>>  include/dt-bindings/clock/g12a-aoclkc.h       | 43 +++++++++++++++++++
>>  include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++
>>  3 files changed, 62 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt 
>> b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> index 79511d7bb321..c41f0be5d438 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>> @@ -10,6 +10,7 @@ Required Properties:
>>  	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
>>  	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
>>  	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
>> +	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
>>  	followed by the common "amlogic,meson-gx-aoclkc"
>>  - clocks: list of clock phandle, one for each entry clock-names.
>>  - clock-names: should contain the following:
>> diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-
>> bindings/clock/g12a-aoclkc.h
>> new file mode 100644
>> index 000000000000..997aca16c94f
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/g12a-aoclkc.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>> +/*
>> + * Copyright (c) 2016 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
>> + */
>> +
>> +#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
>> +#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
>> +
>> +#define CLKID_AO_AHB		0
>> +#define CLKID_AO_IR_IN		1
>> +#define CLKID_AO_I2C_M0		2
>> +#define CLKID_AO_I2C_S0		3
>> +#define CLKID_AO_UART		4
>> +#define CLKID_AO_PROD_I2C	5
>> +#define CLKID_AO_UART2		6
>> +#define CLKID_AO_IR_OUT		7
>> +#define CLKID_AO_SAR_ADC	8
>> +#define CLKID_AO_MAILBOX	9
>> +#define CLKID_AO_M3		10
>> +#define CLKID_AO_AHB_SRAM	11
>> +#define CLKID_AO_RTI		12
>> +#define CLKID_AO_M4_FCLK	13
>> +#define CLKID_AO_M4_HCLK	14
>> +#define CLKID_AO_CLK81		15
>> +#define CLKID_AO_SAR_ADC_SEL	16
>> +#define CLKID_AO_SAR_ADC_DIV	17
> 
> Do we need to export the internal part of these composite clock ?
> I know the other AO controller do it but it would be nice to avoid it, like
> for the EE controllers ... unless there is good reason of course.

Historically, we exposed everything for the AO controller,
we can follow the same scheme as the EE controller starting
from this one.
There is no strong reason to expose everything...

I'll res-pin a v2 with both issues fixed.

> 
> Same for the others below.
> 
>> +#define CLKID_AO_SAR_ADC_CLK	18
>> +#define CLKID_AO_CTS_OSCIN	19
>> +#define CLKID_AO_32K_PRE	20
>> +#define CLKID_AO_32K_DIV	21
>> +#define CLKID_AO_32K_SEL	22
>> +#define CLKID_AO_32K		23
>> +#define CLKID_AO_CEC_PRE	24
>> +#define CLKID_AO_CEC_DIV	25
>> +#define CLKID_AO_CEC_SEL	26
>> +#define CLKID_AO_CEC		27
>> +#define CLKID_AO_CTS_RTC_OSCIN	28
>> +
>> +#endif
>> diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-
>> bindings/reset/g12a-aoclkc.h
>> new file mode 100644
>> index 000000000000..bd2e2337135c
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/g12a-aoclkc.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>> +/*
>> + * Copyright (c) 2016 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
>> +#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
>> +
>> +#define RESET_AO_IR_IN		0
>> +#define RESET_AO_UART		1
>> +#define RESET_AO_I2C_M		2
>> +#define RESET_AO_I2C_S		3
>> +#define RESET_AO_SAR_ADC	4
>> +#define RESET_AO_UART2		5
>> +#define RESET_AO_IR_OUT		6
>> +
>> +#endif
> 
> 
