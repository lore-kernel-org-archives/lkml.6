Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2571388-1521191955-2-5247999436441117666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521191954; b=lxAGEOrKKT+WeveWmskvulVXSc0Zy+SqTd37twjZDI0fuxu
    ZFlIjngixAD+13b6bb/jYSqUO3SvBVymh6yCuKy7XCLF1GtwjNJ/cdVWSbuWtk/3
    ERpW6pSHsBkRXK/hpY04uOcARrQjQHhh2p0C45tXGtt8Ip9SINyibeqj6d7cUXiK
    RHrQTCoVmwt62crIwAgWFLbTC9GuUYSm7g5N8eNoSk/jSljLulJ+KEdE9C0puJPA
    gobqAoay93dYki5i4oWIqQnGP5pFmdrwtUplQfHB2eyGXyYdf3iThLYkgkIstJp2
    mY0OfdcCJ64ekBp8IDqZ/Af/kBKvzVrPg33XsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521191954;
    bh=Xyop4zRSDFrH9Pk/5XIIyU4bC4nQDiPfCC6/aTN2vBk=; b=APK/MI2SlTjG
    zTWfo023q8cSrKE608hm77s4ZIzC9MIYG8FClROEtGYtxLcZZa6vzF7HDYpCYseK
    Dsq8hysHzOa9Bk1n8U8P3jj3P0/2zIoLYjuCzXYvPgeW6hqDuh4TyPVJ2gpijTM9
    qmwYZK/hXaXX0+/zGu4erYc/q2StuZ8/1OzynNsvFdGCvdq9VmUDRmOGCbDN4xPN
    ub3kZUf/nn0RbLm100JPqmMwlvgsaZR84ckggYT1Zc+h5ariOCLu91gVYe0QZ1Uv
    3k7xTFUU9AxTWesVuSkoIeoYPk07MV5s0M4z3ZVJA77sTo6UxA5aIi/5HCPQXmqe
    +nKpg7qreg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeCPJSO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:18:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753128AbeCPJSL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:18:11 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau40 v2 3/5] auditctl: add support for containerid filter
Date: Fri, 16 Mar 2018 05:12:27 -0400
Message-Id: <1521191549-19764-4-git-send-email-rgb@redhat.com>
In-Reply-To: <1521191549-19764-1-git-send-email-rgb@redhat.com>
References: <1521191549-19764-1-git-send-email-rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A u64 container identifier has been added to the kernel view of tasks.
This allows container orchestrators to label tasks with a unique
tamperproof identifier that gets inherited by its children to be able to
track the provenance of actions by a container.

Add support to libaudit and auditctl for the containerid field to filter
based on container identifier.  Since it is a u64 and larger than any
other numeric field, send it as a string but do the appropriate
conversions on each end in each direction.

See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/32
See: https://github.com/linux-audit/audit-testsuite/issues/64
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/auditctl.8        |  3 +++
 lib/fieldtab.h         |  1 +
 lib/libaudit.c         | 36 ++++++++++++++++++++++++++++++++++++
 lib/libaudit.h         |  7 +++++++
 src/auditctl-listing.c | 21 +++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/docs/auditctl.8 b/docs/auditctl.8
index 88466de..8bda43d 100644
--- a/docs/auditctl.8
+++ b/docs/auditctl.8
@@ -210,6 +210,9 @@ Parent's Process ID
 .B sessionid
 User's login session ID
 .TP
+.B containerid
+Process' container ID
+.TP
 .B subj_user
 Program's SE Linux User
 .TP
diff --git a/lib/fieldtab.h b/lib/fieldtab.h
index c425d5b..755800a 100644
--- a/lib/fieldtab.h
+++ b/lib/fieldtab.h
@@ -47,6 +47,7 @@ _S(AUDIT_OBJ_TYPE,     "obj_type"     )
 _S(AUDIT_OBJ_LEV_LOW,  "obj_lev_low"  )
 _S(AUDIT_OBJ_LEV_HIGH, "obj_lev_high" )
 _S(AUDIT_SESSIONID,    "sessionid"    )
