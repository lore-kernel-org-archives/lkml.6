Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6087ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A845208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHg+r3Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A845208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIPTdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 15:33:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46979 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbeIPTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 15:33:41 -0400
Received: by mail-io1-f66.google.com with SMTP id y12-v6so9430761ioj.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mm2qH5uiY5w3kv+RQjUIZaVNOj1ivqy6zHuepPPbNrI=;
        b=BHg+r3Pg3BaZimUYc2uJa/tXemC7zTfFw/Yu/MAdlRi5LSHLL3VQF7fRwnMPZVrIj0
         Q0Zy9NFbU+cHYHCCnkYGacqf7nyBHoY8hKKuBmSojgr3SbR97/4gr7Qjx+U7ZfNxMzgX
         ZcS54Vrkk3udTxMsaCVCFl+Jpc6701csdAw+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mm2qH5uiY5w3kv+RQjUIZaVNOj1ivqy6zHuepPPbNrI=;
        b=i6gTYNDuEIcWP8Mywf4YdqHRuP1HbKcasW4dJQ6uTN1DmAxWJzQkj3xQAKSkXVsYAV
         +ctARTwAF2W0eKl6OCRVwfGHYr4s21wMpMV3tjT763Ic4wLzhl4d2umNh3ZKqXJWxMPl
         htu/aMJzUwou4+VHnlLBzmActmY3cmApOaqhO5zpgNKOBqNyO+osD9wKTLV9g5DB9Cb3
         PwxEQCXHuez1DBmLdhscgVFANvU/KrrZCHsawCJXazP16o/0LoJzDcaFYPQ0V48ZrbrL
         Y/x131CypZDR0/xfreNQcN7drzJN0OtjLCdscF01IV+lq/nXmu8ESfZeYR9ncxMRG9vU
         AMfg==
X-Gm-Message-State: APzg51Cq4LHiOspyZ++M9Ae6zPjck4dVWuMducWrs49mS+jk5fZdK1nH
        3SPKz/W0OVEwaRsmQZLoAfB3Tw6EpwFE7w==
X-Google-Smtp-Source: ANB0VdbCi1t/ovdTCr97aGUViRofFtIDrqpxQ3ruPxN6TSJdkUWEt4lJwOpG13mUimReN/8gam1zYg==
X-Received: by 2002:a6b:9681:: with SMTP id y123-v6mr16687813iod.97.1537107035062;
        Sun, 16 Sep 2018 07:10:35 -0700 (PDT)
Received: from [10.199.96.233] ([209.82.80.116])
        by smtp.googlemail.com with ESMTPSA id w196-v6sm2168126itb.9.2018.09.16.07.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 07:10:34 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 nvmem driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
 <1536054754-3119-3-git-send-email-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <62a85f77-ee9d-e6fa-1356-9b68f65882c6@linaro.org>
Date:   Sun, 16 Sep 2018 15:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1536054754-3119-3-git-send-email-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Do you have any comments on the bindings side of it.

I would like to queue this for next release..


On 04/09/18 10:52, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-Moved nvmem_firmware node as a child to
> 		 firwmare node.
> 
>   .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index 1b431d9..4b95fcc 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -17,6 +17,19 @@ Required properties:
>   		  - "smc" : SMC #0, following the SMCCC
>   		  - "hvc" : HVC #0, following the SMCCC
>   
> +--------------------------------------------------------------------------
> +=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
> +--------------------------------------------------------------------------
> +The nvmem_firmware node provides access to the hardware related data
> +like soc revision, IDCODE... etc, By using the firmware interface.
> +
> +Required properties:
> +- compatible: should be "xlnx,zynqmp-nvmem-fw"
> +
> += Data cells =
> +Are child nodes of silicon id, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
>   -------
>   Example
>   -------
> @@ -25,5 +38,27 @@ firmware {
>   	zynqmp_firmware: zynqmp-firmware {
>   		compatible = "xlnx,zynqmp-firmware";
>   		method = "smc";
> +		nvmem_firmware {
> +			compatible = "xlnx,zynqmp-nvmem-fw";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* Data cells */
> +			soc_revision: soc_revision {
> +				reg = <0x0 0x4>;
> +			};
> +		};
>   	};
>   };
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	pcap {
> +		...
> +		nvmem-cells = <&soc_revision>;
> +		nvmem-cell-names = "soc_revision";
> +	};
> +
> 
Thanks,
srni
