Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D95C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB621872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547222962;
	bh=JDbPG5rUZs0YPEbosQ6A2vtssGafLF0tH/U1YNSI0z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nJkU1lzvFSKUo1PvQeGZsOdQvvXfvrKaMjShdDFTw03ejRpsLs9kRrdV1kfWoUlG8
	 ufo1rlZdqbQaRgOYzTc52n0d8XwEsBzG4F0pQ96NDtc+iVgsKbVeE8a+oyOEbewdvr
	 K0n25w30GdYFo1nW098ENxXMpgVvAe7bgPMG8beU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfAKQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:09:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36755 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfAKQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:09:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so12605948oix.3;
        Fri, 11 Jan 2019 08:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+4rePCn2D2muFtmby3dx4B8iAj2ZTfNNUldaFzxF8U=;
        b=CzJazzjrdRc0ud0BgLjHRNZJb/WU00DFEZGpjXXarwBpgOnUdj7a45AcfhQeTFOS8/
         3ewY0XsGdfZnOJVVdWCdBRDqokKm5TdQEUFmD4IVf7ajZbxL2hMThyZjemPGJYmZk3LO
         M1NDpIwpN/8uSq50IjszT5j4gsGW8bwP0HwANVVPyArmSVG+nt+/7/elTQL6E47ngM3d
         bKQDnMYCh7KnzgrN4LFBdQ3LotU+QFOhTy0hHnlz2Jh4XMKuVXkiYtr/AdCcIo+pv8yw
         0YanctEo2Tuy9m6aMW03wwy/T5FPCC/NN7f2OIA/KJZ+0o96bxuNcDKVQAtKjPikgXM8
         hBkA==
X-Gm-Message-State: AJcUuke33GVBlChZu5HJ+nDg66JvWqa85h943DtrZ6wMqA5oYrN2gcoO
        p7vo7Amv8l47OzIwbKz6Gg==
X-Google-Smtp-Source: ALg8bN48OhaEJVJKRoVwfabmjGSOvtviWRDaI1vMYq7S4o6y7YNztWl1lTEPkpdeaDYqsQkxYkQf3A==
X-Received: by 2002:aca:ea57:: with SMTP id i84mr9603880oih.346.1547222959652;
        Fri, 11 Jan 2019 08:09:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g19sm34112953otl.26.2019.01.11.08.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 08:09:19 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:09:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver
 bindings
Message-ID: <20190111160918.GA20480@bogus>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 10:09:52PM +0800, Henry Chen wrote:
> Document the binding for enabling DVFSRC on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
>  include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
>  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> new file mode 100644
> index 0000000..402c885
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> @@ -0,0 +1,26 @@
> +MediaTek DVFSRC Driver

Bindings are for h/w blocks, not drivers.

> +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> +HW module which is used to collect all the requests from both software and
> +hardware and turn into the decision of minimum operating voltage and minimum
> +DRAM frequency to fulfill those requests.

Seems like the OPP table should be a child of this instead of where you 
currently have it?

> +
> +Required Properties:
> +- compatible: Should be one of the following
> +	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
> +- reg: Address range of the DVFSRC unit
> +- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
> +	different dram type support.

This information should come from the DDR controller or memory nodes 
probably. And we already have some properties related to DDR type.

> +- clock-names: Must include the following entries:
> +	"dvfsrc": DVFSRC module clock
> +- clocks: Must contain an entry for each entry in clock-names.
> +
> +Example:
> +
> +	dvfsrc_top@10012000 {

Drop the '_top'. (Don't use '_' in node and property names).

> +		compatible = "mediatek,mt8183-dvfsrc";
> +		reg = <0 0x10012000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> +		clock-names = "dvfsrc";
> +		dram_type = <MT8183_DVFSRC_OPP_LP4>;
> +	};
> diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> new file mode 100644
> index 0000000..60b3497
> --- /dev/null
> +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +
> +#define MT8183_DVFSRC_OPP_LP4	0
> +#define MT8183_DVFSRC_OPP_LP4X	1
> +#define MT8183_DVFSRC_OPP_LP3	2
> +
> +#define MT8183_DVFSRC_LEVEL_1	1
> +#define MT8183_DVFSRC_LEVEL_2	2
> +#define MT8183_DVFSRC_LEVEL_3	3
> +#define MT8183_DVFSRC_LEVEL_4	4
> +
> +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> -- 
> 1.9.1
> 
