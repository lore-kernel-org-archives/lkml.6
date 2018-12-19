Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BB620869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G68MOoTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeLSQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:26:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36882 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLSQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:26:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJGQTQM033392;
        Wed, 19 Dec 2018 10:26:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545236789;
        bh=frS0927MH+429VNfOisQZDllRE2Sx6wHlGqOYb9ILgc=;
        h=From:To:CC:Subject:Date;
        b=G68MOoTZGP6fFdRFUeaNuzWqhlq1qqL/5w66rptWrW1iF2LKwHhVcDHis58ezkCyc
         hbZjfUo7+okOfushJDe7LsvCWVyPPFViKXqpWKK/EZpUVFZFNXi6XiCdfBy024r7g6
         g3nt45ISgUIcaFWq5jyaevQghCU07a1YoCW0JTuc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJGQTgx026121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 10:26:29 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 10:26:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 10:26:29 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJGQT9C011394;
        Wed, 19 Dec 2018 10:26:29 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.111.148])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wBJGQTU26340;
        Wed, 19 Dec 2018 10:26:29 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 0/2] LP5024/18 LED introduction
Date:   Wed, 19 Dec 2018 10:26:24 -0600
Message-ID: <20181219162626.12297-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am introducing the newest of the TI RGB parts the LP5024 and the LP5018.
Now I understand that there is a patchset in the works that changes the way
the LED labeling is created but I wanted to post these patches for comments and
let the maintainers decide whether to pull this in prior to that patchset being
committed.

Dan

Dan Murphy (2):
  dt: bindings: lp5024: Introduce the lp5024 and lp5018 RGB driver
  leds: lp5024: Add the LP5024/18 RGB LED driver

 .../devicetree/bindings/leds/leds-lp5024.txt  |  63 ++
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-lp5024.c                    | 610 ++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
 create mode 100644 drivers/leds/leds-lp5024.c

-- 
2.20.0.rc2.7.g965798d1f2

