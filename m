Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s5GVcjhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EE020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeKIUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:53:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55848 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:53:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9BDbNB030515;
        Fri, 9 Nov 2018 05:13:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541762017;
        bh=JD3S5YoX56fWzT9JYTJJH+IEcsklecyl4i5Ly01f7i0=;
        h=From:To:CC:Subject:Date;
        b=s5GVcjhrO6ADgc0h++Fh/KtIolhoAGSZNa2OSuFfvDT09qQny0OZMmiddfUCV96Fi
         9XFKEa9GR4aYDbkbLrgIbPj73XDCvtXWOp6dTGKcd1xFr0WAXI8O4NDwpyg513081Z
         bDTC/TyX3zTBqfNAdVbrtaS5VbJbiIy835i6G4ew=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9BDbji124343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 05:13:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 05:13:37 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 05:13:37 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9BDYs8028715;
        Fri, 9 Nov 2018 05:13:34 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 0/3] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date:   Fri, 9 Nov 2018 16:44:09 +0530
Message-ID: <20181109111412.24777-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to enable i2c-omap driver to be used with TI's new
AM654 platforms.

v4:
Add maintainer tag instead of reviewer in patch 3/3.

v3:
Rebase onto v4.20-rc1
Collect Reviewed-by's on v2
Add a patch to MAINTAINERS for i2c-omap.c

Vignesh R (3):
  dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
  i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
  MAINTAINERS: Add entry for i2c-omap driver

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 MAINTAINERS                                        | 8 ++++++++
 drivers/i2c/busses/Kconfig                         | 2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.19.1

