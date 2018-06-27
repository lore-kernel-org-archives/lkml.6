Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33902C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D973F23E8C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/3YU5lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D973F23E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeF0IUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:20:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36719 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeF0IUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:20:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so1065612wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0nHy5GSrQVjXvbp71mSoDsTuKx3cU45EiEA+00GwFvA=;
        b=U/3YU5lqdjhV5Qb6YuJ6evZpBOSvfP0wxezPjP41SpWEzGDLTuY3KbpATxZClv8d14
         40B2WU+DcBKA1zqSkuQegO6gxBbacZ984JX6MbUkk8XDOPSu9ZY/7hD+wwir8yPmO7Fv
         hXUJT1N/J1eOj0cnkNaX257VPJXN3wRxu706A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0nHy5GSrQVjXvbp71mSoDsTuKx3cU45EiEA+00GwFvA=;
        b=VCMR0kcI+XFda0uyzXi/iM2DJZYkjr61Kv/lPJCmPJURNUdPtEIvMyuFMtUook0zm9
         zIMud4fmBvjaj35wqPLZkwtE3yEwyUcAwyPNLlQhR3QaZKY/AVntiyqG0EdNACcJP9TF
         7bu+eF1G76LTJIHP4Ftll7BDRnepa5EMwI4LLqfEM3vkKA19NRgDqSEgwoik+irbFG4l
         ykOGCFs/HcFcCdtMrZeyTp1XzpTx3cf/xyQPx64/qcY+OONlRK33VbRLW/J1pWhZ7LG0
         Rof4FVb64Tmn6xUUiBD7CVpluWvHYQW9IHzKBtehpNJi3Y5MskiXDQn4OQSAywaGAL30
         Y4tA==
X-Gm-Message-State: APt69E0npNdeLEQav1A3Q18Tcu0/JXGfi4tzfRBt+G41rR5KUa1BUT2p
        H9r2zVB9VIu4VWmku0WYNXZ6AQ==
X-Google-Smtp-Source: AAOMgpdrLqvVFH+1FN+0f916mluFT/mbw5eC/DUZL4xGLHRjo8vdspQlJ6KAmm8GD0MwVR1DTThP8g==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr225788wrc.164.1530087636128;
        Wed, 27 Jun 2018 01:20:36 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452? ([2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452])
        by smtp.googlemail.com with ESMTPSA id u15-v6sm7080838wma.37.2018.06.27.01.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 01:20:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: Add mtk-systimer bindings
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
 <1530086039-3763-2-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <32d0da38-f014-c2c0-70ff-11cdf9ed0569@linaro.org>
Date:   Wed, 27 Jun 2018 10:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530086039-3763-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 09:53, Stanley Chu wrote:
> Add binding documentation for the System Timer driver of
> the Mediatek SoCs.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---


>  .../bindings/timer/mediatek,mtk-systimer.txt       |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> new file mode 100644
> index 0000000..7a5bde6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> @@ -0,0 +1,18 @@
> +Mediatek System Timers
> +----------------------
> +
> +Required properties:
> +- compatible: Should contain
> +	"mediatek,sys_timer" for those platforms which support system timer.
> +- reg: Should contain the location and length for system timer registers.
> +- clocks: System timer is drived by system clock.
> +
> +Examples:
> +
> +	sys_timer@10017000 {
> +		compatible = "mediatek,sys_timer";
> +		reg = <0 0x10017000 0 0x1000>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sys_clk>;
> +	};
> +

Actually this binding already exists for mediatek timers, it is useless
to add a new one.

I note the binding in

Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt

contains:

 clocks = <&system_clk>, <&rtc_clk>

However the existing driver does only use <&system_clk> AFAICT, I'm
questioning if <&rtc_clk> is really needed.

So, I suggest you sort out and fixup the rtc_clk thing (drop it) and
then just add your new platform in the list in this binding.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

