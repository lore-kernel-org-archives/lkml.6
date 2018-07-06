Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC96C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67D22458
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BkcoeaAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B67D22458
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeGFX4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:56:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32838 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbeGFX4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:56:20 -0400
Received: by mail-qk0-f194.google.com with SMTP id c131-v6so7163013qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1pMwXXC6QQV4AW6EqAZcV5uNdJYkcQ+6uUFOUSwtabg=;
        b=BkcoeaAJfZqLTW9WOiB8VlCICcdwqb7xyinvOb0usS3AEcglgxZTnZDmeiZTKfALvn
         fllZEgNXQxMxXL32hLDsLkBrak/XP2bs6YMgs+j4A+0r73MR55L1nZcyCdEsRWvcacHE
         /ugo6UGdgl7lQutGQCueSGk0XM0Pu1NllEtXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pMwXXC6QQV4AW6EqAZcV5uNdJYkcQ+6uUFOUSwtabg=;
        b=aJLApwNIQwIEi1sXHOXeO85flhZaVaWUySB0L92m9ihmx9ipizR2wWpGbvUb6deisA
         VQpxXb0Lep2oVF1ueuCL9BPPwd3hl0KW6jvNXFOxl8qRpZsyUHInLPW9SXe6wjjMlJse
         0SdDY+O5GpH58J7dR6vh0rhg+ShOItlpLQQb0cKM1Vx4apm5fh6mFGQBfyWP4mitOk27
         uqZHsJYTfiglKbWsa52fExziVNGWnhL+JGkmIEBAC5/p7hNrPPeyq1lqjBM+IT6O6TTl
         ggHAPqyPPSgwj2JQRGwzCdVKeffvCG1AiMssZRqvnwFJPSoK8jixlfO7/GyrRUwU5nOF
         J53A==
X-Gm-Message-State: APt69E2cXQgY1TnG/eHfRQW0JMNYZ30bKQRgzCFoo10FVqLWiIe0E3k3
        SK0Oe0xwB1FikX7OEMgh2Jn1VeubjEs=
X-Google-Smtp-Source: AAOMgpedwIhJX6K2SKHSAKhR/ro1413j4Kv+hg1YKFzaeKIPlMBrFHUhydXLGnrtx2QfFrlW6DP97g==
X-Received: by 2002:a37:d197:: with SMTP id o23-v6mr10739426qkl.210.1530921379415;
        Fri, 06 Jul 2018 16:56:19 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s9-v6sm7089535qkl.65.2018.07.06.16.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 16:56:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add binding doc for Stingray
 PCIe PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
 <1530728533-28770-2-git-send-email-ray.jui@broadcom.com>
 <20180705233401.GA26079@rob-hp-laptop>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <6a9c7b49-53b0-2d85-cc43-292020bf57ed@broadcom.com>
Date:   Fri, 6 Jul 2018 16:56:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705233401.GA26079@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2018 4:34 PM, Rob Herring wrote:
> On Wed, Jul 04, 2018 at 11:22:12AM -0700, Ray Jui wrote:
>> Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
>> root complex
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
>> new file mode 100644
>> index 0000000..5a13511
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
>> @@ -0,0 +1,41 @@
>> +Broadcom Stingray PCIe PHY
>> +
>> +Required properties:
>> +- compatible: must be "brcm,sr-pcie-phy"
>> +- reg: base address and length of the PCIe SS register space
>> +- brcm,sr-cdru: phandle to the CDRU syscon node
>> +- brcm,sr-mhb: phandle to the MHB syscon node
>> +- #phy-cells: Must be 1, denotes the PHY index
>> +
>> +For PAXB based root complex, one can have a configuration of up to 8 PHYs
>> +PHY index goes from 0 to 7
>> +
>> +For the internal PAXC based root complex, PHY index is always 8
>> +
>> +Example:
>> +	mhb: syscon@60401000 {
>> +		compatible = "brcm,sr-mhb", "syscon";
>> +		reg = <0 0x60401000 0 0x38c>;
>> +	};
>> +
>> +	cdru: syscon@6641d000 {
>> +		compatible = "brcm,sr-cdru", "syscon";
>> +		reg = <0 0x6641d000 0 0x400>;
>> +	};
>> +
>> +	pcie_phy: phy {
> 
> Needs a unit address.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Yes, will address that in v4 with your Reviewed-by added.

Thanks,

Ray

>> +		compatible = "brcm,sr-pcie-phy";
>> +		reg = <0 0x40000000 0 0x800>;
>> +		brcm,sr-cdru = <&cdru>;
>> +		brcm,sr-mhb = <&mhb>;
>> +		#phy-cells = <1>;
>> +	};
>> +
>> +	/* users of the PCIe PHY */
>> +
>> +	pcie0: pcie@48000000 {
>> +		...
>> +		...
>> +		phys = <&pcie_phy 0>;
>> +		phy-names = "pcie-phy";
>> +	};
>> -- 
>> 2.1.4
>>
