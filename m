Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C000ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0C20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE0C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbeGUNoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:44:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeGUNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:44:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so9014798pgu.8;
        Sat, 21 Jul 2018 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uCJ4Zv6LjoMiD5XWxiwB0bYfIo3VCHNwFZUaJGvVQ7I=;
        b=sn9E5sifCUZ704Z+zkF6XVs4jbXKaWCs1R/wr+BUti46REtOVeZBKpdIgDwACuvpwQ
         esivgggUJG+POcEKEmQMnWvLtH4D4HSl7UH3TQh2NHs2gC+zgjEwX2q9d0xGAvIIfIlh
         U1DLXHACR3xW4oOl+gGnTggZnUZLKOPstzPhmLqy+Z9KWC2EgBkG0S09vJHQIjt9VoVg
         Uy2CrP+6NE1UXwA3IgTPbxQ9JVKK4KkogH6kOcnarA5v1E3Cagqv3KN+WaTE998FVOkN
         U8LoLIoLGLnowgGgv15+8SElexxMm4PRjt6RB4sdBOvwHPqcKKa5FSEfyRnx1yVfM3Pw
         3MfA==
X-Gm-Message-State: AOUpUlHjhYHyR2oYeiWdvVhZdaRSZTp9r0ZnnTCpLYvnJV7Fh3UHpCuY
        V4OE65mjsjT8zEZWltGh6x83IP59
X-Google-Smtp-Source: AAOMgpe0HdWBFrGTqCAn60qHlz2WCeX0/fHFVa7fM80fa66Yaq2l3Ro5ZiRZ19K7b0+AuE8zZ/1lqw==
X-Received: by 2002:a63:c80e:: with SMTP id z14-v6mr5446068pgg.77.1532177520815;
        Sat, 21 Jul 2018 05:52:00 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:51:59 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] midas: fix IRQ pin configuration
Date:   Sat, 21 Jul 2018 22:50:48 +1000
Message-Id: <20180721125128.31498-1-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series disables the internal pull-up/down resistors
for IRQ lines which are pulled up externally. Without these patches the
associated IRQs never fire if the bootloader hasn't configured the pins
correctly.

Simon Shields (5):
  ARM: dts: exynos: add max77693 pinctrl config for midas
  ARM: dts: exynos: add pinctrl config for midas keys
  ARM: dts: exynos: add pinctrl for midas fuelgauge irq pin
  ARM: dts: exynos: configure max77686 IRQ pin on midas
  ARM: dts: exynos: configure midas SD card CD pin

 arch/arm/boot/dts/exynos4412-midas.dtsi | 35 ++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.18.0

