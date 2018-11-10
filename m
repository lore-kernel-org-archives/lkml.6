Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E0FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9082C2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kaj2QNKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9082C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeKJNXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:23:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeKJNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:23:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so1654684pgp.13;
        Fri, 09 Nov 2018 19:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie6nUgxmR0xIwmcz6X4nQyYTvc5FzCHbGlqjwDjF0Fg=;
        b=Kaj2QNKfIeNXTXWqQdvzjU5g/pSctSYToI8it9p0MQjnzYKhZLRkBs+mTwl2oC5TsI
         V+aKZ1X92b32Jus/H6iNrj1OwoSbmZwg1o48dJ6gJkRthQHqQy7B8R43+abA1jjGhcTy
         vG9cZySnYGqnNx0FyfqhOjLy3vqfWvsLhjhYGPDMXufJ4ny0Z0Dzt6cypD7AmhaRUUOV
         x2P85HJBg50r35tluuxYOy2b0mUnORD+qNhsw9kD2e+OSPKriSI51+HGAAhssEjF7mbQ
         xJyNeLL31ooZOWxNPAL8ia+hH66PSjdA3sE+OmlfFyF+mSUw7ofTSMv0cnCtS1WNTw3A
         bpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ie6nUgxmR0xIwmcz6X4nQyYTvc5FzCHbGlqjwDjF0Fg=;
        b=QEwDOJ8kmfk2kxa78QWSjOH2eTSLTcQpiR2EDfx/Meyww0Pv7pdwQsaSkNM4qPj0Ef
         bDgF19+GDNgwcbRqT80rK9rfm2Y7dcASNrhKYpQhRncktzHIgjAPt1HdHXuPX446wRhs
         DAGTfNPUorHYmYzs9GnxlB3j9G12lcy/t/o0+swuzUs+0gknXT4kzYUi3BNmZgsuMTn5
         XC6GmDG+hmDuZV2OGqUoWAx3Xyd2+3izX2oEw97Z3Am/VnvM7iRE9nMR+DkAZBLgt68n
         2fJMVmBsyRusLFEhX6BdemHitxSQQhh5iodJSSfMYQb8X5yGcdoCqNvCZl/4p4IgWX+9
         z4DA==
X-Gm-Message-State: AGRZ1gJ9OVO1YfFqGm9VAqRWLKlsRatHNAp0PhIid+et7qsj7Eccn3Y1
        K4Aio7YOnA0QfpRppuBXiaM=
X-Google-Smtp-Source: AJdET5ehXFuNj/z/TInfLVwo05UL1lEBpxjWp4jCsmF51ATwPYAZKVgQnX6KPqHs3XoocRbjX2UGUg==
X-Received: by 2002:a63:c503:: with SMTP id f3mr2528733pgd.431.1541821179125;
        Fri, 09 Nov 2018 19:39:39 -0800 (PST)
Received: from localhost.localdomain ([45.76.192.69])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10191359pfn.89.2018.11.09.19.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 19:39:38 -0800 (PST)
From:   He Yangxuan <yangxuan8282@gmail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: [PATCH v5 0/3] arm64: dts: meson-gxl: add support for phicomm n1
Date:   Sat, 10 Nov 2018 11:39:01 +0800
Message-Id: <20181110033904.4207-1-yangxuan8282@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Phicomm N1. This device based on P230 reference design.
The phy is RTL8211F, need to disable Energy Efficient Ethernet (EEE) to make it stable.
And this box doesn't have cvbs, so disable related section in device tree.

Changes since v4:
 - include device tree

Changes since v3:
 - remove external phy from device tree, will disable EEE in meson-gxl-s905d-p230.dts

Changes since v2:
 - remove changes section in commit message
 - add commit message for patch of vendor prefix and bindings documentation

Changes since v1:
 - rewrite external phy section
 - add phicomm vendor prefix
 - add phicomm n1 in Documentation/devicetree/bindings/arm/amlogic.txt

He Yangxuan (3):
  arm64: dts: meson-gxl: add support for phicomm n1
  dt-bindings: Add vendor prefix for PHICOMM Co., Ltd.
  dt-bindings: arm: amlogic: Add Phicomm N1

 Documentation/devicetree/bindings/arm/amlogic.txt   |  1 +
 .../devicetree/bindings/vendor-prefixes.txt         |  1 +
 arch/arm64/boot/dts/amlogic/Makefile                |  1 +
 .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts | 21 +++++++++++++++++++++
 4 files changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts

-- 
2.11.0

