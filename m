Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEE0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9345F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544448638;
	bh=MUoEBh/CkpemiWbFCDkBrInzhUf0NyuHUrVpJOvg6Vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wP/U3upKsq9q32NPUYaLQTonbe81pf0+tqYrhPNPnrSW7OZdNHqEKNmaKt9NKxWhd
	 7JVz+aoz8h2fm4G5u7+8bGeLj0qWNkcAPqWIbz0xZuZHTROBGyvrXE1UdChtHU4j55
	 CghyUiigpFt+Uc9sUd43j9SawwTqruNjo12twGp8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9345F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeLJNah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeLJNah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:30:37 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF05F2084E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544448636;
        bh=MUoEBh/CkpemiWbFCDkBrInzhUf0NyuHUrVpJOvg6Vs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w7ZbkSvrA3Cx9BCN04eUE+CQ40XnWaDXi2KszSsjylRO49WtKrr1bYufpLpwuybkx
         2E8QtAeAqzOJvv2yh6hgsj5qSs1t65sVXgKF9OyQmFOtpYCcp9bAWUvgsPuqmKJEdZ
         HTd9PuRvxg6QAUMujSakAcHgfUI3YvbihD79TDng=
Received: by mail-qt1-f172.google.com with SMTP id k12so12198159qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:30:35 -0800 (PST)
X-Gm-Message-State: AA+aEWaf6WNk+6shxcqrlCwb8mgII+WtOG7ni2i8Fyf8t0s6pUh8CuYA
        R+eJadXkEHxTDZEY0VcPcxG8E4BZBFaqE37wxw==
X-Google-Smtp-Source: AFSGD/XxNvD00+kUZMDbi/8vU1W/hsWJ+XbTM9JDKWVOyJK23EXcSPOGhBiDyFuXmaicx2dTHQPUMAuWcW3ChVV3f8k=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr12166297qts.144.1544448635158;
 Mon, 10 Dec 2018 05:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20181208070101.6117-1-abrodkin@synopsys.com>
In-Reply-To: <20181208070101.6117-1-abrodkin@synopsys.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Dec 2018 07:30:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+gRtkNe4eeu_jzzMVTO5u=a30SZZFNShxn3o6rjTQYQ@mail.gmail.com>
Message-ID: <CAL_JsqK+gRtkNe4eeu_jzzMVTO5u=a30SZZFNShxn3o6rjTQYQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: Remove 0x prefix from unit-address of node names
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 1:01 AM Alexey Brodkin
<alexey.brodkin@synopsys.com> wrote:
>
> Done automatically with help of:
> ----------------------->8------------------------
> sed -i 's/@0x/@/g' arch/arc/boot/dts/*.dts*
> ----------------------->8------------------------
>
> Inspired by [1] and the like.
>
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/13612017/
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Rob Herring <robh+dt@kernel.org>
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>  arch/arc/boot/dts/abilis_tb10x.dtsi   |  4 ++--
>  arch/arc/boot/dts/axc001.dtsi         |  6 +++---
>  arch/arc/boot/dts/axc003.dtsi         | 14 +++++++-------
>  arch/arc/boot/dts/axc003_idu.dtsi     | 14 +++++++-------
>  arch/arc/boot/dts/axs10x_mb.dtsi      | 22 +++++++++++-----------
>  arch/arc/boot/dts/vdk_axc003.dtsi     |  4 ++--
>  arch/arc/boot/dts/vdk_axc003_idu.dtsi |  4 ++--
>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi  | 14 +++++++-------
>  8 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/arch/arc/boot/dts/abilis_tb10x.dtsi b/arch/arc/boot/dts/abilis_tb10x.dtsi
> index 3121536b25a3..77ac1368a65b 100644
> --- a/arch/arc/boot/dts/abilis_tb10x.dtsi
> +++ b/arch/arc/boot/dts/abilis_tb10x.dtsi
> @@ -178,7 +178,7 @@
>                         clocks = <&ahb_clk>;
>                 };
>
> -               spi0: spi@0xFE010000 {
> +               spi0: spi@FE010000 {

This should be lowercase too.

>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <0>;

[...]

> @@ -119,7 +119,7 @@
>          * This node is intentionally put outside of MB above becase
>          * it maps areas outside of MB's 0xEz-0xFz.
>          */
> -       uio_ev: uio@0xD0000000 {
> +       uio_ev: uio@D0000000 {

lowercase

>                 compatible = "generic-uio";
>                 reg = <0xD0000000 0x2000 0xD1000000 0x2000 0x90000000 0x10000000 0xC0000000 0x10000000>;
>                 reg-names = "ev_gsa", "ev_ctrl", "ev_shared_mem", "ev_code_mem";
> --
> 2.16.2
>
