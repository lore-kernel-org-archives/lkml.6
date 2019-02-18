Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C79D218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497659;
	bh=0BD/bkPUDxW+NRuN4vRYSC4jX3MVR+jvZHjHdasuXJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zq6EAtySDh0HHB4gs6Bsz00lCsMg7vO9SU0czQ9IvrhqcxX/ouV5HqD5sxbbjZubO
	 UjA/JeK0g1VA2f7rWJVcz7P+l86F4DeaRDBu4t5meTeq1ZSdActZK3z6Z6YSEasYtM
	 OreNc3ZpbtqBo6ZmMx+Ne+tyZkIpRIsmCkJsOth0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfBRNrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbfBRNrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45846217F5;
        Mon, 18 Feb 2019 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497654;
        bh=0BD/bkPUDxW+NRuN4vRYSC4jX3MVR+jvZHjHdasuXJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSG9h42NjsupimXu4mNjvbs5Y0WbXeAJhgeHJ4W51P1QJLgFRrcDiKhZRhkoqXxru
         Hk5nW36zeMV8RukMkmWWZEkgGKrNRucfucUAwoYh1XgKE8lTkjHD0iaCBIotdBOsRt
         D8eJ1GLAATlrJcJib60c6TAktRlqHu2t/9uY67Og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Voytik <voytikd@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.20 52/92] arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64
Date:   Mon, 18 Feb 2019 14:42:55 +0100
Message-Id: <20190218133459.606161278@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

From: Dmitry Voytik <voytikd@gmail.com>

commit 26e2d7b03ea7ff254bf78305aa44dda62e70b78e upstream.

After commit ef05bcb60c1a, boot from USB drives is broken.
Fix this problem by enabling usb-host regulators during boot time.

Fixes: ef05bcb60c1a ("arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -40,6 +40,7 @@
 		pinctrl-0 = <&usb30_host_drv>;
 		regulator-name = "vcc_host_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 
@@ -51,6 +52,7 @@
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 


