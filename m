Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2392938-1521185206-2-7824549961653820389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521185205; b=gXOCA7hSLda4tA3TrfUIcwRjuW4KW7VCV3nJzL/zfo7qC+a
    Dqnlv/lJ4j2/oAH5JCvVqAcBp/cXxMLk/BILYvHRFDb5XUJwzcVetF1dDbAESj2R
    bkBFrTwhRRvbrer3thNRTupLHidhgUmzeFsekdektjFcMjZYHmm2o4gGp3D6X2Ha
    HcuDPVxpCYM+HFBFME0xqmB6G9AVFf+6gKNJLbxltW6IZAUegSvtqT9+bSWUf3e6
    bl+AFvtqgxKogTN7ctOdcsqYA1LlX6L4lIc8ZqzBayWLDXCIYPAgH3fnPQSV8/DO
    jl7lJ/gN/xbmWChXFnxfvWI40Xf5AltPhq2mpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521185205; bh=Vk3I/6hNhSr1YW59yMNAVj+B/t
    2GipRtyvURIkZkISE=; b=qBDEhY1mTTVfbszP1hyDK03HqAMR5eBDIiTJslp/PY
    FLai0kSRHwU5Qs2bLwYF5yiu6XhLpISBtkEC3EzJd1WzXMzEOXs+VDlz73/RoRlD
    oXDglBxVfxlFrJIZSxBTz1+6oDiZsd0wwcDXm6bke/BVEhc6ECFihp9G4pXCzKwf
    Gqd7555K+q6GcLfXcOCMRRJYtHEirYs5F2rNGI/A9BwBpc1VYhjjV+LCOVn/aT66
    7REEN8JABAw1rdbUYspJmXliIZFt9gEch25ONJffJPCdArgQDD4Pg4egRFS7P5YM
    bqo1pm50DuBXaIxQ6fTsli6xyy9QX0KSyX53GJP2Ydow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCPH0N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 03:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753128AbeCPH0L (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 03:26:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] perf-probe: Fix to convert array type collectly
Date: Fri, 16 Mar 2018 16:25:47 +0900
Message-Id: <152118514751.28861.9842632501370007663.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix to convert array element type collectly.
Current perf-probe converts the type of array-elements
incorrectly. It always converts the types as a pointer
of array. This passes the "array" type DIE to the type
converter so that it can get correct "element of array"
type DIE from it.

E.g.
  ====
  $ cat hello.c
  #include <stdio.h>

  void foo(int a[])
  {
	  printf("%d\n", a[1]);
  }

  void main()
  {
	  int a[3] = {4, 5, 6};
	  printf("%d\n", a[0]);
	  foo(a);
  }

  $ gcc -g hello.c -o hello
  $ perf probe -x ./hello -D "foo a[1]"
  ====

Without this fix, above outputs
  ====
  p:probe_hello/foo /tmp/hello:0x4d3 a=+4(-8(%bp)):u64
  ====
The "u64" means "int *", but a[1] is "int".

With this,
  ====
  p:probe_hello/foo /tmp/hello:0x4d3 a=+4(-8(%bp)):s32
  ====
So, "int" correctly converted to "s32"

Fixes: b2a3c12b7442 ("perf probe: Support tracing an entry of array")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 tools/perf/util/probe-finder.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index a5731de0e5eb..c37fbef1711d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -423,20 +423,20 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		pr_warning("Failed to get the type of %s.\n", varname);
 		return -ENOENT;
 	}
-	pr_debug2("Var real type: (%x)\n", (unsigned)dwarf_dieoffset(&type));
+	pr_debug2("Var real type: %s (%x)\n", dwarf_diename(&type),
+		  (unsigned)dwarf_dieoffset(&type));
 	tag = dwarf_tag(&type);
 
 	if (field->name[0] == '[' &&
 	    (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)) {
-		if (field->next)
-			/* Save original type for next field */
-			memcpy(die_mem, &type, sizeof(*die_mem));
+		/* Save original type for next field or type */
+		memcpy(die_mem, &type, sizeof(*die_mem));
 		/* Get the type of this array */
 		if (die_get_real_type(&type, &type) == NULL) {
 			pr_warning("Failed to get the type of %s.\n", varname);
 			return -ENOENT;
 		}
-		pr_debug2("Array real type: (%x)\n",
+		pr_debug2("Array real type: %s (%x)\n", dwarf_diename(&type),
 			 (unsigned)dwarf_dieoffset(&type));
 		if (tag == DW_TAG_pointer_type) {
 			ref = zalloc(sizeof(struct probe_trace_arg_ref));
@@ -448,9 +448,6 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				*ref_ptr = ref;
 		}
 		ref->offset += dwarf_bytesize(&type) * field->index;
-		if (!field->next)
-			/* Save vr_die for converting types */
-			memcpy(die_mem, vr_die, sizeof(*die_mem));
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
 		/* Check the pointer and dereference */
