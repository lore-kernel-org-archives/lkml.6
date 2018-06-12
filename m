Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A3B11C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52229208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dcw10hC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52229208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeFLTL6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:11:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41700 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932596AbeFLTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:11:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so69395wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TONlCaiA/6r4DNS8u1e6KzFsnzlfha/2EVHmCOd3IdU=;
        b=Dcw10hC+Iam5RuAMtbbEGLFUwtNwYSAHiIaeJRJhO52130HEXG6v7yHPHm64n7DdQ+
         nMMExhXqfUFeY9OteiyS5RTH3Jys29C5yazUF5X6RqvQGOjPoUuKDf7bqbIcGNiB0tHm
         umKuZ12Kgzqk/hbxjSmXk1mxOKcfJ2P1KqpcqWBQi+TC4nXcxl9NQEeGQ1113ImuBLIb
         /u0lAKfTdXzf9cxPlnyisRpZARgS8glSGpbwP3qyotCvCC/xY+kwnV3HZWNBfIDER/jl
         MSzmXFymHSogFjBr1N5SEu+NXsqne9Dcl4piGaqNhG2sVvvEWwVtGHTPRyQoMztDultW
         3Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TONlCaiA/6r4DNS8u1e6KzFsnzlfha/2EVHmCOd3IdU=;
        b=rqydUtz8IpVALtI/gz+F+Y1x/Sk5ohN4aG7uH78b+LIKdvTI3oLGTP5GS2KJTVLGOt
         mGj+gX96xL2JQrJ5P/rUoU5Aq+PxsQMlexCfXeYy0uR4cdkESlkf22amX0rFFDRENWUt
         X6z8LYIbhrdabIezH84beh3/9jNRZdR11ZKHKFsGCK1V7E/Hhz5cReUOMd9YHqVEQslJ
         i+J5qK8Oe1T5aNK+zjPRdO2Zv+ISjuHn7k3AQNUtWzfaanIUUNIn2xn+k74wlSr40FfE
         YxspMYyr2mIQ+JWDVXEtWNm+Tp280fjUCRjkn35Y2hfcD9GaZYaB3NzeeZb/fqAeU/RF
         ZguA==
X-Gm-Message-State: APt69E2gjPRWIwYUn5WbrcWIhlVCxFX0YbH2uT/FY42kIIHbIfNW/6NL
        4G6FVx7UK/t4qpdcQnIq4P8Z9s35
X-Google-Smtp-Source: ADUXVKL6QpmYdm33kbSzTwkz1/eQeeJE8+JyPeHoXQZaWpCIX7xuy3IkdJ6c7zvNCGRbiiek5ESeQw==
X-Received: by 2002:adf:a645:: with SMTP id k63-v6mr1563357wrc.231.1528830715602;
        Tue, 12 Jun 2018 12:11:55 -0700 (PDT)
Received: from localhost.localdomain (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm2279293wma.45.2018.06.12.12.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 12:11:54 -0700 (PDT)
From:   Chris Opperman <eklikeroomys@gmail.com>
Cc:     eklikeroomys@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: comedi: Improved readability of function comedi_nsamples_left.
Date:   Tue, 12 Jun 2018 23:09:44 +0200
Message-Id: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
a) Reverted u64 to unsigned long long and u32 to unsigned int.
b) Added patch versioning.
c) Changed type of scans_left to unsigned long long to avoid cast.
d) Clarified and updated changelog.

>8-----------------------------------------------------------------------8<

Improve readability of comedi_nsamples_left:
a) Reduce nesting by using more return statements.
b) Declare variables scans_left and samples_left at start of function.
c) Change type of scans_Left to unsigned long long to avoid cast.

Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---
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

