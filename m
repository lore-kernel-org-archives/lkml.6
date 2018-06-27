Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D7A22AAD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uBehhU3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D7A22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964771AbeF0LSk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:18:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60674 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbeF0LSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:18:39 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 07:18:38 EDT
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RBBCfn114454;
        Wed, 27 Jun 2018 06:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530097872;
        bh=m1a4iL38+byWplFbTSDYLbBF96ii29Sl9nYarUm2xq0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uBehhU3mOwXQw9R29JRUifvNWMaZ13dP+RFmGELT3cR5QvwJLRxVvEaTc8YFQKNmQ
         FyLF540dWeosu7tB/e9+wyusns46er8p0CE2LUGYBG0r9UGRfKvidRPvV38RaBD5tC
         Y0LoXDAGcuYunQCmFQKQjCHkc13p2gVWcXCEQkwY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBBCCZ028997;
        Wed, 27 Jun 2018 06:11:12 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 06:11:11 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 06:11:11 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBB94Y021623;
        Wed, 27 Jun 2018 06:11:10 -0500
Subject: Re: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kevin Hilman <khilman@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-3-david@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
Date:   Wed, 27 Jun 2018 16:41:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531202549.11255-3-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 June 2018 01:55 AM, David Lechner wrote:
> This enables Bluetooth modules in davinic_all_defconfig needed for LEGO

davinci_all_defconfig

> MINDSTORMS EV3.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)

> +CONFIG_SERIAL_DEV_BUS=y

Any reason to build this into the kernel?

Thanks,
Sekhar
