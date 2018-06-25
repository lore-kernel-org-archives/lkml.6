Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93140C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D68825EAC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABoBQdmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D68825EAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeFYVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:53:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34385 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeFYVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:53:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so15154103wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sSus7SJjiuAr9XXBv2gWR3n7psLFnbUvvd6lZqZGC2I=;
        b=ABoBQdmY256RsCSlfniVa8vhEg1LGKSHd5y+8/qsFb8VnVSv80Qxyzv6z/OeIGZBIM
         UOYmXuzDs+33oFSYJd2pWkz8k/5D3l/qcraCGYEg0/Fej1QlgHFmNaENlB1KIEqapSSg
         Fqh3/FP4agG9FxD2PX+kxbkULm4DNwS3v+Joo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSus7SJjiuAr9XXBv2gWR3n7psLFnbUvvd6lZqZGC2I=;
        b=Y4fkY3cV6dq+UjSuO2qUnrONunfm1nKlUuQwso/SLGuawyollHHc6btEvjkEUk1kuz
         dq9Zxmor0OBFwCM0CiV7ZsDWxdg0g/73VacuI1OunXhozezLskwwMnfZSwOFFCyUqi0m
         x+J35f1bCGhnQj0U2XPHmWiuBqgX7+WdyjZlIkb1CKMnZmxYvQb/Nlk78AOd79yk81fP
         ns4WgAuD5xjcR7ia3dHnNVHBGFpVmUecVU95FNStxw+XisTtLOW2jUufkpSvjM4rY6QU
         UL/tDWOObhFUXdBf6+9ak7aWpqtT9IovC+sUDlg6qjQmV6peSSXWEGNajM7B+p8HpMLQ
         3cjw==
X-Gm-Message-State: APt69E0Vw0/IrOHEDunKj2+6P/1BTpicEHHwudhE1GoieX2FX/2TAfXT
        iXUB9XfhJOy5zgI2/f/TZoK+6L8MJbg=
X-Google-Smtp-Source: AAOMgpcObMbVezsn1QBhJy/rCcIarVnlHP7SNU57cf74DZ4OgzsYk5F95oX0ZMQHioeKfHBmBfFtkw==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11-v6mr11427801wrs.87.1529963623058;
        Mon, 25 Jun 2018 14:53:43 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452? ([2001:41d0:fe90:b800:7ce3:d1ec:2b62:6452])
        by smtp.googlemail.com with ESMTPSA id h15-v6sm9862177wrp.79.2018.06.25.14.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:53:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: Add mtk-systimer bindings
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
 <1529910601-15005-2-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ad38a952-4400-984a-a7fd-aa4e6af13c13@linaro.org>
Date:   Mon, 25 Jun 2018 23:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529910601-15005-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 09:10, Stanley Chu wrote:
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
> index 0000000..735a6fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
> @@ -0,0 +1,18 @@
> +Mediatek System Timers
> +----------------------
> +
> +Required properties:
> +- compatible: should contain
> +	"mediatek,sys_timer" for those platforms which support system timer.
> +- reg: Mandatory. The location and length for system timer registers.
> +- clock-frequency: Optional. If not assigned specifically, default
> +	value 13000000 (means 13 MHz) would be applied.

The driver tells there is an error if it is not defined, so it can't be
optional.

> +Examples:
> +
> +	sys_timer@10017000 {
> +		compatible = "mediatek,sys_timer";
> +		reg = <0 0x10017000 0 0x1000>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <13000000>;

Replace it by a phandle to a 'fixed-clock'.

eg.

clocks = <&myclk>;


> +	};

myclk: myclk {
	#clock-cells = <0>;
	compatible = "fixed-clock";
        clock-frequency = <13000000>;
};

Thanks

  -- DAniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

