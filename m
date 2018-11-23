Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F991C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6412205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g9roArnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6412205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441451AbeKXGjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeKXGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so13369738wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gODjD0eo2vQeoQYeMF+uNMs3RYPbO6A3EDKJq3DZPzM=;
        b=g9roArnjyLDZnVtDT+iM5K2jdtVfMnF0AoRQaob0IWCk9+CBYfKKBQ350OBJWqhWg/
         NhHkecY7KOP8lU3mSqEwGEuF+SEX9fUlh7J4+HaBVTazWqpGWZKl7d+moxIGw06cDFkJ
         63BEcJQwWzYH739j55CyZMp2lDRrgXJh542RfN6u8wE8sBw4bRQVfivXAp+hegT+34nM
         pFK9yAIOaUFMdTLMAwkdV9AOVKQpRE497ZmocA7/iEZew2omsaJGZeLnIFMQ7G2RLjdW
         QnzyDJmX1XJgGAfIs9YYQGaBSFeOKMWh838tqw7karlgDl7l7My/gUXrWmh9z/tb0JtQ
         W0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gODjD0eo2vQeoQYeMF+uNMs3RYPbO6A3EDKJq3DZPzM=;
        b=dhsOPYZzKM4asJO5cK/Zt7W1gkCAnQZXhT4HJQ/LkFsEZCr21py3+vFLZYk0PX2Nyj
         tPq5Jlk5AuzUr4FcLbffO8GjV27Z3mC0VNlbVqHqeGTXWsc1ggyp6l2lb2CH1LJJEH7a
         kzzyoEJUzSh35sTXmjRXmRVyuPKGfAdQBj2EY2mvhsVsW4ujgxov0RIufkmxzYmCPQYy
         GSJZXyk+0LwXqOX5SDbDj7kvKTKc9lSenBWFf6YbIz/2epR1Utzxz39z+HsE77Q+D7Po
         wMWb1swprw+0dKSkWIL/67oEULkDoqXUnWQ+yLjgEADZFcB4bagjj6M/DZwmxKx1ajsQ
         eQCQ==
X-Gm-Message-State: AA+aEWZhG5Ce8vxe/y9fZ5FPZ1oxnJaNJMJU4KZ1U6UED29ypZPqvAwU
        dV1tZsCUeTSpvd4hnWXhhD4=
X-Google-Smtp-Source: AFSGD/XVZY/Gy1e/DGbb/PS1SHQXZH+yaf5RkhGvgF5Hhgzxsi9uHfXzFj1yb7mwPsDNghXB15wfXg==
X-Received: by 2002:adf:f449:: with SMTP id f9mr15627412wrp.40.1543002803973;
        Fri, 23 Nov 2018 11:53:23 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:23 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
Date:   Fri, 23 Nov 2018 20:53:05 +0100
Message-Id: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit Meson SoCs use Cortex-A9 or Cortex-A5 cores. These come
with the ARM TWD ("Timer Watchdog") which contains a timer and a
watchdog as well as the ARM Global Timer.

This enables the corresponding configs for the 32-bit Meson target.
Additionally this adds and enables the ARM TWD timer. The Global
Timer is added but currently disabled because it's clock input is
the PERIPH clock which is derived from the CPU clock. Thus the rate
of the PERIPH clock will change when changing the CPU frequency.
Unfortunately the Global Timer driver doesn't handle clocks with
changing rates yet (unlike the TWD timer), thus we keep it disabled
for now.

The whole series is inspired by an almost 3 year old patch from
Carlo: [0]


Dependencies:
- I build this on top of my other series "ARM: dts: meson: add the
  timer interrupts and clocks" from [1]
- CLKID_PERIPH requires updated clock driver headers. Neil provided
  a tag which includes the updated headers: [2]
- There is no runtime dependency on the PERIPH clock as we don't
  have CPU frequency scaling support enabled yet. In case the TWD
  timer driver can't find the clock it falls back to auto-detecting
  the clock rate at boot time. This is safe as long as we don't have
  .dts patches in place which allow changing the CPU clock rate. Once
  we enable CPU frequency scaling support for the PERIPH clock becomes
  mandatory so the TWD timer driver knows about changes to the PERIPH
  clock (which is derived from the CPU clock).


[0] https://patchwork.kernel.org/patch/7797581/
[1] https://patchwork.kernel.org/cover/10687005/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html


Martin Blumenstingl (6):
  ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
  ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
  ARM: dts: meson8: add the ARM TWD timer
  ARM: dts: meson8: add the Cortex-A9 global timer
  ARM: dts: meson8b: add the ARM TWD timer
  ARM: dts: meson8b: add the Cortex-A5 global timer

 arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
 arch/arm/boot/dts/meson8.dtsi  | 32 +++++++++++++++++++++++++++-----
 arch/arm/boot/dts/meson8b.dtsi | 32 +++++++++++++++++++++++++++-----
 arch/arm/mach-meson/Kconfig    |  2 ++
 4 files changed, 72 insertions(+), 18 deletions(-)

-- 
2.19.2

