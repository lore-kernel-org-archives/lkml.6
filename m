Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DFE208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9ydTec4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DFE208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeGPNzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:55:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46955 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeGPNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:55:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so2451153edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1NEBeNdVWANA8ZlxjNBqVRrVaVsLeYbYosfG1lGSy/E=;
        b=O9ydTec4jGI3jY3lcotXP4UPH3dAA4dSkjlitgba7XdFa+fqi90yS82Zn/PcAC4Fwh
         oDPB8kHR8tTi080aSWSlxhpvfkcW7EflxR7MrgDOyj8qdTcTFmHMPokyCwSOXhfTgou9
         RVaaAdInhLowra4jWNp8a21Dw7nq7KgwzbmWQdiQCy2CfogerlbC5c4VQ6vyELtnPZjN
         of6Kb3SB3o2jWOQsbav00iavA2Q+wpw6St1N+pclXaESPP5hGmAwFNyOAwDMxE8gAlkW
         WMxKG9c/kEKB92Qw38ycxPUly+LpVX7rj4tiHv0ndKBq6ZvabfAJrduACY3MQ3teaPFo
         RqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1NEBeNdVWANA8ZlxjNBqVRrVaVsLeYbYosfG1lGSy/E=;
        b=NyRK7MKjGD2exhiiIPrqh9tSJD7yAt6fYjPJvlIcwH6Orvq46G3NnQCgRndjYM25uf
         0dEQ0sc8suNAbZC2iQRW9VjhzEztSKBzRnc+K0u9L7qLhbWaO58vNjWmB8zqD5cc+5sg
         oARW3HxqAD1su9gZEkhDsgH2ggtha2GdHFXAVAGHe1zzDVtPZ8tGxgAS+W1lngE0p5F4
         zuwjF23FiL4/ValTdcNWua+8wU1C+oLwtJB4ttmlwKlbRdHjRlVh35VsBbztw7FRjLhf
         +fxv6k5+KQsASdkE8SfYooH6AqXb1Pzb+LgMy/sKx4rKSYiPRa6BMK9ndsHfXl8Key3s
         +G8A==
X-Gm-Message-State: AOUpUlHYzyJHwoZYdqyi2PF3Uwn0VpUReUQ0mZy4hixrT1u4fucEt+JO
        oeAWToEQNICkndEizwqoWz8=
X-Google-Smtp-Source: AAOMgpcJLyzT2KvlE0HqcSl/ec6SGlLml90XY2tiM9gN9twVjOXt7bTETI2AjiLh1LQL3UiprWJM9A==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6-v6mr17986632edr.148.1531747696270;
        Mon, 16 Jul 2018 06:28:16 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id j12-v6sm4649380edk.94.2018.07.16.06.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:28:15 -0700 (PDT)
Subject: Re: [PATCH v4] dt-bindings: mediatek: Add binding for mt2712 IOMMU
 and SMI
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, arnd@arndb.de
References: <1527165331-22261-1-git-send-email-yong.wu@mediatek.com>
 <1529562433.22229.2.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
Date:   Mon, 16 Jul 2018 15:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529562433.22229.2.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/06/18 08:27, Yong Wu wrote:
> Hi Matthias,
> 
>       A gentle ping on this.
> 
> On Thu, 2018-05-24 at 20:35 +0800, Yong Wu wrote:
>> This patch adds decriptions for mt2712 IOMMU and SMI.
>>
>> In order to balance the bandwidth, mt2712 has two M4Us, two
>> smi-commons, 10 smi-larbs. and mt2712 is also MTK IOMMU gen2 which
>> uses ARM Short-Descriptor translation table format.
>>
>> The mt2712 M4U-SMI HW diagram is as below:
>>
>>                             EMI
>>                              |
>>               ------------------------------------
>>               |                                  |
>>              M4U0                              M4U1
>>               |                                  |
>>          smi-common0                        smi-common1
>>               |                                  |
>>   -------------------------       --------------------------------
>>   |     |     |     |     |       |         |        |     |     |
>>   |     |     |     |     |       |         |        |     |     |
>> larb0 larb1 larb2 larb3 larb6    larb4    larb5    larb7 larb8 larb9
>> disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2 mdp3 vdo/nr tvd
>>
>> All the connections are HW fixed, SW can NOT adjust it.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>> change notes:
>> v4: change the license of the new file in this patch to SPDX.
>>
>> v3: http://lists.infradead.org/pipermail/linux-mediatek/2018-May/013279.html
>> Add a new ECO port(DISP_RDMA2) in larb0/port7.
>>
>> v2:
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023848.html
>>
>> v1:
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023665.html
>> ---
>>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
>>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
>>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
>>  include/dt-bindings/memory/mt2712-larb-port.h      | 95 ++++++++++++++++++++++
>>  4 files changed, 106 insertions(+), 6 deletions(-)
>>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
>>

