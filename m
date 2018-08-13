Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F956C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A4217BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3A4217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeHMW2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:28:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54992 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbeHMW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:28:34 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so14825496itb.4;
        Mon, 13 Aug 2018 12:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jn5RmfJ5S4XuNoGrDOWJ3QWkkWiWylYb+Xc4YgDD65M=;
        b=uoCKrccxst55lawCV2FoYtOxR3u4MrnqtjdckUMPj3MLixIve/uRrpSx2HIt/igozx
         q1dOM5tjgwbQQ6MCxav9Qjq7Kgfs2XVH+MoMJb3PepH/h1cRlfBWGhx0xQ2+bKzo29kp
         aZyfXu27NtnOMYx3zabMREAzsnK0AyZ48JZTALhwR+4KWM22AxQsXt2gDDQM5NO8+Clh
         rMdGZuhJQkwATvUsCVKZfrmmGnEMt/z4DEWV90dpoaPPZ3JdRqMfOXOJtzudqdSLijbB
         ciWNPjvFmoMD0EUL9obnVEALOEuFd7Dw4TW51QiW5yd+0C+cDcss8E9fjI/KLR56u8Nu
         plLA==
X-Gm-Message-State: AOUpUlEX5aDqPkCc5YgsQg5zwOBQmeqDvZh9RecUlSyQZrAOcPxySr3v
        BhBijDccKU0xH/Jn6cBYdA==
X-Google-Smtp-Source: AA+uWPwpLKO2KYw/LF8Bqh6lLiHblE+b5yFao1VdGRGGGtcLdt2BWPTU57cGgIKqB9/x2oG6k1QOTA==
X-Received: by 2002:a24:9588:: with SMTP id m130-v6mr12847729itd.48.1534189494670;
        Mon, 13 Aug 2018 12:44:54 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id d197-v6sm5955392itd.22.2018.08.13.12.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:44:54 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:44:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, manivannan.sadhasivam@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20180813194453.GA30702@rob-hp-laptop>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812122215.1079590-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
> Actions Semi OWL family SoC's provides support for external interrupt
> controller to be connected and controlled using SIRQ pins. S500, S700
> and S900 provides 3 SIRQ lines and works independently for 3 external
> interrupt controllers.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> new file mode 100644
> index 000000000000..4b8437751331
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> @@ -0,0 +1,46 @@
> +Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> +in which external interrupt controller can be connected. 3 SPI's
> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> +the following properties:
> +
> +- inputs three interrupt signal from external interrupt controller
> +
> +Required properties:
> +
> +- compatible: should be "actions,owl-sirq"
> +- reg: physical base address of the controller and length of memory mapped.
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 2.

> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
> +  details are maintained at same offset/register.
> +- actions,sirq-offset: register offset for SIRQ interrupts. When registers are
> +  shared, all the three offsets will be same (S500 and S700).

You should have more specific compatible strings if there are 
differences and these settings can be implied by them.

> +- actions,sirq-clk-sel: external interrupt controller can be either
> +  connected to 32Khz or 24Mhz external/internal clock. This needs
> +  to be configured for per SIRQ line. Failing defaults to 32Khz clock.

What are the valid values?

> +
> +Example for S900:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0 0xe01b0000 0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	actions,sirq-clk-sel = <0 0 0>;

If 0 is 32khz, then having this is pointless. But I can't tell what the 
values correspond to.

> +	actions,sirq-offset = <0x200 0x528 0x52c>;
> +};
> +
> +Example for S500 and S700:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0 0xe01b0000 0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-clk-sel = <0 0 0>;
> +	actions,sirq-offset = <0x200 0x200 0x200>;
> +};
> -- 
> 2.14.4
> 
