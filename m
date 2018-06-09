Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i2hiO6iWG1siLQAAmS7hNA
	; Sat, 09 Jun 2018 08:58:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0E516089E; Sat,  9 Jun 2018 08:58:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4vx9hoo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5CDFA605A5;
	Sat,  9 Jun 2018 08:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CDFA605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeFII6O (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:58:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37859 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeFII6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:58:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so15537075wro.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GJyhkPAjgKiRJ4dGLivKhKPaE86YXOAQCJXsMMrH2QM=;
        b=B4vx9hooTRHBUVKz5QS18K8WBsMaiNPr63RrzV+5KnL43+qX4nSwskRZPPcl4zo8NX
         dnzPqSYpOMCF7h9bYcnO4rSTBbkq2l31cqzAm+4UWzdr6gUW09th8m0B8VY20Osdg1JW
         WvKpEB1S+ztOuyRzx8XIPHMGrM94eM0+3ue+4CMxzR+I/qQx9GFjMAtW/i3Vk4/rLa6r
         BUnSQaUfBltMQHPaMOKLq4Zgh0LWvyu1ZrmRL0zbkZmM0xRUqKQtegpEhzbDRXoEy9MM
         NY1MaC0WUGuL6u1koseSZWofjcdnSUU4j10sofYuqd2v1Rk/rzgaLWTkSvHEDZIEU//v
         fmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GJyhkPAjgKiRJ4dGLivKhKPaE86YXOAQCJXsMMrH2QM=;
        b=jf1aXJ5KHcrgUKkMvtDWuXvqFWJ7jwLRrqdA2CYXUCcfFnmKcvGyUUxbOh5wI8Yp40
         XOe1Owi6FYsILdpoJ0JkaLUZ05w3T727bYQ8W7GpyrIVxiLEUyPmMcB+szoPPE4u10SX
         wR62Nypodf60xT/rR1VAEE78CrhsPi7pejd+W1WXAX6Fyhwc39GXC08HcCSjrHJpBIXk
         eQyJOJeIgIk2q/4YVygejNtBzuQ5nLwJNL3hpg1I4n8tLQpcEs+T5g7yNaUig+QXVCSl
         day2nh8ZPQSKtrsSnsh0ooFBUsUTb/SqZ4E4E59/DO4MIC0IMXag9BaeX8aWpvwuzTz1
         l+lw==
X-Gm-Message-State: APt69E1hXqdp2m89dAQAaRKDoU6aZQMZ7S4+4RoIUBSeIC3/fTglqDal
        b65t6kqvX6TTx/MiiXmSXKM=
X-Google-Smtp-Source: ADUXVKK3kyCX2Sdp7h2MXi2AdMRoolJMqkEzpZDaq1W2bISYbLN5miHo9uEuymwk+QpjUtkNX3Og+g==
X-Received: by 2002:adf:e78b:: with SMTP id n11-v6mr7405001wrm.136.1528534691626;
        Sat, 09 Jun 2018 01:58:11 -0700 (PDT)
Received: from localhost.localdomain (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.googlemail.com with ESMTPSA id c53-v6sm80158203wrg.12.2018.06.09.01.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Jun 2018 01:58:11 -0700 (PDT)
From: Chris Opperman <eklikeroomys@gmail.com>
Cc: eklikeroomys@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: shortened a long line
Date: Sat,  9 Jun 2018 12:54:55 +0200
Message-Id: <1528541720-1853-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shortened a long line to improve readability in 
drivers/staging/comedi/drivers.c

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
+		    __comedi_nscans_left(s, cmd->stop_arg);
 		unsigned int scan_pos =
 		    comedi_bytes_to_samples(s, async->scan_progress);
 		unsigned long long samples_left = 0;
-- 
2.1.4
