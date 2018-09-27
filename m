Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE79216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE79216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeI0XJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:09:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38171 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0XJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:09:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id h15-v6so3239624otj.5;
        Thu, 27 Sep 2018 09:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JhdMYkak22rjNvI7ad9QfKyCJ9N02xgNk3y6DiXF3Y=;
        b=SWaaDYWgtTRUHPGp84HJF30kHXUto07zEwMCdbe0NuvOFuQ1L1QjCzGbTsjP6cUY0k
         vJ1v/IkpT3WvXcDZqsotvdFBN8LcgZu5dfZz9bKydLHTCqU+cF0+aTg7W/CVYQbUhUVz
         hmsrWEB5mDi83sCYRMw5e5vs416UUSqZmP37IyVt6j8yIwtXX6FqNQkyu8WxYTauJp7j
         GuKbv5+OoPYfMZzIXZdcW4RGXRMsQA04CBRa5mAskQfRm1AuyWKr+rYvyVObSm4nZc4i
         lbT8jQ1X9mrGb5ezVnVoR29vH8ICwqf/NADZlSXWBUukr8nQ6mYoo0aUQ8h23emBeeRe
         Vu+A==
X-Gm-Message-State: ABuFfoiTOO2/G38z1S7CO+43Rx/dyBDC6WLr6dxoXmQrCvyXisL8KocV
        qvttGLZC5hK8TCueVHm7UQ==
X-Google-Smtp-Source: ACcGV6342N6xmddYHeI4g2qHqr2CxqxTyP30ofvxjiBe0KV0hGcXwPZ0ldStmA+G2Pv8eFO6DURAvQ==
X-Received: by 2002:a9d:2be8:: with SMTP id u95-v6mr7369360ota.280.1538067045914;
        Thu, 27 Sep 2018 09:50:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q15-v6sm761425otl.43.2018.09.27.09.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:50:45 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:50:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 23/30] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Message-ID: <20180927165044.GA30320@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:39:26AM +0800, Guo Ren wrote:
>  - Dt-bindings doc about C-SKY Multi-processors interrupt controller.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> new file mode 100644
> index 0000000..9cdad74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -0,0 +1,40 @@
> +===========================================
> +C-SKY Multi-processors Interrupt Controller
> +===========================================
> +
> +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> +SMP soc, and it also could be used in non-SMP system.
> +
> +Interrupt number definition:
> +
> +  0-15  : software irq, and we use 15 as our IPI_IRQ.
> + 16-31  : private  irq, and we use 16 as the co-processor timer.
> + 31-1024: common irq for soc ip.
> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +	Description: Describes SMP interrupt controller
> +
> +	PROPERTIES
> +
> +	- compatible
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "csky,mpintc"

Only 1 version?

This is fine for a fallback, but you should have an SoC specific 
compatible too in case there are any SoC specific errata/quirks.

> +	- interrupt-cells

Should be: #interrupt-cells

> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be <1>
> +	- interrupt-controller:
> +		Usage: required
> +
> +Examples:
> +---------
> +
> +	intc: interrupt-controller {
> +		compatible = "csky,mpintc";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +	};
> -- 
> 2.7.4
> 
