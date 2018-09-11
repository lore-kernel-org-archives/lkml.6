Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B93C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB7020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cN1V0eYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB7020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeILDx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:53:57 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:39700 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeILDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:53:57 -0400
Received: by mail-ua1-f73.google.com with SMTP id t14-v6so13170424uao.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YJslXAA/H40j+y4TzxG2dqtkoyTP5i1f1/4M+fKfncw=;
        b=cN1V0eYYRLGRojFtOhsu6T2PJJYIPr5S34Qn9PvJZlA4CThYGqpRVc7xNvRiziBDK/
         O8j2OzIpcw+OV9KebBkdehYR+dGtCEe6KSNF0ZinfI81TfwVHuh55+rzVinJpaUsQteJ
         /O3L7jOrN4XGdHmKYh3eCs/thBk650tHMihGvY6gho830UXJSBGCCIdYz3qaW45J29fw
         Y3NTiB7qNIxbLcbjL8Squ8pfgV+GvMejo/46CjQlwzuQlhq7mjdB/vAayP79EsfkRcg5
         RUem9ZBWOUkLTiAp7awLSH5QZGIikecHI7wKdPcobqze4PVKjPlPp0LfOM7fnMR43wzy
         jyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YJslXAA/H40j+y4TzxG2dqtkoyTP5i1f1/4M+fKfncw=;
        b=ixBtmk9pWKGupWgPNAysdzDtDONO45j0aqRN2ygUdEEg4awTGygZUvS/L6//Rz/OTq
         uBRcXqKWrGd7ah0D8B6jKeUPO2xpWuqJdr9aElKjeMD32dMfu5Y+7RUvvYJeJZ6ucJe1
         r57bA3goqW50Ja9KDEPlfPr1PgM/lzeFuQgl5KazVZF6NmFBX03YIcsVng5lMtVBWtIo
         JRnv2f5Yywl03rXUuFRvhtdtdVv7lo31SaTkB32s8UJ689fciqd3xXgC67eL879Aovw9
         BdF99G2v1Wvg7rEymrA9YihWQLo8YwEomJFekP6wpabD7NoiGty8AAhQNr6rGuP6Ar6H
         f/mA==
X-Gm-Message-State: APzg51DqypcH1kAwEFJ90bshVTl+IbYVsKkKVUwZVTBNr8KsgKM7N4J7
        B/5zXZPA9YmnOt7E68OOhd6C3moLFHId
X-Google-Smtp-Source: ANB0VdbCyZ0R89u4exCWakmhc86IvP81sWfWYPlvMkifKRkXX+ZEAa8mObcV7tT7s4Sf6TH7UlAlXrnLrYW/
X-Received: by 2002:ab0:4fde:: with SMTP id t30-v6mr5378903uah.35.1536706347117;
 Tue, 11 Sep 2018 15:52:27 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:52:21 -0700
Message-Id: <20180911225221.54513-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] ipmi: looped device detection
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
 drivers/char/ipmi/ipmi_si_intf.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 90ec010bffbd..a1ca34af7698 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1918,11 +1918,14 @@ int ipmi_si_add_smi(struct si_sm_io *io)
  * held, primarily to keep smi_num consistent, we only one to do these
  * one at a time.
  */
+#define GET_DEVICE_ID_ATTEMPTS	5
 static int try_smi_init(struct smi_info *new_smi)
 {
 	int rv = 0;
 	int i;
 	char *init_name = NULL;
+	bool platform_device_registered = false;
+	unsigned long sleep_rm;
 
 	pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
 		ipmi_addr_src_to_str(new_smi->io.addr_source),
@@ -2003,7 +2006,26 @@ static int try_smi_init(struct smi_info *new_smi)
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

