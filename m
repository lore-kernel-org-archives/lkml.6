Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82432C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315F72150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315F72150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeHXASY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:18:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33179 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeHXASX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:18:23 -0400
Received: by mail-io0-f193.google.com with SMTP id r196-v6so5426070iod.0;
        Thu, 23 Aug 2018 13:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iolxbEmwehonQsyEQqPKI/WpimRh6UnVh5Cbh2Mq1c=;
        b=FxyIOC9v0NQpRTRIFxB58ddLeQqg4wjptKNYyxQfrxhggIwnUdzujp9w4wazKGldb7
         OOoFzZdANnYmBlIldCA4FHpWDw7+gAZyPFaSOwUp2+K6fbqPnWBJ6BiNVAwxy21gvaRk
         stvsQspbSGVV2vu45Dm9u9dt7G5267ZO2+ej0io2O0hCAUAlXARJtmvZWzyIv2KGm3Oo
         tsWgiP+Z7yT8nEQLSxSFRjNAbIugK1vtajwhnUinNpztnUT5SK0TO1kCn4jtrAZ9tpFQ
         Y4nkJjTA+wtU8uMTWT2hyifhIAdsBssceYCdmPOLzUGZG08sJ0rffna4v1C9DR8BSCrd
         w8Hg==
X-Gm-Message-State: APzg51A3P9EUKqN77Y5DPwmKHch1hwl2ufdQ5RETdD8dGHFr2gUoC1Sd
        8pOnEKPNW45Twng+JV8T83uHGunDu/o=
X-Google-Smtp-Source: ANB0Vdadc5L+JvPUHCrKmPkNraqeFYNS4jViIxBVZdIeoAIYmk02QCjK8ekJpHv7xc6hp8T70OMiyA==
X-Received: by 2002:a5e:8e02:: with SMTP id a2-v6mr5950905ion.144.1535057219145;
        Thu, 23 Aug 2018 13:46:59 -0700 (PDT)
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com. [209.85.223.176])
        by smtp.gmail.com with ESMTPSA id q196-v6sm2060137iod.23.2018.08.23.13.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:46:58 -0700 (PDT)
Received: by mail-io0-f176.google.com with SMTP id y3-v6so5428485ioc.5;
        Thu, 23 Aug 2018 13:46:58 -0700 (PDT)
X-Received: by 2002:a6b:3a0b:: with SMTP id h11-v6mr18121019ioa.278.1535057218131;
 Thu, 23 Aug 2018 13:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
In-Reply-To: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 23 Aug 2018 15:46:47 -0500
X-Gmail-Original-Message-ID: <CADRPPNRpquUgwjft=vLNcxy223BLrS=toWii1XExPb7SghGr-A@mail.gmail.com>
Message-ID: <CADRPPNRpquUgwjft=vLNcxy223BLrS=toWii1XExPb7SghGr-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
To:     amit.kucheria@linaro.org
Cc:     lkml <linux-kernel@vger.kernel.org>, lorenzo.pieralisi@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, liviu.dudau@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, matthias.bgg@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>, andy.tang@nxp.com,
        Ran Wang <ran.wang_1@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yao Yuan <yao.yuan@nxp.com>, sumit.garg@nxp.com,
        Marc Zyngier <marc.zyngier@arm.com>, madalin.bucur@nxp.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 3:55 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be
> set to "psci".
>
> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
> bindings examples") attempted to fix this earlier but clearly more is
> needed.
>
> Fix the cpu-capacity.txt documentation that uses the incorrect value so
> we don't get copy-paste errors like these. Clarify the language in
> idle-states.txt by removing the reference to the psci bindings that
> might be causing this confusion.
>
> Finally, fix devicetrees of various boards to reflect current
> documentation.
>
> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
> idle-states node)
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Li Yang <leoyang.li@nxp.com>

For fsl/nxp device trees:

>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi         | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi         | 2 +-

- Leo
