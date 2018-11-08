Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF22C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EB920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWgtXra+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EB920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKIJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:04:11 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35215 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeKIJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:04:11 -0500
Received: by mail-wm1-f41.google.com with SMTP id t15-v6so353166wmt.0;
        Thu, 08 Nov 2018 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+2RU69FRWDk3CMxLfKt+YRapJT+KDR1KMxQ8WMUUXQ0=;
        b=qWgtXra+EyraCFxig7QdPHySEQfSFrlx4jAPDO2CR7MZCKf838sZE2bnQWeFmfteP6
         By6UCsEtsAPcvdwDwfqABOGCWajBoTPq8aya6xXv/4IFG2XFJV2o0VCTYdAMRqjWMqdQ
         HC3SAz2HvTgTuWy1z4nMPl6nSsQdIMSjNzxGJsOXQB/X+TkbAMHy0bIVeBBonv9uzCVW
         XX8aAOn1mcUCdfn5aeAPfEe/pNGxGq1fkhPf3cl1hVaKn4plN1o/5DMNRRrfUq3bmHy3
         ka9j6byYqDVvz0/usUJslQ6hdc5IUcKnesZLMcWH/eOsC2WaHRL4+/r8HpPk5sbB1t5q
         ppwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+2RU69FRWDk3CMxLfKt+YRapJT+KDR1KMxQ8WMUUXQ0=;
        b=VyiqGOOnuPr3fVMOF6pnZWVu37gshcBJ4Ugzv9atSj78DCQA9k1ITvDZ8W+hHFVAaU
         sBdp/sThJ9LeRi26u3H91zeS/Vowy7437y5tcWm/tfv2/Lq6by2idJgMpDelk3x1cqiS
         zoXvJqRca4h4Sw7nwcfkvbRYHF1s/ydyUgJZC3HvwyFxs2crFv/mZQQHjbJNI3/DuBSO
         Qf55nsirvQtynB+2GM/gVMr2t+cCgmHvWhWwkz7OlvHLFc95Jl0Mzw3LBLhFn/rS/mTO
         epg1EtwJ734Roig9XLSs2xdo2fXUwDjvcATn2bKo+TGugX99Ki44FaJRgQXvQl6aJ7A7
         C55w==
X-Gm-Message-State: AGRZ1gK8rVc6az41ScvI2JDNYecS7BBqfxV7oE54+ag1gHpn6YbFC/IH
        Il0ZAWWs5XbYEyAmcaBBmgo=
X-Google-Smtp-Source: AJdET5fJ+OMqtKg0R0Ocelx9I94U+anSplJ69PlkTlMLLBWJXVq3ZNYfjRepCB29ldstGOF6n3gXJA==
X-Received: by 2002:a1c:da51:: with SMTP id r78-v6mr2929322wmg.39.1541719576207;
        Thu, 08 Nov 2018 15:26:16 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:3cbc:a9ea:9ab8:4b19? (p200300EA8BCFE3003CBCA9EA9AB84B19.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:3cbc:a9ea:9ab8:4b19])
        by smtp.googlemail.com with ESMTPSA id g1-v6sm5792095wmg.2.2018.11.08.15.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:26:15 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: replace PHY_HAS_INTERRUPT with a
 check for config_intr and ack_interrupt
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Message-ID: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
Date:   Fri, 9 Nov 2018 00:26:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
using interrupts isn't possible if a driver defines neither
config_intr nor ack_interrupts callback. So we can replace checking
flag PHY_HAS_INTERRUPT with checking for these callbacks.
This allows to remove this flag from all driver configs.

v2:
- add helper for check in patch 1
- remove PHY_HAS_INTERRUPT from all drivers, not only Realtek
- remove flag PHY_HAS_INTERRUPT completely

Heiner Kallweit (2):
  net: phy: replace PHY_HAS_INTERRUPT with a check for config_intr and ack_interrupt
  net: phy: realtek: remove flag PHY_HAS_INTERRUPT from driver configs

 drivers/net/phy/amd.c          |  1 -
 drivers/net/phy/aquantia.c     |  6 ------
 drivers/net/phy/at803x.c       |  3 ---
 drivers/net/phy/bcm63xx.c      |  4 ++--
 drivers/net/phy/bcm87xx.c      |  2 --
 drivers/net/phy/broadcom.c     | 16 ----------------
 drivers/net/phy/cicada.c       |  2 --
 drivers/net/phy/davicom.c      |  4 ----
 drivers/net/phy/dp83640.c      |  1 -
 drivers/net/phy/dp83822.c      |  1 -
 drivers/net/phy/dp83848.c      |  1 -
 drivers/net/phy/dp83867.c      |  1 -
 drivers/net/phy/dp83tc811.c    |  1 -
 drivers/net/phy/icplus.c       |  1 -
 drivers/net/phy/intel-xway.c   | 10 ----------
 drivers/net/phy/lxt.c          |  2 --
 drivers/net/phy/marvell.c      | 15 ---------------
 drivers/net/phy/meson-gxl.c    |  2 +-
 drivers/net/phy/micrel.c       | 14 --------------
 drivers/net/phy/microchip.c    |  1 -
 drivers/net/phy/microchip_t1.c |  1 -
 drivers/net/phy/mscc.c         |  6 ------
 drivers/net/phy/national.c     |  1 -
 drivers/net/phy/phy_device.c   |  8 ++++++--
 drivers/net/phy/qsemi.c        |  1 -
 drivers/net/phy/realtek.c      |  7 -------
 drivers/net/phy/smsc.c         |  7 +------
 drivers/net/phy/ste10Xp.c      |  2 --
 drivers/net/phy/vitesse.c      |  9 ---------
 include/linux/phy.h            |  5 ++---
 30 files changed, 12 insertions(+), 123 deletions(-)

-- 
2.19.1

