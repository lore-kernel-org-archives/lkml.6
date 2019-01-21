Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B32C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AE420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079865;
	bh=hPpVfqH0qZ0DTzqya9uokBuCPdUN+wczNsjyavORQk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+3LrwxZP3oP+PnDdmZ9y8SJCsDzlEmGFsbSwa5JPZZxHSxjiiAnB8aOzBj45JQ6p
	 s5AM4E62XSjM/83gD1/Kyju5td/q7yuHUPIcYaE9XEIGxMyNV0EDYnd/HMXzRGRxWx
	 sFV16InzGmvJS1XZVFxNuCdTqENJ8Tw5HmLBv1Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfAUOKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:10:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbfAUOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:10:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so17681857ljd.0;
        Mon, 21 Jan 2019 06:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jpIsQBQw8LJ2Rg1bqKD/AdjTLRe3AL1lYfFNor0shs=;
        b=XBIo5C2vKvF+ZdydWisb69IbQ7e83WL60oax87Mdif7++Yc1gcrrLNeF9l78AakdJG
         BTB7aLUUterwSloD+3lF5AzsnecYmCYaYdME9l726qSGVrMbhcI4MoE/NZWS9f0BoT+l
         3kUNUGqlKk7u5lgnvQa95KIu4sHfbm2+WfdGrEdb9KxCHqG9LMBvxghufyASGgAr50Kx
         slj14bMwjVmyi9ouSsHxo78Y76Zt0fUQI2pYJM0owfmpw61ckmohogwfLgTuvzJYECkS
         khsCoIs2knnXED+0IUMwZpie38CyaMbR47amwqpMa29V0L2N+QVHJQyX5ohRWX4iBlfu
         AKLg==
X-Gm-Message-State: AJcUukfbEISzjMPuN8aQPm1XQlR7BLJu/Dw/xt+T1koRkqkCvpfLH2cc
        M+WL3jI/+Go8qMruAqmvujU=
X-Google-Smtp-Source: ALg8bN70hGTRSnrzSBC1jLEvfQyE7Sm582UUirijl92Kc4H35LLCPrw9baZaJXEHY8+7pcPiG83/qA==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr17974492ljj.9.1548079845547;
        Mon, 21 Jan 2019 06:10:45 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q10-v6sm2295968ljj.3.2019.01.21.06.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 06:10:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glaHg-0001iu-TD; Mon, 21 Jan 2019 15:10:40 +0100
Date:   Mon, 21 Jan 2019 15:10:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] riscv: dts: add initial support for the SiFive
 FU540-C000 SoC
Message-ID: <20190121141040.GM3691@localhost>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
 <20181215052154.24347-6-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-6-paul.walmsley@sifive.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:21:52PM -0800, Paul Walmsley wrote:
> Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
> based around the SiFive U54-MC core complex and a TileLink
> interconnect.
> 
> This file is expected to grow considerably as more device drivers are
> added to the kernel.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> 
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> new file mode 100644
> index 000000000000..0ef314cf17b6
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <1000000>;
> +		cpu0: cpu@0 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,e51", "sifive,rocket0";

Looks like you forgot the currently required "riscv" compatible here and
below.

But perhaps it's the binding and arch code that should be revised
instead (e.g. as per your discussion with Rob elsewhere in this thread).

Johan
