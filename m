Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC792177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KctG3CVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfAKKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:01:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:01:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BA16D8055892;
        Fri, 11 Jan 2019 04:01:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547200866;
        bh=9jmRLQ4N9I8LaJBdJKtSEAoPPLY+SO0iw7dqQ2Lwyxk=;
        h=From:To:CC:Subject:Date;
        b=KctG3CVW1G1W1aJ5cI/WFxTuLZlNrngs2HPUfabeBf7jCFySIvWZiX74xyrBk2ZO9
         bc00nCzBNz5FfxUZyBD+wRL9hRNglS/Rt99ZqNn0d4GUJ1OEYqeORg8MSQNYN899j7
         M8vsYup8vN6wRe5zYKGytoAqB5FDqeYTkve/YAww=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BA167q052028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 04:01:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:01:05 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:01:05 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BA12XZ015629;
        Fri, 11 Jan 2019 04:01:03 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] arm64: ti: k3-am654: USB support
Date:   Fri, 11 Jan 2019 12:00:58 +0200
Message-ID: <1547200861-17795-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The AM654 SoC supports 2 DWC3 USB controller instances. The
AM654 base board supports the 2nd (USB1) instance in high-speed.

This series enables support for USB1 instance on the AM654-base-board.

To test, you need to first apply the below 2 series.

AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html

cheers,
-roger

Jyri Sarha (1):
  arm64: dts: ti: am654: Add Main System Control Module node

Roger Quadros (2):
  arm64: dts: ti: k3-am6: add USB support
  arm64: dts: ti: k3-am654-base-board: enable USB1

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 88 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 20 ++++++
 2 files changed, 108 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

