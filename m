Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D63C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9023A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9023A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeJBULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbeJBULu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:50 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 597EAA67;
        Tue,  2 Oct 2018 13:28:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 111/228] ASoC: rt1305: Use ULL suffixes for 64-bit constants
Date:   Tue,  2 Oct 2018 06:23:28 -0700
Message-Id: <20181002132506.908357205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 4f29b663c08d369fe320a148179996c94cf7d01b ]

With gcc 4.1.2:

    sound/soc/codecs/rt1305.c: In function ‘rt1305_calibrate’:
    sound/soc/codecs/rt1305.c:1069: warning: integer constant is too large for ‘long’ type
    sound/soc/codecs/rt1305.c:1086: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 29bc643ddd7efb74 ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt1305.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1066,7 +1066,7 @@ static void rt1305_calibrate(struct rt13
 	pr_debug("Left_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Left channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0l = 562949953421312;
+	r0l = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0l, rhl);
 	pr_debug("Left_r0 = 0x%llx\n", r0l);
@@ -1083,7 +1083,7 @@ static void rt1305_calibrate(struct rt13
 	pr_debug("Right_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Right channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0r = 562949953421312;
+	r0r = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0r, rhl);
 	pr_debug("Right_r0 = 0x%llx\n", r0r);


