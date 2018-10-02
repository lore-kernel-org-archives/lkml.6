Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E6C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26FC2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJBHb/wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26FC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJBRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:45:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJBRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:45:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1732071wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rD6Bf0eRV5TzkZpX3VScfy5sgHzXSNC3vAprJpA9r4g=;
        b=SJBHb/wmu7JlbqBaOCMwXI4XJDq3/zNI1GnwfMXZEwjICLigcWi0dRYhdg8sfC1jIt
         w3kfik8RqzRiDbwNHCLtrkAlU24k1s3ELlfzN1JZC9uR5FXgiu0S4eyIOL/V3aBo22Wi
         R60Skv6gMZWfsOKnZquxRISIl/2JMANdIuIHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rD6Bf0eRV5TzkZpX3VScfy5sgHzXSNC3vAprJpA9r4g=;
        b=sEKsxIXcnn7BTyWd6mJZ+FsV9iKKYCqj5s5ijc9N1h+9FlXY3rkMsI/eBACB1l1tNW
         wQLndoL8FFHQtZrCFDFT/ckNAxyVTJSBj/or+Snn2haJ0B1LtJjKnhVUHbqSKLSJG7nh
         0NW09JN6YnlMSK1bxoqvIWsplSLZOdj1mvuHKAnkghu7RriF3RGpc+uqM7GzARWWkcBy
         vHItZyvZGfh508GwNIZjr0jcckySqIpE/PfYoHiXWWuDEkRmjG2M6pUv27UEHUbGgeIz
         XEzEXkggfHeS/XJEv9wCbop/PgjBQNa8ZfKv1NvewEFabz0yygKOvb8csm/fLS8xgk4q
         tWkg==
X-Gm-Message-State: ABuFfoit9ikjdlzugQqwLJMKtWNqnUg+R8KQD5uG4L8ruZhA+3f7Yr6k
        Hdn3M5vUOsXMv835By9es1ANeQ==
X-Google-Smtp-Source: ACcGV62xxGysA4U79lNOrTsxCNaGElWDIQda6sX9gMZQeiL65EBikYDSrRpSd87QNog2gz4eWzSI5A==
X-Received: by 2002:a1c:f10a:: with SMTP id p10-v6mr1421792wmh.127.1538478180191;
        Tue, 02 Oct 2018 04:03:00 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y4-v6sm19260819wrd.25.2018.10.02.04.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 04:02:59 -0700 (PDT)
Subject: Re: [PATCH v9 6/8] dt-bindings: interconnect: Document qcom,msm8916
 NoC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-7-georgi.djakov@linaro.org>
 <20180925182217.GA15771@bogus>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABzShHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+wsF+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH87BTQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AcLBZQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <9c736b9e-5595-9c12-b995-d67085e46aca@linaro.org>
