Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB292170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eorNFOES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB292170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeI1CJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:09:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1CJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:09:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so2641224pfh.2;
        Thu, 27 Sep 2018 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NyltW0T3+m2Q3RLz0xHvkBC3ilCvPRrdix0TWbU39J0=;
        b=eorNFOESZOzUGrzG3p5iXGs9psXwxlbyQIHwiCHW8KLcNwu5wxpUPWJWRTnj8E5IgH
         Q36drIQZCn3GcvwDR4aQZI8Irxy7j085er51Nl4KWhQYlTi9bQIbvSz8nmbrtcaoEa7Q
         rObjYZjGgAub3POvkSakY30TB9Uhh7F8kCASvjjqsQSdZ73RQsb3jmNL5Ghz69HXYAW3
         4L278dHvWCdHyEMHhfxfqrk0ZTWANmzxCToWScaIEUNSoORshAaDMjrR7fflhKC+Xqsx
         WaQ8mU4/gMzkYs6UIQHv4OGMzPukZrvFr8T2sCNC6ZRuuyVJvza4BfgaiNrKc73+mueF
         3jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NyltW0T3+m2Q3RLz0xHvkBC3ilCvPRrdix0TWbU39J0=;
        b=gZV4znlvcyZKuSn3S131MjEKB0xmNZ4OAeeUgMlttWQkMkA/Xmloj4CWcQryWIxSFz
         fEVc2WdtUgWd/8PwSTd5aRpYtlXZYmk2gBuvp7Au7Lss3NhFDvumQ/MO8BPDn59qzwyb
         bEJ8TsN/pXBMbQprVECHn0RBXPhdONz3E8/Z/OAeySqkKnTEV9Sx/TDzbpWL93igb6Qt
         G60Ahydo3Ow7qptIMeetYgItvY/h/4cWCAbRoVs7DV+vKuH4hCmSKg22QiCkKBKaV4tW
         scrjrcj+moPeJr7/9L11cSgCv5ifSuKxxnN9g04mRCHKYZswHKJMIBuA4mX07mPNHnFD
         iOxw==
X-Gm-Message-State: ABuFfoiNVqSdVy7fUI8clU03TK7ZJWY9gOaPgqULZBuCju+AybL+gy+v
        ofdodyTBpSYmVUNPUN6u09k=
X-Google-Smtp-Source: ACcGV61onZl98wmTy8h/bPpyTV69RF13jJK3zKtJfyC0R1U9OvDesa+2EdGb32dcPB/UYpTsoaZwGQ==
X-Received: by 2002:a17:902:566:: with SMTP id 93-v6mr12810650plf.184.1538077756082;
        Thu, 27 Sep 2018 12:49:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g65-v6sm1449850pfg.98.2018.09.27.12.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:49:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 0/2] Add an initial DT binding doc for ina3221
Date:   Thu, 27 Sep 2018 12:49:08 -0700
Message-Id: <20180927194910.18464-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It defines
a child node to describe the input source of each ina3221 channel.
Then it changes the driver to handle the information properly.

Changelog
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

 .../devicetree/bindings/hwmon/ina3221.txt     |  40 +++
 Documentation/hwmon/ina3221                   |   2 +
 drivers/hwmon/ina3221.c                       | 237 ++++++++++++++++--
 3 files changed, 265 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

