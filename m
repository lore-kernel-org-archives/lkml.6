Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155B021873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151438;
	bh=u/euN5k6b/G77ab6COVitbQboIWq98AS5t4/1M97StY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOxvzGhrfB5UTi+kZb6H1w7XnpOuHH+Pexu5DOylGt+lrEJGiRkka1uRXv+tacISu
	 EixzQhqgg9qPwP3SQ9ICRJQJtpEs0fQHZUQwxWKqzR9Q0G2Eq3gMy0Db8JKNbiOTi5
	 ZTDn25osfGBBfddMYEJVnW5eHcMYjdpRQZusoQ4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeLRQks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeLRQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1670218A2;
        Tue, 18 Dec 2018 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151242;
        bh=u/euN5k6b/G77ab6COVitbQboIWq98AS5t4/1M97StY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tylkVoS/erVV6Qdv0gXk/MZPgXNDeFufZ32U543+Q6l8tcVv16pNci/7JPsyuvXX9
         AFrny3ponkEwm2HruIDx/fAMSfkCl+NvfGAKLfUDHb82OMpBAZ7u672ZjCqLui56uB
         F2ysW0gvdeSzV340YriLYYo3J30ixksi6TNkIwVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Lueschner <lueschem@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.19 23/44] ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs
Date:   Tue, 18 Dec 2018 17:39:35 +0100
Message-Id: <20181218163930.214408235@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

commit e25b6783c7b1bb79103d4617336879423f86b05e upstream.

The commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
introduced a wifi power sequence. Unfortunately the polarity of the reset
GPIOs were wrong and broke the wifi support on Raspberry Pi 3 B and
later in 3 B+. This wasn't discovered before since the power sequence
takes only effect in case the relevant MMC driver is compiled as a module.

Fixes: b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
Cc: stable@vger.kernel.org
Reported-by: Matthias Lueschner <lueschem@gmail.com>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts |    2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -31,7 +31,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
 	};
 };
 
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -26,7 +26,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
 	};
 };
 


