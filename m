Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B93C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858B22087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KwteWK+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfARNeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:34:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36168 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfARNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:34:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IDY8P7032089;
        Fri, 18 Jan 2019 07:34:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547818448;
        bh=JUfz9m/jPu7HP3vUJw1Fmlc+FqLxoEBdRg/fAbb2oh4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KwteWK+bUOHZ1QTw3W413+xG+YvoHU/eY+fU6gq77fG2O1cFeQxsm7L64CsbV7dDs
         t3Yek+w8+nNjH0Q5Uvgiog/qa0F5nilY8z8bFvuQ1FnwwdBn2sm918fokbCrMMDJUN
         xSdbAz2jvRXH0N7qVa5NRZw/2g+Eq1S3ZbY9i2AA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IDY8la054452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 07:34:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 07:34:08 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 07:34:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IDY8bt024388;
        Fri, 18 Jan 2019 07:34:08 -0600
Date:   Fri, 18 Jan 2019 07:34:08 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Min Guo <min.guo@mediatek.com>
CC:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <hdegoede@redhat.com>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20190118133408.GA30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Min Guo <min.guo@mediatek.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hdegoede@redhat.com,
        Yonglong Wu <yonglong.wu@mediatek.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
 <20190117143342.GS5544@atomide.com>
 <1547792054.4433.254.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547792054.4433.254.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Fri, Jan 18, 2019 at 02:14:14PM +0800, Min Guo wrote:
> On Thu, 2019-01-17 at 06:33 -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> > > There are some quirk of MediaTek musb controller, such as:
> > >  -W1C interrupt status registers
> > >  -Private data toggle registers
> > >  -No dedicated DMA interrupt line
> > 
> > Can you please separate the musb generic changes listed above
> > into separate individual patches in preparation for adding
> > support for new hardware?
> > 
> > Otherwise we'll have hard time finding out with git bisect what
> > exactly breaks things if we run into trouble.
> 
> Thanks for your suggestion.
> I prepared to divide these changes into separate patches. Later, Mr.Bin
> suggested not to do this.

Initially I thought the clearb/w() changes should be just a couple
lines, so didn't think to separate it. But after reviewed the final
implemenation, I agree Tony's comment is the right thing to do, please
separate the musb core changes, each for clearb/w(), get/set_toggle(),
and dma.

Regards,
-Bin.
