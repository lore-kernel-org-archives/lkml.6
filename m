Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C3C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A88218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863763;
	bh=QWVrVEuD0twwM1dzn+bBLVRA49PR5gI/Sc5OihH+tJE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b8mBFDuovTi2nHYhV7+q9q1OqYIOPfPsqkcB4nSPsIWV43BSqOl+x9bU7o5bR/R1x
	 /R7JKd86QTU9pfmQqf61cLDZK78QTDtQsk8+YtN/gX5gdmQS21dGzmslEUwbR6mIJ+
	 5yQhtjs8CL6CxYmAcMwuyRBGHg+1Xs035U+W0Hwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLZWgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeLZWgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257C621741;
        Wed, 26 Dec 2018 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863761;
        bh=QWVrVEuD0twwM1dzn+bBLVRA49PR5gI/Sc5OihH+tJE=;
        h=From:To:Cc:Subject:Date:From;
        b=jyydBE6pEb43ePf4zd64jKkd7rowoqRESv3K571SN3Cof20bSFX3ya1TZqka8R+d2
         D3HV+CdQ6LWTWL0N0es4AdiESY3xii5SmNxyi8nxWvW8fXvGwIx81451E3hoHBi+zO
         gue2RGkfaD6hgmYsj4RokE6rbAXs24p2NdbALMYA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/97] ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V
Date:   Wed, 26 Dec 2018 17:34:21 -0500
Message-Id: <20181226223557.149329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 5f8208f557065163f9a8089ea2ea7888f9d96922 ]

Since commit d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add
AXP813 regulator nodes") my BPIM3 no longer works at gigabit speed.

With the default setting, dldo3 is regulated at 2.9v which seems
sufficient for the PHY but the aforementioned commit drops it to 2.5V
which is insufficient. Note that this behaviour is random for all BPIM3.
Some work with 2.5V, but some don't.

Finnaly, someone from Bananapi confirmed that this regulator must be set
to 3.3V.

Fixes: d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813
		      regulator nodes")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[wens@csie.org: Reworked commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index c7ce4158d6c8..f250b20af493 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -309,8 +309,8 @@
 
 &reg_dldo3 {
 	regulator-always-on;
-	regulator-min-microvolt = <2500000>;
-	regulator-max-microvolt = <2500000>;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-pd";
 };
 
-- 
2.19.1

