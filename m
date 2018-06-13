Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED6CDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C532086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etTuYWY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C532086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935309AbeFMRRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:17:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44976 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeFMRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:17:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so3551202wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KacoUq519n48FvDeNCOchU55uTEWHppfDAQIj+HGccc=;
        b=etTuYWY2++usFm9adqBG0cCrfcBo9vymizPcXPb+Y4TEz9gOu5uIrhVZq7//O57EL+
         ysODTJqZO19X0VPjioo+37Y8/dPJBhIXSfDu2pU+19b1dI+U0kV6aVYZw+GZYpngxrTw
         ZRI2RbDEw70mZZDjI99fgfiLzv+Fy6YxSMbxWOdnyL/91LtTm81mrbWrmNzbX9vc0k0E
         vCOxwfllRBgi2s1BxE/xyPg1efVb/0b3pKuyUvEIrdc4DmjIvk2If7sj3GEMoIXacFZ7
         03hrmVmvlZVzxiJSRVDPdXXPLgnEkyKnO6nxA3gEW9/ZLw4WquakXf4A6tx6I+oIY7zJ
         QmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KacoUq519n48FvDeNCOchU55uTEWHppfDAQIj+HGccc=;
        b=W5+CaZTizCkDjo8MFOmGOs9zoaZ3Fkzg8HYnW69QgWtU9So+Ll3y1uyjUhqboKIM0s
         r7vKV1tX9vkTazrnbsXixcb/kxKJaXlNHMeoP95RsZmYeC9TKYb79GDDK327ZQ+UMBgm
         L1jty6Wgy5VFT6JGw4nuUvnusw9pne35Nzvq7ORKnKogLGrb0pSw5vugzc+3xTkPs7Z2
         Ej5DD6jVjdXeiRFVOB9cADYAvCV1GXqXR/lvevc4aSJ5Mn0PPenmwg+nCSfVGqpIeAHR
         zUa/0MPpE8cPxAxt55dRUqXiZZqIrzAUkPl5rPP89SVvYW+9aldVGU+a4+CuHElqAw1b
         +8ug==
X-Gm-Message-State: APt69E3bCoPJfrS2FKUEhyN0S/dFd+4PxY6eK/JpkO4/mnuS2Xvm6l/A
        rDHyyi907V4iNysXKpYMVXU=
X-Google-Smtp-Source: ADUXVKI3aVV8HFJut4ESK4/hknJzKAPJpFUosUPiKPxP7Zx384P2uhjXke1lQcuUTZ4cn0nvk6Cx5w==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr4915347wri.124.1528910264133;
        Wed, 13 Jun 2018 10:17:44 -0700 (PDT)
Received: from localhost.localdomain (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.googlemail.com with ESMTPSA id l67-v6sm4326853wmb.22.2018.06.13.10.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 10:17:43 -0700 (PDT)
From:   Chris Opperman <eklikeroomys@gmail.com>
Cc:     eklikeroomys@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: comedi: Improved readability of function comedi_nsamples_left.
Date:   Wed, 13 Jun 2018 19:14:35 +0200
Message-Id: <1528910104-1360-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability of comedi_nsamples_left:
a) Reduce nesting by using more return statements.
b) Declare variables scans_left and samples_left at start of function.
c) Change type of scans_Left to unsigned long long to avoid cast.

Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---

Changes v5:
a) Moved additional text to below the cut-off line.

 drivers/staging/comedi/drivers.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 9d73347..57dd63d 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -473,21 +473,21 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
 {
 	struct comedi_async *async = s->async;
 	struct comedi_cmd *cmd = &async->cmd;
+	unsigned long long scans_left;
+	unsigned long long samples_left;

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
+	samples_left = scans_left * cmd->scan_end_arg -
+		comedi_bytes_to_samples(s, async->scan_progress);
+
+	if (samples_left < nsamples)
+		return samples_left;
 	return nsamples;
 }
 EXPORT_SYMBOL_GPL(comedi_nsamples_left);
--
2.1.4

