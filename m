Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F231BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883F2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ssV7Cja3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLCIBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36854 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLCIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB380fVi062144;
        Mon, 3 Dec 2018 02:00:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543824041;
        bh=hQerg8EElqPefc6AUnRVPYxGXN5Ylc+pzOo+O3qYHA4=;
        h=From:To:CC:Subject:Date;
        b=ssV7Cja351xmLXdfn1EsU8wMOObmWGFV/VBPv6oLMnYb5sSMNAoZwJSrHqkuU6BKx
         tq/aRnEtC3fwvlBk91APsa3mDR6p8YPxR75x+0NIM5lK8ngVZqJe7VoowL3oAZKETE
         OaNwW1LH/u/87Nv+KOoJWtoxsONLyzfJKVbwbTpw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB380f3T053242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 02:00:41 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 02:00:40 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 02:00:41 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB380bfZ024335;
        Mon, 3 Dec 2018 02:00:38 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] tscadc: Couple of fixes
Date:   Mon, 3 Dec 2018 13:31:16 +0530
Message-ID: <20181203080118.17504-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of fixes for tscadc drivers that I found while adding support for
new SoC.


Vignesh R (2):
  mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd
    cells
  iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 drivers/mfd/ti_am335x_tscadc.c       | 5 +++--
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.19.2

