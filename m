Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D618C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697E2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeKLNYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:24:55 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:52437 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbeKLNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:24:55 -0500
X-UUID: 55fb43f5b935423eb3c5ad37f0387523-20181112
X-UUID: 55fb43f5b935423eb3c5ad37f0387523-20181112
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1880894518; Mon, 12 Nov 2018 11:33:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 12 Nov 2018 11:33:28 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 12 Nov 2018 11:33:28 +0800
Message-ID: <1541993608.30437.3.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose
 timer node
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <stable@vger.kernel.org>
Date:   Mon, 12 Nov 2018 11:33:28 +0800
In-Reply-To: <20181112024556.GI2642@sasha-vm>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
         <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
         <20181112024556.GI2642@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 21:45 -0500, Sasha Levin wrote:
> On Mon, Nov 12, 2018 at 09:28:08AM +0800, Ryder Lee wrote:
> >The crash http://termbin.com/zitb is caused by the timer register
> >into system in early pahse during kernel boot, but the clock
> >sources didn't get ready at that time.
> >
> >A better way is to switch to use CLK_OF_DECLARE() in driver for things
> >that need them early, but this node is actually useless in MT7622.
> >So we drop it.
> >
> >Fixes: 9cc7f0de9e67 ("arm64: dts: mt7622: add timer, CCI-400 and PMU nodes")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> To confirm: the patch this fixes was added in v4.20-rc1, which means
> that this current patch doesn't apply to any of the stable trees.
> 
> Did we miss something?
> 

I didn't see any fixup for this?

Ryder

