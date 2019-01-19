Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F794C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94002084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMsQHhNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfASWaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:30:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36538 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfASWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:30:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so11828469oix.3;
        Sat, 19 Jan 2019 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXdfjLbvWADu2xnhaWD9Ipp8Sac4nR48CwxbLVF68A8=;
        b=uMsQHhNjCBfO+fDgedRKm7N4ZZs5a0mJiirbPfqtCociZZZ3LVD4qWRolyymnog9oR
         YIdH73OFahCgEdbCaDS8ddIKFDrOCnXlGcnaj+HDB5ceJwBxUll/IRcw14GSb4ZZEJSs
         w9GCPadvUE3dUQTmrMQ+fbZrkIzClpH+tRKh/KYWLjO0V50zh/Sutji2xyXrkCEtML9f
         QqtlFu0fZlMlJ1EUlaIvJdp4BUasZwRtj5IprEhEthGlY6P30c2ujvXSIqJHM5/ECGro
         bzEVG2RMcTlzXySgeOjomBNA7AgHQzDOwpM82ng6NvvyBdMAMuu7wqUJx1cYChiClGUf
         NVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXdfjLbvWADu2xnhaWD9Ipp8Sac4nR48CwxbLVF68A8=;
        b=AeEFVd8XtkXpXSnytl6TU4dsSCwL6nXWRGFc3ao09KvoCBCdGnUZQBr5MeNz8w4mnB
         PH4g5o5KxSgIr8zwH/OK+U9JQAOp4Ae8YoqHj7gFdd12jU7tj9onI+lB1tJotWLb66Xm
         Dz4BOH8yqCKLEHaEirT0YczrAkQ3msK549SK4QEUBOks6B/HvsN/buBdvOqQbXxH7tRu
         5zBIQsQdyed2mWbyMYcdJk8Oi+pduxdZOPu0UUivZgZdBrMWgCTPAoE3SwA5Wa5MRMPC
         iS+vDcxJGDVN+0fAKwu/0WcyOvcY5bqjvghZMDacFOBW3Rl3pu7NwjV21vRXlJq9/aLM
         83TQ==
X-Gm-Message-State: AJcUukdUnelCZ5UQ9r/uXeAa8OHBs0IRqbaadp1jrHvhDWqZl/JGt4J/
        7l0lWhiWf+IpDRik/145cDH+4GO/6k4py3FVN5E=
X-Google-Smtp-Source: ALg8bN4vYceMuZXNjubl7hFSWQyHQXOvgR7DZws4qXRBnzYLSdwbLsyAGKgN5/xnBZ1c0LPf3IX6s3g/eMu6E+Kvuj0=
X-Received: by 2002:a05:6808:296:: with SMTP id z22mr1938356oic.67.1547937050854;
 Sat, 19 Jan 2019 14:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20190119211815.25101-1-slongerbeam@gmail.com> <20190119211815.25101-3-slongerbeam@gmail.com>
In-Reply-To: <20190119211815.25101-3-slongerbeam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 19 Jan 2019 20:30:42 -0200
Message-ID: <CAOMZO5AMgKra8ZxUyBkvDDR68gWZ+YiOhO-yHS-+adMWGgnEsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx53-smd: Add OV5642 video capture support
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, Jan 19, 2019 at 7:19 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Add video capture support from the OV5642 to IPU CSI0 on
> the i.MX53 SMD.
>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Only one minor nit below that perhaps Shawn could adjust while applying:

     pmic: dialog@48 {
>                 compatible = "dlg,da9053", "dlg,da9052";
>                 reg = <0x48>;
> +               interrupt-parent = <&gpio7>;
> +               interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
> +
> +               regulators {
> +                       ldo7_reg: ldo7 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3600000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       ldo9_reg: ldo9 {
> +                               regulator-min-microvolt = <1250000>;
> +                               regulator-max-microvolt = <3650000>;
> +                               regulator-always-on;

regulator-always-on could be removed from the two regulators above
since they are used by the camera.
