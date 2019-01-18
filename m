Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C288C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5499B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfARGOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:14:23 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41340 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726457AbfARGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:14:23 -0500
X-UUID: 3b414f0671d4471caa0a4bb0aeaf3cc4-20190118
X-UUID: 3b414f0671d4471caa0a4bb0aeaf3cc4-20190118
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1195770821; Fri, 18 Jan 2019 14:14:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Jan
 2019 14:14:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 14:14:14 +0800
Message-ID: <1547792054.4433.254.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb
 controller
From:   Min Guo <min.guo@mediatek.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <hdegoede@redhat.com>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Date:   Fri, 18 Jan 2019 14:14:14 +0800
In-Reply-To: <20190117143342.GS5544@atomide.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
         <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
         <20190117143342.GS5544@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 06:33 -0800, Tony Lindgren wrote:
> Hi,
> 
> * min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> > There are some quirk of MediaTek musb controller, such as:
> >  -W1C interrupt status registers
> >  -Private data toggle registers
> >  -No dedicated DMA interrupt line
> 
> Can you please separate the musb generic changes listed above
> into separate individual patches in preparation for adding
> support for new hardware?
> 
> Otherwise we'll have hard time finding out with git bisect what
> exactly breaks things if we run into trouble.

Thanks for your suggestion.
I prepared to divide these changes into separate patches. Later, Mr.Bin
suggested not to do this.

The detailed information can be referred to:
https://patchwork.kernel.org/patch/10743561/
https://patchwork.kernel.org/patch/10763737/
https://patchwork.kernel.org/patch/107463741/

> Regards,
> 
> Tony


