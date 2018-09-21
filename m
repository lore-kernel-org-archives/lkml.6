Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BBECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AFF21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4eYpCoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AFF21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391591AbeIVEXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:23:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeIVEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:23:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so6660637pgo.4;
        Fri, 21 Sep 2018 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CrWttZIXkGDUWUpXPKRtfTuudXRl8wQSxEa6teGnI5E=;
        b=m4eYpCoKerbx2acEOZ6ZF+2CClVBS6ZBpiP9Mwy/a6yIfHD6U3eWbratqtkkRxzP1r
         Xtvr0jSDtnK1vdfjJFfiSag5pvUeTiTiwXkSe+gBsh5EYll7tUJHJrvQtQnqjYjEv5ib
         zAYJRGWQl+JT7giDDLqUHdpx+3XX0K/PstE2ur3/dsCMHThwfaWh1zVaEOlXGRHGMC9f
         sZ+FhCVMgX0CRUBR5gq/HSLC1PeLU/Xr94LJ0MgnjHoK4x+RCTCI75g3UrAgZs1oyfOs
         2GcNtzv2WnwtsnfKDFxAknlouGkdF6dR9lKODhA4ggpl9YBKDvOYqOQDHNn4pjZMGR5s
         nAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CrWttZIXkGDUWUpXPKRtfTuudXRl8wQSxEa6teGnI5E=;
        b=HU1/JqRPgLkKJPi1l3VGuOJAeQoUQI+GXsQ4IediuYuopWbifnolgtD7zLdQE6RHvG
         eTZrJ0u99D01ncdPooejn8vcjhSLIsLSzzzHcPdzukifNJvIgykXwOBnmQzlQGIB2AOO
         WUAsn4p1MmeSjXMLgUQ7WQ2Uum/20mms/m6YMrV6Mwod5sHCiTMAslURUO6Y3tXXThNI
         FtX3xc9Z0tZlOgF1pSlDmagZYglzcQdJZ0OG1EXd2R2tmTCz2QY/YSOyc9udiLbzvHY9
         AQmZodla3PKOJyHSLiKuPUrC58IuZ+KMT2GKoosHT2oWo9Nq2elOK+NVrGUa4DdIghBv
         L4sA==
X-Gm-Message-State: APzg51DCV8U0Se2A6Dboz5uhglHzg7FEJSNdGjo1kxE/65u8NJazFBj0
        c9Y2ggDbcuGuMwj9sfEBY7c=
X-Google-Smtp-Source: ANB0Vda19AXYxH/S5B+q+pTUMgpxE7cKnUxiNLrwC6aXI8NzgKDujsZMFdM4cHa592kv305jsOyB1A==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr48148494pfz.85.1537569148744;
        Fri, 21 Sep 2018 15:32:28 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 203-v6sm31683227pgb.14.2018.09.21.15.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:32:28 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2]  Add an initial DT binding doc for ina3221
Date:   Fri, 21 Sep 2018 15:32:14 -0700
Message-Id: <20180921223216.634-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
v2->v3:
 * Fixed two places in DT bindings (PATCH-1)
v1->v2:
 * Redefined DT bindings (detail in PATCH-1)
 * Changed the driver code accordingly (detail in PATCH-2)

Nicolin Chen (2):
  dt-bindings: hwmon: Add ina3221 documentation
  hwmon: ina3221: Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  38 ++++++
 Documentation/hwmon/ina3221                   |   1 +
 drivers/hwmon/ina3221.c                       | 126 ++++++++++++++++--
 3 files changed, 155 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

