Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991AE21A00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="PfEUrzgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991AE21A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFUSVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:21:43 -0400
Received: from mout01.posteo.de ([185.67.36.65]:58794 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeFUSVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:21:42 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D5F8221026
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529605300; bh=vHAo6u0y/oFl+tmi40bTeGDIa/Pls7RbArcBTSxMWJs=;
        h=From:To:Cc:Subject:Date:From;
        b=PfEUrzgcgDfCqWH7ItHN9IO8ebX+l9zB680xvpDVSDE3RzrdRdrYlC5fKQKfb5L2U
         96JlgV+cUTpCZminjoVeCprjmrnCfR1CQVNWqQWrPoBwmyH0esXs9Ikkrf1Z7BGBjH
         IdjlJErRhSN+jhbSP+DkNt6ei511rnPaW/+PZM5RMq5sNvB6L7iPnI52DiSZ7YUn4Y
         ZeymYKSXOWYsNoH0Ds3Q5Imm/wTdX3ruZWRfbcVHqqaPT4ZkgRXlDRxZNWBCd/Gl+1
         15pvlK/roU8E4b8W+cnCa+IsaMV9qTpEeeA23Om+GF3hBAPMesyIgumz6t3QcnP+UE
         ioN1kd3TRMLng==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41BVQW6hFnz9rxL;
        Thu, 21 Jun 2018 20:21:39 +0200 (CEST)
From:   Michael Straube <michael.straube@posteo.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@posteo.de>
Subject: [PATCH] staging: rtl8723bs: fix comparsion to NULL - coding style
Date:   Thu, 21 Jun 2018 20:20:39 +0200
Message-Id: <20180621182039.27700-1-michael.straube@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparsion to NULL issues found by checkpatch.
Use !x instead of x == NULL.

Signed-off-by: Michael Straube <michael.straube@posteo.de>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0822e440204e..e55895632921 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -747,7 +747,7 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	u8 match = false;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	if (ie_ptr == NULL)
+	if (!ie_ptr)
 		return match;
 
 	eid = ie_ptr[0];
@@ -1163,7 +1163,7 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	const unsigned char *addr;
 	int len;
 
-	if (mac_addr == NULL)
+	if (!mac_addr)
 		return;
 
 	if (rtw_initmac) {	/* 	Users specify the mac address */
-- 
2.17.1

