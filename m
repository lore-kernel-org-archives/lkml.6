Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F86C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4212721741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s7qwNPTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4212721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHNPvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:51:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:51:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7ED4U7X027759;
        Tue, 14 Aug 2018 08:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534251870;
        bh=0ns/vPNcf0seHydL6baJK872eNELaT860sSOLbDtqvU=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=s7qwNPTzGYb2f27MudaWd6zfZMxLYzwFpWqEmEplhvpFPgrNwuB/fI4fbUNmJxoS4
         YupfnKXXMtyK9RywrsNlOwBOmRidtXpIEPQIg542Ml/4+Mk6xZLHqnawjXCkWgXIvx
         vyv7cnMbufGr2npNILihQaEYh3grsf+OI2YoD/MI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ED4UY2014363;
        Tue, 14 Aug 2018 08:04:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 08:04:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 08:04:30 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ED4Rw5002121;
        Tue, 14 Aug 2018 08:04:28 -0500
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To:     Ramon Fried <ramon.fried@gmail.com>
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
 <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3ffbd957-a62f-b1ec-63b9-4ab3e03c8873@ti.com>
Date:   Tue, 14 Aug 2018 18:34:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 14 August 2018 06:25 PM, Ramon Fried wrote:
> On Tue, Aug 14, 2018 at 1:53 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi,
>>
>> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
>>> Hi.
>>> I recently saw that the PCI endpoint API only supports outbound memory
>>> mapping: (AXI -> PCI) through the map_addr op.
>>> Why inbound mapping is missing (PCI->AXI) is missing ?
>>> In almost all of the PCI EP controllers I've worked with there was a
>>> need to map complete BARS or part of BARS to mmio/aperature regions on
>>> the device.
>>
>> pci_epc_set_bar() is used for mapping BAR.
> Thanks Kishon.
> what about address mapping ? Synopsys has this functionality if I
> recall correctly.

The addresses that the RC will put in BAR's is not known while we initialize
the endpoint. So we really can't map BAR's PCI address to an inbound address
while EP initialization.

I think some older version of Synopsys had this (and didn't have BAR mapping).
Actually TI's K2G had this IP. However the ATU registers here are mapped to
BAR0. So the host side PCI driver can program the PCI address (that the RC has
allocated for BARs) in ATU.

Thanks
Kishon
