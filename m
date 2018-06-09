Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lnSrAGHGG1t5LAAAmS7hNA
	; Sat, 09 Jun 2018 12:25:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D71A1607A4; Sat,  9 Jun 2018 12:25:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L136H06t"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A4E0602FC;
	Sat,  9 Jun 2018 12:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A4E0602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeFIMZ3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:25:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54015 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeFIMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:25:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so7397023wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oG4rlrJygGoH1GSxzzHI1kTkKCXWlMaevMpd0LTAJGI=;
        b=L136H06tpXAU8jPDq/H4Wvpfb/6Jn6Am9C6Tosxr0OoFsClmo3MvGgjPISVqyY/YSO
         l+nDbIuCj60vBYpB494Dc0B3Zr6hKuaEaMqxHKATDF/XRqFdAF871U7EQwm+um73wAuy
         Obg58rKuuUGJFyriT/XAU2MbuTU1357A2agmYJEOCpoMzhRxm8v810zspVAcC3wSp3K7
         7tpVtWijMP3J1bMrxFhyEA9YpSBkKV4QGnsbxm6+x4QA3SGJd214ihbFKIdLj8UGF7uh
         1bViy4qbBhyOZ5XzfvqOmwWbrUbuDFeay0CpJM0kqk26UPzEbYSB35o4cjDx4smxzOvO
         wzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oG4rlrJygGoH1GSxzzHI1kTkKCXWlMaevMpd0LTAJGI=;
        b=ArWoE59Iq6eQwoAHXy4G9vnLYVFDBmRQiFSAHEPjK8bmbnNLUFyVbhbxCXcayHsU91
         iAZTAUdY3aq9UKEpRg51jSKo/JsOEDwnkw4GThTBu7qtvTVDHWRvzJ285JG9SXKKCxSh
         Rky94yOMnhIjT9FAhYRbOzkB44KPi68jTcsobU7/r0hp4LcINkZXWHn3Vc7d+yrplRV+
         pn6xBHTrd4n+ad+FL5CMlRxMukk+hgbqvVQjT7GiRpuhyC7QZONODxziXlI1ugCUFCLh
         cYJrLMQcpAVR30CkFvcuQ1QsnJTq7NHMm5PcWmV7wqEv6Rq6UtsyQEsx8avm97BOzLsK
         6veQ==
X-Gm-Message-State: APt69E1JrP5FI+gQ9Jx1FSMwSTwKmX2ft3ynYE+ebWEqPjWZGYrfxxdW
        GgDme5MR9KDduMzZlLY7l/Q=
X-Google-Smtp-Source: ADUXVKKoIQy3M1zKWIcm7MPwGvB3NK8ad7OCbh2fPaTk9X+vWLxqxFzc1Lj2SJWSvzmt8YLccSnKrw==
X-Received: by 2002:a1c:4a5d:: with SMTP id x90-v6mr3839518wma.67.1528547126994;
        Sat, 09 Jun 2018 05:25:26 -0700 (PDT)
Received: from localhost.localdomain (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm15691992wma.45.2018.06.09.05.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Jun 2018 05:25:26 -0700 (PDT)
From: Chris Opperman <eklikeroomys@gmail.com>
Cc: eklikeroomys@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: Improved readability of function comedi_nsamples_left.
Date: Sat,  9 Jun 2018 16:23:21 +0200
Message-Id: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---
 drivers/staging/comedi/drivers.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 9d73347..3207ae2 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -468,26 +468,25 @@ EXPORT_SYMBOL_GPL(comedi_nscans_left);
  * Returns the number of samples remaining to complete the command, or the
  * specified expected number of samples (@nsamples), whichever is fewer.
  */
-unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
-				  unsigned int nsamples)
+u32 comedi_nsamples_left(struct comedi_subdevice *s, u32 nsamples)
 {
 	struct comedi_async *async = s->async;
 	struct comedi_cmd *cmd = &async->cmd;
+	u32 scans_left;
+	u64 samples_left;
 
-	if (cmd->stop_src == TRIG_COUNT) {
-		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
-		unsigned int scan_pos =
-		    comedi_bytes_to_samples(s, async->scan_progress);
-		unsigned long long samples_left = 0;
-
-		if (scans_left) {
-			samples_left = ((unsigned long long)scans_left *
-					cmd->scan_end_arg) - scan_pos;
-		}
+	if (cmd->stop_src != TRIG_COUNT)
+		return nsamples;
 
-		if (samples_left < nsamples)
-			nsamples = samples_left;
-	}
+	scans_left = __comedi_nscans_left(s, cmd->stop_arg);
+	if (!scans_left)
+		return 0;
+
+	samples_left = ((u64)scans_left * cmd->scan_end_arg) -
+		comedi_bytes_to_samples(s, async->scan_progress);
+
+	if (samples_left < nsamples)
+		return samples_left;
 	return nsamples;
 }
 EXPORT_SYMBOL_GPL(comedi_nsamples_left);
-- 
2.1.4
