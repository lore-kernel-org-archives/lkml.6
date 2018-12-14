Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4ECC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C720811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303C720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeLNCYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:24:17 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31050 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbeLNCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:24:16 -0500
X-UUID: 980cd94c4d1a463892664daaa042d4b1-20181214
X-UUID: 980cd94c4d1a463892664daaa042d4b1-20181214
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1531560930; Fri, 14 Dec 2018 10:24:07 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 10:24:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 10:24:05 +0800
Message-ID: <1544754244.24219.135.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>
Date:   Fri, 14 Dec 2018 10:24:04 +0800
In-Reply-To: <20181213123658.GG1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
         <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
         <20181213123658.GG1605@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,

	Thanks for your comments.
On Thu, 2018-12-13 at 13:36 +0100, Andrew Lunn wrote:
> > +- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +Both delay properties need to be a multiple of 170 for fine-tune rgmii,
> > +range 0~31*170.
> > +Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
> > +range 0~31*550.
> > +Both delay properties need to be a multiple of 550 for mii/rmii,
> > +range 0~31*550.
> 
> You see "need to be" here, but the driver does not care. It will round
> down. Please either make the driver check, or change the text to
> rather say it will round down.
OK, will mark "round down" in the binding file.
> 
>        Andrew


