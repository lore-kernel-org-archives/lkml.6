Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADD5218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeibXxXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeLRWAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:00:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42937 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeLRWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:00:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so17472071wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgNGzAIjC+h/YGa02m+8VUza7KfaHGEKOk/Q/RGkFyg=;
        b=SeibXxXRwP1rn7Y8dWILe0s04iu43wZy+/Ur6VThosHdeXBCXVWLNCTUiKJ4XN5ENk
         T913xZjN/lpvB4eBRRSbEngpCj4t2INWa7YnihA05C1CQ0yRtZiMPABS9LCHEVkncjw8
         XuOwP41hFmbcghVvW0SNVT/yK2eqShAEy1vXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgNGzAIjC+h/YGa02m+8VUza7KfaHGEKOk/Q/RGkFyg=;
        b=o96e4BJooyGewou61oA+H4ksoSPlHDw/d1A3EqOhENGryDUU4ajJItcoo1lXfGSsag
         JQTqHn5kRPYzlKoLrA5bz0aIsOyN1GjymD5fhdgoBnCZVDGLT4jJthCH3ES/4BZyadRG
         rko25vcISW/nHuwfWiJZtN9Vg86wDCmKOo4rIRYaYjtltUwnpqU3bvobCdIcBGWKAo6O
         g+ISdCtJOf0HH9JiVoPYj6gX0GgipMyEOyLJ2Kme8MOWKgWDehsMyYleHGKxfjjMWuZN
         kgDJrCjbdJPCioZjZWkKp54bHzt+GPV6dP00/m5k6elXCC15wkK2z514w9QcmYzOAgR7
         TEtA==
X-Gm-Message-State: AA+aEWYQ0po9WOJV8bZuFLen/HeD0FnSO68WTACC/cn5YLjch3qc3l6I
        D9Rk2RbStoctIJDlLo1B3t3mVJ7v/IE=
X-Google-Smtp-Source: AFSGD/VytNXtAxnX/T6GZAheVpg3PEwPewqOCV2CbG63DuIZDP6+4cZaomdBi6CmvMM5vCRBKsjnXg==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr16597120wrv.88.1545170411633;
        Tue, 18 Dec 2018 14:00:11 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id x76sm7449158wmd.27.2018.12.18.14.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 14:00:10 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux@armlinux.org.uk
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v3 0/2] Update AMBA driver for enhanced component ID spec.
Date:   Tue, 18 Dec 2018 21:59:42 +0000
Message-Id: <20181218215944.2444-1-mike.leach@linaro.org>
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
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

Russell: Do you want me to add these 2 patches to your patch tracking system?
Thanks
Mike

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (2):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add  UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++-
 include/linux/amba/bus.h                      | 32 +++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.19.1

