Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B28C2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548082746;
	bh=t0OsnDWd7cr+f9sahwAKvtT5SLU5mQ0DUQmCWdZTc64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o01RV6+YIl62BOnuQZtwVXUKzmGD0puMrGzSCasFC1Cj9iy8L8hRb9qty5CY5LqLU
	 DMoC0bjtUFc3uNJFjeee19yGsy/zofXpD1aF4yFAadd7mHQGXvUCwGoTCAt/TsCKZW
	 19TbEi0nLO4wEVOE4N3kKYqtDl28pqv5RBt4YMU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfAUO7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:59:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43059 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAUO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:59:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so14716910oie.10;
        Mon, 21 Jan 2019 06:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/9Uug1Ejuv4f8YRQX5ceM4h66n/a0h50B849R+4uA8=;
        b=IpXCWDJz7e4WIubWJ1I0H+LL8c4IHWVnkmbs2LfbS9rvgp3u9uibhv+snqBZlybBQ+
         s9xclapgYBbOHiMot8NJiLPesi7OSxZLSkaDJan0087ryAHntOoI3KOQroh64LZOqXCJ
         Xcxjr4EseoKwcpAy2JQvHG4ToVOFF18KIFaNdy92n9JInyzkrixrtQvDQQ/ZuoGabTKH
         5qz6jSE1ZHw3Ap/hi2C/1I7ElC9zmddkx7bBtq+1j7XGKu522gohzw1Hav5bDIBrbm5M
         VldJBhijrR3bk23qNnmJtSskAEmvRIeVt4qbmBsADfRSoYviZA0vcGXD8kMTJke+qZxV
         3qnQ==
X-Gm-Message-State: AJcUukdyLIiXHpKNQJJpnyS/gfaiToXYC+VBkPrpR5J0QfFecSIZYBGn
        SMUvT4V7TfKTVhh0vKkUjA==
X-Google-Smtp-Source: ALg8bN401f+OXx2xpMJU9jIWKbBAfydSwLBnDZh+3Vs/dVKpKl0Nw/Cq6Dt6z72aRCOajW93SemtZA==
X-Received: by 2002:aca:3403:: with SMTP id b3mr5647994oia.242.1548082743063;
        Mon, 21 Jan 2019 06:59:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u136sm6309367oie.38.2019.01.21.06.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 06:59:02 -0800 (PST)
Date:   Mon, 21 Jan 2019 08:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v4 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190121145901.GA7547@bogus>
References: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
 <1548066043-1252-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548066043-1252-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:50:42PM +0530, Yash Shah wrote:
> DT documentation for PWM controller added.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..b207908
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,37 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> +supports one period for all channels in the PWM. This is set globally in DTS.
> +The period also has significant restrictions on the values it can achieve,
> +which the driver rounds to the nearest achievable frequency.
> +
> +Required properties:
> +- compatible: Should be "sifive,pwmX" and "sifive,$socname-pwm".

The order here is wrong.

You still need to enumeration valid version numbers. Is 'sifive,pwm20' 
valid?

> +  Please refer to sifive-blocks-ip-versioning.txt for details.
> +- reg: physical base address and length of the controller's registers
> +- clocks: Should contain a clock identifier for the PWM's parent clock.
> +- #pwm-cells: Should be 2.
> +  Refer to bindings/pwm/pwm.txt for details.
> +- sifive,period-ns: the driver will get as close to this period as it can
> +- interrupts: one interrupt per PWM channel

How many channels? If variable, is the a max number?

> +
> +PWM RTL that corresponds to the IP block version numbers can be found
> +here:
> +
> +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm

Put this in the description at the top.

> +
> +Further information on the format of the IP
> +block-specific version numbers can be found in
> +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

You already said this.

> +
> +Examples:
> +
> +pwm:  pwm@10020000 {
> +	compatible = "sifive,fu540-c000-pwm","sifive,pwm0";

Space after the ',' needed.

> +	reg = <0x0 0x10020000 0x0 0x1000>;
> +	clocks = <&tlclk>;
> +	interrupt-parent = <&plic>;
> +	interrupts = <42 43 44 45>;
> +	#pwm-cells = <2>;
> +	sifive,period-ns = <1000000>;
> +};
> -- 
> 1.9.1
> 
