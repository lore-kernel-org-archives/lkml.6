Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7CE21582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2syETwj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7CE21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbeKVFox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbeKVFov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E77521527;
        Wed, 21 Nov 2018 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827359;
        bh=k0DymU77Tv0RlUkrtqydHHW6sp5kuXtk0gBrILsmXwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2syETwj805zMTHlnLKn8CyKOJEnDDSfFeQ6KUq5PX6Rlns0ltGXA1sGgJyfLFtcZH
         5ACkJZd6oHTQ5Y9xGjKXUg2nRp10HBULGcqhSCp+7NBdtw6JHIuoXH1Ti1B+ivmMXe
         h3ZbjZO5OQiQwSi8nuhHEFjihVu6TXQ0oeyqXtfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 4.14 20/21] ARM: dts: r8a7791: Correct critical CPU temperature
Date:   Wed, 21 Nov 2018 20:07:04 +0100
Message-Id: <20181121183422.969409038@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
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

From: Chris Paterson <chris.paterson2@renesas.com>

commit e4fdf59bcce3b490bbc7197145bcb9f9d5a18cd3 upstream.

The R-Car M2W hardware manual states that Tc = –40°C to +105°C. The
thermal sensor has an accuracy of ±5°C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95°C is a safer value to use.

Fixes: cac68a56e34b9810 ("ARM: dts: r8a7791: enable to use thermal-zone")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/r8a7791.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -91,7 +91,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <115000>;
+					temperature	= <95000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};


