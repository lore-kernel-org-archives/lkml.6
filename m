Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496F321925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F1wZf7j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbfBOIs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:48:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBOIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:48:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8mMIS009913;
        Fri, 15 Feb 2019 02:48:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550220502;
        bh=Gyk2Q3oXt18BwtJ2h0Yrustu6G0tnn/n4V3TTANsQfg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F1wZf7j75Zw457hYSokjJMUi2DELEW0DBuALGTdiCL9t5Ac20IIzJ/HoX3z4UwLcm
         7QBDtefxAzdb1f8eovAaa2HZZXsHTIsdZru7WjxlfTlZt7CpS2w6L35teXXkKDEC1a
         KCUBot7I3fmFxRxjqfTBc3GWDei20/XHcVGe/urI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8mME2102622
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 02:48:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:48:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:48:21 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8mIPL018285;
        Fri, 15 Feb 2019 02:48:19 -0600
Subject: Re: [PATCH v2 0/3] arm64: ti: k3-am654: USB support
To:     Roger Quadros <rogerq@ti.com>
CC:     <nm@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1549370722-414-1-git-send-email-rogerq@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <d67c23b7-bd1c-c7ae-e878-9437d41e26ff@ti.com>
Date:   Fri, 15 Feb 2019 10:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549370722-414-1-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 14:45, Roger Quadros wrote:
> Hi,
> 
> The AM654 SoC supports 2 DWC3 USB controller instances. The
> AM654 base board supports the 2nd (USB1) instance in high-speed.
> 
> This series enables support for USB1 instance on the AM654-base-board.
> 
> The series depends on [1] and [2]. Both are in the -next branch of their
> respective maintainer trees.
> 
> To test you can apply on top of linux-next. As usb/next was just pushed
> today, it might have not reached linux-next yet. If so please pull that from [3].
> 
> If using arm64 defconfig, you need to enable
> 	CONFIG_USB_DWC3_KEYSTONE=y
> 	CONFIG_OMAP_USB2=y
> and the necessary USB drivers that you want to test. e.g. USB network adapter.
> 
> [1] AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
> [2] AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
> [3] usb-next https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/log/?h=next
> 
> Changelog:
> v2
> - usb & phy nodes are not kept disabled in k3-am65-main.dtsi.
>    Unused ones are disabled in board dts instead.

Series queued for 5.1, thanks.

-Tero

> 
> cheers,
> -roger
> 
> 
> Jyri Sarha (1):
>    arm64: dts: ti: am654: Add Main System Control Module node
> 
> Roger Quadros (2):
>    arm64: dts: ti: k3-am6: add USB support
>    arm64: dts: ti: k3-am654-base-board: enable USB1
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 84 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 28 +++++++++
>   2 files changed, 112 insertions(+)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
