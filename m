Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C8622360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYjDsqBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C8622360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKOLln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:41:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:41:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so5584084pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I8Ps1Ot+ilZM/p93NJCoBHoDOUqbuCiTwoYJCqizx7Q=;
        b=ZYjDsqBB3yqmmfFeW+FTJ2vSUeSBoT+iJIYcRjJdaCdBizVbcjglncmXdjYYQnRwgG
         d5eolt/rEavAaA5eLQtVOT7fjRwh2TTlc1EkR5REPKWxV09t/v3yRvqOewgfy+bIyvHa
         UAHLv7acaEH6SpeQanofYCfmXEjc+Uagox3O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8Ps1Ot+ilZM/p93NJCoBHoDOUqbuCiTwoYJCqizx7Q=;
        b=guu0FtASyzDlYlzqtIvjdt5p+R7dF9PVA161sFPs0BhJV0ZmtGBRlaV8+/o0m27HDt
         EEEkZ9cjsk2KJ9nUO0lOQnmSk2uBjUoqEYJ15Sif4c5tJJUU+bKZZ7L56DSrWPGmqdNO
         cTahFIv2lIFnbPExaWqCK7G4XSTpRmmIn2ispoDMWwwKNKcC9N18D7uZ9DX/x8/SA0/j
         jA4I7UN1YgWvheGAkqAJQWrAyiy2YEShXXDWcyZbdggK25Fa0OcE6HY8VLitRGn71sox
         eUZCMsxh7cdhVQSj74C5J+9xfRL4e71TyzJIKe30SzawAJGfPFAPQYq9D5rQ/Cc8H3FJ
         jcSQ==
X-Gm-Message-State: AGRZ1gJ4RuoEEk0dbuyjFndOnk377b3EkpZAXm/oTO8SRI8kvP33SFR1
        tcL9ZBbTEuR52K3RpYSiJpIITg==
X-Google-Smtp-Source: AJdET5dUkn00v53ZSXBdCZc60AdNhAE+LJSu71ZWD0AUnHFdV+dKdQNvZJQGdxZB2Vihxd+qVT5XZA==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr3930731pgl.186.1542245758681;
        Wed, 14 Nov 2018 17:35:58 -0800 (PST)
Received: from [172.30.51.152] ([64.114.255.97])
        by smtp.googlemail.com with ESMTPSA id 18-v6sm38694983pfu.129.2018.11.14.17.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:35:57 -0800 (PST)
Subject: Re: [PATCH 1/2] clocksource: meson6_timer: use register names from
 the datasheet
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
 <20181028125501.17336-2-martin.blumenstingl@googlemail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6793aba9-87fc-6cf8-cada-f1fa6a1e0040@linaro.org>
Date:   Thu, 15 Nov 2018 02:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181028125501.17336-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2018 13:55, Martin Blumenstingl wrote:
> This makes the driver use the names from S805 datasheet for the
> preprocessor #defines. This makes it easier to spot that the driver
> currently only supports Timer A (as clockevent with interrupt support)
> and Timer E (as clocksource without interrupts). Timer B, C and D (which
> are similar to Timer A) are currently not supported by the driver.
> 
> While here, this also removes the internal "CED_ID" and "CSD_ID" defines
> which are used to identify the timer. These IDs are not described in the
> datasheet and thus make it harder to compare the code to what's written
> in the datasheet.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clocksource/meson6_timer.c | 110 ++++++++++++++++++-----------
>  1 file changed, 68 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
> index 92f20991a937..c622135bee9d 100644
> --- a/drivers/clocksource/meson6_timer.c
> +++ b/drivers/clocksource/meson6_timer.c
> @@ -10,6 +10,8 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> @@ -20,80 +22,102 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  
> -#define CED_ID			0
> -#define CSD_ID			4
> -
> -#define TIMER_ISA_MUX		0
> -#define TIMER_ISA_VAL(t)	(((t) + 1) << 2)
> -
> -#define TIMER_INPUT_BIT(t)	(2 * (t))
> -#define TIMER_ENABLE_BIT(t)	(16 + (t))
> -#define TIMER_PERIODIC_BIT(t)	(12 + (t))
> +enum meson6_timera_input_clock {
> +	MESON_TIMERA_CLOCK_1US = 0x0,
> +	MESON_TIMERA_CLOCK_10US = 0x1,
> +	MESON_TIMERA_CLOCK_100US = 0x2,
> +	MESON_TIMERA_CLOCK_1MS = 0x3,
> +};
>  
> -#define TIMER_CED_INPUT_MASK	(3UL << TIMER_INPUT_BIT(CED_ID))
> -#define TIMER_CSD_INPUT_MASK	(7UL << TIMER_INPUT_BIT(CSD_ID))
> +enum meson6_timere_input_clock {
> +	MESON_TIMERE_CLOCK_SYSTEM_CLOCK = 0x0,
> +	MESON_TIMERE_CLOCK_1US = 0x1,
> +	MESON_TIMERE_CLOCK_10US = 0x2,
> +	MESON_TIMERE_CLOCK_100US = 0x3,
> +	MESON_TIMERE_CLOCK_1MS = 0x4,
> +};

It is not required to specify the values. The standard defines the
default first value is zero, and each enum has the value which is +1 of
the previous one.

Other than that, the changes look ok.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

