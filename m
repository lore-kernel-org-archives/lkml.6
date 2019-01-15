Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF4E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vn06AA/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfAOOdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:33:42 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfAOOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:33:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEXdMY108286;
        Tue, 15 Jan 2019 08:33:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547562819;
        bh=9Gtv9agAugy5zPFMqFW2P3jNSSC8INY6j5BCjE8sIyo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Vn06AA/SOf142E4sAB/uo4aG2fEyblO7RRj0OfOYzAoDh8ZWdCCZxULqX5Qxm/ggD
         RR9sSHN1SdSenOa7rCVq2t/GhNBz4sxX1aYZBq71N4kTpqOHuNsKlPPcgst53X76YC
         Q0BtGUc7Ae6tGTCDGhWnXBIoO17gGcXKAtEc9h28=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEXdiZ058053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:33:39 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:33:39 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:33:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEXdh9022713;
        Tue, 15 Jan 2019 08:33:39 -0600
Date:   Tue, 15 Jan 2019 08:33:06 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: ti: k3-am654: USB support
Message-ID: <20190115143306.wub3y2c2zsq7byy5@kahuna>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547200861-17795-1-git-send-email-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:00-20190111, Roger Quadros wrote:
> Hi,
> 
> The AM654 SoC supports 2 DWC3 USB controller instances. The
> AM654 base board supports the 2nd (USB1) instance in high-speed.
> 
> This series enables support for USB1 instance on the AM654-base-board.
> 
> To test, you need to first apply the below 2 series.
> 
> AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
> AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
> 

Please clarify if these have hit linux-next yet (I dont see anything in
the threads as to being picked up yet, may be I am wrong). Once they do hit
linux-next, please rebase to Tero's latest tip and repost.


-- 
Regards,
Nishanth Menon
