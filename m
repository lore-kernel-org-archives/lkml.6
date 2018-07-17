Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B1B206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHh9JM+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B1B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeGQU6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:58:39 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45932 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:58:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so4467835oic.12;
        Tue, 17 Jul 2018 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=remtMM1dLeUZagBlL/2ql9wierFKRupmAW/ztpEL5wo=;
        b=sHh9JM+C+FNAhYqDjxabChBh+zTaViIkcCRUaEUQJ7+JpJRygXkZ2BMXgFwZS+nIQl
         7gog1Gm0fdIxPTrxQ+ksE2955g9uv06z899i7EsstqyWlBgXALuVhfnDkFmfDE3/E360
         ByMyceHtcErniudtN5uWN5/R2h4bxZ/xBDhfrWSSByaEfoSuTjUyp1lEOd7hY/GSdNLJ
         hJ46fNyhjnU0t5iRBgGNwd259dsLzjKZKFqmRVvRu/qdS/T0Rg3nVp5nUNyj/Vtt1M0g
         AQcnCzAIueYWbCjKlXdehV2oFexyxXTA/5iJIB0bigKasDhPCs4wWXo8GLIIVEBppTbw
         bPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=remtMM1dLeUZagBlL/2ql9wierFKRupmAW/ztpEL5wo=;
        b=j9qYeXBMYIDNKaZfhSl4KrxS+e67TDooAMdSBaYTgUjRwRKkEoBNLIGW4ILFxdwQbe
         eFJfs3aO2TSpOGnSmHaZ3MQmBOclxVo/fNrJRXCQ7pJsRlTwsetBhelX+x90E7emLrjw
         Yfwb/OYu8UPNyzXXth1h2NdLimIRyft1nxdsLgNovihbDvHs/L7jDNxn366/hsSqsSrE
         8/DOKVFo95yCenoR31jSmsbdEFMBcU6Hk76mB0aeF1sXHwMikPlSBqCTJQ9lo9ePFjJf
         YynqsIZYzhOkPIJtwbqjoaZRruRd4UsW9Caqj/5hxCU8qag5Uzte/5BLdil1AW0Ew1uf
         cAgw==
X-Gm-Message-State: AOUpUlEobslobGqZitxt/dNhz0719aiNdYwmMM6/0ZZ1GtelmQsL/KSo
        LhQE5Ylpc92Z0zZRVMo4UKHUtysz8IvG/GbLLv4=
X-Google-Smtp-Source: AAOMgpf1qCGxwzUZZh85ZwrqxCYApzp0cQuyzLPe4bAexPRanIbU8V2VE7IaQBHNmyagVK0PaHtpukJ4qyL7sCMXf1Y=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr3034667oif.165.1531859060283;
 Tue, 17 Jul 2018 13:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:23:59
 -0700 (PDT)
In-Reply-To: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 01:53:59 +0530
Message-ID: <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
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

Hi Krzysztof

On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi Anand,
>
> Thanks for patch.
>
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> clk_summary do not show tmu_apbif clk enable, so replace
>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>
> This is not valid reason to do a change. What is clk_summary does not
> really matter. Your change has negative impact on power consumption as
> the clock stays enabled all the time. This is not what we want... so
> please explain it more - why you need the clock to be enabled all the
> time? What is broken (clk_summary is not broken in this case)?
>

Opps I could not explain some more in my commit message.

Actually TMU sensor for Exynos process are controlled by so external clk

Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
control the CLK_SENSE tmu.

So as per my understanding tmu is clk driver which control the flow  PMIC.

clk_prepare_enable combine clk_prepare and clk_enable
and clk_disable_unprepare combine clk_disable and clk_unprepare.

most of the driver prefer clk_prepare_enable and clk_disable_unprepare.

clk_summary is just a reference looking point where we could check the
clk is enable/disable.

what is broken ?
I still few more parameter need to tuned to configure the tmu driver.

>> simplify the enable of tmu_triminfo_apbif clk, also fixed
>> the order of goto error for failed cases.
>
> This has to be split into separate change.
>
> Best regards,
> Krzysztof

Best Regards
-Anand
