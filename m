Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="obDoflB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfAOKAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:00:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42974 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfAOKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:00:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so2031165edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vRX2KAWNtaUajnhYZlYwW+dL/BwPFiM5lo0RqCcBmy4=;
        b=obDoflB6Sue/vDxRGDduY4g3r4akPT/TEDArt4TqqtQg7c/q4CfTnAKUyKdfnMrJVI
         FyG+TmpVOej+H7dTimbfliCJ8anA1iZF++MeLiLrEB4uw9VRnDNfV5+0mjF3OJyJcJS1
         jiThKaMiY7VKwGYZIl5NlfVb0xloeCcgiXNkAl4m1LetTB3asVS+lVRrrmZCmXl/Bgdw
         HTgij6sB3F5DWZ0ervzTedxCNfmAYv1x8qWJy0BIGGFc2ZtSwFA6R4GTLGvPJenNbTNL
         oqa5pDoxqcLeQQKT4HL3rSBUvlJzi34vyMHLuNI2O8OxDN0sW22gwI+vIYE6yEMVbsX5
         pyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vRX2KAWNtaUajnhYZlYwW+dL/BwPFiM5lo0RqCcBmy4=;
        b=VDBlKaBbxxp/3TJiLcWlWDbs9rjPXclm+/pvJoxuj+15adozERmxbe+TJVu6skkQ1B
         yP3jf8f0v3yUJZ5e2OY7LV4sjna8uezDevL45f34xBe0DEg9XH+mASi4bFiVMy1wcRrg
         nxUXz0KyHoRPlaf50I10lezMCPL4o090qREiWxzkM8ujPynLSSlQq74OBRi/fsLfOZba
         WWgarUIztVV5pmGR/W6Q91BKYJ8+EHsU5IKWaLwTI5hnOSd2lZDEU3uUokZa6Gifd9pm
         B8+N0vZK8gcNe7wQJFhpFqWe2uoHfXoMp4YCHtdHhKLrIjAOxLxvtFxEXB1B7uakl2+Z
         RJgQ==
X-Gm-Message-State: AJcUukc2UVSK33QbvPsCm912Emg6/GqrQKyhoqABKleDKxh87HEMA9w9
        k+QZnv0qAhHCGjM5+qxpzGcsYA==
X-Google-Smtp-Source: ALg8bN78Kpx0ZGpi7od0psVnM8LVsU1vLkHZozkJgrC8KOFlR2MpsBlLosT+ZQ9wAraFa5ChzRbqFw==
X-Received: by 2002:a50:b5a5:: with SMTP id a34mr2753460ede.52.1547546440462;
        Tue, 15 Jan 2019 02:00:40 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:c75])
        by smtp.gmail.com with ESMTPSA id a38sm4693454edd.44.2019.01.15.02.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:00:39 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
        <CAL_JsqLvSWF60eqLsXUcP5GL0ijgfE6XwvectiM1D1Y9LPpOkA@mail.gmail.com>
Date:   Tue, 15 Jan 2019 11:00:37 +0100
In-Reply-To: <CAL_JsqLvSWF60eqLsXUcP5GL0ijgfE6XwvectiM1D1Y9LPpOkA@mail.gmail.com>
        (Rob Herring's message of "Fri, 4 Jan 2019 11:51:51 -0600")
Message-ID: <86fttup7ei.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Jan 2019 at 11:51, Rob Herring <robh+dt@kernel.org> wrote:

> On Fri, Dec 28, 2018 at 4:51 AM Loys Ollivier <lollivier@baylibre.com> wrote:
>>
>> Hello !
>>
>> This patch series adds a new GNSS driver for the globaltop GNSS receivers.
>> These receivers transmits NMEA output sequence as soon as they have booted.
>> Power management can be done via the main supply and optional backup supply
>> as defined in the device tree.
>>
>> The driver has been tested using a GlobalTop pa6h chipset on a Libretech-cc
>> board using the expansion header. Changes made in the board device tree can
>> be found below for reference and testing.
>>
>> Loys
>>
>> Loys Ollivier (4):
>>   dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
>>   dt-bindings: gnss: add gtop binding
>>   gnss: add gtop receiver type support
>>   gnss: add driver for globaltop receivers
>>
>>  Documentation/devicetree/bindings/gnss/gtop.txt    |  33 +++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  drivers/gnss/Kconfig                               |  13 ++
>>  drivers/gnss/Makefile                              |   3 +
>>  drivers/gnss/core.c                                |   1 +
>>  drivers/gnss/gtop.c                                | 152 +++++++++++++++++++++
>>  include/linux/gnss.h                               |   1 +
>>  7 files changed, 204 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/gtop.txt
>>  create mode 100644 drivers/gnss/gtop.c
>>
>> ---
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> index 90a56af967a7..3b3d4dcc47aa 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
>> @@ -17,6 +17,7 @@
>>
>>         aliases {
>>                 serial0 = &uart_AO;
>> +               serial1 = &uart_A;
>
> You should not need this as the UART is not used as a tty. It could be
> that the serial driver requires aliases, but that should be fixed.
> There should be some examples of fixing this in other serial drivers.
>

Thanks Rob,
Followed up on that [0]. 

[0]: https://lore.kernel.org/linux-amlogic/1547484866-3600-1-git-send-email-lollivier@baylibre.com/
>>                 ethernet0 = &ethmac;
>>         };
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
