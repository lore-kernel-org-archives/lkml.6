Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA73C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F3220843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VeSEcwHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F3220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIYM03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:26:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45266 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:26:29 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8P6KGar109100;
        Tue, 25 Sep 2018 01:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537856416;
        bh=XvuxGuNyjLJ3XKo+mf3QizG/DmgfB6d2BFP7+8NBWaA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VeSEcwHAhVheiZkclHKdDqsJDeNgLX838OSQPZYvUamVs6dbGO8eL4Dhg6lIX/Gfg
         52aVYMd6JEkRW5/yAEON4Ly13eDDBm6kFgKHv66+xMfRPG4uVPEKAJgNmxMYt61i8R
         pLyNG9jn6IbXQa66Am2tsFX0AqGezFbbFJwT369g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P6KGju009712;
        Tue, 25 Sep 2018 01:20:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 01:20:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 01:20:16 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P6KCRg021805;
        Tue, 25 Sep 2018 01:20:12 -0500
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
Date:   Tue, 25 Sep 2018 11:49:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>> Hi Kishon, Tejun,
>>
>> This patch series adds support for the SATA AHCI and PHY found on the
>> ARM-basd BCM63138 DSL SoCs.
>>
>> It would probably make sense for patches 1-3 to go through Kishon's
>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
>> two patches through the Broadcom ARM-SoC tree.
>>
>> Let me know if this is not a workable plan, thank you very much!
> 
> Looks like I had left patches with the incorrect subject, please
> disregard the following patches:
> 
> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
> DSL SoCs
> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
> 
> since they have incorrect/inconsistent titles, the other patches are
> fine though. Sorry about that.

merged the first 3 patches to linux-phy tree.

Thanks
Kishon
