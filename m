Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAACC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40F7208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i9qxwkrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40F7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeF1EPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:15:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59102 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeF1EPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:15:30 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5S4FMLF070111;
        Wed, 27 Jun 2018 23:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530159322;
        bh=xZFvuwVFKa2BKYiYNB5KHeuCqEhxcNrImCLX7nMNWCg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=i9qxwkrIy7LmnTkBF9Yh45iKmqaOOZMHVlPI0vWR7ELtXFilLch9X8pCkr1/7XBMo
         9ykU906TgYXPRI5uySCnYAHAtreOF3+SezSmaXqREMixvlH0EaC9pisqpq7RuP83Zp
         Evy1qP0LUJZUaURahGfH+BS1+PPnOAtpUpMRwFRo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5S4FM81005030;
        Wed, 27 Jun 2018 23:15:22 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 23:15:21 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 23:15:21 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5S4FJgX024762;
        Wed, 27 Jun 2018 23:15:19 -0500
Subject: Re: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
To:     Santosh Shilimkar <ssantosh@kernel.org>
References: <20180622101617.11157-1-kishon@ti.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
Date:   Thu, 28 Jun 2018 09:45:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh,

On Friday 22 June 2018 03:46 PM, Kishon Vijay Abraham I wrote:
> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
> binding.
> 
> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
> Everyone who use a custom .config should also enable
> CONFIG_MMC_SDHCI_OMAP for MMC to work.

Can this series be merged?

Thanks
Kishon
