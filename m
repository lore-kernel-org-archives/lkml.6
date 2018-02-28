Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831452-2-8991140142006018906
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831452; b=Jq6KgEUZu4RveRZUtQ8ROitspusN9vh7zq2lAs1lJj8UaeM
    RHYZIq87+HnVzIzRXgGG7KYs8HNkqvyf6f1ZuSm7F96zhntd8Lpakj8H00gRPL4z
    mXDB7tjvJN+676F0oLR98B1eeQo3gfOiBLjcEwAt6UzbntPFJGSLOa2cFPJcgUwK
    oHMXljyP3WHeaVtFDuuCPM4Q7BSvRt96Ant+Nb+e2BMiDAqzhD/87q21qzxXKD6N
    vGMDJgs6tDNW2wqC1kQQ0N8oLe2FI33qnVH/d4rcQj+7OUhDV7QpP/sMQJasvNZq
    aedfJJSVx9nwXHLW8WEWpPzonDO3tfS+b0e41OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831452; bh=UmnpCOH6GtNEGSbzwmG
    NiTRTr+wLr1wsl4Su3ldImcQ=; b=IN7MSvCL/9T3FEuc5BZw1gt6VSUIMMqqCgl
    1GLBtg3zFfNH8KdH88tuaCBdYIbfIvSnlrJVpHScY9a9V6Y269vEDFlLjvJ2tKpr
    +ket0Y+QT00cHVoOic9gjJSeh0HttmuTrb+HP9+l1UeN7NJSkj4k++5y7fVht9Dz
    aUFNnnPtEGCI9OmtrsTgBRb+7kRZQXlbqJfruvPLOh3gCd6+Iky0u4opOvv3f+L6
    wrf0MaCAQ+u5mt/vsb3nTxseDaP7y+ctYv/8R3BbU+fWbILfBmc/4d0iJiErrmZU
    YFwr/wbthal2UO2bfZjaAA8j2J3FcrgoXhtA7Jg33i8c1QSq5Fw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeB1PYI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:24:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33407 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752888AbeB1PWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Thiago Rafael Becker" <thiago.becker@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "NeilBrown" <neilb@suse.com>,
        "Matthew Wilcox" <mawilcox@microsoft.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.622436378@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 046/140] kernel: make groups_sort calling a
 responsibility group_info allocators
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thiago Rafael Becker <thiago.becker@gmail.com>

commit bdcf0a423ea1c40bbb40e7ee483b50fc8aa3d758 upstream.

In testing, we found that nfsd threads may call set_groups in parallel
for the same entry cached in auth.unix.gid, racing in the call of
groups_sort, corrupting the groups for that entry and leading to
permission denials for the client.

This patch:
 - Make groups_sort globally visible.
 - Move the call to groups_sort to the modifiers of group_info
 - Remove the call to groups_sort from set_groups

Link: http://lkml.kernel.org/r/20171211151420.18655-1-thiago.becker@gmail.com
Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Acked-by: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2:
 - Drop change in gss_rpc_xdr.c
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -242,6 +242,7 @@ asmlinkage long sys32_setgroups16(int gi
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -60,6 +60,9 @@ int nfsd_setuser(struct svc_rqst *rqstp,
 				GROUP_AT(gi, i) = exp->ex_anon_gid;
 			else
 				GROUP_AT(gi, i) = GROUP_AT(rqgi, i);
+
+			/* Each thread allocates its own gi, no race */
+			groups_sort(gi);
 		}
 	} else {
 		gi = get_group_info(rqgi);
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -67,6 +67,7 @@ extern void groups_free(struct group_inf
 extern int set_current_groups(struct group_info *);
 extern int set_groups(struct cred *, struct group_info *);
 extern int groups_search(const struct group_info *, gid_t);
+extern void groups_sort(struct group_info *);
 
 /* access the groups "array" with this macro */
 #define GROUP_AT(gi, i) \
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -103,7 +103,7 @@ static int groups_from_user(struct group
 }
 
 /* a simple Shell sort */
-static void groups_sort(struct group_info *group_info)
+void groups_sort(struct group_info *group_info)
 {
 	int base, max, stride;
 	int gidsetsize = group_info->ngroups;
@@ -130,6 +130,7 @@ static void groups_sort(struct group_inf
 		stride /= 3;
 	}
 }
+EXPORT_SYMBOL(groups_sort);
 
 /* a simple bsearch */
 int groups_search(const struct group_info *group_info, gid_t grp)
@@ -164,7 +165,6 @@ int groups_search(const struct group_inf
 int set_groups(struct cred *new, struct group_info *group_info)
 {
 	put_group_info(new->group_info);
-	groups_sort(group_info);
 	get_group_info(group_info);
 	new->group_info = group_info;
 	return 0;
@@ -247,6 +247,7 @@ SYSCALL_DEFINE2(setgroups, int, gidsetsi
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -203,6 +203,7 @@ SYSCALL_DEFINE2(setgroups16, int, gidset
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -477,6 +477,7 @@ static int rsc_parse(struct cache_detail
 				goto out;
 			GROUP_AT(rsci.cred.cr_group_info, i) = gid;
 		}
+		groups_sort(rsci.cred.cr_group_info);
 
 		/* mech name */
 		len = qword_get(&mesg, buf, mlen);
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -539,6 +539,7 @@ static int unix_gid_parse(struct cache_d
 		GROUP_AT(ug.gi, i) = gid;
 	}
 
+	groups_sort(ug.gi);
 	ugp = unix_gid_lookup(uid);
 	if (ugp) {
 		struct cache_head *ch;
@@ -806,6 +807,7 @@ svcauth_unix_accept(struct svc_rqst *rqs
 		return SVC_CLOSE;
 	for (i = 0; i < slen; i++)
 		GROUP_AT(cred->cr_group_info, i) = svc_getnl(argv);
+	groups_sort(cred->cr_group_info);
 	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
 		*authp = rpc_autherr_badverf;
 		return SVC_DENIED;
