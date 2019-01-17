Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F407DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21DA20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2Eu5a95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfAQPBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:01:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfAQPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:01:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0HF0s0U002070;
        Thu, 17 Jan 2019 09:00:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547737254;
        bh=rdGQk9n2YzbzcczW3hOu0Ip4buEmlda/DN4Kz6Lt+Y4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=A2Eu5a95wECgOPvbNyIpTeppAXFwQZU1fBsfB1MrdONwwu3Njia0ON4Wc8+pylKGc
         wHZlPlYRXY+Gi+zGmkG2Ckc/kjz8gMpwt31DCSMz9vJBXcyQc156KqJnyFpo1b04zk
         eqdZFEaj+stfp0O2pt+Rap9VmIa9JVz/y0MMAMg0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0HF0sKj108553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:00:54 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 09:00:54 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 09:00:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0HF0rC6003734;
        Thu, 17 Jan 2019 09:00:53 -0600
Date:   Thu, 17 Jan 2019 09:00:53 -0600
From:   Bin Liu <b-liu@ti.com>
To:     <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Subject: Re: [PATCH v3 0/4] Add MediaTek MUSB Controller Driver
Message-ID: <20190117150053.GH18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:15:44PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> These patches introduce the MediaTek MUSB controller driver.
> 
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only modes. This has beed tested on
> MT2701 with a variety of devices in host mode and with the 
> f_mass gadget driver in peripheral mode, plugging otg cables
> in/out a lot of times in all possible imaginable plug orders.
> 
> changes in v3:

Please put the change log in each individual patch, which helps in
viewing patches.

Regards,
-Bin.
