Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48E12070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NsrkrZvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfACOEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:04:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48584 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfACOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:04:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x03E3vCn058759;
        Thu, 3 Jan 2019 08:03:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546524237;
        bh=PaAla/8JRVVNax5naMoFXQj/h9fHzEYPdFIfQWtUMY4=;
        h=From:To:CC:Subject:Date;
        b=NsrkrZvs8EDFlXSuu5kr/tFkxX+NRhYqit6rUcqLu0qqzJStv9s2PG6Qf03xnFPX1
         g0pwx7OPC9h39zSIvkzAQ1aZLFfrvL9JjQ8BG5Y7dpNb9LIZE2bXdFwFWukTVvoZUz
         v8Ovp3Bs9RCgR11Kjqp+Ik9VZFbUdWrWuPOzAAe4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x03E3vuG020729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 08:03:57 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 3
 Jan 2019 08:03:55 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 3 Jan 2019 08:03:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x03E3rlM021111;
        Thu, 3 Jan 2019 08:03:53 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] ASoC: ti: davinci-mcasp: GPIO mode support for pins
Date:   Thu, 3 Jan 2019 16:05:49 +0200
Message-ID: <20190103140552.29809-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Each McASP pins can be configured individually to be used as McASP or GPIO pin.

This series will allow client drivers to use pins as GPIO (optional) in case the
board wired up them to be used in this mode.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm
    callbacks
  bindings: sound: davinci-mcasp: Document GPIO support
  ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins

 .../bindings/sound/davinci-mcasp-audio.txt    |  17 +
 sound/soc/ti/davinci-mcasp.c                  | 295 +++++++++++++-----
 2 files changed, 237 insertions(+), 75 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

