Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E9220854
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqX/AkwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E9220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeKCEEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:20 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F7020848;
        Fri,  2 Nov 2018 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184964;
        bh=QSbk2P2S/HPPOGTIqvjbDH4/z/MZaK6UshPAFQXeIcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqX/AkwPmiRk5gRThITe7iXl8X+vZtwF+EdC12RWXgCLVuUXfxDPXBoGJhzY3C+Km
         7iP6OB94OHyiZXs1lON12s+yyHxSGyg1NJ4V0EDCwyjH4Co/O9MjG//7ozhg5apqh8
         MiHpCylrqxLjnjDFPQMG6XbMHQOvsEYWCvXjT/qM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 109/143] ARM: dts: r8a7790: Correct critical CPU temperature
Date:   Fri,  2 Nov 2018 19:34:54 +0100
Message-Id: <20181102182906.546272874@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit fcab5651fae4258a993170b7aaf443adbd3d4d84 upstream

The R-Car H2 hardware manual states that Tc = –40°C to +105°C. The
thermal sensor has an accuracy of ±5°C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95°C is a safer value to use.

Fixes: a8b805f3606f7af7 ("ARM: dts: r8a7790: enable to use thermal-zone")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 16358bf8d1db..97e8b9b0b750 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -153,7 +153,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <115000>;
+					temperature	= <95000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};
-- 
2.17.1



