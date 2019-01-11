Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C98DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140352133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217296;
	bh=uq5JL/jrvM0FwZp/oqW/vKAogok0WeVpBDAyiuj+0F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EAfCmxoWebXBCvJG/sGy37pYVi886Xh/P5F5RtxQAKWcvQA2jXbM8opFliwVXjkLl
	 EeMemo5oRqG7oaWtDgWrGO4qlXnHQ5MFm866/l9pqTNWAL/mZmi3aLYjdeJQu0wW7l
	 CjqckcmJyAGgOFCztgGoSA4yEgzx87Y79HZZj6SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfAKOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389554AbfAKOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0743204EC;
        Fri, 11 Jan 2019 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217293;
        bh=uq5JL/jrvM0FwZp/oqW/vKAogok0WeVpBDAyiuj+0F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urZR4I/P6OpOMcAhRKdG5d732P5UK5QS2VhYRD3ssZDGUMSvuIg92/kB+Gxq6GGob
         Etzy/s0ftGwZVOLpWgnB5CCbXFLsVbbHt8eGeGIYFCzJ1i5MubYipGRip0Fe1bAVpD
         S0Nbz6yXb4sJuy8FTH7FOaWrU5wA7E9z/VJn4Cow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/148] ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V
Date:   Fri, 11 Jan 2019 15:12:59 +0100
Message-Id: <20190111131114.391001335@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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



