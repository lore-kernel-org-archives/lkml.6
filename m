Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E2AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02421470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IKM0cyIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B02421470
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJCX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:56:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44284 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJCX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:56:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93H6OWH121551;
        Wed, 3 Oct 2018 12:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538586384;
        bh=EwEwrAcEluIgdJGEK15lA7Hl6qNCf+AIkvwKMtuKaqs=;
        h=From:To:CC:Subject:Date;
        b=IKM0cyIWsp+OAAOoi+J6pBE4NpwALZTGp1T7KV4yLiwY1m7egwSGc0qD+mHne+N1c
         3cJnVW2/wLQWt12jhji9nAhWkfM6G0UmolbvmjSaWDLgfZw6Psbquyuhq8dC4vrXyR
         NLTcxNhDou7RzxW+uD2s7tpcqSIALVBJyeVTZIkU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6O4I023289;
        Wed, 3 Oct 2018 12:06:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 12:06:25 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 12:06:25 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93H6L3E010144;
        Wed, 3 Oct 2018 12:06:22 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] pwm-tiecap: Add support for AM654 SoCs
Date:   Wed, 3 Oct 2018 22:36:56 +0530
Message-ID: <20181003170658.3835-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0

