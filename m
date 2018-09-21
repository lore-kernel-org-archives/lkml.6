Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D288121479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1tVo7H45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D288121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbeIURex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbeIURew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:34:52 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B1F21479;
        Fri, 21 Sep 2018 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537530382;
        bh=VgVEy/97ATOTzwLl3+Cmv1wGuViyZrqzAF5Afe+y21U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1tVo7H45BaQ4C1C8rnqUjDnW5tRup7axvLGzGL9s1FiA17iZAJVaiSn457SVWdSoD
         z7dzhTnXVxiIRRIu9OEXVSe1cNfanPbRmWPt2tYj/hmsUze/YTquZNC/ebl1/4aAsb
         om/l/LsObvwx53cQRrGMIrTuVbsW0WA4UlR+pPWo=
Received: by mail-wm1-f42.google.com with SMTP id o18-v6so2949638wmc.0;
        Fri, 21 Sep 2018 04:46:21 -0700 (PDT)
X-Gm-Message-State: APzg51AP6GO8hgSD6EzHvho1qaijaL/0XK+kLcsTcsUx7TtFEoBCbMkq
        YNy+ZzQpuNNKbpcKgDZKu7G2l8lwj0utTMnKS5o=
X-Google-Smtp-Source: ANB0VdZuJZ2Ur//4CNPKoCPcOQOhdE13T+G2I8TYfwTdXI4ccF+3tCtw4oralAWhqRrkZY/x6d94neE62V0o8HkM8As=
X-Received: by 2002:a1c:e4c3:: with SMTP id b186-v6mr6978252wmh.116.1537530380229;
 Fri, 21 Sep 2018 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk>
In-Reply-To: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Sep 2018 13:46:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
Message-ID: <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: ordering wrong order tmu_cpu on
 Odroid-XU3/4 thermal-zones definition
To:     willy.mh.wolff.ml@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 at 13:33, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> This patch is to open a discussion about wrong order of tmu_cpu.
>
> It seems that tmu_cpu1 correspond to cpu3, and tmu_cpu3 match cpu1.
> Note, cpu{0|3} in dtsi correspond to cpu{3|7} in linux and are the big
> cores.

Hi,

I do not understand this sentence. In DTSI, the CPU0-3 are the A7,
little cores. Defined by exynos5422-cpus.dtsi. What did you mean here?

> By dependencis from exynos5422-odroidxu3-common.dtsi to
> exynos5800.dtsi -> exynos5420.dtsi, I guess definitions of tmu_cpuX are
> incorrect. However, changing the address, reg interrupts or clocks
> would breack other boards depending on it. As I can't test other boards,
> I've just overload the reference in the thermal-zones node.

There are 8 CPUs (4 little and 4 big) but only 4 thermal zones for
CPUs. The mapping of names of CPU nodes and TMU nodes in DTS is not
direct. These are just indices ... although more important is to map
the cooling devices to proper TMU. This should be mentioned in DTS as
this the real problem here.

>
> To reproduce the problem, I provide two scripts:
> == script_stress:
>
> for i in 0 10 20 40 80; do
>     echo $i
>     taskset $i stress -t 10 -c 1
> done;
>
> == script_read_temp:
>
> while true; do
>     for i in 0 1 2 3 4; do
>         echo $i
>         cat /sys/devices/virtual/thermal/thermal_zone$i/temp
>     done;
>     sleep 1
>     clear
> done;
>
> Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 96e281c0a118..4512ffad2785 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -135,7 +135,8 @@
>                         };
>                 };
>                 cpu1_thermal: cpu1-thermal {
> -                       thermal-sensors = <&tmu_cpu1 0>;
> +                       // thermal-sensors = <&tmu_cpu1 0>;

Do not leave commented lines, there are not needed.

Also your email does not match signed-off-by. You must have something
wrong with either git setup or mailer (git commit --si will use the
same address for From and SoB so I guess the mailer...).

Best regards,
Krzysztof
