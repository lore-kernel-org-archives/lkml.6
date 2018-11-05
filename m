Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA2CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1073920831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jch0orA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1073920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeKEPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:43:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36020 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbeKEPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:43:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA56PBCB035927;
        Mon, 5 Nov 2018 00:25:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541399111;
        bh=0PppT9mIaehdR4ZaC0+tEzCfp+TKjPHiJwNnjg6c5WY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Jch0orA/z5rv2CM5RY+A/+eh6BA4An5lNM7ID1FAW3HxSipxV1sLUmNx1NlRMsESN
         CDLF+4E4Iz5WnZXj42+Yzza6rQNMO4pPdsfVplo1s9sLdKMpfoCOePXd+xX6b9Vgp4
         1bXBziHKczc4gG1alFe4oCyigZPVv7rFNAxPWtZo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA56PB8P036073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 00:25:11 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 5 Nov
 2018 00:25:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 5 Nov 2018 00:25:11 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA56P8Fp031313;
        Mon, 5 Nov 2018 00:25:08 -0600
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kishon@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
Date:   Mon, 5 Nov 2018 11:57:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Saturday 03 November 2018 03:06 PM, Marc Kleine-Budde wrote:
> On 11/02/2018 08:26 PM, Faiz Abbas wrote:
>> In some subsystems (eg. CAN) the physical layer capabilities are
>> the limiting factor in the datarate of the device. Typically, the
>> physical layer transceiver does not provide a way to discover this
>> limitation at runtime. Thus this information needs to be represented as
>> a phy attribute which is read from the device tree.
>>
>> Therefore, add an optional max_bitrate attribute to the generic phy
>> sybsystem. Also add the complementary API which enables the consumer
>> to get max_bitrate.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> NACK - We already have such a functionality in the CAN subsystem.
> Please have a look at the patches:
> 
> e759c626d826 can: m_can: Support higher speed CAN-FD bitrates
> b54f9eea7667 dt-bindings: can: m_can: Document new can transceiver binding
> 2290aefa2e90 can: dev: Add support for limiting configured bitrate
> 54a7fbcc17bc dt-bindings: can: can-transceiver: Document new binding
> 

I remove the transceiver child node binding documentation in patch 5/6.

The existing implementation is pretty limiting as it just has a child
node with no associated device. What if a transceiver requires its own
configurations before it can start sending/receiving messages (for
example, my usecase requires it to pull the standby line low)?

I think that can be solved by implementing the transceiver as a phy and
exposing a generic get_max_bitrate API. That way, the transceiver device
can do all its startup configuration in the phy probe function.

In any case, do suggest if you have a better idea on how to implement
pull gpio low requirement.

Thanks,
Faiz
