Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mSepGD21GlsfLQAAmS7hNA
	; Fri, 08 Jun 2018 16:56:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3197F607A4; Fri,  8 Jun 2018 16:56:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOxFW0UO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4D02607DC;
	Fri,  8 Jun 2018 16:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4D02607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFHQ4Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:56:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36340 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:56:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so14070978wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nKyDvEcogVelZCrIwXds53gKJoZYN36JnIDsL/Uab2Y=;
        b=GOxFW0UOPEWPoZle8lptLaQ0RuBRx3NzSCEB2ThYRLdC8bnHa7ypKSRSc7sKI3uTm0
         lxsyIHUwpelkGdO05a5H8YJrCWZY2xExWpyostTMufRsMq9Ma/VvIX28tw8c1QzsUgyx
         Me4qa8FyfBAZ7O8Om+/KpkUcX5o9nTSeEbNPl3w6t2qUsl4HrXm3Toq8Ybzt08B4F7hU
         AIggTGWDjLK7G8P9iDDC6tZylLkAsz8BiAI0i/v/Wj0T3dwfxT1wi7qyDlonezPUET+9
         ljPF6aQg/9JfsNo0kN764t1CnxjP0/kIWuitgD6zr9jC08nq97SDxQZD8r2Wolr5DXbx
         z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nKyDvEcogVelZCrIwXds53gKJoZYN36JnIDsL/Uab2Y=;
        b=jN//9w2pAI1raNptzPjWkc+ECXrnGTPW57CQtyNctGVWMg+Cf9ZfMu412XswdphXSQ
         Ahqjeuth1WJCJiOsVhoiS2a+tb6ETSXz/nE7zkDUMgy8LIHoQeBvsjQQxNBYccfDLV5a
         m8OWZXN5l+rCiVHfeXpUu21aXOv46asVo5cTTQUggfLQA+UvjLSrhe1KvzEVZoAbzOtz
         uWSWYViebLyXTczrBLw9oZbdsNvhHY2OXOqnPtpcNjiMQvP8i6TVSBwLAfSWBnAW6FFg
         ypTooa61VwjbDx+GHAh4Low0Kb/+4+d7gCrS8WOWPi+0mfGY48PzlWcWckgkPVCCHD0w
         qugA==
X-Gm-Message-State: APt69E3fythjzNp51soLHXe4Xa0K+OWzSNEpjM6AbWmRqrazHTIQ4uvl
        kyvy4yTFWPWod+NTfQzhAkMByVMn
X-Google-Smtp-Source: ADUXVKLSDRKrIic5l8pUkJPIKUprYQDyt8Zhol0XXU7f49hVoe9GS7hbaNsssMZd2ykbiMg+IN1Eig==
X-Received: by 2002:adf:81c2:: with SMTP id 60-v6mr5632054wra.13.1528476983425;
        Fri, 08 Jun 2018 09:56:23 -0700 (PDT)
Received: from localhost.localdomain (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.googlemail.com with ESMTPSA id a203-v6sm2845938wme.46.2018.06.08.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 09:56:22 -0700 (PDT)
From: Chris Opperman <eklikeroomys@gmail.com>
Cc: eklikeroomys@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed coding style problems.
Date: Fri,  8 Jun 2018 20:52:37 +0200
Message-Id: <1528483959-23158-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a coding style problem in drivers/staging/comedi/drivers.c
and is submitted for task 10 of the eudyptula challenge.
Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---
 drivers/staging/comedi/drivers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 9d73347..90ee974 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -475,7 +475,8 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
 	struct comedi_cmd *cmd = &async->cmd;
 
 	if (cmd->stop_src == TRIG_COUNT) {
-		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
+		unsigned int scans_left =
+			__comedi_nscans_left(s, cmd->stop_arg);
 		unsigned int scan_pos =
 		    comedi_bytes_to_samples(s, async->scan_progress);
 		unsigned long long samples_left = 0;
-- 
2.1.4
