Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54003C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA820652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547672891;
	bh=M9ENv+WrHUYH9nX+r1c75NNRa1eiEiBPU5CzPf72wNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c80kF4PTwor57DXE04fsbdo/H9WzNr2twqHSNsFjxZS9Z3Jtemprripn1wzbi5nd/
	 biWfg1COTvhnsPVeB9eve6kaFqPZRiLmQ4huirdupfqRodqO2uXwBPwx172A7tkhkl
	 JAqacdq+BEEdR4zXMOysfFCCOHsuO3YIXQchkzy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfAPVIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:08:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43670 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfAPVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:08:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so9071070otr.10;
        Wed, 16 Jan 2019 13:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wMvltuEb67wibfY2D2ojfW+tDYLhRAe2UHf8TZ4RuI0=;
        b=rApDNUSYuVLJ2ZaRNdEtfR6ijf4qUzkHqScqjSP3Dxf0uFqsYEcwZGl+N0X2TG385L
         jQYl64D1G1q+9FZZDfKkqMEgHpTfpySTeV8evUxOoNkYQ7TcLmq52l1w0pjG/ercXx8e
         +0eMrz2bWSQzE5p5Ye/oUfFxNbDJN9z7/8S5uXDzuGQFeNS4yYU2bwRaZcvyz27i011/
         qul/vF56qMjuVf3WPlNsY2Z3cXVmuqBn2BY03dcmHFTXRq0WFBEx/wA1FtuYjCKPIgmk
         PyuflWmhqBC6UOYuLzmf82i9xuf8i1bFiGV0+tXP8z1Iccf1htEQxCn4BZ1papIsCL63
         dDwg==
X-Gm-Message-State: AJcUukcUAYt8XDCD81KO7BmujySrUVLEK4GZByKRAH68YzMtX/tmEbkz
        63YtuVWUhrc///dTvVF80A==
X-Google-Smtp-Source: ALg8bN4DvfD2O/xk0VZPhQ+44SgsduOyCG2/57/0kIBroNOMBg5LPr1zhaVKEnY8G0wB09U7COP86g==
X-Received: by 2002:a05:6830:134a:: with SMTP id r10mr6741543otq.195.1547672887417;
        Wed, 16 Jan 2019 13:08:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm4371074otc.54.2019.01.16.13.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:08:06 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:08:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Message-ID: <20190116210806.GA21535@bogus>
References: <20190111151401.25047-1-jank@cadence.com>
 <20190111151401.25047-2-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111151401.25047-2-jank@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:14:00PM +0000, Jan Kotas wrote:
> This patch adds a DT binding documentation for
> Cadence RTC controller.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  Documentation/devicetree/bindings/rtc/cdns,rtc.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cdns,rtc.txt b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
> new file mode 100644
> index 000000000..40713bbbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
> @@ -0,0 +1,25 @@
> +Cadence Real Time Clock
> +
> +The Cadence RTC controller with date, time and alarm capabilities.
> +The alarm may wake the system from low-power state.
> +
> +Required properties:
> +- compatible: Should be "cdns,rtc-r109v3"
> +- reg: Specifies base physical address and size of the register area.
> +- interrupts: A single interrupt specifier.
> +- clocks: Must contain two entries:
> +	- pclk: APB registers clock
> +	- ref_clk: reference 1Hz of 100Hz clock, depending on IP configuration

1Hz OR 100Hz?

> +	See ../clocks/clock-bindings.txt for details.
> +
> +Example:
> +        rtc0: rtc@fd080000 {
> +        	compatible = "cdns,rtc-r109v3";
> +        	reg = <0xfd080000 0x1000>;
> +
> +        	clock-names = "pclk", "ref_clk";
> +        	clocks = <&sysclock>, <&refclock>;
> +
> +        	interrupt-parent = <&gic>;
> +        	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> -- 
> 2.15.0
> 
