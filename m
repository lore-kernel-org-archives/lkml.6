Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B10206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vtsq5oFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B10206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLCNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:20:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39818 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLCNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:20:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so12140100wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dDYWcGw/WcqQiCks78l9uhvporxrTWQBg5cG5YlzJMs=;
        b=vtsq5oFhnv3QDDJDm6k9H9hwhp7LnKzGVO/zNsUWhrEkD4wQt1KYCoy+BymPHXiCQZ
         ODKEAEIQxaiye8SXsKGVTSoVlFAVqAS4HQXsfxo4bmJs6BA8Xe9i6hOfsyvBunLZ/s/5
         ZNNGIU+oe7acy4ZhT+YWU+PBPGGiOVOnWmorYVNDHGOmnH6Pg2W5cEYCZWp+Stt0//gy
         Dz/IxHCqkFuN8eTqFbARI9qAZH5fAb2MQZb0MgnQGYnhSiL5eI36e03OWgj5EE031rm4
         wblbVKQaGhh3kcUFXCSIA2et63ilR50K4EDe/HfO+0h2WSxpENnyr0Q0bG2X6X3I0cgV
         Qz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dDYWcGw/WcqQiCks78l9uhvporxrTWQBg5cG5YlzJMs=;
        b=ZbTcjFk+tSjfh9IWsfDZjhaf66lV1NUwH6dptEndGL3Z5yHIoQWh/HbKIIildHA3aq
         ZVJ93s6wJy32iIgbxUA0mfVkrYojVmhXrBtoKGb/UKE/rFB+UWFNXXTeBYsVMdKBhXeT
         fjKnUWbUKwbDf24EPrbAI2IMJtsM4slDd1tidZejNGw3SrcFsjHy/XLuxZBepFe3WFDZ
         n/xjJlXYD/yqXBfbLsYb/T7qZWslYG1XhMkTzgj3GzCz/h/KaCNdvkREdVf+U3yHTWsx
         8vs+uexEoUbeJr9101mZTC9HkOmXjwj7ubIiF74PZhay9Iwd+nGV6xSwULxJf83fAQJr
         cy1A==
X-Gm-Message-State: AA+aEWZFYC8fElDIIijUXTrz+ezRyUNyCsiohS6deEsl0PNjT/7Z/w4J
        I3P2Nr+/bX9SJSdipcYvKy+KEg==
X-Google-Smtp-Source: AFSGD/WMzOvJuYZbJ+eVbN6i3kOLdbpS+y7D8KK91Vq79ZJQ1zydvhB6h67gWMBnKRZjBbrymliHUg==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr15162979wrw.50.1543843140373;
        Mon, 03 Dec 2018 05:19:00 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n19sm6371063wmh.26.2018.12.03.05.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 05:18:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: meson: add clock controllers input clocks
Date:   Mon,  3 Dec 2018 14:18:47 +0100
Message-Id: <20181203131850.31388-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the first step that needs to be done so the
amlogic clock controllers properly claim their input clocks
through DT instead of relying on fixed names.

I'll be waiting for this hit mainline before sending the related
driver changes.

Changes since v1: [0]
- add clock-names for the main clock controller

[0]: https://lkml.kernel.org/r/20181129164524.18670-1-jbrunet@baylibre.com

Jerome Brunet (3):
  dt-bindings: clk: meson: add ao controller clock inputs
  dt-bindings: clk: meson: add main controller clock input
  arm64: dts: meson: add clock controller clock inputs

 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt     | 8 +++++++-
 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt       | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                | 4 ++++
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.19.1