Joerg, will you take this through your tree, or would you mind to provide a
Acked-By?

Thanks,
Matthias

>> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> index 53c20ca..df5db73 100644
>> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> @@ -40,6 +40,7 @@ video decode local arbiter, all these ports are according to the video HW.
>>  Required properties:
>>  - compatible : must be one of the following string:
>>  	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
>> +	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
>>  	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
>>  - reg : m4u register base and size.
>>  - interrupts : the interrupt of m4u.
>> @@ -50,8 +51,9 @@ Required properties:
>>  	according to the local arbiter index, like larb0, larb1, larb2...
>>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>>  	Specifies the mtk_m4u_id as defined in
>> -	dt-binding/memory/mt2701-larb-port.h for mt2701 and
>> -	dt-binding/memory/mt8173-larb-port.h for mt8173
>> +	dt-binding/memory/mt2701-larb-port.h for mt2701,
>> +	dt-binding/memory/mt2712-larb-port.h for mt2712, and
>> +	dt-binding/memory/mt8173-larb-port.h for mt8173.
>>  
>>  Example:
>>  	iommu: iommu@10205000 {
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> index aa614b2..615abdd 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> @@ -2,8 +2,9 @@ SMI (Smart Multimedia Interface) Common
>>  
>>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>>  
>> -Mediatek SMI have two generations of HW architecture, mt8173 uses the second
>> -generation of SMI HW while mt2701 uses the first generation HW of SMI.
>> +Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
>> +the second generation of SMI HW while mt2701 uses the first generation HW of
>> +SMI.
>>  
>>  There's slight differences between the two SMI, for generation 2, the
>>  register which control the iommu port is at each larb's register base. But
>> @@ -15,6 +16,7 @@ not needed for SMI generation 2.
>>  Required properties:
>>  - compatible : must be one of :
>>  	"mediatek,mt2701-smi-common"
>> +	"mediatek,mt2712-smi-common"
>>  	"mediatek,mt8173-smi-common"
>>  - reg : the register and size of the SMI block.
>>  - power-domains : a phandle to the power domain of this local arbiter.
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> index ddf46b8..083155c 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> @@ -4,8 +4,9 @@ The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>>  
>>  Required properties:
>>  - compatible : must be one of :
>> -		"mediatek,mt8173-smi-larb"
>>  		"mediatek,mt2701-smi-larb"
>> +		"mediatek,mt2712-smi-larb"
>> +		"mediatek,mt8173-smi-larb"
>>  - reg : the register and size of this local arbiter.
>>  - mediatek,smi : a phandle to the smi_common node.
>>  - power-domains : a phandle to the power domain of this local arbiter.
>> @@ -15,7 +16,7 @@ Required properties:
>>  	    the register.
>>    - "smi" : It's the clock for transfer data and command.
>>  
>> -Required property for mt2701:
>> +Required property for mt2701 and mt2712:
>>  - mediatek,larb-id :the hardware id of this larb.
>>  
>>  Example:
>> diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
>> new file mode 100644
>> index 0000000..6f9aa73
>> --- /dev/null
>> +++ b/include/dt-bindings/memory/mt2712-larb-port.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2017 MediaTek Inc.
>> + * Author: Yong Wu <yong.wu@mediatek.com>
>> + */
>> +#ifndef __DTS_IOMMU_PORT_MT2712_H
>> +#define __DTS_IOMMU_PORT_MT2712_H
>> +
>> +#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
>> +
>> +#define M4U_LARB0_ID			0
>> +#define M4U_LARB1_ID			1
>> +#define M4U_LARB2_ID			2
>> +#define M4U_LARB3_ID			3
>> +#define M4U_LARB4_ID			4
>> +#define M4U_LARB5_ID			5
>> +#define M4U_LARB6_ID			6
>> +#define M4U_LARB7_ID			7
>> +#define M4U_LARB8_ID			8
>> +#define M4U_LARB9_ID			9
>> +
>> +/* larb0 */
>> +#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
>> +#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
>> +#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
>> +#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 3)
>> +#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 4)
>> +#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
>> +#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 6)
>> +#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB0_ID, 7)
>> +
>> +/* larb1 */
>> +#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB1_ID, 0)
>> +#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB1_ID, 1)
>> +#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB1_ID, 2)
>> +#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 3)
>> +#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB1_ID, 4)
>> +#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB1_ID, 5)
>> +#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 6)
>> +#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB1_ID, 7)
>> +#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB1_ID, 8)
>> +#define M4U_PORT_HW_VDEC_TILE		MTK_M4U_ID(M4U_LARB1_ID, 9)
>> +#define M4U_PORT_HW_IMG_RESZ_EXT	MTK_M4U_ID(M4U_LARB1_ID, 10)
>> +
>> +/* larb2 */
>> +#define M4U_PORT_CAM_DMA0		MTK_M4U_ID(M4U_LARB2_ID, 0)
>> +#define M4U_PORT_CAM_DMA1		MTK_M4U_ID(M4U_LARB2_ID, 1)
>> +#define M4U_PORT_CAM_DMA2		MTK_M4U_ID(M4U_LARB2_ID, 2)
>> +
>> +/* larb3 */
>> +#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
>> +#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
>> +#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
>> +#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
>> +#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
>> +#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 5)
>> +#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 6)
>> +#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
>> +#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
>> +
>> +/* larb4 */
>> +#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB4_ID, 0)
>> +#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 1)
>> +#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB4_ID, 2)
>> +#define M4U_PORT_DISP_OD1_R		MTK_M4U_ID(M4U_LARB4_ID, 3)
>> +#define M4U_PORT_DISP_OD1_W		MTK_M4U_ID(M4U_LARB4_ID, 4)
>> +#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 5)
>> +#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB4_ID, 6)
>> +
>> +/* larb5 */
>> +#define M4U_PORT_DISP_OVL2		MTK_M4U_ID(M4U_LARB5_ID, 0)
>> +#define M4U_PORT_DISP_WDMA2		MTK_M4U_ID(M4U_LARB5_ID, 1)
>> +#define M4U_PORT_MDP_RDMA2		MTK_M4U_ID(M4U_LARB5_ID, 2)
>> +#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB5_ID, 3)
>> +
>> +/* larb6 */
>> +#define M4U_PORT_JPGDEC_WDMA_0		MTK_M4U_ID(M4U_LARB6_ID, 0)
>> +#define M4U_PORT_JPGDEC_WDMA_1		MTK_M4U_ID(M4U_LARB6_ID, 1)
>> +#define M4U_PORT_JPGDEC_BSDMA_0		MTK_M4U_ID(M4U_LARB6_ID, 2)
>> +#define M4U_PORT_JPGDEC_BSDMA_1		MTK_M4U_ID(M4U_LARB6_ID, 3)
>> +
>> +/* larb7 */
>> +#define M4U_PORT_MDP_RDMA3		MTK_M4U_ID(M4U_LARB7_ID, 0)
>> +#define M4U_PORT_MDP_WROT2		MTK_M4U_ID(M4U_LARB7_ID, 1)
>> +
>> +/* larb8 */
>> +#define M4U_PORT_VDO			MTK_M4U_ID(M4U_LARB8_ID, 0)
>> +#define M4U_PORT_NR			MTK_M4U_ID(M4U_LARB8_ID, 1)
>> +#define M4U_PORT_WR_CHANNEL0		MTK_M4U_ID(M4U_LARB8_ID, 2)
>> +
>> +/* larb9 */
>> +#define M4U_PORT_TVD			MTK_M4U_ID(M4U_LARB9_ID, 0)
>> +#define M4U_PORT_WR_CHANNEL1		MTK_M4U_ID(M4U_LARB9_ID, 1)
>> +
>> +#endif
> 
> 
