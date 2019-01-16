Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f4cPDGrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfAPN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:59:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAPN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:59:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GDxENM098001;
        Wed, 16 Jan 2019 07:59:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547647154;
        bh=qPKrUkrAIkB2XNH4Q+k0AA3gQLZgT3gnNmps+D3At18=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=f4cPDGrJ7X8ejUO/J1U1FfA+RcQ99VNhqlUT9YZD0bFwytwNyuDFyWLfVGqJw92fB
         gAMO7KZrHEmABGY/BtuycUtAxxv4L7d4wJGmEGZGWnA958mMC/AImmTLFVBR5PP1b5
         b6K+f5GhOTzHEUoHrCtkUtJo8b/YF49lHWbog2AE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GDxEBt054639
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 07:59:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 07:59:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 07:59:14 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GDxEBD009808;
        Wed, 16 Jan 2019 07:59:14 -0600
Date:   Wed, 16 Jan 2019 07:59:14 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Min Guo <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v2 4/4] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20190116135914.GF18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yonglong Wu <yonglong.wu@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-5-git-send-email-min.guo@mediatek.com>
 <20190115203815.GD18026@uda0271908>
 <1547631542.4433.232.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547631542.4433.232.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:39:02PM +0800, Min Guo wrote:
> Hi Bin,
> 
> On Tue, 2019-01-15 at 14:38 -0600, Bin Liu wrote:
> > Hi Min,
> > 
> > very close, thanks.
> > Below I tried to explain a further cleanup in musb_clearb/w() and
> > musb_get/set_toggle() implementation. Please let me know if it is not
> > clear.
> > 
> > Basically, we don't need musb_default_clearb/w(), just assign the
> > musb_io function pointers to musb_readb/w().
> > 
> > Then the mtk platform musb_clearb/w() calls musb_readb/w() and
> > musb_writeb/w() to handle W1C.
> 
> Sorry to bother you again, I encounter a problem when prepare the patch.

no problem at all.

> The define of musb_clearb/w and musb_readb/w are difference as follow,
> and cannot be directly assigned:
> u8/u16 (*readb/w)(const void __iomem *addr, unsigned offset)
> void (*clearb/w)(void __iomem *addr, unsigned int offset)) 
> 
> if modify clearb/w as:
> u8/u16 (*clearb/w)(const void __iomem *addr, unsigned int offset)) 
> then musb_clear needs writeb/w the const addr.
> Can I delete const in (*readb/w)?

yes, please create a separate patch for it, and for readl() as well,
and stating it is for implementing clearing W1C registers.

Regards,
-Bin.
