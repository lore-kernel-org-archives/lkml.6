Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F48C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9620868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DuHpYSSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE9620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLHQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:46:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLHQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:46:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so7231935wmd.4;
        Sat, 08 Dec 2018 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pM4FAqUmlNQk5CoUyTd1qnDe/uR77MZL4ayRZ464rPE=;
        b=DuHpYSSLnPfY2ImKcn1jNXWNz8BqkY0et3zsd1bze1IERm4cQUwIeVM00EDHff6qyN
         2J6sxik5qqzvh30WtzogVI2lFS3eILZq2A7RBWNNiEDJA8yKPwILbseKGlayPYqWm2/O
         DM/ZwYpPNXI2r4fknEwbm3CX+FDuxG8D+aHLO9qlXrCb1wAiRuF4NszqAd2TZguxhe5G
         5A/P1K3+P4Lnj9/5i8vvI9i5BcY6PhdLIZFlzoz352/GV7RX1BGHkLKzgoPX2BKC27PH
         ycin0ocMg6959cQvd6LBrqM3TUPUlntvTyHsuYikPvC1hf8AgEs2uUIvmXeym6RXYeif
         4P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pM4FAqUmlNQk5CoUyTd1qnDe/uR77MZL4ayRZ464rPE=;
        b=ZBRau1jR9pZjS0tiOZQ/BxmWP7h/F00xeryXOn9yjWvpkGTdpRFP73Xy+vCAHZT456
         fiiVZpUEEigfqw4BfL0wocD7/4cTKKJWd6sAxJa6dgAsNwnqSKNNnlaupoS5gA6bz39J
         JXqATbijuJu7MvVfmp+pUKZeBZVoQ+FZf7U5TbmF75kBxz75tCrQEC4Cpya0hsksppXm
         21AzyPOsMS5XYWtV5uLp1Ezk2dkpADfCLe/t1nrZVTRjEFx+g5DB28GGPNQXah+qEpwD
         4wJmUn3P1LDnKY7dpPlOZw6H9HS++Vx9+m4niFst0DrpzGypplrsBNBW9oFedsaia6Kc
         FgoQ==
X-Gm-Message-State: AA+aEWaiJo9TZcEMFih/5dL15VsEJtQKrNgPYoq6rVCkqdGbPFNYbUvX
        mWMQxKfE27g80piIG+axqPasMzV3
X-Google-Smtp-Source: AFSGD/UPq9RtICsuxf6JrvhRkG/J2kFp1Ibcxi8ueiAdsR83/piZeOPtqS0K1WFu5x/JbTnIkZCKlg==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr5878978wmb.145.1544287614688;
        Sat, 08 Dec 2018 08:46:54 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:53 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: meson: add the APB/APB2 busses
Date:   Sat,  8 Dec 2018 17:45:49 +0100
Message-Id: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
Meson6. This is preparation work for adding the Mali GPU which is
located on theses busses.

Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
region at 0xd0000000 is called APB2 or A9_APB and it has a different
size (256k) compared to Meson8 and Meson8b (2M).

Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
- Meson6: [0]
- Meson8: [1]
- Meson8b: [2]


[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
[2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53


Martin Blumenstingl (3):
  ARM: dts: meson6: add the APB2 bus
  ARM: dts: meson8: add the APB bus
  ARM: dts: meson8b: add the APB bus

 arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.19.2

