Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vy4AHt9HGVsbQQAAmS7hNA
	; Thu, 07 Jun 2018 14:58:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C83FD607E7; Thu,  7 Jun 2018 14:58:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 32D1A608B8;
	Thu,  7 Jun 2018 14:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32D1A608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935583AbeFGO6x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41215 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935555AbeFGO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:49 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbq-0005a0-TF; Thu, 07 Jun 2018 15:09:51 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002qk-4c; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Olof Johansson" <olof@lixom.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.664948701@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 118/410] arm: spear13xx: Fix spics gpio controller's
 warning
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit f8975cb1b8a36d0839b6365235778dd9df1d04ca upstream.

This fixes the following warning by also sending the flags argument for
gpio controllers:

Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi@e0100000

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/boot/dts/spear1310-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -345,7 +345,7 @@
 			spi0: spi@e0100000 {
 				status = "okay";
 				num-cs = <3>;
-				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0 0>, <&spics 1 0>;
 
 				stmpe610@0 {
 					compatible = "st,stmpe610";
