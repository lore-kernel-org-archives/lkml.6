Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5944E2170F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5944E2170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeHNPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:40:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47200 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbeHNPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:40:23 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7ECrEHP020295;
        Tue, 14 Aug 2018 07:53:14 -0500
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ECrEmQ027676;
        Tue, 14 Aug 2018 07:53:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 07:53:14 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 07:53:14 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ECrBF0025860;
        Tue, 14 Aug 2018 07:53:12 -0500
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To:     Ramon Fried <ramon.fried@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
Date:   Tue, 14 Aug 2018 18:23:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
> Hi.
> I recently saw that the PCI endpoint API only supports outbound memory
> mapping: (AXI -> PCI) through the map_addr op.
> Why inbound mapping is missing (PCI->AXI) is missing ?
> In almost all of the PCI EP controllers I've worked with there was a
> need to map complete BARS or part of BARS to mmio/aperature regions on
> the device.

pci_epc_set_bar() is used for mapping BAR.

Thanks
Kishon
