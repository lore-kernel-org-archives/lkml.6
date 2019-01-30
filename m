Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0017C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAEF21900
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIcGm47b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfA3Xk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:40:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43825 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Xk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:40:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so1296746wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoQpmnrQILE9VZn7UG83GWFanQbctVJxciTsFkrKO4c=;
        b=jIcGm47bwiYMa0K0tJp7cB1ARPhvZ6n8KbAZ7R+wIvmbX/x2T4jqp1+CIP4aOw6mm5
         wW5CNXjjvxUO0T9gm/eWtF8PYxkcQq9vPJCwZZIDBqRAhRjXHYUV0ExhTXab4exeU8A6
         awCtpgBE9mN0nfJC82BPx7Zom5n4kBEKBUYmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoQpmnrQILE9VZn7UG83GWFanQbctVJxciTsFkrKO4c=;
        b=aA3zb/T2Yn1fD73kd1HBYE+dBjp58lnMRhLztvpYN6l7OFxSUsa1OTUTCWOJz6mB52
         ngdbmhyRjw3PDXNqi+DxU51tT0896qG0P5rSI+N+3izWv+8p5XDXCJcbtzDGK85Bp1PE
         3NTSlrMz89yC8zxszdCSA2zRvhJfcLOz6+tM6QNeP62oRyLfqaMyAH566+IYdIlnRvlR
         eqBTYYUlyEdSB9oeaxIfHrG0jTrUDmlZ+p+GRmg70ZQZR1Fum1GCFJPzEt3/dE6Ph7j9
         vFutCaAeXTyFJWQhK01rXzYidnG6bAbmoZ4++CGiJ+htvGSd4ssWBH4tgaTx3CuD3iZ4
         pwzQ==
X-Gm-Message-State: AHQUAuZjYRb47ugnZXpCS8zMsIrQZReJjLzLcsCylAunCVUkFaQKunoc
        gIaKibAkuAGbLec0UG/UxPE5jw==
X-Google-Smtp-Source: AHgI3Ia9EW7qeAFQ4Tw73Cze4UYXFce9rWOtis57ZG1OR7zM1HfM+J0RttygLOkr+IZMCKhNrCfSdw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr1285177wrq.178.1548891656790;
        Wed, 30 Jan 2019 15:40:56 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 15:40:56 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, saiprakash.ranjan@codeaurora.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com, arm@kernel.org
Subject: [PATCH v4 0/3] Update AMBA driver for enhanced component ID spec.
Date:   Wed, 30 Jan 2019 23:40:48 +0000
Message-Id: <20190130234051.2294-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 15:12 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35, and reported new devices that share
PID for multiple components, while overcoming the limitation of binding by
PID alone, which cannot now work.

Patch 0001: Adds new UCI data structure and uses it with existing drivers
that use private data field in amba_id. This fixes issue from prior set.
Patch 0002: Implements the UCI matching code in the AMBA core code.
Patch 0003: Update ETMv4 driver to use UCI as appropriate. 

Thanks
Mike

Tested on DB410, Juno; kernel 5.0-rc4

Changes since v3:
Fix UCI structure to allow CoreSight drivers to set private data. This
fixes bug where none-UCI private data would cause a driver binding
mismatch. (e.g. STM).

Add CS_AMBA macros to simplify building AMBA ID tables, with and without
UCI settings.

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (3):
  drivers: amba: Updates to component identification for driver
    matching.
  drivers: amba: Update component matching to use the CoreSight UCI
    values.
  coresight: etmv4: Update ID register table to add UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++------------
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++----
 drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
 drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
 include/linux/amba/bus.h                      | 39 ++++++++++++++++
 7 files changed, 153 insertions(+), 80 deletions(-)

-- 
2.19.1