+_S(AUDIT_CONTAINERID,  "containerid"  )
 
 _S(AUDIT_DEVMAJOR,     "devmajor"     )
 _S(AUDIT_DEVMINOR,     "devminor"     )
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 331cdde..c45f366 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -1737,6 +1737,42 @@ int audit_rule_fieldpair_data(struct audit_rule_data **rulep, const char *pair,
 			else if (strcmp(v, "unset") == 0)
 				rule->values[rule->field_count] = UINT_MAX;
 			break;
+		case AUDIT_CONTAINERID: {
+			unsigned long long val;
+
+			if ((audit_get_features() &
+				AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER) == 0)
+				return -EAU_FIELDNOSUPPORT;
+			if (flags != AUDIT_FILTER_EXCLUDE &&
+			    flags != AUDIT_FILTER_USER &&
+			    flags != AUDIT_FILTER_EXIT)
+				return -EAU_FIELDNOFILTER;
+			if (isdigit((char)*(v))) 
+				val = strtoull(v, NULL, 0);
+			else if (strlen(v) >= 2 && *(v)=='-' && 
+						(isdigit((char)*(v+1)))) 
+				val = strtoll(v, NULL, 0);
+			else if (strcmp(v, "unset") == 0)
+				val = ULLONG_MAX;
+			else
+				return -EAU_FIELDVALNUM;
+			if (errno)
+				return -EAU_FIELDVALNUM;
+			vlen = sizeof(unsigned long long);
+			rule->values[rule->field_count] = vlen;
+			offset = rule->buflen;
+			rule->buflen += vlen;
+			*rulep = realloc(rule, sizeof(*rule) + rule->buflen);
+			if (*rulep == NULL) {
+				free(rule);
+				audit_msg(LOG_ERR, "Cannot realloc memory!\n");
+				return -3;
+			} else {
+				rule = *rulep;
+			}
+			*(unsigned long long*)(&rule->buf[offset]) = val;
+			break;
+		}
 		case AUDIT_DEVMAJOR...AUDIT_INODE:
 		case AUDIT_SUCCESS:
 			if (flags != AUDIT_FILTER_EXIT)
diff --git a/lib/libaudit.h b/lib/libaudit.h
index 756a3b8..cefe71d 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -328,6 +328,9 @@ extern "C" {
 #ifndef AUDIT_FEATURE_BITMAP_FILTER_FS
 #define AUDIT_FEATURE_BITMAP_FILTER_FS		0x00000040
 #endif
+#ifndef AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER
+#define AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER 0x00000080
+#endif
 
 /* Defines for interfield comparison update */
 #ifndef AUDIT_OBJ_UID
@@ -351,6 +354,10 @@ extern "C" {
 #define AUDIT_FSTYPE 26
 #endif
 
+#ifndef AUDIT_CONTAINERID
+#define AUDIT_CONTAINERID 27
+#endif
+
 #ifndef AUDIT_COMPARE_UID_TO_OBJ_UID
 #define AUDIT_COMPARE_UID_TO_OBJ_UID   1
 #endif
diff --git a/src/auditctl-listing.c b/src/auditctl-listing.c
index f670ff9..974dcb4 100644
--- a/src/auditctl-listing.c
+++ b/src/auditctl-listing.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
 #include "auditctl-listing.h"
 #include "private.h"
 #include "auditctl-llist.h"
@@ -460,6 +461,26 @@ static void print_rule(const struct audit_rule_data *r)
 						audit_operator_to_symbol(op),
 						audit_fstype_to_name(
 						r->values[i]));
+			} else if (field == AUDIT_CONTAINERID) {
+				unsigned long long val;
+
+				if (r->values[i] == sizeof(unsigned long long)) {
+					val = *(unsigned long long*)(&r->buf[boffset]);
+
+					if (val != ULLONG_MAX)
+						printf(" -F %s%s%llu", name,
+							audit_operator_to_symbol(op),
+							val);
+					else
+						printf(" -F %s%s%s", name,
+							audit_operator_to_symbol(op),
+							"unset");
+				} else {
+					printf(" -F %s%s%s", name,
+						audit_operator_to_symbol(op),
+						"inval");
+				}
+				boffset += r->values[i];
 			} else {
 				// The default is signed decimal
 				printf(" -F %s%s%d", name, 
-- 
1.8.3.1

