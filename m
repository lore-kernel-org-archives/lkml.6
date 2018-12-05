Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0D208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jZxGtCDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeLEPTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:19:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33258 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:19:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5FIwbD072795;
        Wed, 5 Dec 2018 09:18:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544023138;
        bh=3USVK6RT8NoK4DD/hiOT81RkZBnnclUcqfNzMAQ5lJw=;
        h=Subject:References:CC:From:Date:In-Reply-To;
        b=jZxGtCDm4a8wFBQOM2I5Xk6EKVWs4/cPYg0YID621ie3qBRKMOVrbS589YzLupjWn
         1V1RMPU3QWn2ZnMQGTXGU8kceh3xaV0gVpbOqA0pze46C4X18aLEi1es05LgnAqhi+
         PUOpccSJcV1CeRaWCrnGPY3vHcHsgL+6eJ45xNL4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5FIwVb100685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 09:18:58 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 09:18:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 09:18:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FIuVW001748;
        Wed, 5 Dec 2018 09:18:56 -0600
Subject: Re: [PATCH 0/3] usb: dwc3: Add support for AM654 USB
References: <1544022879-5704-1-git-send-email-rogerq@ti.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C07EC5F.1030405@ti.com>
Date:   Wed, 5 Dec 2018 17:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1544022879-5704-1-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misspelled Felipe's ID. Will resend this series.

On 05/12/18 17:14, Roger Quadros wrote:
> Hi Felipe,
> 
> TI's AM654 USB SoC has 2 instances of the DWC3 controller.
> This series adds AM654 USB wrapper support to the keystone-usb driver.
> 
> cheers,
> -roger
> 
> Roger Quadros (3):
>   usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
>   dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
>   usb: dwc3: keystone: Add support for ti,am654-dwc3
> 
>  Documentation/devicetree/bindings/usb/keystone-usb.txt |  4 ++--
>  drivers/usb/dwc3/Kconfig                               |  6 +++---
>  drivers/usb/dwc3/dwc3-keystone.c                       | 11 ++++++++++-
>  drivers/usb/dwc3/gadget.c                              |  2 ++
>  4 files changed, 17 insertions(+), 6 deletions(-)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
