Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8C2217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YaeKDSmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfAVOeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:34:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47680 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfAVOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:34:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0MEXnI5012069;
        Tue, 22 Jan 2019 08:33:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548167629;
        bh=isxP2QyO/Q8vsgPq55lQGp+Zxy0AFL2Jxwc2k9mQiwg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YaeKDSmmCWIM4DZNFPWyMblfQXWGD4rK3cdUzJpL/FFKskVBwXbCiC5bCP5hlDul4
         66jsRCXh8zdG6TCgAWz59j85m/SQYA9idnHNjvWV1mw8cZZNZA42E0xKEmuitHb7GO
         u9g5GRtXj3w1vEfsfVPvgGpgGE8JZAMfpwnGZ7O8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0MEXnnj039278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 08:33:49 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 22
 Jan 2019 08:33:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 22 Jan 2019 08:33:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0MEXnbf012288;
        Tue, 22 Jan 2019 08:33:49 -0600
Date:   Tue, 22 Jan 2019 08:33:48 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Min Guo <min.guo@mediatek.com>
CC:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <hdegoede@redhat.com>,
        <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190122143348.GF30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, hdegoede@redhat.com, tony@atomide.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
 <20190121151417.GA19238@bogus>
 <1548149773.4433.284.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1548149773.4433.284.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Tue, Jan 22, 2019 at 05:36:13PM +0800, Min Guo wrote:
> Hi Bin,
> 
> Sorry to bother you again, I encounter a problem about the extcon
> property.
> 
> I don't find a common driver describing the usb-connector. Is
> there any driver that I can refer to, specially the way to switch MUSB
> controller between host and device mode? 
> If it needs to implement by myself, is it possible to emulate an
> usb-connector driver by extcon-usb-gpio, and also use the notifier
> mechanism or can you give me some advices?

I am afraid I am unable to help you on this. I wasn't really pay
attention when usb-connector was introduced and not sure how it can
replace extcon. Now after read usb-connector.txt, it seems the binding
only defines a/b/c-connector, but not ab-connector, and there is no
enough information (at least for me) explaining how VBUS and ID fix into
this usb-connector binding.

Maybe Rob can provide some hint.

Regards,
-Bin.
