Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D3C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665120989
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fF6/d6LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6665120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLIIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 03:46:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55938 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 03:46:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB98kO2c030035;
        Sun, 9 Dec 2018 02:46:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544345184;
        bh=R9eQ3jQUekd6o7D3neeAAWPThzzT7LRiEA5oOJYqaCY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fF6/d6LN8j0UDafLNM73wgrG4E3Ua2z13BlLh8I+TP3fHr2u3gICeC12ZS+/bh3K8
         yFzjV+QvP2BOcZ0JGooi0pnILcmZdURLTOGp2+Q6LrlZUee26h7kqL0QJJYIY1HeT/
         h+2wzUZH3U4ImvII/aDur0CbOJ6Ni7oqJUGEjVAE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB98kOR3076583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Dec 2018 02:46:24 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 9
 Dec 2018 02:46:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 9 Dec 2018 02:46:24 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB98kLjk021292;
        Sun, 9 Dec 2018 02:46:22 -0600
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003165603.2579-1-vigneshr@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <0e4286ea-85d1-a909-17c0-47f9506b3e5a@ti.com>
Date:   Sun, 9 Dec 2018 14:17:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181003165603.2579-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 03/10/18 10:26 PM, Vignesh R wrote:
> This series adds support for octal mode of mt35x flash. Also, adds
> support for OSPI version of Cadence QSPI controller.
> 
> Based on top of patches adding basic support for mt35xu512aba here:
> https://patchwork.ozlabs.org/cover/971437/
> 
> Vignesh R (3):
>   mtd: spi-nor: Add Octal mode support for mt35xu512aba


>   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
>   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller

Could you consider above two patches for v4.21 once [1][2] are merged?

[1] https://patchwork.ozlabs.org/patch/1006717/
[2] https://patchwork.ozlabs.org/patch/1006715/

Let me know if this needs to be re-posted.

> 
>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
>  drivers/mtd/spi-nor/spi-nor.c                         | 11 ++++++++++-
>  include/linux/mtd/spi-nor.h                           |  2 ++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 

-- 
Regards
Vignesh
