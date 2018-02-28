Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519833728-2-1896757954264899722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833728; b=JsGfmweoD81dLTsGYi0AWVkrzV2YNKapOdFPXCX5My5Gt8x
    0im4WJCSmdjqeedV9dAoaa+/fSobHuKsoh9Vsneu+8f6ZDbAaoGysEz98A4Onlf1
    DHw7PusAgbm2cwKeVBdNi9U8UnU1yDZoGv/Ll/gDc4cAaf3D2hQLbdC08H20Xb9o
    S1RtslW6f5uBQAG6xhE4hgCJZu+MOoCS5dROgBr7FMyjvc1qRKuFnSvxBiN84vP0
    h9s6lNeLQH49uvmtP5BiIw97mJQvO6k3l/KrOMhFv1wjW0jpmV/dFsWBbzWCJF1E
    yNUn+1zX4HaiJ4i6hyTlruAUVBdtZGEGQDCZE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833728; bh=xkzfDlTLJBoHbW8Nrgx
    Hx52OdhX9RjLVYSNKjqZ18KA=; b=OIOCHq/O1Tcv028i2Z8AaClA1Y1qLA31ppm
    4dzJbTqc8Xe7VPe1UZesEW1fR6G+TEARjzxnE53QkF/G2mhKeCseL79VBUksa96J
    jLSU/IQY74N+9IwDBvpzGhNATdLRWlfuSjJwvGQBwDVEAzY1ygyaGinRxjMc+o72
    VtYK8CA73WPyF6u9N7rbxQmwRcjGX6AQtvW5p0BeCg9tG4Dq3J24UtaNhYX8mXA4
    xex0wCDU2/oxaYZ623SsrGoIn4DfbAEwa121BVvEpyIVICzHzJ8+KysnEdnmxIVS
    xqQpHz+0i8Nd7oL8LSJBkn2dg7lDLYX5FOI+/gPO9Mn33wBpw3Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeB1QCE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:02:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34704 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753121AbeB1QCD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:02:03 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "NeilBrown" <neilb@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Matthew Wilcox" <mawilcox@microsoft.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Thiago Rafael Becker" <thiago.becker@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.709445810@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 114/254] kernel: make groups_sort calling a
 responsibility group_info allocators
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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/compat_linux.c   | 1 +
 fs/nfsd/auth.c                    | 3 +++
 include/linux/cred.h              | 1 +
 kernel/groups.c                   | 5 +++--
 kernel/uid16.c                    | 1 +
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 1 +
 net/sunrpc/auth_gss/svcauth_gss.c | 1 +
 net/sunrpc/svcauth_unix.c         | 2 ++
 8 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -263,6 +263,7 @@ COMPAT_SYSCALL_DEFINE2(s390_setgroups16,
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -59,6 +59,9 @@ int nfsd_setuser(struct svc_rqst *rqstp,
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
@@ -69,6 +69,7 @@ extern int set_current_groups(struct gro
 extern void set_groups(struct cred *, struct group_info *);
 extern int groups_search(const struct group_info *, kgid_t);
 extern bool may_setgroups(void);
+extern void groups_sort(struct group_info *);
 
 /* access the groups "array" with this macro */
 #define GROUP_AT(gi, i) \
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -104,7 +104,7 @@ static int groups_from_user(struct group
 }
 
 /* a simple Shell sort */
-static void groups_sort(struct group_info *group_info)
+void groups_sort(struct group_info *group_info)
 {
 	int base, max, stride;
 	int gidsetsize = group_info->ngroups;
@@ -131,6 +131,7 @@ static void groups_sort(struct group_inf
 		stride /= 3;
 	}
 }
+EXPORT_SYMBOL(groups_sort);
 
 /* a simple bsearch */
 int groups_search(const struct group_info *group_info, kgid_t grp)
@@ -162,7 +163,6 @@ int groups_search(const struct group_inf
 void set_groups(struct cred *new, struct group_info *group_info)
 {
 	put_group_info(new->group_info);
-	groups_sort(group_info);
 	get_group_info(group_info);
 	new->group_info = group_info;
 }
@@ -246,6 +246,7 @@ SYSCALL_DEFINE2(setgroups, int, gidsetsi
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -190,6 +190,7 @@ SYSCALL_DEFINE2(setgroups16, int, gidset
 		return retval;
 	}
 
+	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
 
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -231,6 +231,7 @@ static int gssx_dec_linux_creds(struct x
 			goto out_free_groups;
 		GROUP_AT(creds->cr_group_info, i) = kgid;
 	}
+	groups_sort(creds->cr_group_info);
 
 	return 0;
 out_free_groups:
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -479,6 +479,7 @@ static int rsc_parse(struct cache_detail
 				goto out;
 			GROUP_AT(rsci.cred.cr_group_info, i) = kgid;
 		}
+		groups_sort(rsci.cred.cr_group_info);
 
 		/* mech name */
 		len = qword_get(&mesg, buf, mlen);
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -520,6 +520,7 @@ static int unix_gid_parse(struct cache_d
 		GROUP_AT(ug.gi, i) = kgid;
 	}
 
+	groups_sort(ug.gi);
 	ugp = unix_gid_lookup(cd, uid);
 	if (ugp) {
 		struct cache_head *ch;
@@ -827,6 +828,7 @@ svcauth_unix_accept(struct svc_rqst *rqs
 		kgid_t kgid = make_kgid(&init_user_ns, svc_getnl(argv));
 		GROUP_AT(cred->cr_group_info, i) = kgid;
 	}
+	groups_sort(cred->cr_group_info);
 	if (svc_getu32(argv) != htonl(RPC_AUTH_NULL) || svc_getu32(argv) != 0) {
 		*authp = rpc_autherr_badverf;
 		return SVC_DENIED;
