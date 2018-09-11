Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E881AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867DE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gz6GJY+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867DE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeILD6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:58:06 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:40473 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILD6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:58:06 -0400
Received: by mail-yb1-f202.google.com with SMTP id a16-v6so1517332ybl.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nIVzj8vLIevKw27+IX4HLod5KBJg4dlwXT/e9v6B4v4=;
        b=Gz6GJY+pNQlMhygLj4LnsG2nqUCs2kUNOpAxKKbhBEKmZo0v6ycmmaXeYGiaGVp5yY
         rBk1fKIAIv8gB3Q8MLi0BpBNt27xX1iQNFjfHm2/iq8NOhR/ICAdqWaRykbefJXzGOKf
         SVOWiu7wm+k1oAc57JdkIT//bKfLrT8RZ2AbehNMQK0SpX3Qk27I+vlf10p1nIp2toAm
         +0k9xvdqeEagHTVDzlhklTJEtkKSbkY3J0JUV4wZwV2Ho8dSMeOiMl4JHl9pjvzMaRco
         ylUwZ6U5BRuwxXc9L/N/VyDBGJkhPYmrAriQg2jVGK8/ZS6I6A1S0CSE3tS8szJGE1OD
         TNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nIVzj8vLIevKw27+IX4HLod5KBJg4dlwXT/e9v6B4v4=;
        b=SdYFcN3TS7j2zjw4jEqeqvXy2NLhjL8WgvLeUy/keMLEjIgSU2Nim0fwEQgaF4Gv+B
         jPwtg4IY0nsv4reld40mMfkijC5kRkfXveBbcTpZZb0N0ATLe7FyN3KTpOMgnnL45nKO
         G73pjpCeaVnr1xD1KwVEFbtXY5dQ9Hnk5CMpuC28r0iCPiswwAELyKZuYBzhUxmI4N26
         MXFwmgLfuKkIxKSmWTtcRWM4P8JUyrnbmVBU4sy1OvhuA11xVP6cSxskM4tNxzLQMfWX
         +O/RKXoip38Ij0pupH+PD5g7grcAFWxXimVl3s1/gdj+RktDfwZUQxNB21glTxDojv45
         qh/Q==
X-Gm-Message-State: APzg51Cs1KyZGGesoDi0ojypd52DxAyQK4SgoOj/wgxVaMH5zTUyUtPd
        qY10JwYC39I3bBNK6yyI7PalZFrDksMy
X-Google-Smtp-Source: ANB0VdYAWgH1q/eSRvThpfjcTOPiJYNLWxlIuXxolbS5agN8VqFmVULipE8/9DPxopN6b3AxNSC0R+eeV8SB
X-Received: by 2002:a81:1789:: with SMTP id 131-v6mr7921111ywx.218.1536706596194;
 Tue, 11 Sep 2018 15:56:36 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:56:30 -0700
Message-Id: <20180911225630.124502-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH v2] ipmi: looped device detection
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, minyard@acm.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to get the device ID repeatedly during initialization before giving up.
The BMC isn't always responsive, and this allows it to be slightly flaky
during early boot.

Tested: Installed on a system with the BMC software disabled
such that it was non-responsive.  The driver correctly detected this
and gave up as expected.  Then I re-enabled the BMC software unloaded
and reloaded the driver and it was detected properly.

Signed-off-by: Patrick Venture <venture@google.com>
---
v2:
 - removed extra variable that was set but not used.
---
 drivers/char/ipmi/ipmi_si_intf.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 90ec010bffbd..5fed96897fe8 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1918,11 +1918,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
  * held, primarily to keep smi_num consistent, we only one to do these
  * one at a time.
  */
+#define GET_DEVICE_ID_ATTEMPTS	5
 static int try_smi_init(struct smi_info *new_smi)
 {
 	int rv = 0;
 	int i;
 	char *init_name = NULL;
+	unsigned long sleep_rm;
 
 	pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
 		ipmi_addr_src_to_str(new_smi->io.addr_source),
@@ -2003,7 +2005,26 @@ static int try_smi_init(struct smi_info *new_smi)
 	 * Attempt a get device id command.  If it fails, we probably
 	 * don't have a BMC here.
 	 */
-	rv = try_get_dev_id(new_smi);
+	for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
+		pr_info(PFX "Attempting to read BMC device ID\n");
+		rv = try_get_dev_id(new_smi);
+		/* If it succeeded, stop trying */
+		if (!rv)
+			break;
+
+		/* Sleep for ~0.25s before trying again instead of hammering
+		 * the BMC.
+		 */
+		sleep_rm = msleep_interruptible(250);
+		if (sleep_rm != 0) {
+			pr_info(PFX "Find BMC interrupted\n");
+			rv = -EINTR;
+			goto out_err;
+		}
+	}
+
+	/* If we exited the loop above and rv is non-zero we ran out of tries.
+	 */
 	if (rv) {
 		if (new_smi->io.addr_source)
 			dev_err(new_smi->io.dev,
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

