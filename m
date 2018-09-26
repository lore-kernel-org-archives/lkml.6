Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498E42151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdrR9d8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498E42151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeI0AsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:48:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35410 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeI0AsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:48:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id y21-v6so2797472edr.2;
        Wed, 26 Sep 2018 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b39qv6pmPD9F1Uadw4HO92tikBp0XnWPtXxz+lkV76E=;
        b=bdrR9d8OU07sG80OIwbZo3Ym/IWe1t/1EWVNUG+WVJSDRCLLaWsfg1s75qNcoxImPh
         T6F780K4T5kIcmgdQuo6DVBY55po/cYiQIjh39e9asYQhuEuqSiasfXjMyJk04X6JACZ
         DHTagt8EUs+ZZnO5We/YlmaAZI6kTcKHFFovgAbXueI7X27TwZES/0RhM0+kuglxfl1B
         zKuYtXd+RGesW/E8WlGV9DmbgA2woMQQf6hQitOfq1pqLSRxZO9Oz7lUCXfdLViVe24h
         oHGw+XWHZJNcbJLFiSvIxaSaxpnzmEHkqWYZ2MnHIrcEQ8LMLl7s+WUPBrjKVmC0sRBK
         wZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b39qv6pmPD9F1Uadw4HO92tikBp0XnWPtXxz+lkV76E=;
        b=cLtKR2Bdl0tpciSIXdBvx9brH2iOfszAYJXrgJAqNHHzBLH4O3DEb06Ohg6RWAQjKG
         0zFdwOBt2OHp6DbgcNNAD2eaBgL9W8E07jkRJpM4JSOSYPW2yGXc95ROpcNwC4ucA2AC
         OJzo2+IZ4+WTp0VyC6IY851SkwbDeDHcI70jgrtL5CxA5cjG4BWr+jrb/exY9CSUOXPn
         5Md3yCTsVJRkqr3wqjkGVYoMY56AKFRHgjqqbyOoqcZ8PtRWBH/v01h36J43lejofNZZ
         RRExXxNqWb2Wgp1WyQnHL9VOUEXZK6viYvKbNXnRkvzM9+qFZW6feiyJ4gFx2FQsX8n9
         ZEcg==
X-Gm-Message-State: ABuFfoghQ2/WQ5q+8Xw9eTijW7RMy1BKE53/ZTI6QWV0R8uGl41KBFec
        ToNx8bvcOGeMyTUZ4fdiJlo=
X-Google-Smtp-Source: ACcGV62Et9GbCERds+xo4fYQyb8BbYE6T9FLfVNCAcWgHyRFxvGmiVYN3aV0T7BQctOFVBykQs3BBg==
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr11797093edp.84.1537986823319;
        Wed, 26 Sep 2018 11:33:43 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id f10-v6sm56802edt.56.2018.09.26.11.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:33:42 -0700 (PDT)
Subject: Re: [PATCH net] dt-bindings: net: add support for Microchip KSZ9131
 Ethernet PHY
To:     Yuiko Oshino <yuiko.oshino@microchip.com>, davem@davemloft.net,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        m.felsch@pengutronix.de, Markus.Niebel@tqs.de, andrew@lunn.ch,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <1537985783-22724-1-git-send-email-yuiko.oshino@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <87d34a1b-5188-2999-bffe-fe377bc6ad3f@gmail.com>
Date:   Wed, 26 Sep 2018 11:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537985783-22724-1-git-send-email-yuiko.oshino@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 11:16 AM, Yuiko Oshino wrote:
> Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet phy

Capitalize PHY here.

Targeting the "net" tree which is for bugfixes is not appropriate here
since this is adding support for a new PHY model.

The binding looks reasonable though:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
> ---
>  .../devicetree/bindings/net/micrel-ksz90x1.txt     | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> index e22d8cf..d23d14a 100644
> --- a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> +++ b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> @@ -1,4 +1,4 @@
> -Micrel KSZ9021/KSZ9031 Gigabit Ethernet PHY
> +Micrel/Microchip KSZ9021/KSZ9031/KSZ9131 Gigabit Ethernet PHY
>  
>  Some boards require special tuning values, particularly when it comes
>  to clock delays. You can specify clock delay values in the PHY OF
> @@ -64,6 +64,33 @@ KSZ9031:
>          Attention: The link partner must be configurable as slave otherwise
>          no link will be established.
>  
> +KSZ9131:
> +
> +  All skew control options are specified in picoseconds. The minimum
> +  value is 0, and the maximum is property-dependent. The increment
> +  step is 100ps. The default value is the neutral setting, so setting
> +  rxc-skew-ps=<0> actually results in -700 picoseconds adjustment.
> +
> +  Optional properties:
> +
> +    Maximum value of 2400, default value 700:
> +
> +      - rxc-skew-ps : Skew control of RX clock pad
> +      - txc-skew-ps : Skew control of TX clock pad
> +
> +    Maximum value of 1500, default value 700:
> +
> +      - rxdv-skew-ps : Skew control of RX CTL pad
> +      - txen-skew-ps : Skew control of TX CTL pad
> +      - rxd0-skew-ps : Skew control of RX data 0 pad
> +      - rxd1-skew-ps : Skew control of RX data 1 pad
> +      - rxd2-skew-ps : Skew control of RX data 2 pad
> +      - rxd3-skew-ps : Skew control of RX data 3 pad
> +      - txd0-skew-ps : Skew control of TX data 0 pad
> +      - txd1-skew-ps : Skew control of TX data 1 pad
> +      - txd2-skew-ps : Skew control of TX data 2 pad
> +      - txd3-skew-ps : Skew control of TX data 3 pad
> +
>  Examples:
>  
>  	mdio {
> 


-- 
Florian
