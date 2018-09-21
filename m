Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7860EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2CC21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT70Qwmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2CC21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbeIUGbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:31:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUGbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:31:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so5160579pfi.1;
        Thu, 20 Sep 2018 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y4pdwtP9HWKqzzYcGtcTcLg4Rc95tepbiok+WToIdDg=;
        b=FT70QwmmGFAGQD1VMRKcXTF2F0c+7+XDWUYmXIZGHFLHOeyQaMIFNNQuI5YKU7kYei
         PFyt0J5vg0LptVYaocB9jn6bIK5x9CF2k+hH6fiGb+S0EKbzmWWB0fcw1wAvrENU3su+
         cZ0yamt3qyFAB0awCNf4TnbmwmyvqmkBZRbDcD+KqTWIAwaKQJEECfrMq7cZpdfOhZzs
         I3wsCofnoeygth1ENKVNOkg7SMuGVeEzvs3/ecs0dpxusH7MDmQAcX5kAQBSKj1oIih/
         yLpraP7f+kV1UETSJ/bj6rVeEr40Vpz6n5RBnvr2q2qDhhYY73UY0xi7LLYuLlOxs1aU
         3XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4pdwtP9HWKqzzYcGtcTcLg4Rc95tepbiok+WToIdDg=;
        b=apcrJAOwOUHmQjDdb0F5ax9F+VllWsQhpSwO2XGvdBhgDPLTaLKuosnB0djV7+hQo3
         /ClABxhBP+yGwDzKCzHmj8Ech8/J6pSqv8GLfmBgYs76odBhiZTmgVfCatRZgr0E0wOh
         qSgPRruvJMy69ej9/ty4R8ieVCd7dT0g88VqdbI5xuDGMbA0H8PfypRQ/Os2PzSvuisE
         9ZNBUMaF6ugNKdDBb7WVDZTNFHl/ITlCHU+hogeTj4fW0L2hGHSixryTDlPyFPE/0+R2
         W+H1HKnRmEL82IRmT+OkPpmnUMXnv1Bq6JHxiMlH+Xl1DyC8JFFjMODV2FGFFpRDyAc6
         h6oA==
X-Gm-Message-State: APzg51CkekfeObbUvAcE5d/0uKhCj2Sx/rqfc5f/txqoxCyNVBD/0PYp
        KP8aw1EZu0hXpNLRBl85IckqKGyO
X-Google-Smtp-Source: ANB0VdYnMKiR8yCiXvrq/8iYG/4s2jOp60AsM9FL/taoA5I52wzOXUwUkbPxu72omowu9bD1MyYppg==
X-Received: by 2002:a63:e806:: with SMTP id s6-v6mr2147432pgh.176.1537490709416;
        Thu, 20 Sep 2018 17:45:09 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g5-v6sm37242903pgn.73.2018.09.20.17.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:45:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-2-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d744da89-ebd3-6059-31bf-e65e4c3d2ea4@roeck-us.net>
Date:   Thu, 20 Sep 2018 17:45:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921000753.21846-2-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 05:07 PM, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   .../devicetree/bindings/hwmon/ina3221.txt     | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> new file mode 100644
> index 000000000000..266c9586c9b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,23 @@
> +ina3221 properties
> +
> +Required properties:
> +- compatible: Must be "ti,ina3221"
> +- reg: I2C address
> +
> +Optional properties:
> +
> +- ti,channel1-name:
> +- ti,channel2-name:
> +- ti,channel3-name:
> +	The names of the input sources (described in the schematics)
> +	Set the names with "NC" to indicate not-connected channels
> +

I don't really think this is a good idea - first to specify sensor
names this way, and much less specifying that "NC" means that a sensor
shall be disconnected/disabled.

Also, if we define devicetree support for this chip, it should include
all configuration options required to configure it. This should at
the very least include shunt resistor values.

Thanks,
Guenter

> +Example:
> +
> +ina3221@40 {
> +	compatible = "ti,ina3221";
> +	reg = <0x40>;
> +	ti,channel1-name = "NC";
> +	ti,channel2-name = "VDD_5V0_EXT";
> +	ti,channel3-name = "VDD_19V";
> +};
> 

