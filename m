Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F90C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76A2257BE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76A2257BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeGARzi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:55:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeGAQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1EBBAD8;
        Sun,  1 Jul 2018 16:31:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.14 053/157] ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
Date:   Sun,  1 Jul 2018 18:22:05 +0200
Message-Id: <20180701160855.296379694@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit d5b4885b1dff72ac670b518cfeaac719d768bd4d upstream.

There is a problem with the sd-uhs mode when doing a soft reboot.
Switching back from 1.8v to 3.3v messes with the card, which no longer
respond (timeout errors). According to the specification, we should
perform a card reset (power cycling the card) but this is something we
cannot control on this design.

Then the only solution to restore the communication with the card is an
"unplug-plug" which is not acceptable

Until we find a solution, if any, disable the sd-uhs modes on this design.
For the people using uhs at the moment, there will a performance drop as
a result.

Fixes: 3cde63ebc85c ("ARM64: dts: meson-gxl: libretech-cc: enable high speed modes")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -205,9 +205,6 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 


