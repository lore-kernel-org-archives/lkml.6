Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F337AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B522C2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BYwU1Xbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B522C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGRAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:00:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41632 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:00:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so2084184plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EFeBTriw3WtWApru9lpzGXgxuzTUuNPf+UmnstYWyfo=;
        b=BYwU1Xbdvx6Q+0Bwj5O0fkF1gdaXKBYs1Gdgxpg/1EFnVof2s9zFEIWDRIIVeDIdoD
         AauX9wMFSaErn7ezTncsU5a1AEfBeMlPL50W7UaNh8pzg6tvLuhh6V6Vxhyv9+INOmWH
         vWRylC3oSDFZD4ifHmnmrMNZ7gQ9BcOeLPvrgzUgLJ/Rid4w1IKl4BbeTreJGKR2eAvp
         Hy7H/AW1NrfMPqArAfEIO3MBtiTxlkmjXExDNKt6baOqsSi4hChcUxPsNoWeGWUvuDUy
         pioPhFAhWqCO9nc0MBotg7KnAyarrLjSjMjumwa2VyX/gKOaPasPAmIlj8Nxvd0g+j0O
         2qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EFeBTriw3WtWApru9lpzGXgxuzTUuNPf+UmnstYWyfo=;
        b=arYdst6v4b+gS0JXjYZ+4kJL1f9Tf5ih4k6wvJKIicvv0d3D1w19TqwtV9PCTf3r0J
         lBgkqxwQ2zg37D1yNKlJ0TJ5pKzdRYtlrm+7W6leFp4onnxNRlfuAa4u1V3pcTH+HRA4
         /hOCBpoUR/7QlzzEbOCpbkPN2ianSock2hxOHSLL2o0+wkXRclBidKOOMXwP8NN/qxiU
         UN/0IpeAutHJO/gmMtTT6vZo8mzK1+6E8Fvu5dVXe5g98DOOPgweZ2mMxJmObFKPFCT7
         GWq9XOqQ2t+iJUEAS741MGopSF9F6SADGcND7fja0WWUVEd63UqQwxPE13a+BsJ4PJu0
         +LhQ==
X-Gm-Message-State: AA+aEWZ/4ayZZ593HKGsvfZbYzQP/Xpz9B0Aminyqq5YEIcoWdLlHZI8
        SIhZAigMxtQCqxaNGgfF5clS2cDmep4=
X-Google-Smtp-Source: AFSGD/VN6fxcWaaug+LymN0uEElGhbOPQYiZ01ZDtWT+BJ2pEbIfTyUrhdQrzPUza3sSpPKzqbHljw==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr2818163plm.234.1544202008731;
        Fri, 07 Dec 2018 09:00:08 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id 125sm8733897pfd.124.2018.12.07.09.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:00:07 -0800 (PST)
Date:   Fri, 07 Dec 2018 09:00:07 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 08:46:10 PST (-0800)
Subject:     Re: [PATCH 3/4] RISC-V: Remove per cpu clocksource
In-Reply-To: <1543870651-16669-4-git-send-email-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, anup@brainfault.org,
        Damien.LeMoal@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-a0437cab-9a27-45a5-aabe-0dee2c1d96db@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018 12:57:30 PST (-0800), atish.patra@wdc.com wrote:
> There is only one clocksource in RISC-V. The boot cpu initializes
> that clocksource. No need to keep a percpu data structure.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/clocksource/riscv_timer.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 96af7058..39de6e49 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -49,7 +49,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
>  	return get_cycles64();
>  }
>
> -static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
> +static struct clocksource riscv_clocksource = {
>  	.name		= "riscv_clocksource",
>  	.rating		= 300,
>  	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
> @@ -106,7 +106,6 @@ static long __init riscv_timebase_frequency(struct device_node *node)
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
>  	int cpuid, hartid, error;
> -	struct clocksource *cs;
>
>  	hartid = riscv_of_processor_hartid(n);
>  	cpuid = riscv_hartid_to_cpuid(hartid);
> @@ -116,8 +115,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>
>  	/* This should be called only for boot cpu */
>  	riscv_timebase = riscv_timebase_frequency(n);
> -	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
> -	clocksource_register_hz(cs, riscv_timebase);
> +	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>  			 "clockevents/riscv/timer:starting",

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
