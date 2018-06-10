Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UN2zA+DhHFuTHgAAmS7hNA
	; Sun, 10 Jun 2018 08:31:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DF8F960850; Sun, 10 Jun 2018 08:31:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCBACC8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65021600D0;
	Sun, 10 Jun 2018 08:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65021600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbeFJIbY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 04:31:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38337 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeFJIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 04:31:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so10862923wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m31xckP+r6X4YVNkBnZUfEz62rLbyUMJe66iL8DB8us=;
        b=NWCBACC8bNg9aGdvtWZ/M2zEUI9L/GM+O7gm9uzLVJAp1xnkCpo7GIDZTvfSreDMIx
         iE9MhOZxz/EQN0oKMMS2YILNwAKV0Hy7fwF1CH28lLwSSja+5/uBPKTBoRqytTJJj9Ni
         8e73wRzRrJdvPLa5AyomKAm5pXQvr3zhfawgab3UgTMGkmbh8bEr6dzd0WynlkHlP9cs
         TdxMC1DT8XE0hr99eu+jqP03KIRugUTYPHL04r+ezTeyxkP1OO7R18gT7bP+ay61AMOs
         kun8cw2cJZsudJAEeRWg0sEWxiEISfw50oAsBmh1dRlnZfXNxzirFdLQ6lQmb4VDgZAH
         MZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m31xckP+r6X4YVNkBnZUfEz62rLbyUMJe66iL8DB8us=;
        b=L89sGdOaaM98diQ+EGwPAFV38+S8FCo0FkQ//fpST3rL+RaUU54J+0yOPtmfOa2ERU
         QpRB3iwQwKb1xevtxUWx1AkJSRVPmTaTUt541EWsSxpP4vAfzq01X+N6YqZferCTuhDC
         m0sKEwe90DUtl3RTvD80EKT99T5gunsKImARbgO1xdAGpWad6RydPrLHqiQpNDRJLd7c
         hrzhm8Ah83WmehzghT5hJ3LiC9TKdsCLsNcG9LUSYuP7sQqJWr9UHKP4+rQhpnmy+Amh
         Ckb4YuT24OKntgJpINcDcPV0DfJtfGuKbLy3A7ymbnyZV7bcJ+qBlI/ZV2T1tGzV13uF
         uFOQ==
X-Gm-Message-State: APt69E2vVPbr5E+wr4cAo9Vkln4mWbJmv7g8s0tFRguZcitYi9IGh/NZ
        1pJNAE4RMEqipLqQwmmqWSw=
X-Google-Smtp-Source: ADUXVKJ4Pz9uRNqp8CvPUuyxcLxHd2WipPiB5UWVKNzHoP9dcFh+jgN+C1Q6xvHKwsSlyik4m4r4LQ==
X-Received: by 2002:a1c:eacd:: with SMTP id g74-v6mr4999468wmi.103.1528619481083;
        Sun, 10 Jun 2018 01:31:21 -0700 (PDT)
Received: from localhost (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.gmail.com with ESMTPSA id h65-v6sm4582834wmf.7.2018.06.10.01.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 01:31:20 -0700 (PDT)
Date: Sun, 10 Jun 2018 12:30:01 +0200
From: chris <eklikeroomys@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180610103001.GA7804@kerdev>
References: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
 <20180609140527.GC28854@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609140527.GC28854@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
I've added changelog text to the patch below. Appreciate your 
feedback!
Regards,
Chris Opperman

>8----------------------------------------------------------------------8<

Improved the readability of comedi_nsamples_left:
a) Reduced nesting by using more return calls.
b) Separated variable declarations from code.
c) Using kernel integer types.

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
