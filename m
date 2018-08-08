Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE61C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E90214FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knc+7JY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E90214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHHRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbeHHRDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:03:12 -0400
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A609219F5;
        Wed,  8 Aug 2018 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533739394;
        bh=WyTPmcLf26uVa54updGaaJ/g97kqbywaz6/9IZnrHDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Knc+7JY+lwU/eKFLkGM/BqweuGo6Nl61zRQEtfnOQLvrmSLhlVkZYAbSMAZKvmto/
         nhJElWu7YiuXWDS1dwwae7c/TevYsnElqt8rz2PD/Bi/SWHNemDjISLcLDVJ7U34T2
         YSZPWJ5RHwfJ45lCE9hv/ksyp7MWBoi9UBMeC/cY=
Received: by mail-qk0-f182.google.com with SMTP id c126-v6so1662130qkd.7;
        Wed, 08 Aug 2018 07:43:14 -0700 (PDT)
X-Gm-Message-State: AOUpUlH/yC+/td8qgrctkSjTkzeH1uq4zIM/BsiHDmsT8MzA0Tej+C9F
        ROIujxTLcef0S9OKBAsNcxe/KbegToV3EcdORA==
X-Google-Smtp-Source: AA+uWPwQh1/LKxtw7wT32cBwdR08CqQyxCAljsHyY9Yd5o0hZ3GFAHP3neLoHhgnAUAb3B4IWgnmTEapW6wMXjBYzUo=
X-Received: by 2002:a37:a0c8:: with SMTP id j191-v6mr2621286qke.375.1533739393265;
 Wed, 08 Aug 2018 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-3-hch@lst.de>
In-Reply-To: <20180802115008.4031-3-hch@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 08:43:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZXo7JKszrvAwCzAgysKrwdwb1oZX9K8+FxO4ZitNh_A@mail.gmail.com>
Message-ID: <CAL_JsqKZXo7JKszrvAwCzAgysKrwdwb1oZX9K8+FxO4ZitNh_A@mail.gmail.com>
Subject: Re: [PATCH 02/11] dt-bindings: Add an enable method to RISC-V
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 5:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Palmer Dabbelt <palmer@sifive.com>
>
> RISC-V doesn't currently specify a mechanism for enabling or disabling
> CPUs.  Instead, we assume that all CPUs are enabled on boot, and if
> someone wants to save power we instead put a CPU to sleep via a WFI
> loop.  Future systems may have an explicit mechanism for putting a CPU
> to sleep, so we're standardizing the device tree entry for when that
> happens.
>
> We're not defining a spin-table based interface to the firmware, as the
> plan is to handle this entirely within the kernel instead.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
> index b0b038d6c406..6aa9cd075a5b 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
> @@ -82,6 +82,15 @@ described below.
>                  Value type: <string>
>                  Definition: Contains the RISC-V ISA string of this hart.  These
>                              ISA strings are defined by the RISC-V ISA manual.
> +        - cpu-enable-method:

Something wrong with "enable-method" as defined in the DT spec[1]?

> +                Usage: optional
> +                Value type: <stringlist>
> +                Definition: When absent, default is either "always-disabled"
> +                            "always-enabled", depending on the current state
> +                            of the CPU.
> +                            Must be one of:
> +                                * "always-disabled": This CPU cannot be enabled.
> +                                * "always-enabled": This CPU cannot be disabled.

To follow the spec, 'enable-method' should simply not be present in
the always-enabled case. I think the always disabled case should be
handled with:

status = "disabled";
enable-method = "none";

With "none" needing to be added to the spec.

[1] https://github.com/devicetree-org/devicetree-specification/blob/master/source/devicenodes.rst#general-properties-of-cpuscpu-nodes
