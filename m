Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE93C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325F21568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaM1Solc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325F21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeHXAIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:08:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45755 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:08:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so407127oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B31Nrm4kl7TE48y9/D7bjQbbnioCA5XX0o+dTj6vI2s=;
        b=BaM1Solc/CLF50tOYx+QrZu4jhCsVRFQHJfSOdHeUoPtUaOcTDXCYmwhtPMnqQOylH
         q5C0i+1n0zcuKcWXg4vomGNrzHzmtqmPb9m4qFGPoBq1ZalmQtO9jFEfap4VGYf+kXD5
         7YoMkWDm3Vthm1dqgvakw2qpEST9Od/EbblQGRRm/S1L5Wsb9a/a03e91h4Z3KXIj7kT
         2ChYow8WKhONM+JrD9LKLN8QCZa+0epKU+HPU8iYZN+uxj3Bj7J5SdiKb/QECvNeT1NN
         vYhsB6ztffXAW/vE0X/BHh9JzMxfiR5YRWCGQGKjCw3+c7xq6jPoE5/Msx4ZiFNGQRjn
         b+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=B31Nrm4kl7TE48y9/D7bjQbbnioCA5XX0o+dTj6vI2s=;
        b=s+kkynj+rly3DyUJrvGy8hsMPi8eR36VOGuPUlJJGHKl2DoxNAyY92mRzf/4/NEaRY
         tHV8ccmQOc90J6snBLiYJHUjhJ/YZK2Y0WZDuRUQvGg474nM6z5JMfSHIV7CkaaxSRuh
         y2wWGwiEhTRfmZBuQG5cW644ORdujbG3t6UI/FL3UhQwxhfWvYEUbRBg/kEISQhxGzeS
         TS4DRr1ckn9WN3x+hoZ6/Bo6noH/aVHQXLP4suRJKOlXHw6IYWIxz8tVKIKXLeZR5R3Z
         ogk9iaK4f7RTM0YdD+/1FjDo0xQwH2FZH0vdz91vzK6IqGYRDZgAI8Fq9jbucnzsH8+A
         9UiQ==
X-Gm-Message-State: APzg51DDzvX2YOsWYzXj9xPHKpNg+tsjm/UiqFynoxU7OHMAEw2dDIX5
        N0g158pfova3NI//o8nZGA==
X-Google-Smtp-Source: ANB0VdYINasliKZJv6sBKjqxraH+zKlSpBPBOmT2BQp6kfIgHWjPwTlcGmZzYeSRQpsdFwRVyxQNOg==
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr9407910oih.246.1535056632904;
        Thu, 23 Aug 2018 13:37:12 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id m11-v6sm3076562oif.27.2018.08.23.13.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:37:12 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 2EF25B9A;
        Thu, 23 Aug 2018 15:37:11 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id E81023000CF; Thu, 23 Aug 2018 15:37:09 -0500 (CDT)
From:   minyard@acm.org
To:     Andrew Banman <abanman@hpe.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, rja@hpe.com, frank.ramsay@hpe.com,
        justin.ernst@hpe.com, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect call
Date:   Thu, 23 Aug 2018 15:37:02 -0500
Message-Id: <1535056623-26634-2-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535056623-26634-1-git-send-email-minyard@acm.org>
References: <1535056623-26634-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

The capabilities detection was being done as part of the normal
state machine, but it was possible for it to be running while
the upper layers of the IPMI driver were initializing the
device, resulting in error and failure to initialize.

Move the capabilities detection to the the detect function,
so it's done before anything else runs on the device.  This also
simplifies the state machine and removes some code, as a bonus.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reported-by: Andrew Banman <abanman@hpe.com>
---
 drivers/char/ipmi/ipmi_bt_sm.c | 92 ++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index cbc6126..b4133832e 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -59,8 +59,6 @@ enum bt_states {
 	BT_STATE_RESET3,
 	BT_STATE_RESTART,
 	BT_STATE_PRINTME,
-	BT_STATE_CAPABILITIES_BEGIN,
-	BT_STATE_CAPABILITIES_END,
 	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
 };
 
@@ -86,7 +84,6 @@ struct si_sm_data {
 	int		error_retries;	/* end of "common" fields */
 	int		nonzero_status;	/* hung BMCs stay all 0 */
 	enum bt_states	complete;	/* to divert the state machine */
-	int		BT_CAP_outreqs;
 	long		BT_CAP_req2rsp;
 	int		BT_CAP_retries;	/* Recommended retries */
 };
@@ -137,8 +134,6 @@ static char *state2txt(unsigned char state)
 	case BT_STATE_RESET3:		return("RESET3");
 	case BT_STATE_RESTART:		return("RESTART");
 	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
-	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
-	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
 	}
 	return("BAD STATE");
 }
