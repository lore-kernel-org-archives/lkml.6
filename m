Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12125C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60EF22360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60EF22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeKLUGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:06:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33270 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:06:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACADZIM087825;
        Mon, 12 Nov 2018 04:13:35 -0600
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACADZHR058071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 04:13:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 04:13:35 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 04:13:35 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACADXS8006807;
        Mon, 12 Nov 2018 04:13:33 -0600
Subject: Re: [PATCH v2 0/2] phy: cadence: Add driver and dt-bindings for
 Sierra PHY
To:     Alan Douglas <adouglas@cadence.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <1541003618-25806-1-git-send-email-adouglas@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c90ce7bc-f8d8-42ba-bb38-28656436d0d8@ti.com>
Date:   Mon, 12 Nov 2018 15:43:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541003618-25806-1-git-send-email-adouglas@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 31/10/18 10:03 PM, Alan Douglas wrote:
> The Cadence Sierra PHY supports a number of different protocols.  This
> series adds a driver with support for USB3 and PCIe modes.
> 
> Only one clock frequency is currently supported, so the value of clock
> provided in device tree is ignored.
> 
> Changes since v1:
> * Moved subnode resets into each subnode in devicetree bindings
> * Modified driver to put subnode resets on exit
> * Changed driver filename to phy-cdns-sierra.c
> 
> Changes since RFC v2:
> * Devicetree bindings modified as suggested by Rob Herring.
> * Tidy up and correction of return paths in probe function.
> 
> Changes since RFC v1:
> * Each group of lanes is now treated as a subnode, and a generic PHY
>   device is created for each group.
> * General cleanup based on comments
> * A reset is now required for each subnode.  The complete PHY block
>   is taken out of reset at initial probe, and remains out of reset.
> * Added a binding to allow for hardware configuration of PHY registers

It's not applying to my -next. Can you rebase this series to -rc1?

Thanks
Kishon
> 
> 
> Alan Douglas (2):
>   dt-bindings: phy: Document cadence Sierra PHY bindings
>   phy: cadence: Add driver for Sierra PHY
> 
>  .../devicetree/bindings/phy/cdns-sierra-phy.txt    |  68 ++++
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/cadence/Kconfig                        |   9 +
>  drivers/phy/cadence/Makefile                       |   2 +
>  drivers/phy/cadence/phy-cdns-sierra.c              | 395 +++++++++++++++++++++
>  6 files changed, 476 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
>  create mode 100644 drivers/phy/cadence/Kconfig
>  create mode 100644 drivers/phy/cadence/Makefile
>  create mode 100644 drivers/phy/cadence/phy-cdns-sierra.c
> 
