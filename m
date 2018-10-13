Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9D0C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C02077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 20:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHSN6twT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20C02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeJNE3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:29:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35208 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeJNE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:29:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so16008130wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=htq52MbTXDpeNFqXTIJCmCzIDiqBCxW3ZBLxEDZAggk=;
        b=dHSN6twTAz1zbG7QiibAYi0nOwy2vTnoMCfvwdzcM2TWKIGwgDLd4lKRKApvMB2a3S
         8TjwCQ898KBoKw1VcHSbaf0R040GkBxPyiB4+/AwYGnhr0aqHwmUAVIKzRBxxauVBt3x
         o+e9FSWw0pQb1+WU4c5zopbTcAkvHfwlvLcIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=htq52MbTXDpeNFqXTIJCmCzIDiqBCxW3ZBLxEDZAggk=;
        b=hoU0M9FNiwfH3EArntE+/3E7D4N2g6VXffbOlMECBOctzPU1P2FMO9Boc0QHP6HUHy
         tcbjEmPfPkzoSxYwxGlkaWMEqpcY+8lBG6ZRk5vjsU75mXH+e62a3Du15XAFEPC9+piA
         ZLZ7R15rqgUPywaz3HiArbpXjtPziyksxXiUUQmnRJAWkm0BTO/xTp1m81JJtdaOm4SH
         jmEOQ43wN3Nm1FsyWO3Y6cWyNVlKYcvWFbkdU+ZwE59WZI9nHljcPk/sPf9LEtv/9nS0
         Uw0JMI8lsJa0S5/FfcT61gk9XVNqH822OvamKbma6I36v3lpNq5HRgwl88o15XUI7q/g
         kmog==
X-Gm-Message-State: ABuFfohIGPZthAI1a4LcouP6NKKdX3itduCOVHI4lK/ojRpD0GJlqj2o
        SL/NqXj3qmsoY4GaPp6HaXdtsNZfNgs=
X-Google-Smtp-Source: ACcGV6167aU9lF9r/JC8uU7+iFpAdHPfl18Eb9/JMm6ABx6k+z6YvVaxEbbcZM1AwsfPkPeDXwNDeQ==
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr8459503wmg.64.1539463836555;
        Sat, 13 Oct 2018 13:50:36 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e142-v6sm14353118wmf.20.2018.10.13.13.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 13:50:35 -0700 (PDT)
Subject: Re: [PATCH V12 0/8] C-SKY(csky) Linux Kernel Driver
To:     Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1539315341.git.ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dfe56d38-cfa5-2be1-114e-c6721d6c92a3@linaro.org>
Date:   Sat, 13 Oct 2018 22:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1539315341.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 14:02, Guo Ren wrote:
> This is about 12th patchset for C-SKY linux drivers and it should pair
> with 8th kernel patchset.

Guo,

I'm willing to take your timer related patches but you have to put a
proper description.

  -- Daniel


> Changelog:
>  - Remove the set_irq_createmapping call back in csky-mp-intc.c.
>  - Convert the cpumask to an interrupt-controller specific representation
>    in driver's code, and not the SMP code's, and also modify the related
>    codes in csky kernel patchset.
>  - Add COMPILE_TEST for csky_mp_timer.
>  - Fixup smp boot error, cpuhp_setup_state must after timer_of_init()
>    for csky_mp_timer.
> 
> Any feedback is welcome, thx for all people review my patchset.
> 
> Guo Ren (8):
>   irqchip: add C-SKY SMP interrupt controller
>   dt-bindings: interrupt-controller: C-SKY SMP intc
>   irqchip: add C-SKY APB bus interrupt controller
>   dt-bindings: interrupt-controller: C-SKY APB intc
>   clocksource: add C-SKY SMP timer
>   dt-bindings: timer: C-SKY Multi-processor timer
>   clocksource: add gx6605s SOC system timer
>   dt-bindings: timer: gx6605s SOC timer
> 
>  .../interrupt-controller/csky,apb-intc.txt         |  62 +++++
>  .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++
>  .../bindings/timer/csky,gx6605s-timer.txt          |  42 ++++
>  .../devicetree/bindings/timer/csky,mptimer.txt     |  42 ++++
>  drivers/clocksource/Kconfig                        |  18 ++
>  drivers/clocksource/Makefile                       |   2 +
>  drivers/clocksource/timer-gx6605s.c                | 154 ++++++++++++
>  drivers/clocksource/timer-mp-csky.c                | 173 +++++++++++++
>  drivers/irqchip/Kconfig                            |  17 ++
>  drivers/irqchip/Makefile                           |   2 +
>  drivers/irqchip/irq-csky-apb-intc.c                | 274 +++++++++++++++++++++
>  drivers/irqchip/irq-csky-mpintc.c                  | 198 +++++++++++++++
>  include/linux/cpuhotplug.h                         |   1 +
>  13 files changed, 1025 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
>  create mode 100644 drivers/clocksource/timer-gx6605s.c
>  create mode 100644 drivers/clocksource/timer-mp-csky.c
>  create mode 100644 drivers/irqchip/irq-csky-apb-intc.c
>  create mode 100644 drivers/irqchip/irq-csky-mpintc.c
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

