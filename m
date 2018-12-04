Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFABC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B2A20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UeawtK66";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b8U+8Xr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B2A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLDJ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:29:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:29:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 73C8861661; Tue,  4 Dec 2018 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543915743;
        bh=S4rnCLAEYzUqxRh1KMVkzX/Tmng5R/aHYsuksyr8VbY=;
        h=Date:From:To:Cc:Subject:From;
        b=UeawtK66cXsmcrj1LPU4pO1xmA4FS3HwcGvE+zhGwrPkmqwBmI9IHX4b218zZSYBm
         GbZkeao2j0tmaRofeLv9ohv0ys2+wINVwzx7iemEfMfxPR2pmsUHE/lBS99ICdOlE6
         keJRO2/zO2FLf5+HgcmHs/DV4tDfqiuzaJYvnIKg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 70AED61657;
        Tue,  4 Dec 2018 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543915742;
        bh=S4rnCLAEYzUqxRh1KMVkzX/Tmng5R/aHYsuksyr8VbY=;
        h=Date:From:To:Cc:Subject:From;
        b=b8U+8Xr8pjqQ7CmS+4y50jaJAylE9mHCCIhMP2xv9JFLS/JJgCcXzWbRN18vN7ELD
         a1LACNWq3twMEE7KcPmxffnKaSxCFxCieslwj674W2o6lzr04YGxttYAG6glEMb77w
         9pwpwkBD0dinMEvcPfLu9sXafOwdYYtRVfXJ67sk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Dec 2018 17:29:02 +0800
From:   yuankuiz@codeaurora.org
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: proc: printf using alarm for alrm
Message-ID: <b44225b8e243a70c6ab63a40a3de630d@codeaurora.org>
X-Sender: yuankuiz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 From 549bae59445c5ec67dd6a46f3ea4f58966d40c9b

Current the struct rtc_wkalrm is dumped as
"alrm_" by printing converted from the struct
name of "alrm.*" directly. Shall we use the
"alarm *" to replace the "alrm_*" during this
dumping?

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  drivers/rtc/rtc-proc.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index a9dd921..d4a3c91 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -58,7 +58,7 @@ static int rtc_proc_show(struct seq_file *seq, void 
*offset)

  	err = rtc_read_alarm(rtc, &alrm);
  	if (err == 0) {
-		seq_printf(seq, "alrm_time\t: ");
+		seq_printf(seq, "alarm time\t: ");
  		if ((unsigned int)alrm.time.tm_hour <= 24)
  			seq_printf(seq, "%02d:", alrm.time.tm_hour);
  		else
@@ -72,7 +72,7 @@ static int rtc_proc_show(struct seq_file *seq, void 
*offset)
  		else
  			seq_printf(seq, "**\n");

-		seq_printf(seq, "alrm_date\t: ");
+		seq_printf(seq, "alarm date\t: ");
  		if ((unsigned int)alrm.time.tm_year <= 200)
  			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
  		else
@@ -85,9 +85,9 @@ static int rtc_proc_show(struct seq_file *seq, void 
*offset)
  			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
  		else
  			seq_printf(seq, "**\n");
-		seq_printf(seq, "alarm_IRQ\t: %s\n",
+		seq_printf(seq, "alarm IRQ\t: %s\n",
  				alrm.enabled ? "yes" : "no");
-		seq_printf(seq, "alrm_pending\t: %s\n",
+		seq_printf(seq, "alarm pending\t: %s\n",
  				alrm.pending ? "yes" : "no");
  		seq_printf(seq, "update IRQ enabled\t: %s\n",
  			(rtc->uie_rtctimer.enabled) ? "yes" : "no");
-- 
2.7.4
