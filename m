Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27816C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40DF21906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="HkUUTddO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAZQc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:32:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37943 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfAZQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:32:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so9024023lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kS5H/aXW8GuV+ml679sxzZ/9wuuF0lVRxh23dupYwdQ=;
        b=HkUUTddOVU9DoiJ6tr9HDAPjUavOUN1er30Nt0VEC0kDHOOUnOJxkUo/R9laKhoZxj
         7FWS+MIk0ZCTrK3Tr3lI121wEIc/JvCDV4nr6iJTEwdnmSpTKSnrvHkPg6bi/rWI37kK
         VFPFnjls23m40ElKlrniGukTJLoIaT1pi+ayHjNpobC+Dt16KcT4T5aGGaWqgx9dfaiG
         RLDjcar2I94LJg1zgW2K3Dz8VO0xmaxd0Am+YBZ8F33ZRguZgzU7eYLJ9XBWFowCmEbc
         UsFAD00yLrO4P2sLNVKgVR6zBHrKbJ9/HrnuFSUGHaxEfZHoMRZdzTxjsLgdZzx8TOBr
         jNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kS5H/aXW8GuV+ml679sxzZ/9wuuF0lVRxh23dupYwdQ=;
        b=gwmHF3NVllBnijNrJHPeZGxMnxVwUuDhoP4GWw7lB0CZRE/vB8D4qBaX0ruoiKA2R4
         w+cKGl/+aPsiV5ZWdezMl+7yACYFgFqlfEYLuYl0wxRjzAGvCxwBuOykQXGKGfcFV2BK
         w+uUCx1RVfEbDESLDePpUqojrnX3vxVVU/EbsWgPofnEzGcQ9kagImsWk13AbAjy9xiO
         WLgw86WqDq7kFRQ3WCUBth7CwobhobnccCxTaKkiiKl+G9p3BMMhOe6UKNq7gUqv9ZW/
         iRav7a6ucm/YBDbGEyVh0r1EnUFGQaAXDCW9vQ7GKnVNnKZ3c9vMGgb2WjPgMHxTopnK
         EBVQ==
X-Gm-Message-State: AJcUukdD4gvCgPbD2rL0Nz5eBrtBR6aKj60phEE9NdtQTnKHoadDto3b
        rfntNG7PMHoaqOLEWhUYl7nxc9mZHXM=
X-Google-Smtp-Source: ALg8bN7auManVNcXvNC0adk6cLwS53omYHeXvQ3IKRI+5FPlGLjNBN/V6magOWSC8fouvtvyYSImCA==
X-Received: by 2002:ac2:5599:: with SMTP id v25mr12652916lfg.169.1548520344420;
        Sat, 26 Jan 2019 08:32:24 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id e94sm2170532lfi.23.2019.01.26.08.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 08:32:23 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 0/2] spi: support inter-word delays
Date:   Sat, 26 Jan 2019 17:32:18 +0100
Message-Id: <20190126163220.26421-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed in v3:
* Drop setting of inter-word delay via device tree

Changed in v2:
* Fix atmel-spi driver to not unconditionally set minimal delay if no
  delay is required (erroneous clamping)

This short series adds support for SPI inter-word delays and configures
the spi-atmel driver to honour the setting.

Some SPI slaves are so slow that they are unable to keep up even at the
SPI controller's lowest available clock frequency.  I have such a
configuration where an AVR-based SPI slave is unable to feed the SPI bus
fast enough even the SPI master runs at the lowest possible clock speed.

Jonas Bonn (2):
  spi: support inter-word delay requirement for devices
  spi-atmel: support inter-word delay

 drivers/spi/spi-atmel.c | 18 +++++++++++++-----
 include/linux/spi/spi.h |  3 +++
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.19.1

