Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeE3LRW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:17:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32823 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752600AbeE3LHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:08 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Joe Perches" <joe@perches.com>, "Jean Delvare" <jdelvare@suse.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.175214312@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 072/153] firmware/dmi_scan: constify strings
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit ffbbb96dd7570b9aafd426cd77a7ee03d224cabf upstream.

Add const to all DMI string pointers where this is possible.  This fixes a
checkpatch warning.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Joe Perches <joe@perches.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/firmware/dmi_scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -14,7 +14,7 @@
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static char dmi_empty_string[] = "        ";
+static const char dmi_empty_string[] = "        ";
 
 static u16 __initdata dmi_ver;
 /*
@@ -46,7 +46,7 @@ static const char * __init dmi_string_no
 	return "";
 }
 
-static char * __init dmi_string(const struct dmi_header *dm, u8 s)
+static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
 {
 	const char *bp = dmi_string_nosave(dm, s);
 	char *str;
@@ -130,7 +130,7 @@ static int __init dmi_checksum(const u8
 	return sum == 0;
 }
 
-static char *dmi_ident[DMI_STRING_MAX];
+static const char *dmi_ident[DMI_STRING_MAX];
 static LIST_HEAD(dmi_devices);
 int dmi_available;
 
@@ -140,7 +140,7 @@ int dmi_available;
 static void __init dmi_save_ident(const struct dmi_header *dm, int slot, int string)
 {
 	const char *d = (const char*) dm;
-	char *p;
+	const char *p;
 
 	if (dmi_ident[slot])
 		return;
@@ -246,7 +246,7 @@ static void __init dmi_save_oem_strings_
 	struct dmi_device *dev;
 
 	for (i = 1; i <= count; i++) {
-		char *devname = dmi_string(dm, i);
+		const char *devname = dmi_string(dm, i);
 
 		if (devname == dmi_empty_string)
 			continue;
