Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DBC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A1D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895816;
	bh=RGvVVdQSRR7FvcIEW6KyEwi9jK4bBCQJsv4MEHSrAD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDBxa2Z0r7S1ZqW+rV7oLmk1pEEfe/IGUQ5f7HKdigbModRpBYbGdTyHFCfvvEZq0
	 oap1fDK4kViWduI4iwxVZ9hi/gj6IKUGtxKzf6TEOG8re4cp0Sh/nHoG0nKcUP23qG
	 2C6rwiPQA/EwDmzQv2oPuX1COJJ+m8BooIC/ujVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfBKOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbfBKOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE80920844;
        Mon, 11 Feb 2019 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895810;
        bh=RGvVVdQSRR7FvcIEW6KyEwi9jK4bBCQJsv4MEHSrAD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRGx0VsLFmW+ZwdV+TYfV0xAMxvkA3WzA3HP73z68B02A7lV6XqX7xU9KTTRHSydz
         76Ki8OZ+BxGuzLuXw33xTVc0rSkVBr8vr+oG1BPLo3fK7fyjRrbkhYKJLaCQ0+IDou
         q1PUyjoGNppXr6yita5/23dF3kvNdYNIC2SCqyMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.20 330/352] arm64: dts: allwinner: a64: Fix USB OTG regulator
Date:   Mon, 11 Feb 2019 15:19:17 +0100
Message-Id: <20190211141907.896089827@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jernej Skrabec <jernej.skrabec@siol.net>

commit b1360dcfdaa1d55952e5ec8dd9d99f88965d7ac9 upstream.

Currently, AXP803 driver assumes that reg_drivevbus is input which is
wrong. Unfortunate consequence of that is that none of the USB ports
work on the board, even USB HOST port, because USB PHY driver probing
fails due to missing regulator.

Fix that by adding "x-powers,drive-vbus-en" property to AXP803 node.

Fixes: 14ff5d8f9151 ("arm64: dts: allwinner: a64: Orange Pi Win: Enable USB OTG socket")

Cc: stable@vger.kernel.org
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -188,6 +188,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 


