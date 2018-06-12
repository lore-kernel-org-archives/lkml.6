Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C989FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74434208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="W6UtYCGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74434208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeFLIq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:46:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45971 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933439AbeFLIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:46:23 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so34738730lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ImfPuMr8t26sZqnTD/IQuaXUA+hBMVXTKAL/3TwpSI=;
        b=W6UtYCGpSeXxQPdcWrt4t3eH5aszsPC6dIAdDrJLXPy/+uboimHl0PgiXLU4Fc6pAw
         TGAhw52Bi3AJ8ukksH+yr7jO06gn5ib+uJL9VMRxWSlLH1TI3rzvcOuHebxR94bhEeNg
         8U3LcqF4xFjtJMG0r4/PEj+1xtYcXQwbd6zsUV5XJ5/xSL+oSLxEZxYBODtIlSuJFmGU
         BAJAQEns1d0QluT0TGLYHu71w1jqAW5tsCzjgJYiGnutUPx1pR/A987UhiPUlQzlDDAe
         Qe9llAdXdHFGcYRb7QsUDrCkCgGzEmPcfpKaSEMnSvdzAVOTKOmnLONTM9zTDKazxy3E
         k3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ImfPuMr8t26sZqnTD/IQuaXUA+hBMVXTKAL/3TwpSI=;
        b=My1wRZkJ4x5LFN2wYu43owLeUEPLcGFpzIAWf9efRPdqY6k7zUdB1UIPpErloFlBHC
         3qJu3zgzuY7K1LTF5VexjncPxDvissVRt5zDvjHINb8u9/IQla3JQMnuJ4Fk/DpzqTSm
         BW2joPc0WYklF9hzncW20WXMMq8bL7WF5vUCz8qjkNRoyK0pxlKmRFx8NX7ycqcJTFtP
         xy1VKEO9Pc0BDxTObySiGGL6D1xGOeK/ofgrNe/54UTzVJRF38k311A/6uzKn30J9onO
         gXgW+gkEmeBecTaYOpJROXKHLn3UVCTLx5BgWG7dhhqi4ptCktZ6NfT+Wrp7u/Wskeum
         AH+g==
X-Gm-Message-State: APt69E1sT6WZSH8U8n/atLt+IjIDVAnkaAerOM5rETbuSwAS+2GXucyr
        c4LtxVNq9wha4i/9zSbYM8m+WA==
X-Google-Smtp-Source: ADUXVKIUAfBT+3SajwxIN/N9tLdb4zlL9zjk0Z8hByfs3z+u4Ia7kRPAfeRE5HNj/flRiJeJl5hmxA==
X-Received: by 2002:a2e:419:: with SMTP id 25-v6mr1683132lje.146.1528793182337;
        Tue, 12 Jun 2018 01:46:22 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.249])
        by smtp.gmail.com with ESMTPSA id s20-v6sm87843lfk.56.2018.06.12.01.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 01:46:21 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] dt-bindings: usb: new ehci-npcm7xx dt
To:     avifishman70@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, mathias.nyman@linux.intel.com,
        bjorn.andersson@linaro.org, jhogan@kernel.org, albeu@free.fr,
        chunfeng.yun@mediatek.com, tony@atomide.com,
        baolu.lu@linux.intel.com, elder@linaro.org, digetx@gmail.com,
        kstewart@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
References: <20180611195837.251551-1-avifishman70@gmail.com>
 <20180611195837.251551-3-avifishman70@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e12a159a-53ff-0c5e-9ce0-4fa9f93dd429@cogentembedded.com>
Date:   Tue, 12 Jun 2018 11:46:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611195837.251551-3-avifishman70@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/11/2018 10:58 PM, avifishman70@gmail.com wrote:

> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Device Tree documentation for Nuvoton npcm7xx EHCI.
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> Reviewed-by:   Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> new file mode 100644
> index 000000000000..b682bec103f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> @@ -0,0 +1,17 @@
> +Nuvoton NPCM7XX SoC USB controllers:
> +-----------------------------
> +
> +EHCI:
> +-----
> +
> +Required properties:
> +- compatible: "nuvoton,npcm750-ehci"
> +- interrupts: Should contain the EHCI interrupt

    How about "reg"?

> +
> +Example:
> +
> +	ehci1: usb@f0806000 {
> +		compatible = "nuvoton,npcm750-ehci";
> +		reg = <0xf0806000 0x1000>;
> +		interrupts = <0 61 4>;
> +	};
> 

MBR, Sergei
