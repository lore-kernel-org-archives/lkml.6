Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6F22083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551111430;
	bh=JM6O9z/744pGi2Hrx2xf0uVVaIzAUpnynvfyO0A8QJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ftBhm+qfxyXh7wlpeAe+3p6XwGf1TRBeWutgsVnt144evN53X7i/uWHsU9QYvtAWI
	 tlIUZA1xzRmeYGXzm6KDAYQ7E4Hmv7Ddf9xR1L9K1MkNi5XZony/wAcZTXiJy2ali0
	 0zl0hoZEZIXDHK9wY71U/dsJZUG236o3ApahOrDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfBYQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:17:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36232 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:17:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id v62so8313949otb.3;
        Mon, 25 Feb 2019 08:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZgl08wVheNXRHxr4vLfl6VsoO9LletEevKcY+JRreA=;
        b=b3ibUCDy1sSpM7VCT83t6pPFi7I2/dtj+pWgZvq5HMG9dbnSpkd0INsUEYBk4QgE7Q
         aJTjlksZ2ylCaIpArtdV5UtSzV2Q3f27Ud6WW+2EfBUFxw+QCkv91Fx2in/ZQChvFIXE
         IRXz1LLKBjOq+KxpsFKzjUcVCakxD10pZJHDTdux4YtdI8ya5+Yi++R0cJW7MGxy5829
         vJOHgcA4H0WyIcbLR6hJSdogf3QCEFI69aDPL8ThE7U59tM69qgRHBrT8Bz1DCzBrBwZ
         aNlodkRDiGCHRN60BhO+k4w61gJFaCGFxwqVDg36rQV7xigoMxF178GJF52TNf26Yd2J
         u0Mg==
X-Gm-Message-State: AHQUAubuhliKn/nqnPqJ+CUe5906pRmDXNJ4Ni8rM855IimVdHwE3bRa
        LuXP1gjMIisxE3R/Iv/kVA==
X-Google-Smtp-Source: AHgI3IaZMGZweVREEbNqjRE1K814Cp47hVR+4dXlSUcinYNyKJ3SryMRXkFxl4nBhksWOel8ksmDQw==
X-Received: by 2002:a9d:5c16:: with SMTP id o22mr11762673otk.235.1551111427383;
        Mon, 25 Feb 2019 08:17:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h205sm4252608oib.11.2019.02.25.08.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:17:06 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul.burton@mips.com,
        ralf@linux-mips.org, jhogan@kernel.org, ezequiel@collabora.co.uk,
        paul@crapouillou.net, mark.rutland@arm.com, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com, ulf.hansson@linaro.org,
        malat@debian.org
Subject: Re: [PATCH 1/2] dt-bindings: MIPS: Add doc about Ingenic CPU node.
Message-ID: <20190225161705.GA29894@bogus>
References: <1548854044-56483-1-git-send-email-zhouyanjie@zoho.com>
 <1548854044-56483-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548854044-56483-2-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:14:03PM +0800, Zhou Yanjie wrote:
> Dt-bindings doc about CPU node of Ingenic XBurst based SOCs.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  .../devicetree/bindings/mips/ingenic/ingenic,cpu.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt
> new file mode 100644
> index 0000000..38e3cd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.txt
> @@ -0,0 +1,17 @@
> +Ingenic Soc CPU
> +
> +Required properties:
> +- device_type: Must be "cpu".
> +- compatible: One of:
> +  - "ingenic,xburst".

Only 1 version?

Is everything else discoverable or implied by this? Cache sizes, 
instruction set features, bugs, etc.?

> +- reg: The number of the CPU.

Ideally, this should be based on some h/w id, but generally only SMP 
processors have that.

BTW, is SMP supported? If so, you need to define how secondary cores get 
booted (unless that is standard and implied).

> +- next-level-cache: If there is a next level cache, point to it.
> +
> +Example:
> +cpu0: cpu@0 {
> +	device_type = "cpu";
> +	compatible = "ingenic,xburst";
> +	reg = <0>;
> +	next-level-cache = <&l2c>;
> +};
> +
> -- 
> 2.7.4
> 
> 
