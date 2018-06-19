Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B932075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XlqDAK/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B932075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030695AbeFSTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:55:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56786 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030472AbeFSTzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:55:32 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 15:55:31 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5JJioPs021438;
        Tue, 19 Jun 2018 14:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437490;
        bh=v5cRhBD4ssKWiRE48xFKD2b5bxk3BW5XfZoKW3svYg4=;
        h=From:To:CC:Subject:Date;
        b=XlqDAK/c+c+MDnk0mlD58HcZNFv9ZYsl3CP6DVGy7QED7NGwqbVMcNHZ4GNth+umQ
         v+x8Y0niMi7iPDWtjseckSKc0nC5TrHHhH85Fcj/JSavvJOyo7lD33CG1odAhiDPzj
         tp6hfjidYLBn7bXVTdAwyTtk9QXGY2enpGoQmbx8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJioXK025876;
        Tue, 19 Jun 2018 14:44:50 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:44:50 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:44:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiol6018771;
        Tue, 19 Jun 2018 14:44:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/2] serial: 8250_omap: Add compatible for AM654 UART
Date:   Tue, 19 Jun 2018 14:44:48 -0500
Message-ID: <20180619194450.6353-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series was previously send out as part of a larger AM654 UART
support series, but was determined to create a bit of merge conflicts
due to interdependence.

Changes since RFC are indicated in corresponding patches in the series

Instead this series is split out. The series itself is based off
v4.18-rc1 and available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-uart

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log (integrated of all series) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (2):
  dt-bindings: serial: 8250_omap: Add compatible for AM654 UART
    controller
  serial: 8250_omap: Add support for AM654 UART controller

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/8250/8250_omap.c                      | 1 +
 2 files changed, 2 insertions(+)

-- 
2.15.1

