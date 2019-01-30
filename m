Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74778C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4688820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548866501;
	bh=INKXaGtg/+0fOqPEPqdDp5qyFRb7znKg7z8o00GHa4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tnVUsfgMdiUhEuuDkP4iM5GCuFGZTeOryQ72nCJB4Uu/6G76C0f1A49OHr6ePN5Qh
	 XMnlP7zeyZT5r+ZrKuU6zwSmIH5LP7/Hl8O8zantg0FUTalHIwsBiasKE2F3hK1utx
	 gaeQmkZOdcdnE5DvkoNMmvCjlDRWoa/GsRfahljk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfA3Qlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:41:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41532 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbfA3Qlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:41:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so136279oii.8;
        Wed, 30 Jan 2019 08:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GqYVig0xsnSrfSCre6GYt4V6DdROEuY5kK2wQy2U+us=;
        b=qxAByISx889rYPikClM4LDUjKpqVIRlss4WPg+Onmj4oS5NwnejOIFguf1q0FcLoMr
         mC6pHZ4iILmY8qdGh0VPylYpyfj29yxWNzRP447uX+d3IYlyInYZPuUk3MkxudInpRY0
         9MFhqnAmarku22/fBCi16UQO1x3nPS7Uo08Sy/3g5AHn8Iuf7UNXPk0yZT/0NMqPD3I6
         QgrqGUiR0XEQunhH+feExvg+ZEIJYQ3LfWaRaTwdLS40DVq2OIgwj0k7YMbOsd00mSVT
         TockTXWaDrbqVXzxXB9XsqpBxesqAmwdocjl6kVbjBqODANkVDeSch+HF4IaALyKnf8t
         djZw==
X-Gm-Message-State: AJcUukcEy5ZJIhcOkLFuQ7a6lSNjChBp59VSh1Y0Y/finKgda3YIjUV+
        o8gbco0LBtlFwRnkhsphuA==
X-Google-Smtp-Source: ALg8bN6T16gYELyQMb/m7eszNaoFBmul6xe8bU7k1nOEppKc44gbKcMHB0LvQaxno/dBGGmrWt/G3g==
X-Received: by 2002:a54:4d01:: with SMTP id v1mr12297052oix.246.1548866498305;
        Wed, 30 Jan 2019 08:41:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm708691otj.9.2019.01.30.08.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:41:37 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:41:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: interrupt-controller: loongson ls1x
 intc
Message-ID: <20190130164136.GB31687@bogus>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190124032730.18237-1-jiaxun.yang@flygoat.com>
 <20190124032730.18237-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124032730.18237-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:27:30AM +0800, Jiaxun Yang wrote:
> Dt-bindings doc about Loongson-1 interrupt controller
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../loongson,ls1x-intc.txt                    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> new file mode 100644
> index 000000000000..a4e17c3f5f93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> @@ -0,0 +1,24 @@
> +Loongson ls1x Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "loongson,ls1x-intc". Valid strings are:
> +
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupts : Specifies the CPU interrupts the controller is connected to.
> +
> +Example:
> +
> +intc: interrupt-controller@1fd01040 {
> +	compatible = "loongson,ls1x-intc";
> +	reg = <0x1fd01040 0x78>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	interrupt-parent = <&cpu_intc>;
> +	interrupts = <2>, <3>, <4>, <5>, <6>;
> +};
> \ No newline at end of file

Please fix.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
