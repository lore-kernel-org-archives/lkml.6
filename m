Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EEEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2402089C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2402089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeHFGFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:05:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbeHFGFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:05:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w763rplY133295
        for <linux-kernel@vger.kernel.org>; Sun, 5 Aug 2018 23:58:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpbucmu84-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 23:58:33 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Mon, 6 Aug 2018 04:58:31 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 04:58:30 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w763wTbP34013284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 03:58:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 182A04C04A;
        Mon,  6 Aug 2018 06:58:39 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 732924C040;
        Mon,  6 Aug 2018 06:58:38 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 06:58:38 +0100 (BST)
Received: from intelligence.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 33E48A024D;
        Mon,  6 Aug 2018 13:58:27 +1000 (AEST)
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Cc:     fbarrat@linux.vnet.ibm.com
Subject: [RFC PATCH 2/2] checkpatch: Fix commit ID test when "commit" and hash on different lines
Date:   Mon,  6 Aug 2018 13:58:09 +1000
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180806035809.24752-1-andrew.donnellan@au1.ibm.com>
References: <20180806035809.24752-1-andrew.donnellan@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080603-0016-0000-0000-000001F1BC98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080603-0017-0000-0000-00003246F95A
Message-Id: <20180806035809.24752-2-andrew.donnellan@au1.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=735 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

RFC because I'm bad at Perl
---
 scripts/checkpatch.pl | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index aca4d758112a..ae7a54287db7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2662,40 +2662,46 @@ sub process {
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
+			my $ref_line = $line;
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
+			if ($ref_line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
-			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
+			} elsif ($ref_line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
+				if (defined $rawlines[$linenr - 2] &&
+					$rawlines[$linenr - 2] =~ /\bcommit$/) {
+					$ref_line = "commit " . $ref_line;
+				}
 			}
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
 
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			$short = 0 if ($ref_line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($ref_line =~ /\bcommit\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($ref_line =~ /\bcommit [0-9a-f]/i);
+			$case = 0 if ($ref_line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
+
+			if ($ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
 				# Reference fits on 1 line
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+			} elsif ($ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
 				# line 1: 'commit <hash>',
 				# line 2: '("description")'
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+			} elsif ($ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
 				# line 1: 'commit <hash> ("description',
 				# line 2: 'description continued")'
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+			} elsif ($ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 defined $rawlines[$linenr + 1] &&
 				 $rawlines[$linenr] =~ /^\s*\("[^"]+/ &&
@@ -2708,7 +2714,7 @@ sub process {
 				$rawlines[$linenr + 1] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+			} elsif ($ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 defined $rawlines[$linenr + 1] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+$/ &&
@@ -2716,7 +2722,7 @@ sub process {
 				# line 1: 'commit <hash> ("description',
 				# line 2: 'description continued'
 				# line 3: 'description continued")'
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$ref_line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)$/;
 				$orig_desc .= " " . $1;
-- 
2.11.0

