Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C78C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23588214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ahPoliL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23588214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeJTQDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:03:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33488 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeJTQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:03:42 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9K7ri5X023864;
        Sat, 20 Oct 2018 02:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540022024;
        bh=YKh40aMTxBP51Wa6pTNfJxX2D4M9iL0nr5RPlS+qyfI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ahPoliL/K6/PZRq/TPCjGWNQknCA44PNF5DZXGZdERbroN8s9yKpk9AVoeTy25G0p
         dtVBEALT+uBzyysioa4Dmx1D+fkU9EIK4fmfUnkrvnuyoxr6ujsmYKyaGJt8YxPU5y
         mztaknkr8DC88MR665S+gzsFHr/JpcJNNuU7SRKs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9K7riRx017065;
        Sat, 20 Oct 2018 02:53:44 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 20
 Oct 2018 02:53:44 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 20 Oct 2018 02:53:44 -0500
Received: from [172.22.218.57] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9K7reBD017098;
        Sat, 20 Oct 2018 02:53:41 -0500
Subject: Re: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180928052557.21663-1-vigneshr@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com>
Date:   Sat, 20 Oct 2018 13:23:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928052557.21663-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-Sep-18 10:55 AM, Vignesh R wrote:
> Couple of patches to enable i2c-omap driver to be used with TI's new
> AM654 platforms.
> 
> 
> Vignesh R (2):
>   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
>   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
> 
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>  drivers/i2c/busses/Kconfig                         | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 

Gentle ping...

Regards
Vignesh
