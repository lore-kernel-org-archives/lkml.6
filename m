Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A99C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC2320859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC2320859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeJMO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:57:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbeJMO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:57:12 -0400
X-UUID: d3038ff7ca4a434f8afe486788d67500-20181013
X-UUID: d3038ff7ca4a434f8afe486788d67500-20181013
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 90285496; Sat, 13 Oct 2018 15:21:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 13 Oct 2018 15:21:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 13 Oct 2018 15:21:02 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <jjian.zhou@mediatek.com>, <wenbin.mei@mediatek.com>
Subject: mmc: mediatek: add MT8183 MMC driver support
Date:   Sat, 13 Oct 2018 15:20:44 +0800
Message-ID: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this series of patch include below changes:
1. Add MT8183 SoC support in Mediatek MMC DT bindings
2. Fill mmc->actual_clock
3. Fix cannot receive new request issue
4. Tune CMD/DATA together to save tuning time
5. Add MT8183 MMC driver support
6. Refine the tuning method to drop too much redundant code

Chaotian Jing (6):
  mmc: dt-bindings: add support for MT8183 SoC
  mmc: mediatek: fill the actual clock for mmc debugfs
  mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready
    fail
  mmc: mediatek: tune CMD/DATA together
  mmc: mediatek: add MT8183 MMC driver support
  mmc: mediatek: drop too much code of tuning method

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   1 +
 drivers/mmc/host/mtk-sd.c                        | 292 ++++++++++++++++++++---
 2 files changed, 254 insertions(+), 39 deletions(-)

-- 
1.8.1.1.dirty

