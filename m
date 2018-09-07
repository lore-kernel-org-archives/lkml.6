Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C366C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723320861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B723320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIGNXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:23:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6365 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbeIGNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:23:48 -0400
X-UUID: 73ed283b8d7c49d39aef79c81b132e75-20180907
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1599932375; Fri, 07 Sep 2018 16:43:49 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 7 Sep
 2018 16:43:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 7 Sep 2018 16:43:46 +0800
Message-ID: <1536309826.32173.45.camel@mhfsdcap03>
Subject: Re: [PATCH v2] usb: xhci: fix interrupt transfer error happened on
 MTK platforms
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <stable@vger.kernel.org>
Date:   Fri, 7 Sep 2018 16:43:46 +0800
In-Reply-To: <20180907074251.GA2079@kroah.com>
References: <e8698cc5710a9d1f25e33e2201e2177bfbfec75c.1536305256.git.chunfeng.yun@mediatek.com>
         <20180907074251.GA2079@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2018-09-07 at 09:42 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 07, 2018 at 03:29:12PM +0800, Chunfeng Yun wrote:
> > The MTK xHCI controller use some reserved bytes in endpoint context for
> > bandwidth scheduling, so need keep them in xhci_endpoint_copy();
> 
> If they are "reserved" shouldn't they be properly named?  And by using
> reserved bytes, isn't that a spec violation?
It indeed violates the spec, "they shall be treated by system software
as Reserved and Opaque", and it's a quirk of the MTK xHCI controller.

> 
> thanks,
> 
> greg k-h


