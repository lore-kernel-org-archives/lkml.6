Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420C208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSXvShyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5420C208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGaLC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54915 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbeGaLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2254109wmb.4;
        Tue, 31 Jul 2018 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cz/7IskC8IPjQ796NiGLRqJhomWBnOtgz/e298LLo9s=;
        b=rSXvShyQn4PDlEjrJhBPAQykhGE3rz8TEEt5oo/8SbqkoU+c+/XnQbqrBzPP+pinw5
         9Hr/UvC7thYzIRcxs7KrVKrlcv9eGx+xAgNbEQOOEX8dVVWEEVjD3UktQ314nTpBcbCY
         zXkAiWVyJa+vxD6rOEeVojqh/ZAS7mrhB/lp12OR4zxhExWBug5tdqTZ2OxTTw5Cqsg+
         fOR9wGs5pe99kOldbZLiK51Zb5e00Ow3j8AvR7e040UnNRj/HWQqibt8pGVzdWdwbxpD
         bW+lYjZXVJE8iGmoaqH2Q9RTB5EaIr9Yxs96YC1SV9AUBgHkTmLyWt2XKzNv75HXtZ7E
         VX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cz/7IskC8IPjQ796NiGLRqJhomWBnOtgz/e298LLo9s=;
        b=GnDEos4bENVWju2QIVqCta/4WTO5nNMKg0C3KR3/mnKMogZ/SKu8sN5CSJPM9qkze+
         ru1+hwOxZb0UJgUIGbFFi1OKTSoKSfXGsgjYrHV4Hg9defs/Z/Kst5re6DBoC8w4kXs5
         8U0Rc4apjoj9tKGdlG6GCojQLmIuW36T7VoiD1WfLDe7V9UMCe7rb3EvmcNFlq+VzEmL
         byoLcZxXRqETdmUOzHhw1HyaltTtjandP1UsL/CCZnlT1iEHaC5nat40k1a+/f1+Bfk1
         dzEQEtu3FTdfdetIDJ3LUlj5TdjnG6FHifZofyJD5vPWiDP9TjNvf3uT/mp3CQaeI/U+
         go5Q==
X-Gm-Message-State: AOUpUlGgbjrUYcqtisOHqog4wqyciLpT1DOW3PekEux8StUiu9H8mhtz
        XhOd5/gbVepxd3kdu2N+52c=
X-Google-Smtp-Source: AAOMgpd70SwbfuuBVQdomB/WG/NOtBjHb6xDPw+fSX7AL+9vIZIPC69e2TH38A9k+GDBJixTxN9osg==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr1708480wme.6.1533028980062;
        Tue, 31 Jul 2018 02:23:00 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id y191-v6sm1670873wmy.4.2018.07.31.02.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:22:59 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de,
        andi.shyti@samsung.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v6 0/4] IR support for A83T
Date:   Tue, 31 Jul 2018 11:22:54 +0200
Message-Id: <20180731092258.2279-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the sunxi A83T ir module and enhances 
the sunxi-ir driver. Right now the base clock frequency for the ir driver
is a hard coded define and is set to 8 MHz.
This works for the most common ir receivers. On the Sinovoip Bananapi M3 
the ir receiver needs, a 3 MHz base clock frequency to work without
problems with this driver.

This patch series adds support for an optinal property that makes it able
to override the default base clock frequency and enables the ir interface 
on the a83t and the Bananapi M3.

changes since v5:
* removed already merged patches
* adapt patch 2 to be applyable to current rc-1

changes since v4:
* rename cir pin from cir_pins to r_cir_pin
* drop unit-address from r_cir_pin
* add a83t compatible to the cir node
* move muxing options to dtsi
* rename cir label and reorder it in the bananpim3.dts file

changes since v3:
* collecting all acks & reviewd by
* fixed typos

changes since v2:
* reorder cir pin (alphabetical)
* fix typo in documentation

changes since v1:
* fix typos, reword Documentation
* initialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' & remove if statement
* change dev_info() to dev_dbg()
* change naming to cir* in dts/dtsi
* Added acked Ackedi-by to related patch
* use whole memory block instead of registers needed + fix for h3/h5

changes since rfc:
* The property is now optinal. If the property is not available in 
  the dtb the driver uses the default base clock frequency.
* the driver prints out the the selected base clock frequency.
* changed devicetree property from base-clk-frequency to clock-frequency

Regards,
Philipp

Philipp Rossak (4):
  ARM: dts: sun8i: a83t: Add the cir pin for the A83T
  ARM: dts: sun8i: a83t: Add support for the cir interface
  ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller
  ARM: dts: sun8i: h3-h5: ir register size should be the whole memory
    block

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts |  5 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi            | 18 ++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.11.0

