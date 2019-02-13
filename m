Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA07C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01B121872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090275;
	bh=qonGC8hvWUu24vFn3aQnEukSadxoMv4in4X/P6RqgNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k3ZvjRLx+XxlgjBcTiZx0UwgzL7xP3l4FmRlB7YZTaktOz6DAL7EhOiRQhU96zlAJ
	 4gCZwiIgDTruaKgJCpaGYCj7RNdHE9YummI5pg8pqLVGu9RkBSjUXiKSJ1shyCpqbS
	 QVDce9cvwiYyg5lst8rApGpx0atJS4lMRi2AkUjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfBMUhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:37:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40960 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfBMUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:37:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so6625743otk.8;
        Wed, 13 Feb 2019 12:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3voqcrjL3lddC/ozmniVT3xEKHp7odJOLdH6cCVc9Zg=;
        b=l47pdV6tdRP6Xf0lVjuRdNCxKtVx63CwQGd/F7HAXu3rNWBkQthwaBO6FYAcy5S6ZJ
         pPTR/vbVuuhmT9fB6G6KZdhY8tWiEZW+Bi9gEkimrGEpJGAr7x8fRJCsua48Hwv0GlxY
         VK50tsqGy+D473Wb9y62KM9YJVEgFuXuNDoUEPbeXwzJ9QMWWCscPOZQRN9ryLj9N1md
         RDFCxeuN7He3XHnhKkieiyTg2Uki1lDlsiD9xkZwcxi2IGcaPh0WoEuTvwQQ7RkiFZpf
         w5iG6n50mVlp7QrVyhON3kBVvnrOlJkKYYNmTh0m71L1IXeeUXf1XJqcLtbK45QSCawd
         +2Tw==
X-Gm-Message-State: AHQUAubO4cLIROQM+bTDPHrp4YTjzD7IwW3TEio/t+/hkf+uCuXmrJtF
        1HnTdTfwqFt9MyrUjvvwfX2jPPU=
X-Google-Smtp-Source: AHgI3IbjNfHeTqSx3HupP3ww1rN82H76GaY3sbAyX1kKWLiOrdJcRlW9FD+RN4RDGZUt+dvIqM+puA==
X-Received: by 2002:aca:e5c9:: with SMTP id c192mr30475oih.118.1550090272993;
        Wed, 13 Feb 2019 12:37:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r203sm136372oih.11.2019.02.13.12.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:37:52 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:37:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v6 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190213203752.GA18326@bogus>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550049978-20705-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:56:17PM +0530, Yash Shah wrote:
> DT documentation for PWM controller added.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..3b9c64c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,30 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> +supports one period for all channels in the PWM. All PWMs need to run at
> +the same period. The period also has significant restrictions on the values
> +it can achieve, which the driver rounds to the nearest achievable period.
> +PWM RTL that corresponds to the IP block version numbers can be found
> +here:
> +
> +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> +
> +Required properties:
> +- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
> +  Please refer to sifive-blocks-ip-versioning.txt for details.

Please specify what soc and IP version are used. Is sifive,pwm10 valid?

> +- reg: physical base address and length of the controller's registers
> +- clocks: Should contain a clock identifier for the PWM's parent clock.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory
> +  for a description of the cell format.
> +- interrupts: one interrupt per PWM channel
> +
> +Examples:
> +
> +pwm:  pwm@10020000 {
> +	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> +	reg = <0x0 0x10020000 0x0 0x1000>;
> +	clocks = <&tlclk>;
> +	interrupt-parent = <&plic>;
> +	interrupts = <42 43 44 45>;
> +	#pwm-cells = <3>;
> +};
> -- 
> 1.9.1
> 
