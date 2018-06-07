Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c9GDC1JXGVu3eQAAmS7hNA
	; Thu, 07 Jun 2018 16:04:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74A81607E7; Thu,  7 Jun 2018 16:04:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 09CD860590;
	Thu,  7 Jun 2018 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09CD860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935692AbeFGQD6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:03:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39255 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933018AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zq-ID; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pM-DJ; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Colin Ian King" <colin.king@canonical.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Raghava Aditya Renukunta" <RaghavaAditya.Renukunta@microsemi.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.693405720@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/410] scsi: aacraid: remove redundant setting of
 variable c
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 91814744646351a470f256fbcb853fb5a7229a9f upstream.

A previous commit no longer stores the contents of c, so we now have a
situation where c is being updated but the value is never read. Clean up
the code by removing the now redundant setting of variable c.

Cleans up clang warning:
drivers/scsi/aacraid/aachba.c:943:3: warning: Value stored to 'c' is
never read

Fixes: f4e8708d3104 ("scsi: aacraid: Fix udev inquiry race condition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/aacraid/aachba.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -796,11 +796,8 @@ static void setinqstr(struct aac_dev *de
 		while (*cp == ' ')
 			++cp;
 		/* last six chars reserved for vol type */
-		c = 0;
-		if (strlen(cp) > sizeof(str->pid)) {
-			c = cp[sizeof(str->pid)];
+		if (strlen(cp) > sizeof(str->pid))
 			cp[sizeof(str->pid)] = '\0';
-		}
 		inqstrcpy (cp, str->pid);
 
 		kfree(cname);
