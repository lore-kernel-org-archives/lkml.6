Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA572086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBTMcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:32:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:18778 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727484AbfBTMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:31:44 -0500
X-UUID: 9fbae55b8a5c4fd3852ab660312c0e86-20190220
X-UUID: 9fbae55b8a5c4fd3852ab660312c0e86-20190220
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1456685008; Wed, 20 Feb 2019 20:31:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 20:31:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 20:31:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 20:31:35 +0800
From:   <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2,0/7] Add Mediatek thermal dirver for mt8183
Date:   Wed, 20 Feb 2019 20:31:26 +0800
Message-ID: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports for mt8183 chip to mtk_thermal.c.
MT8183 has six temperature sensors and two thermal
controllers. It has different calibration coefficent with
past project, and doesn't need to select bank.
As a result, we add the common architecture for scalability.

change in v2:
1.Add fix tag of commit message to PATCH 1/7.
2.Change memery declaration of controller_base to PATCH 4/7.
3.Add module author to PATCH 7/7.

Michael Kao (7):
	  thermal: mediatek: fix register index error
	    thermal: mediatek: add common index of vts settings.
	    thermal: mediatek: add calibration item
	    thermal: mediatek: add thermal controller offset
	    thermal: mediatek: add flag for bank selection
	    dt-bindings: thermal: add binding document for mt8183 thermal
	      controller
	    thermal: mediatek: add support for MT8183

	   .../bindings/thermal/mediatek-thermal.txt          |   1 +
	    drivers/thermal/mtk_thermal.c                      | 316 +++++++++++++++++----
	     2 files changed, 258 insertions(+), 59 deletions(-)

