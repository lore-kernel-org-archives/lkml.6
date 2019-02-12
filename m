Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C2EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677EE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W1sObXA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfBLODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:03:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46013 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:03:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so2768948wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tckqtzwjj5TWT5FFf8VcTFGwnA9DW5qTKhzDQO+xdxw=;
        b=W1sObXA3tijnRtq9ZeKEd1a75IWHrsZI6GOydysmPtdFkNrb1mpavtyiNFnnj1LT29
         sGFOTlB6WBew55Q9rf/0rwjIkNKA5oTmeh9DaL+0WPj+E2hlRF1oqEZKQLLUbaDZO7w0
         vkYcM20JhjxbJqEZKmE4DFygCXGsET/WFZDnOnkjbrXqairEyKGkwcsSg5oPQ8sbUrAO
         SMWzQEVkr5wab6zZ26zYje/y3t+MYUll+lQgK1eMMjKWMkekZ5duEYNpK45ZbN9Ztjya
         v/bG7DgKK3P0N1HB/JsxPPEdiqkOvYnakAaSiNoFJLYsVbLZMbzN9fluCGJLynWw1Amc
         lJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tckqtzwjj5TWT5FFf8VcTFGwnA9DW5qTKhzDQO+xdxw=;
        b=ipJqSAB10HJulpMD7+Y8bOYP+FY4iVnkTpKgUjpUYyFlScSB4tNlWYQ3FFjSIVmYmN
         BKQgqPKnqrJC2AeVYIC/tepiTSvzt1vJXt+e9uedZ7gu7OZUCcikyk2k8tLdaNG2DJEF
         emAX9J4HDMTaTKSB5BtkPeNkQ0wvl9ajBrOY5uus0BkSJEzzLpMxtf7ezavYwaOM9FMr
         ekwSX9BRJrYgY1jt405DYo03EOyb+XvouV+K09RZuV5PJDEdMOID9yAmlpmX9jczjHlt
         tcK+v9mJ4z50/9/m4RpCziF05FtHdYhjxbmwziFW5j79sFM61x/emlw8CvK61I4wcuOq
         Lg7g==
X-Gm-Message-State: AHQUAuayD3usOP8FoYBorUSllcVVwPlRocqNSwx1NLD2BxrXIZFPSaaE
        ohx88GRWpiagWRnjE4OQFt83hQ==
X-Google-Smtp-Source: AHgI3IZXFnjSZ5BPU3aN3v4F9GfPm4trRAXctnT/G05Fl6rThVrcy7XUfNNfZagCOnrgMLkrOkfChg==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr2954715wrv.277.1549980182633;
        Tue, 12 Feb 2019 06:03:02 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:03:01 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: Add SEI Robotics SEI510 Board support
Date:   Tue, 12 Feb 2019 15:02:57 +0100
Message-Id: <20190212140259.9537-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds minimal support for the SEI Robotics SEI510 Board,
which is based on the Amlogic G12A S905X2 :
and has the following features :
- Amlogic G12A S905X2 SoC
- 10/100 Ethernet
- USB2 + USB3 ports
- Micro SDCard Port
- Audio + CVBS AV Jack port
- HDMI 2.1 + CEC Port
- ADC Touch Button
- Far-Field Microphone Array + Mono HP
- IR Sensor
- IR Emmiter LED Array
- RGB Led

The first patch adds the Shenzhen SEI Robotics Co., Ltd vendor prefix.

Neil Armstrong (2):
  vendor-prefixes: Add prefix for Shenzhen SEI Robotics Co., Ltd
  arm64: dts: Add SEI Robotics SEI510 Board

 .../devicetree/bindings/arm/amlogic.txt       |  1 +
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 38 +++++++++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts

-- 
2.20.1

