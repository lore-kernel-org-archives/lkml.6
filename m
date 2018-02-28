Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835756-2-18219160682878097146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835756; b=pznwn5AyLd8MaK5SUo4VoBuMsWXdHeBzTPhavvt7SylpEL9
    MnSJRXuIohMxnaHGbBTaya1nwGpPUxOZ3puhaGddU2aL3/0UWS3RHqDCOAfG/4P/
    O+y53t5Fv9uMkBwPsb9a8wcx6gRuw8ycKkTOlrsBvrDwVKe7nWyn8mZEnf2is89n
    G66zt2Kjz7BBO/OczXIZkLikY5khqIczAH+xu/9Pq4ctLI4hFHtInvArNbG/KqNE
    fHHCpk85D4lAQQJnH+6U1Y2HcQw0Lq6hb5SqgK7WIGpPKglcwGKEuwTPnutDg7DV
    cbH745mFWDe7iT2mz2KdUOXjQbUffoBcc5RdWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835756; bh=UNdbRTmHyM+kwZge79/
    vL56fav7rEPlOxEUnSVJ1gEg=; b=L+wm0Q3lGmwDSP02/MWBslsqLeS5DDRtCd9
    kmgYYM1ZCL9ct7/vR4198USFsQY6ltBoIuXahI1rOhpXi0FfwC5pXUbBc1ZjAyT5
    k9N6piPEP4B+csED7mlG35KcZd9DDQq28ZARWIzAJdbuVTkybKuBMRP7yB9h+ln9
    bdgNlpTOsB0r2a5Z7m9iNuugxW4XCOU8YGPalx4yIUGB88Tb+5jn9YneK8+V2ReM
    g9tCw5HAbU4/Prj1/foVfXAOVkCKnpfGbLr4p3+yU2fcgjAnFu8eWBmUG1T6fRg0
    KeT9lfnEPOuFky8DbRADMG0w3qxWgtzqjFuuf1EH4dlcpxdvuyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934608AbeB1QNm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:13:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35063 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933070AbeB1QNi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:13:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Long Li" <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Paul Meyer" <Paul.Meyer@microsoft.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.90841535@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 029/254] hv: kvp: Avoid reading past allocated blocks
 from KVP file
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Meyer <Paul.Meyer@microsoft.com>

commit 297d6b6e56c2977fc504c61bbeeaa21296923f89 upstream.

While reading in more than one block (50) of KVP records, the allocation
goes per block, but the reads used the total number of allocated records
(without resetting the pointer/stream). This causes the records buffer to
overrun when the refresh reads more than one block over the previous
capacity (e.g. reading more than 100 KVP records whereas the in-memory
database was empty before).

Fix this by reading the correct number of KVP records from file each time.

Signed-off-by: Paul Meyer <Paul.Meyer@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/hv/hv_kvp_daemon.c | 70 ++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -196,11 +196,14 @@ static void kvp_update_mem_state(int poo
 	for (;;) {
 		readp = &record[records_read];
 		records_read += fread(readp, sizeof(struct kvp_record),
-					ENTRIES_PER_BLOCK * num_blocks,
-					filep);
+				ENTRIES_PER_BLOCK * num_blocks - records_read,
+				filep);
 
 		if (ferror(filep)) {
-			syslog(LOG_ERR, "Failed to read file, pool: %d", pool);
+			syslog(LOG_ERR,
+				"Failed to read file, pool: %d; error: %d %s",
+				 pool, errno, strerror(errno));
+			kvp_release_lock(pool);
 			exit(EXIT_FAILURE);
 		}
 
@@ -213,6 +216,7 @@ static void kvp_update_mem_state(int poo
 
 			if (record == NULL) {
 				syslog(LOG_ERR, "malloc failed");
+				kvp_release_lock(pool);
 				exit(EXIT_FAILURE);
 			}
 			continue;
@@ -227,15 +231,11 @@ static void kvp_update_mem_state(int poo
 	fclose(filep);
 	kvp_release_lock(pool);
 }
+
 static int kvp_file_init(void)
 {
 	int  fd;
-	FILE *filep;
-	size_t records_read;
 	char *fname;
-	struct kvp_record *record;
-	struct kvp_record *readp;
-	int num_blocks;
 	int i;
 	int alloc_unit = sizeof(struct kvp_record) * ENTRIES_PER_BLOCK;
 
@@ -249,61 +249,19 @@ static int kvp_file_init(void)
 
 	for (i = 0; i < KVP_POOL_COUNT; i++) {
 		fname = kvp_file_info[i].fname;
-		records_read = 0;
-		num_blocks = 1;
 		sprintf(fname, "%s/.kvp_pool_%d", KVP_CONFIG_LOC, i);
 		fd = open(fname, O_RDWR | O_CREAT | O_CLOEXEC, 0644 /* rw-r--r-- */);
 
 		if (fd == -1)
 			return 1;
 
-
-		filep = fopen(fname, "re");
-		if (!filep) {
-			close(fd);
-			return 1;
-		}
-
-		record = malloc(alloc_unit * num_blocks);
-		if (record == NULL) {
-			fclose(filep);
-			close(fd);
-			return 1;
-		}
-		for (;;) {
-			readp = &record[records_read];
-			records_read += fread(readp, sizeof(struct kvp_record),
-					ENTRIES_PER_BLOCK,
-					filep);
-
-			if (ferror(filep)) {
-				syslog(LOG_ERR, "Failed to read file, pool: %d",
-				       i);
-				exit(EXIT_FAILURE);
-			}
-
-			if (!feof(filep)) {
-				/*
-				 * We have more data to read.
-				 */
-				num_blocks++;
-				record = realloc(record, alloc_unit *
-						num_blocks);
-				if (record == NULL) {
-					fclose(filep);
-					close(fd);
-					return 1;
-				}
-				continue;
-			}
-			break;
-		}
 		kvp_file_info[i].fd = fd;
-		kvp_file_info[i].num_blocks = num_blocks;
-		kvp_file_info[i].records = record;
-		kvp_file_info[i].num_records = records_read;
-		fclose(filep);
-
+		kvp_file_info[i].num_blocks = 1;
+		kvp_file_info[i].records = malloc(alloc_unit);
+		if (kvp_file_info[i].records == NULL)
+			return 1;
+		kvp_file_info[i].num_records = 0;
+		kvp_update_mem_state(i);
 	}
 
 	return 0;
