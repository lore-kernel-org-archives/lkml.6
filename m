Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56753C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9F62170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9ui6lWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9F62170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeI1DOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:14:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45581 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:14:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so2780545pgd.12;
        Thu, 27 Sep 2018 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P5Rd6p4jsWq71kIYji+uUh3Ej9u3ymYB/pmbVBVe4B8=;
        b=k9ui6lWHO29wsCotFyQzm/FOCWsi3RT4kWyxF2cUYiTdi7Pn7B9ZM/WYS+VAr7YOdd
         TWCE/1Wun6GrktzZ8z5JInpWuJVsIA/UKZ1uokjhSA8a/UkDg85lggLAVjiMjxnQKhoF
         RFPqttjzCUHJlOhlQ9dxSygT7Ok9HFOJXbGA6iDePWwvzCY9MXjCJ3WVXzb5/uHRNM/2
         GBSlzYyvhIqsEh88/pq2HoqGjCAA963MoztWCEx+Nccv2aFSS1tqaBDkBAWW3ZYEQyuE
         e3GrpMV0aVCZ60hp0S6xwyW2fYlvlwRsy3sZabeM9jQqQV0TqsC1jW1G+PT6fSAL6gF3
         ZOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P5Rd6p4jsWq71kIYji+uUh3Ej9u3ymYB/pmbVBVe4B8=;
        b=KDDq7/yU1On8Zxvy1h1uPWo+t8VghPKMYoKYsPX+OqXhd2lvf9vHSHpG6Hd1J8N7Kg
         L2NTFm0UnzLESVFw080AZIhhGN35IZntW2l3w4EbrPJcH86VjxEn8aJiG/JZ6Plr93bI
         JrRd34iImvKqLhsK5nwQdxdSgfEaq7W5PH3Dl+vXPfeF0/hUqjNbru5t4Je9pwscvB8V
         8yme3EUzTt9eB55SiwL6KCbCqrUjFxyt5QiuYknd/iNez1j/hQAOGrJGp4ds8+zJoBwo
         J5CM+seRjRXXrKBroL4+gkTVbRx+MEem4AlM8preZCdwF20IVZ8owmUNf0witVqxD4d6
         mpQQ==
X-Gm-Message-State: ABuFfogQuo9kVQfTxUu9V8FB+6zItQAIYhs1EVMZW29M+toUg13aSn1X
        1M8pjfBZuuPmvosu65EzqgA=
X-Google-Smtp-Source: ACcGV63cCOorHzjrLaW2jkb+Td+UeZUQt8rQNsmapPat3dM13RxDtwOSM/Qbs1ZNBiNnxPDRqaxaTw==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr12709715plr.242.1538081653120;
        Thu, 27 Sep 2018 13:54:13 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v26-v6sm4354101pfe.57.2018.09.27.13.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:54:12 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 0/2] Add an initial DT binding doc for ina3221
Date:   Thu, 27 Sep 2018 13:54:04 -0700
Message-Id: <20180927205406.21932-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
v6->v7:
 * Refined the example in the binding doc (PATCH-1)
v5->v6:
 * Removed status property and merged examples (PATCH-1)
 * Added in[123]_enable sysfs nodes (PATCH-2)
v4->v5:
 * Changed two property names of child node (PATCH-1)
 * Changed the driver accordingly and simplified is_visible (PATCH-2)
v3->v4:
 * Fixed one place in child DT node bindings (PATCH-1)
 * Changed the driver accordingly and added is_visible (PATCH-2)
v2->v3:
 * Fixed two places in DT bindings (PATCH-1)
v1->v2:
 * Redefined DT bindings (detail in PATCH-1)
 * Changed the driver code accordingly (detail in PATCH-2)

Nicolin Chen (2):
  dt-bindings: hwmon: Add ina3221 documentation
  hwmon: ina3221: Read channel input source info from DT

 .../devicetree/bindings/hwmon/ina3221.txt     |  44 ++++
 Documentation/hwmon/ina3221                   |   2 +
 drivers/hwmon/ina3221.c                       | 237 ++++++++++++++++--
 3 files changed, 269 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

