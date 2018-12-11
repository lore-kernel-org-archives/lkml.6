Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC00C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D75C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLKJkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:40:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52614 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLKJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:40:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBB9dqJ1085157;
        Tue, 11 Dec 2018 03:39:52 -0600
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBB9dqEu079262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 03:39:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 03:39:51 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 03:39:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBB9dmPO012459;
        Tue, 11 Dec 2018 03:39:49 -0600
Subject: Re: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <balbi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C0F85E4.10609@ti.com>
Date:   Tue, 11 Dec 2018 11:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1544445555-17325-3-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 10/12/18 14:39, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver
> to linux kernel.
> 
> The Cadence USBSS DRD Driver is a highly
> configurable IP Core which can be
> instantiated as Dual-Role Device (DRD),
> Peripheral Only and Host Only (XHCI)
> configurations.
> 
> The current driver has been validated with
> FPGA burned. We have support for PCIe
> bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance
> with XHCI specification, so it works with
> standard XHCI linux driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   44 +
>  drivers/usb/cdns3/Makefile         |   16 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  157 +++
>  drivers/usb/cdns3/core.c           |  451 +++++++
>  drivers/usb/cdns3/core.h           |  108 ++
>  drivers/usb/cdns3/debug.h          |  346 ++++++
>  drivers/usb/cdns3/debugfs.c        |  168 +++
>  drivers/usb/cdns3/drd.c            |  315 +++++
>  drivers/usb/cdns3/drd.h            |  129 ++
>  drivers/usb/cdns3/ep0.c            |  864 +++++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 1802 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1177 ++++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   74 ++
>  drivers/usb/cdns3/trace.c          |   11 +
>  drivers/usb/cdns3/trace.h          |  343 ++++++

You went to the other extreme of combining everything (host/gadget/drd) together
which again makes this very hard to review.

I think what Felipe meant was to only combine the gadget driver code into one patch.

The series could be split into 6 patches like so.
-dt binding
-pci glue
-core driver
-host driver
-gadget driver
-drd driver

>  19 files changed, 6065 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
> 
<snip>

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
