Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7949C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBE6217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VKSU0trU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLZGlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:41:03 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58436 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLZGlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:41:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0C8C8527
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IYAZcGbbjday for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:41:00 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id D349892C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:41:00 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id f24so18472415ioh.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g3wttt0q7Zfjx6R84hg27h7QE4aVQJubtqB7Mh20Y/k=;
        b=VKSU0trUuNG2ioz7529i9Xwpc3LIuhMiWTmQHwnd+PhnEyCdY1Mu5+pr0E9CvM//HU
         cmjhn/cA+IHyTKwLaIRLHagOZ3dXDushuXYP3cR8SQVSf8wneWJRn2tURo1bfJ2coARZ
         883hDo6ytaWop87NRL2FIlrjE7Pv4QRVRiV1uC43zsGPwKjOVzP/y+oP6bpm7lJRq/cp
         FfEoWA7+CUnldfd0QkISUDKrwomVcZqZhAK8e51cEu6wTSuy6Q/ofBuTDApDs8pf+vlz
         K5O8ddMGl8U2yoVvZUAi5aGGdGwx/9HRN1ppbj40EltcdMTjHU4CFTl0phIXAhrvz0/6
         gBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g3wttt0q7Zfjx6R84hg27h7QE4aVQJubtqB7Mh20Y/k=;
        b=DsNHyDnWSwNtuYYS5ZBbtjEKKEPh4sxYFBWZAP/wA0W9YYZxxEWdkUxoqPyxTOtB4O
         8E1dMiU3HsgIjjododalkYFFhGav3quhQxhqOU8Tb+RHBIjuO4lZcLDaC12N46zIbRgw
         qOV9PC9t6D+J1odsGaJf+tXLAkhta0xhrgwoRHwTChUYp5VVcPFW69ZYPsp8HCokNzkP
         ExMVNdgZH/k5XYq1PjGTJJT0DawSbHd1Ffwpn6p/oV1m39g/iAbQGpz/aDRZzSm0InJP
         5NDLRW9G+XO6ZtLixfTm4tfAZKx+M1FNP4g9GsOziMzkdKPpMM2zUCYHtTA5D12AL0e/
         5+tA==
X-Gm-Message-State: AJcUukfTwoJSROPco+kEv3tw7n81SpKTcH1IfEeg1tInx1FOh+Av0OcH
        GilwxDvusIeTiA9/dUI5xpLZRxYFuY3t2bFVkBJWVuyV8p3AI+dyxZ9gtluRzJP4ILQ4Mry1sSt
        /4mRhv/zImEkk+mjRELOW3AiB2U0A
X-Received: by 2002:a24:7fc3:: with SMTP id r186mr11490847itc.178.1545806460452;
        Tue, 25 Dec 2018 22:41:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4BlhYoVFa5vEqihPA8UArVd+Fs+t805DVW+rRM2144NLCzLoswP0hCpTHMrme/5odvbNFpZA==
X-Received: by 2002:a24:7fc3:: with SMTP id r186mr11490838itc.178.1545806460183;
        Tue, 25 Dec 2018 22:41:00 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id p10sm4985103iol.57.2018.12.25.22.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:40:59 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: eicon: fix a missing check of api_parse
Date:   Wed, 26 Dec 2018 00:40:32 -0600
Message-Id: <20181226064032.75800-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

api_parse can fail, and if it fails, we should not use the ss_parms
which can be incorrect.
The fix checks its return value and stops using ss_parms if api_parse
fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/isdn/hardware/eicon/message.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/eicon/message.c b/drivers/isdn/hardware/eicon/message.c
index def7992a38e6..afb4a7d88288 100644
--- a/drivers/isdn/hardware/eicon/message.c
+++ b/drivers/isdn/hardware/eicon/message.c
@@ -1846,7 +1846,13 @@ static byte facility_req(dword Id, word Number, DIVA_CAPI_ADAPTER *a,
 				break;
 
 			case S_HOLD:
-				api_parse(&parms->info[1], (word)parms->length, "ws", ss_parms);
+				if (api_parse(&parms->info[1],
+							(word)parms->length,
+							"ws", ss_parms)) {
+					dbug(1, dprintf("format wrong"));
+					Info = _WRONG_MESSAGE_FORMAT;
+					break;
+				}
 				if (plci && plci->State && plci->SuppState == IDLE)
 				{
 					plci->SuppState = HOLD_REQUEST;
-- 
2.17.2 (Apple Git-113)

