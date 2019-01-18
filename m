Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sO740a5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfARKei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:34:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34384 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:34:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so14486981wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQsdFB7zSu2fdgFvwxux5vAqSxQfjC79f0KKFbqqnxQ=;
        b=sO740a5eRJsCL9zNKH0EtLCBvcZ8dQZ7gYyUVfqixd/ElU65q5usoJbkbygaRgfxDe
         ZUnpKMHCzNaFxU4efzaQ+yCSqWhe44KlTUOLwOd17VF5Pk3ePbgw7UMufRGTrSCBlnSn
         zOC8p/s+bcKgpTh/gkQnvwSNXEfDtzdU4CsrRoG5NztvxOvD8e/HYuLjPpovPW9khLty
         XZ3T3L63zg9fvB+q+EWoSRtIL6DAi8sIW7IaqE4OHG7vC0vOnSlpK2YqZs6eYGbNwvLp
         GE9Lh1joq7mpMFesfW8WcZ1YvCP6dpChRpJpEjiAxO260S55xELpouWw3rwcFCBR0jMy
         JRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQsdFB7zSu2fdgFvwxux5vAqSxQfjC79f0KKFbqqnxQ=;
        b=aUE5uNDBJA1X0Dg+q0c9I8JVmVEft26GZ5hzYEbV/j6aWZU1kDsY5/D+nsf5ko2J0w
         allCSk5XPDQC0ODiFipfyjUrSwaoChobAGVwZY5abHyc190nwwaxthHJpD1ibQH7fZbp
         IfMiiGrmZiv3R+cC+RqcElekejRxUKwJIyifFu1P/xnOROeqRAhQfClInFc1yMSIabn2
         YZbtQD5qo7ImG4wRJ/Aw5TNPaL7PDu1dVpr3eW8cR8AI6fIWpTLHw3uDZ+P1n/Q/ZZgu
         qj68DGJFT4iQ4iK8X7wGFB6/Io5ohv3ujtVaSBCrmn8UBX21wZoRgxh36kbT0KG6ThQK
         5uvg==
X-Gm-Message-State: AJcUukdYTGeYPDaLBqZQEsSjWmBHmQD8Y+ISjmF0C7awL8Vjervq/ce7
        dsbEL3dkaO50c9YGEDDPSAgZwg==
X-Google-Smtp-Source: ALg8bN5b63q7AurgEDVxG6WjpBGyi9gHQDhV3Q/egyIHjwg/ezJHxxgT0nO9EDQ0mB+XZuiiY9y7Ug==
X-Received: by 2002:a05:6000:1144:: with SMTP id d4mr15430631wrx.136.1547807676309;
        Fri, 18 Jan 2019 02:34:36 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s16sm67066247wrt.77.2019.01.18.02.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 02:34:35 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 0/4] soc: amlogic: clk-measure: add axg and g12a support
Date:   Fri, 18 Jan 2019 11:34:19 +0100
Message-Id: <20190118103423.15075-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the axg and g12a SoC family in amlogic's
clock measure driver and enable it on the related devices

Changes since v1 [0]:
* re-order node in the g12a.dtsi
* change node name

[0]: https://lkml.kernel.org/r/20190117164838.8008-1-jbrunet@baylibre.com

Jerome Brunet (4):
  dt-bindings: amlogic: add new compatible devices to clk_measure
  soc: amlogic: clk-measure: add axg and g12a support
  arm64: dts: meson: axg: add clk measure support
  arm64: dts: meson: g12a: add clk measure support

 .../bindings/soc/amlogic/clk-measure.txt      |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   5 +
 drivers/soc/amlogic/meson-clk-measure.c       | 194 ++++++++++++++++++
 4 files changed, 206 insertions(+)

-- 
2.20.1

