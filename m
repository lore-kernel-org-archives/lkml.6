Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAD4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF1621480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDl3kh4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF1621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeIZIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:02:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:02:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so12473346pfh.5;
        Tue, 25 Sep 2018 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vn6F+B4SV98rBF2jaB+i4NBTjG9lJYXTriU3XFApq6k=;
        b=vDl3kh4GdB4SrxgcUIMUuqVULX5AnhBPdaHHSM4NCUcokgYcxh1MlEQx9OfPvpCTyt
         oV+UvZKg9em+HHulDvjwHbxrxp6x9WvmwQsGdKpeqnFcqEfCA2N4x1r/i7Vmh5ZkJg/C
         +2C+JyafYrKRIdN22UrA8S0Tu4esiUcPDtkZumMM6xzhlkJUfPR3LDJ1SWkyksgM9rq/
         w9nJinXXE4TMVIozsE+YCQhbmayiXfJyvwnVPJOekCkPrurwi9ItoEdUR86an65eKC3L
         hLhkXAQINwY/I8PyN/QVzRgpz1DJp87Y9eKupPyXlDYNyuEM7EiM4d8rXfxqmO8qbP2q
         OzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vn6F+B4SV98rBF2jaB+i4NBTjG9lJYXTriU3XFApq6k=;
        b=EWfsdWqXyEsU52g0pylMCRksMdG3DYR0G4tk5uvwm3sR641yeevtzF69SqQp9x8yi0
         LqZKeCHOIETg7N4dkeChzHNbiWSEsXhPR4oxxIP8n9WpOq/0fhOgwdpO65ONjW7IpjHM
         Nfkkk+j1YW+aeJpe6BlNCyZaN4H0oTufufPf98sxkx04Ld6k/0OvkI4LrqTSSsEkr5Je
         LB3ep8fxpYCVBcFJ5uupoYCP3QsKj53lg72gVSP2dB/Z6SGOGId3LIV9MSOeGJcxJdVE
         rHqSPTSCru4DF79R+2ZgCHcCdq+JzSUjjztHI6+WYzucogixhNDC5hRaaM1DfZT/wlPJ
         jAAQ==
X-Gm-Message-State: ABuFfohHg5BIVkU4gL7H+qUDZsmcVS0kwLvUxLiHNPDTcUm0qYbcWP6E
        j/4OSU16nn2kGmf1eI+0RXcX6QfZ
X-Google-Smtp-Source: ACcGV62CupOauvKCVBeZexv5uMKPzVz8f9XJMtdHi/Z3nBDnRNSJn5C0uHKlzbF+JZj8xLX38+Pwfw==
X-Received: by 2002:a17:902:b908:: with SMTP id bf8-v6mr3690990plb.284.1537926752084;
        Tue, 25 Sep 2018 18:52:32 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4947863pfd.155.2018.09.25.18.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 18:52:31 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
Date:   Tue, 25 Sep 2018 18:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925225930.31886-2-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 09/25/2018 03:59 PM, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v4->v5:
>   * Replaced "input-id" with "reg" and added address-cells and size-cells
>   * Replaced "input-label" with "label"
>   * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
> v3->v4:
>   * Removed the attempt of putting labels in the node names
>   * Added a new optional label property in the child node
>   * Updated examples accordingly
> v2->v3:
>   * Added a simple subject in the line 1
>   * Fixed the shunt resistor value in the example
> v1->v2:
>   * Dropped channel name properties
>   * Added child node definitions.
>   * * Added shunt resistor property in the child node
>   * * Added status property to indicate connection status
>   * * Changed to use child node name as the label of input source
> 
>   .../devicetree/bindings/hwmon/ina3221.txt     | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> new file mode 100644
> index 000000000000..e17a897f4803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,49 @@
> +Texas Instruments INA3221 Device Tree Bindings
> +
> +1) ina3221 node
> +  Required properties:
> +  - compatible: Must be "ti,ina3221"
> +  - reg: I2C address
> +
> +  Optional properties:
> +  = The node contains optional child nodes for three channels =
> +  = Each child node describes the information of input source =
> +
> +  - #address-cells: Required only if a child node is present. Must be 1.
> +  - #size-cells: Required only if a child node is present. Must be 0.
> +
> +  Example:
> +
> +  ina3221@40 {
> +          compatible = "ti,ina3221";
> +          reg = <0x40>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          [ child node definitions... ]
> +  };
> +
> +2) child nodes
> +  Required properties:
> +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> +
> +  Optional properties:
> +  - label: Name of the input source
> +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> +  - status: Should be "disabled" if no input source
> +
> +  Example:
> +
> +  input@0 {
> +          reg = <0x0>;
> +          status = "disabled";

I kind of feel embarrassed that I asked for the reg change ... especially while
saying at the same time that I would like to see this work for other chips
as well.

Other chips have different kinds of sensors. Voltage, current, power, temperature,
and others. Whatever we come up with should support that.

I see two possibilities right now. We can stick with reg and add a "type" property,
or we can make the index something like
	{voltage,current,power,temperature,humidity}-{id,index}

I personally prefer "type", but I don't really have a strong opinion.
What do you think ? Or maybe we should really wait for feedback from Rob.

Thanks,
Guenter

> +  };
> +  input@1 {
> +          reg = <0x1>;
> +          shunt-resistor-micro-ohms = <5000>;
> +  };
> +  input@2 {
> +          reg = <0x2>;
> +          label = "VDD_5V";
> +          shunt-resistor-micro-ohms = <5000>;
> +  };
> 

