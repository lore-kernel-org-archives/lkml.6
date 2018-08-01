Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB9EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B607208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H1HLylfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B607208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbeHANN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:13:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45602 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388464AbeHANN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:13:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w71BRvNX002300;
        Wed, 1 Aug 2018 06:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533122877;
        bh=G25mBoRDpjjYlaBadScCg9IduHrzT73FfIQG5nDw0hE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H1HLylfb3v0q2g1VMogHiiBt0JHtOss65YgqXiw5+wvpinzxVgaydTylN6lG/2hb+
         9kCxftYVHZn2L6H4eHcaTV5z59z7uPPgZq66gwgwU6Cs14NheIBViDlMfsHP/4iqJM
         78ia9MOJkn/kj2pB2ECDKfD2W4XjbvxSVCD+3Isk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w71BRvhr019929;
        Wed, 1 Aug 2018 06:27:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 1 Aug
 2018 06:27:57 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 1 Aug 2018 06:27:57 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w71BRtCE005672;
        Wed, 1 Aug 2018 06:27:55 -0500
Subject: Re: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <82e8093d-eb6b-ea04-7d36-54ee27df3e06@ti.com>
Date:   Wed, 1 Aug 2018 14:27:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 19/07/18 20:57, Pawel Laszczak wrote:
> This patch set introduce new Cadence USBSSP DRD driver
> to linux kernel.
> 
> The Cadence USBSSP DRD Driver s a highly
> configurable IP Core which can be
> instantiated as Dual-Role Device (DRD),
> Peripheral Only and Host Only (XHCI)
> configurations.
> 
> The current driver has been validated with
> FPGA burned. We have support for PCIe
> bus, which is used on FPGA prototyping.
> 
> The host site of USBSSP controller is compliance
> with XHCI specification, so it works with
> standard XHCI linux driver.
> 
> Also, device side of USBSSP controller was designed
> in such way to looks like XHCI. It means that
> most of logic of USBSSP controller is also compliance
> with XHCI specification.
> 
> Consequently, the USBSSP driver for peripheral mode
> is very similar to XHCI driver.
> 
> This version of driver supports only Device mode but
> DRD and Host mode will be added in the future.
> 

Based on the posting date this series looks like v3.

You should add the version prefix to the patches next time.
e.g. [PATCH v4 ...]

It is also recommended to add a Change-log in the cover letter
explaining what changes were made in each revision.

There are a bunch of checkpatch warnings in this series.
You can use ./scripts/checkpatch.pl on the patches and fix the
issues.

> ---
> 
> Pawel Laszczak (31):
>   usb: usbssp: Defined register maps and other useful structures.
>   usb: usbssp: Added some decoding functions.
>   usb: usbssp: Add trace events used in driver
>   usb: usbssp: Added USBSSP platform driver
>   usb: usbssp: Added first part of initialization sequence.
>   usb: usbssp: added template functions used by upper layer.
>   usb: usbssp: Initialization - added usbssp_mem_init
>   usb: usbssp: Added ring and segment handling functions.
>   usb: usbssp: add implementation of usbssp_mem_cleanup
>   usb: usbssp: added usbssp_trb_in_td function.
>   usb: usbssp: added function for stopping driver.
>   usb: usbssp: added functions for queuing commands.
>   usb: usbssp: addec procedure for handlin Port Status Change events.
>   usb: usbssp: added procedure handling command completion events.
>   usb: usbssp: added device controller error, transfer and SETUP
>     completion event.
>   usb: usbssp: added connect/disconnect procedures.
>   usb: usbssp: added implementation of usbssp_halt_endpoint function.
>   usb: usbssp: added handling of Port Reset event.
>   usb: usbssp: added support for USB enumeration process.
>   usb: usbssp: added queuing procedure for control transfer.
>   usb: usbssp: added queuing procedure for BULK and INT transfer.
>   usb: usbssp: added procedure removing request from transfer ring
>   usb: usbssp: added implementation of transfer events.
>   usb: usbssp: added detecting command timeout.
>   usb: usbssp: added implementation of usbssp interface.
>   usb: usbssp: added endpoint configuration functionality.
>   usb: usbssp: implements usbssp_gadget_ep_enable function
>   usb: usbssp: implemented usbssp_gadget_ep_disable function.
>   usb: usbssp: added support for LPM.
>   usb: usbssp: added support for TEST_MODE.
>   usb: usbssp: add pci to platform driver wrapper.
> 
>  drivers/usb/Kconfig                  |    2 +
>  drivers/usb/Makefile                 |    2 +
>  drivers/usb/usbssp/Kconfig           |   29 +
>  drivers/usb/usbssp/Makefile          |   15 +
>  drivers/usb/usbssp/gadget-dbg.c      |   39 +
>  drivers/usb/usbssp/gadget-ep0.c      |  571 +++++
>  drivers/usb/usbssp/gadget-ext-caps.h |  102 +
>  drivers/usb/usbssp/gadget-if.c       |  569 +++++
>  drivers/usb/usbssp/gadget-mem.c      | 1938 +++++++++++++++
>  drivers/usb/usbssp/gadget-port.c     |  287 +++
>  drivers/usb/usbssp/gadget-ring.c     | 3452 ++++++++++++++++++++++++++
>  drivers/usb/usbssp/gadget-trace.c    |   13 +
>  drivers/usb/usbssp/gadget-trace.h    |  482 ++++
>  drivers/usb/usbssp/gadget.c          | 1909 ++++++++++++++
>  drivers/usb/usbssp/gadget.h          | 2373 ++++++++++++++++++
>  drivers/usb/usbssp/usbssp-pci-wrap.c |  226 ++
>  drivers/usb/usbssp/usbssp-plat.c     |  186 ++
>  17 files changed, 12195 insertions(+)
>  create mode 100644 drivers/usb/usbssp/Kconfig
>  create mode 100644 drivers/usb/usbssp/Makefile
>  create mode 100644 drivers/usb/usbssp/gadget-dbg.c
>  create mode 100644 drivers/usb/usbssp/gadget-ep0.c
>  create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
>  create mode 100644 drivers/usb/usbssp/gadget-if.c
>  create mode 100644 drivers/usb/usbssp/gadget-mem.c
>  create mode 100644 drivers/usb/usbssp/gadget-port.c
>  create mode 100644 drivers/usb/usbssp/gadget-ring.c
>  create mode 100644 drivers/usb/usbssp/gadget-trace.c
>  create mode 100644 drivers/usb/usbssp/gadget-trace.h
>  create mode 100644 drivers/usb/usbssp/gadget.c
>  create mode 100644 drivers/usb/usbssp/gadget.h
>  create mode 100644 drivers/usb/usbssp/usbssp-pci-wrap.c
>  create mode 100644 drivers/usb/usbssp/usbssp-plat.c
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
