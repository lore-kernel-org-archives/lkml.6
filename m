Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F2821873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dPwtXqhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeLRPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:52:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56042 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLRPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:52:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBIFpIWd125353;
        Tue, 18 Dec 2018 09:51:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545148278;
        bh=PqxrPyIuAqdAT+svYzC+6UTzwE5NisjnkqGf6S7SbYE=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=dPwtXqhgYXE+rMr8sznG2YesrDAsst0kWWD7Wjo28uZXpGEGrKm0vHJk+d5PFnpUe
         RtcS6M+Qr43bgztWkRFTNqj67YS+nikqkVbsdqWuiXFjf6Xk8BA5c8A/w5Lu93gs+y
         aakGkO8qRd1RqFFfLOFP2iLbLRkHPKXVL8BtABZA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBIFpIua033006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 09:51:18 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 18
 Dec 2018 09:51:17 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 18 Dec 2018 09:51:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBIFpDXY031387;
        Tue, 18 Dec 2018 09:51:13 -0600
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C191770.9090804@ti.com>
Date:   Tue, 18 Dec 2018 17:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5BFFBCAC.9000004@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark

David,

On 29/11/18 12:17, Roger Quadros wrote:
> On 27/11/18 00:37, David Lechner wrote:
>> On 11/26/18 1:52 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The remoteproc core creates certain standard debugfs entries,
>>> that does not give a whole lot of useful information for the
>>> PRUs. The PRU remoteproc driver is enhanced to add additional
>>> debugfs entries for PRU. These will be auto-cleaned up when
>>> the parent rproc debug directory is removed.
>>>
>>> The enhanced debugfs support adds two new entries: 'regs' and
>>> 'single_step'. The 'regs' dumps out the useful CTRL sub-module
>>> registers as well as each of the 32 GPREGs and CT_REGs registers.
>>> The GPREGs and CT_REGs though are printed only when the PRU is
>>> halted and accessible as per the IP design.
>>>
>>
>> If the driver used regmap to access the CTRL I/O memory, then
>> 'regs' wouldn't be needed since regmap already does debugfs.
>>
> 
> ok, we could split out CTRL from this and use regmap.
> 

I was thinking of using regmap for both control and debug
but regmap_mmio only supports one iomap even though it supports
multiple ranges.

What can we do here?

The control and debug regions even though separate are right
next to each other

reg = <0x34000 0x3000>,
	<0x22000 0x400>,
	<0x22400 0x100>;
reg-names = "iram", "control", "debug";

We could combine control and debug into one iomap and use
2 regmap ranges. But this is really working around the
regmap_mmio limitation of not being able to use more than one ioremaps.

Mark, any suggestions?

Is it meaningful to support __devm_regmap_init_mmio_clk()
with separate iomem regions for the ranges?

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
