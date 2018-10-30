Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88320C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586D62080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586D62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJaAoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:44:22 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:27671
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727637AbeJaAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:44:22 -0400
X-IronPort-AV: E=Sophos;i="5.54,445,1534802400"; 
   d="scan'208";a="283843923"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Oct 2018 16:50:19 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] constify thermal_zone_of_device_ops structures
Date:   Tue, 30 Oct 2018 16:14:58 +0100
Message-Id: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal_zone_of_device_ops structures can be const as they are
only passed as the last argument of a thermal_zone_of_sensor_register
function and the corresponding parameter is declared as const.

Done with the help of Coccinelle.

---

 drivers/thermal/armada_thermal.c           |    2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
