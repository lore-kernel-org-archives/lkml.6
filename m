Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA187208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA187208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeK0Mfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:35:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:15009 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbeK0Mfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:35:45 -0500
X-UUID: 2ec0257fe35348d5bd44df66f1838ea3-20181127
X-UUID: 2ec0257fe35348d5bd44df66f1838ea3-20181127
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 475931140; Tue, 27 Nov 2018 09:39:32 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 09:39:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Nov 2018 09:39:29 +0800
Message-ID: <1543282769.24219.129.camel@mhfsdcap03>
Subject: Re: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>
Date:   Tue, 27 Nov 2018 09:39:29 +0800
In-Reply-To: <20181126214626.GA13830@bogus>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
         <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
         <20181122151932.GD15403@lunn.ch> <1542936676.24219.66.camel@mhfsdcap03>
         <20181126214626.GA13830@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,
	Thanks for your comments.
On Mon, 2018-11-26 at 15:46 -0600, Rob Herring wrote:
> On Fri, Nov 23, 2018 at 09:31:16AM +0800, biao huang wrote:
> > Dear Andrew,
> > 
> > 	Thanks for you remind.
> > 
> > 	Sincerely, I respect any comment from any reviewer. If I didn't reply
> > for any comment, really sorry for that.
> > 
> > 	As to this "tx-delay" issue, the following reply in v3 maybe ignored.
> > 	https://lkml.org/lkml/2018/11/19/158
> > 
> > 	"the delay time in mediatek dwmac design is not so accurate,
> > 	the current mt2712 and the following ICs will not use the
> > 	same delay design, but will use stages to indicate different
> > 	delay time.
> > 	so maybe "mediatek.tx-delay" represent the delay stage is a
> > 	good choice"
> > 
> > 	And to make it clearer here.
> > 
> > 	In mt2712, there are two delay macro circuit: named fine-tune and
> > coarse-tune.
> > 	a. fine-tune, 170+/-50ps per stage, total 32 stages
> > 	b. coarse-tune, 0.55+/-0.2ns per stage, total 32 stages
> > 	If we only consider mt2712, delay in fine-tune select a integer
> > multiple of 170ps, delay in coarse-tune select a integer multiple of
> > 550ps, for stage 0~31, the delay in fine-tune will not have the same
> > value with that in coarse-tune.
> > 	OK, It seems the property "fine-tune" can be eliminated .
> > 
> > 	But the following ic will not have the same accuracy as mt2712,
> > and maybe will not have two delay macro circuit to be selected.
> 
> New IC will have new compatible string then. If it is different, then 
> likely these properties would have to change or have different meaning 
> unless you use time.
> 
OK, I'll use tx-delay-ps instead of tx-delay.
> > 	1. assume two delay macro circuit in the following ic,
> > 	fine-tune, 100ps per stage, coarse-tune, 0.55ns per stage,
> > 	if we want delay 2.2ns, fine-tune will get a 22, and coarse-tune get a
> > 4. We can't distinguish which delay macro we are choosing.
> 
> Why wouldn't you just choose fine-tune for anything less than the max 
> range (3200ps in this example) and course for greater than 3100ps.
> 
The fine-tune circuit and coarse-tune circuit are parallel, and
fine-tuen is a select switch.
It depends on users to choose which circuit is take effect.
I shouldn't assume users would choose fine-tune when delay < 3200ps, and
coarse for > 3100ps.

so, tx-delay-ps will be chosen, and "fine-tune" boolean property should
be remained as a indicator.
> > 	2. assume only one delay macro circuit is used, a similar case as 1
> > will also increase the complexity of driver.
> > 	Then, we need define more flag property to know which delay macro we
> > are handling.
> > 
> > 	The common things for all delay macro circuit in MediaTek mac design is
> > the stages, not the accuracy. so if we maintain stage info in "mediatek,
> > tx-delay", we only need care which stage we should choose.
> > And for each IC, we will recommend a best stage as a candidate.
> 
> What if you had a 3rd delay circuit?
> 
OK, tx-delay-ps will be a meaningful property.
If more delay circuit is added, fine-tune property(boolean --> u32) can
still be a indicator.
> > 	Above is my personal opinion, may be my understanding is wrong,
> > welcome for further discussion.
> > 
> > 	Thanks a lot.


