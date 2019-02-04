Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87680C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECDE214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aOdC0wHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfBDP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:56:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57974 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfBDP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:56:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14Fs5ER058441;
        Mon, 4 Feb 2019 09:54:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549295645;
        bh=Jem1voZ+sxN51hD3XGuE4zNRDbj+KHR0kpaBDsTDRho=;
        h=From:To:CC:Subject:Date;
        b=aOdC0wHFtbO/4nTmgCzkt4hu12drXeZ/RIPVPhKA7OyolGSBzVlderJJ1tChK5Bve
         M71L1WPHjmMfZDML/JDoHG5oOPcvmujYLe57OUkIMEXwORZTy50lt1I6hKCFZS9/YV
         OwKgKT4EQ96nq/AN0y9yNKHQgKRG7OLKf/110nkU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14Fs5sI040239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:54:05 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:54:05 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:54:04 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14Fs1mL012077;
        Mon, 4 Feb 2019 09:54:02 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] AM57xx: PRU ICSS Support
Date:   Mon, 4 Feb 2019 17:53:53 +0200
Message-ID: <1549295637-24890-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds PRU-ICSS support for AM57xx IDK.

PRU-ICSS is not present only on AM57xx SoCs so the PRUSS
nodes are left disabled in dra7.dtsi. The board that uses
a AM57xx SoC will have to enable them if required.

PRU-ICSS has a SYSC register but it requires custom handling.
So we add a new "ti,sysc-pruss" type to the ti-sysc bus driver.

This series depends on 

[1] - PRU ICSS support v2
 https://lkml.org/lkml/2019/2/4/677

cheers,
-roger

Roger Quadros (2):
  dt-binding: bus: ti-sysc: Add support for PRUSS SYSC type
  bus: ti-sysc: Add support for PRUSS SYSC type

Suman Anna (2):
  ARM: dts: dra7: add PRU-ICSS modules
  ARM: dts: am57xx-idk-common: Enable PRU-ICSS nodes

 Documentation/devicetree/bindings/bus/ti-sysc.txt |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi          |   8 +
 arch/arm/boot/dts/dra7.dtsi                       | 194 ++++++++++++++++++++++
 drivers/bus/ti-sysc.c                             |  77 +++++++++
 include/linux/platform_data/ti-sysc.h             |   1 +
 5 files changed, 281 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

