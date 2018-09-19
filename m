Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D4ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A3B208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A3B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbeISND2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:03:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46661 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbeISND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:03:28 -0400
X-UUID: 6bffb2733e514f4295934c5835d8db84-20180919
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 559810318; Wed, 19 Sep 2018 15:26:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 19 Sep 2018 15:26:37 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 19 Sep 2018 15:26:37 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>
CC:     <argus.lin@mediatek.com>, <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <chenglin.xu@mediatek.com>,
        <chen.zhong@mediatek.com>, <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH 0/4] Add PMIC wrapper support for Mediatek MT8183 SoC IC
Date:   Wed, 19 Sep 2018 15:25:57 +0800
Message-ID: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8AEE27DA121A4E19047BC153546DE5B92B1568C1BBCBE9E95AAE5CECC92FB202000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for a new PMIC MT6358 and a new SoC
MT8183 to the pmic-wrap driver.

Hsin-Hsiung Wang (4):
  dt-bindings: mediatek: add compatible for mt8183 pwrap
  soc: mediatek: use group of bits for pwrap capability
  soc: mediatek: add mt8183 pwrap support
  arm64: dts: mediatek: add pwrap device node for mt8183

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   1 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  10 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 439 +++++++++++++++------
 3 files changed, 329 insertions(+), 121 deletions(-)

-- 
1.9.1