@@ -185,7 +180,6 @@ static unsigned int bt_init_data(struct si_sm_data *bt, struct si_sm_io *io)
 	bt->complete = BT_STATE_IDLE;	/* end here */
 	bt->BT_CAP_req2rsp = BT_NORMAL_TIMEOUT * USEC_PER_SEC;
 	bt->BT_CAP_retries = BT_NORMAL_RETRY_LIMIT;
-	/* BT_CAP_outreqs == zero is a flag to read BT Capabilities */
 	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
 }
 
@@ -447,7 +441,7 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 
 static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 {
-	unsigned char status, BT_CAP[8];
+	unsigned char status;
 	static enum bt_states last_printed = BT_STATE_PRINTME;
 	int i;
 
@@ -500,12 +494,6 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
 			BT_CONTROL(BT_H_BUSY);
 
-		bt->timeout = bt->BT_CAP_req2rsp;
-
-		/* Read BT capabilities if it hasn't been done yet */
-		if (!bt->BT_CAP_outreqs)
-			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
-					SI_SM_CALL_WITHOUT_DELAY);
 		BT_SI_SM_RETURN(SI_SM_IDLE);
 
 	case BT_STATE_XACTION_START:
@@ -610,37 +598,6 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 		BT_STATE_CHANGE(BT_STATE_XACTION_START,
 				SI_SM_CALL_WITH_DELAY);
 
-	/*
-	 * Get BT Capabilities, using timing of upper level state machine.
-	 * Set outreqs to prevent infinite loop on timeout.
-	 */
-	case BT_STATE_CAPABILITIES_BEGIN:
-		bt->BT_CAP_outreqs = 1;
-		{
-			unsigned char GetBT_CAP[] = { 0x18, 0x36 };
-			bt->state = BT_STATE_IDLE;
-			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
-		}
-		bt->complete = BT_STATE_CAPABILITIES_END;
-		BT_STATE_CHANGE(BT_STATE_XACTION_START,
-				SI_SM_CALL_WITH_DELAY);
-
-	case BT_STATE_CAPABILITIES_END:
-		i = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
-		bt_init_data(bt, bt->io);
-		if ((i == 8) && !BT_CAP[2]) {
-			bt->BT_CAP_outreqs = BT_CAP[3];
-			bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
-			bt->BT_CAP_retries = BT_CAP[7];
-		} else
-			pr_warn("IPMI BT: using default values\n");
-		if (!bt->BT_CAP_outreqs)
-			bt->BT_CAP_outreqs = 1;
-		pr_warn("IPMI BT: req2rsp=%ld secs retries=%d\n",
-			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
-		bt->timeout = bt->BT_CAP_req2rsp;
-		return SI_SM_CALL_WITHOUT_DELAY;
-
 	default:	/* should never occur */
 		return error_recovery(bt,
 				      status,
@@ -651,6 +608,11 @@ static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 
 static int bt_detect(struct si_sm_data *bt)
 {
+	unsigned char GetBT_CAP[] = { 0x18, 0x36 };
+	unsigned char BT_CAP[8];
+	enum si_sm_result smi_result;
+	int rv;
+
 	/*
 	 * It's impossible for the BT status and interrupt registers to be
 	 * all 1's, (assuming a properly functioning, self-initialized BMC)
@@ -661,6 +623,48 @@ static int bt_detect(struct si_sm_data *bt)
 	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
 		return 1;
 	reset_flags(bt);
+
+	/*
+	 * Try getting the BT capabilities here.
+	 */
+	rv = bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
+	if (rv) {
+		dev_warn(bt->io->dev,
+			 "Can't start capabilities transaction: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	smi_result = SI_SM_CALL_WITHOUT_DELAY;
+	for (;;) {
+		if (smi_result == SI_SM_CALL_WITH_DELAY ||
+		    smi_result == SI_SM_CALL_WITH_TICK_DELAY) {
+			schedule_timeout_uninterruptible(1);
+			smi_result = bt_event(bt, jiffies_to_usecs(1));
+		} else if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
+			smi_result = bt_event(bt, 0);
+		} else
+			break;
+	}
+
+	rv = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
+	bt_init_data(bt, bt->io);
+	if (rv < 8) {
+		dev_warn(bt->io->dev, "bt cap response too short: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	if (BT_CAP[2]) {
+		dev_warn(bt->io->dev, "Error fetching bt cap: %x\n", BT_CAP[2]);
+out_no_bt_cap:
+		dev_warn(bt->io->dev, "using default values\n");
+	} else {
+		bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
+		bt->BT_CAP_retries = BT_CAP[7];
+	}
+
+	dev_info(bt->io->dev, "req2rsp=%ld secs retries=%d\n",
+		 bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
+
 	return 0;
 }
 
-- 
2.7.4