Date:   Tue, 2 Oct 2018 14:02:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180925182217.GA15771@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09/25/2018 09:22 PM, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 05:01:49PM +0300, Georgi Djakov wrote:
>> Document the device-tree bindings of the Network-On-Chip interconnect
>> hardware found on Qualcomm msm8916 platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom-msm8916.txt    | 41 ++++++++
>>  include/dt-bindings/interconnect/qcom.h       | 98 +++++++++++++++++++
>>  2 files changed, 139 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
>>  create mode 100644 include/dt-bindings/interconnect/qcom.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
>> new file mode 100644
>> index 000000000000..744df51df4ed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
>> @@ -0,0 +1,41 @@
>> +Qualcomm MSM8916 Network-On-Chip interconnect driver binding
>> +----------------------------------------------------
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +			"qcom,msm8916-bimc"
>> +			"qcom,msm8916-pnoc"
>> +			"qcom,msm8916-snoc"
>> +- #interconnect-cells : should contain 1
>> +- reg : shall contain base register location and length
>> +
>> +Optional properties :
>> +clocks : list of phandles and specifiers to all interconnect bus clocks
>> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
>> +
>> +Examples:
>> +
>> +		snoc: snoc@580000 {
> 
> interconnect@...

Ok.

> 
>> +			compatible = "qcom,msm8916-snoc";
>> +			#interconnect-cells = <1>;
>> +			reg = <0x580000 0x14000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +		};
>> +		bimc: bimc@400000 {
> 
> interconnect@...

Ok.

> 
>> +			compatible = "qcom,msm8916-bimc";
>> +			#interconnect-cells = <1>;
>> +			reg = <0x400000 0x62000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +		};
>> +		pnoc: pnoc@500000 {
> 
> and here.

Ok.

> 
>> +			compatible = "qcom,msm8916-pnoc";
>> +			#interconnect-cells = <1>;
>> +			reg = <0x500000 0x11000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
>> +		};
>> diff --git a/include/dt-bindings/interconnect/qcom.h b/include/dt-bindings/interconnect/qcom.h
>> new file mode 100644
>> index 000000000000..48f944b30e5d
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom.h
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Qualcomm interconnect IDs
>> + *
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_H
>> +
>> +#define BIMC_SNOC_MAS			1
>> +#define BIMC_SNOC_SLV			2
>> +#define MASTER_AMPSS_M0			3
>> +#define MASTER_BLSP_1			4
>> +#define MASTER_CRYPTO_CORE0		5
>> +#define MASTER_DEHR			6
>> +#define MASTER_GRAPHICS_3D		7
>> +#define MASTER_JPEG			8
>> +#define MASTER_LPASS			9
>> +#define MASTER_MDP_PORT0		10
>> +#define MASTER_QDSS_BAM			11
>> +#define MASTER_QDSS_ETR			12
>> +#define MASTER_SDCC_1			13
>> +#define MASTER_SDCC_2			14
>> +#define MASTER_SNOC_CFG			15
>> +#define MASTER_SPDM			16
>> +#define MASTER_TCU_0			17
>> +#define MASTER_TCU_1			18
>> +#define MASTER_USB_HS			19
>> +#define MASTER_VFE			20
>> +#define MASTER_VIDEO_P0			21
>> +#define PNOC_INT_0			22
>> +#define PNOC_INT_1			23
>> +#define PNOC_M_0			24
>> +#define PNOC_M_1			25
>> +#define PNOC_SLV_0			26
>> +#define PNOC_SLV_1			27
>> +#define PNOC_SLV_2			28
>> +#define PNOC_SLV_3			29
>> +#define PNOC_SLV_4			30
>> +#define PNOC_SLV_8			31
>> +#define PNOC_SLV_9			32
>> +#define PNOC_SNOC_MAS			33
>> +#define PNOC_SNOC_SLV			34
>> +#define SLAVE_AMPSS_L2			35
>> +#define SLAVE_BIMC_CFG			36
>> +#define SLAVE_BLSP_1			37
>> +#define SLAVE_BOOT_ROM			38
>> +#define SLAVE_CAMERA_CFG		39
>> +#define SLAVE_CATS_128			40
>> +#define SLAVE_CLK_CTL			41
>> +#define SLAVE_CRYPTO_0_CFG		42
>> +#define SLAVE_DEHR_CFG			43
>> +#define SLAVE_DISPLAY_CFG		44
>> +#define SLAVE_EBI_CH0			45
>> +#define SLAVE_GRAPHICS_3D_CFG		46
>> +#define SLAVE_IMEM_CFG			47
>> +#define SLAVE_LPASS			48
>> +#define SLAVE_MPM			49
>> +#define SLAVE_MSM_PDM			50
>> +#define SLAVE_MSM_TCSR			51
>> +#define SLAVE_MSS			52
>> +#define SLAVE_OCMEM_64			53
>> +#define SLAVE_PMIC_ARB			54
>> +#define SLAVE_PNOC_CFG			55
>> +#define SLAVE_PRNG			56
>> +#define SLAVE_QDSS_CFG			57
>> +#define SLAVE_QDSS_STM			58
>> +#define SLAVE_RBCPR_CFG			59
>> +#define SLAVE_RPM_MSG_RAM		60
>> +#define SLAVE_SDCC_1			61
>> +#define SLAVE_SDCC_4			62
>> +#define SLAVE_SECURITY			63
>> +#define SLAVE_SERVICE_SNOC		64
>> +#define SLAVE_SNOC_CFG			65
>> +#define SLAVE_SPDM			66
>> +#define SLAVE_SYSTEM_IMEM		67
>> +#define SLAVE_TLMM			68
>> +#define SLAVE_USB_HS			69
>> +#define SLAVE_VENUS_CFG			70
>> +#define SNOC_BIMC_0_MAS			71
>> +#define SNOC_BIMC_0_SLV			72
>> +#define SNOC_BIMC_1_MAS			73
>> +#define SNOC_BIMC_1_SLV			74
>> +#define SNOC_INT_0			75
>> +#define SNOC_INT_1			76
>> +#define SNOC_INT_BIMC			77
>> +#define SNOC_MM_INT_0			78
>> +#define SNOC_MM_INT_1			79
>> +#define SNOC_MM_INT_2			80
>> +#define SNOC_MM_INT_BIMC		81
>> +#define SNOC_PNOC_MAS			82
>> +#define SNOC_PNOC_SLV			83
>> +#define SNOC_QDSS_INT			84
>> +#define SYSTEM_SLAVE_FAB_APPS		85
> 
> Each of the 3 providers in the example should have their own number 
> space. This looks like you have combined them all. Though that is hard 
> to tell because I can't really decipher the naming convention 
> completely.

That's the plan. Thanks for reviewing!

BR,
Georgi
