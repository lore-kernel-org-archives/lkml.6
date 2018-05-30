Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeE3LN4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:13:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60721 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752242AbeE3LHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:31 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Colin Ian King" <colin.king@canonical.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Raghava Aditya Renukunta" <RaghavaAditya.Renukunta@microsemi.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.46783766@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 038/153] scsi: aacraid: remove redundant setting of
 variable c
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -784,11 +784,8 @@ static void setinqstr(struct aac_dev *de
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
