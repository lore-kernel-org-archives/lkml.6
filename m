Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194BE2150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="YyCMQLd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194BE2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbeHBOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:45:31 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.136]:14052 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbeHBOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533214466;
        s=strato-dkim-0002; d=as-electronics.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=I626qcWW8PuHqooUV4ueTApLv6RpCSD9LCbqvGnyZ9g=;
        b=YyCMQLd2jQ8FQk4CaI9Lr2tukfbOCwIxYaJmVZ3sObp7OIOIeRyWCGmDRDJ8RpAKpR
        WCcUmUBc/uQETIUOpK1aOhClEyy3lbG2eWD9NZQKxuZHgkg20ZfwG2sDkD/KKm/V8wNA
        +AqQrIkBnDMbq8zCeBiwFF9T2K1QL1VkcqfEn3ZQ/PBo/Q6xutfzzSX/jHxrU61qDkQx
        PhtCbjVNhcrMfGB3RCkvEwSzWRKSFnq18iJkEb9+hIluKTYW5qIm3EgoEKngGulC3M/1
        QubMMu64Cyp1MJv55hXl3QNli32SegPsk2NzT/bfD+xA++NWM1pRzkcgMQYilQuoVDpC
        IWcA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+ReE5zXU1i255vGQvjM+ToVYx2MGL/3gV0P3t0="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72CsJ7PX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 14:54:19 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Cc:     cyrille.pitchen@wedev4u.fr, frieder.schrempf@exceet.de,
        pp@emlix.com, Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Extend the SPI mem interface to set a custom memory name
Date:   Thu,  2 Aug 2018 14:53:51 +0200
Message-Id: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes were previously send with the series that transforms the FSL QSPI
driver to the SPI mem interface [1]. As these changes are needed for other
drivers too I send them separately now.

The first patch fixes a typo, the second extends the interface to set and get a
custom name for the memory device and the third patch makes use of this in the
m25p80 driver.

[1] https://patchwork.ozlabs.org/cover/939864/

Changes in v3:
==============
* Move fix for typo in spi-mem.h to a separate patch
* Fix documentation of spi_mem_get_name() and get_name()
* Avoid overwriting the name of the memory device in probe of m25p80
* Add Suggested-by tags

Changes in v2:
==============
* Add a name field to struct spi_mem and fill it while probing

Frieder Schrempf (3):
  spi: spi-mem: Fix a typo in the documentation of struct spi_mem
  spi: spi-mem: Extend the SPI mem interface to set a custom memory name
  mtd: m25p80: Call spi_mem_get_name() to let controller set a custom
    name

 drivers/mtd/devices/m25p80.c |  3 +++
 drivers/spi/spi-mem.c        | 28 ++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h  | 14 +++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.7.4

