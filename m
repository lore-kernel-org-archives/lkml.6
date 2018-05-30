Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3999954-1527690117-2-17659725689569302335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527690117; b=gvFU339HSzLHaoGMSONXABwQk8fMSn3pSZZ4qgI/ijhDeL1TkQ
    sTaG+IGTonzro58R6KaVBs8egAvYpnFRXZhaGmSc8YemYHJfX6+rdxgkTWYQBsbN
    VLdIFRdf7D9EDpPvxZb0IeWpepv7F0MDt8Kt1GFmB7sEToMZjhqhhtMKZj39o3kb
    krT81tNkiYP1NvR1pcfLJCCU+KMmPVZ32aJOJMSwuA6PAnnjt7Pw8eUfvRdppBQO
    SIzOcalAXvS9tsESsw06LItI25WQuvAkJJi2HjZcUxUyYv7RAi7rFCPTtu6StcGY
    NmIkYMJMP0umnWeaRC9yoh7RaivBp3S3dSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527690117; bh=NH/G4k3p5dXrpYPnQEJmkFvq4RmZt8
    WHcZTNmkrBLbg=; b=ajBaOrfz9mDBuRSdAGFMDdiXA55jdjEBkf5chaxcv+iF2J
    EzFb+Sd4RC48duSiluRMe/CXQJ0+xmqCA3fzJTBFWH7IkInbchCgDROddWw7h13x
    KGAk5obWjIbAEJAg/Qln0Dkh7714sBMXLuqJOcLrfEaaKDPFptMOtXGU9eBK6wOs
    1y6AqaPf/rCt+KMaR05wkiDJgNW53zOgceDaifRGtBqw4h+0y+KKcPiVPS45+DeG
    aqBHi5bu8aPylkRrCzHb3kxkCUHP9EDE1cAqBarWx41179eV2RKGplcAB5ScOYZh
    5zUKK5vfqJen2pD/ZrfIYYRwgdqOVxoMm72y/n9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE7uIur76FPs9dQWK6/cIJqDUinMBZX69uXbwemBSVcsjWYKMRA0PbPk05ljwK0k1PpdDxBAQ/2RGoHSIiZYcWA1Yh445jVvfZVYurXfWvpQgfrlZiN4
    OmpWjC2a7k1958Krou7pxWTPl1BtUzqqUEGwABqIKYeVd9dq981RhDz3TKFCn+JmZhj/yxbmBtoJh/Sm8RJ/w93JODpyPBQJxmsXz0jmlRg0ENPdxZCQpyrK
    OM6+owsjdsGLyvEVAqLUPQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=z6gsHLkEAAAA:8
    a=VwQbUJbxAAAA:8 a=Qy0aOJa3TTYsb1N067AA:9 a=eljxqnDXQBx4Un7N:21
    a=reVgodwpcCpcgoud:21 a=x8gzFH9gYPwA:10 a=d-OLMTCWyvARjPbQ-enb:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeE3OVy (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 10:21:54 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:11385 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753131AbeE3OVk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 10:21:40 -0400
From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH V3 5/5 selinux-next] selinux: Switch to rcu read locks for avc_compute
Date: Wed, 30 May 2018 16:11:04 +0200
Message-ID: <20180530141104.28569-6-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To be able to preempt avc_compute we need preemptible
locks, this patch switch the rwlock reads to rcu_read_lock.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 152 +++++++++++++++++++++--------------------
 security/selinux/ss/services.h |   2 +-
 2 files changed, 79 insertions(+), 75 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 954ebe490516..a9aa863c47a3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -84,7 +84,7 @@ static struct selinux_ss selinux_ss;
 
 void selinux_ss_init(struct selinux_ss **ss)
 {
-	rwlock_init(&selinux_ss.policy_rwlock);
+	spin_lock_init(&selinux_ss.policy_lock);
 	mutex_init(&selinux_ss.status_lock);
 	selinux_ss.active_set = kzalloc(sizeof(struct selinux_ruleset),
 					GFP_KERNEL);
@@ -779,7 +779,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	if (!state->initialized)
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -837,7 +837,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -879,7 +879,7 @@ int security_bounded_transition(struct selinux_state *state,
 	if (!state->initialized)
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -944,7 +944,7 @@ int security_bounded_transition(struct selinux_state *state,
 		kfree(old_name);
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -1035,7 +1035,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
 	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	if (!state->initialized)
 		goto allow;
 
@@ -1092,7 +1092,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 		}
 	}
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
@@ -1122,7 +1122,7 @@ void security_compute_av(struct selinux_state *state,
 	u16 tclass;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	avd_init(state, avd);
 	xperms->len = 0;
 	if (!state->initialized)
@@ -1160,7 +1160,7 @@ void security_compute_av(struct selinux_state *state,
 	map_decision(&state->ss->active_set->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1177,7 +1177,7 @@ void security_compute_av_user(struct selinux_state *state,
 	struct sidtab *sidtab;
 	struct context *scontext = NULL, *tcontext = NULL;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	avd_init(state, avd);
 	if (!state->initialized)
 		goto allow;
@@ -1212,7 +1212,7 @@ void security_compute_av_user(struct selinux_state *state,
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
 				  NULL);
  out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1319,7 +1319,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		rc = -EINVAL;
 		goto out;
 	}
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
 	if (force)
@@ -1335,7 +1335,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	rc = context_struct_to_string(policydb, context, scontext,
 				      scontext_len);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 out:
 	return rc;
 
@@ -1491,7 +1491,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		if (!str)
 			goto out;
 	}
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
@@ -1505,7 +1505,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	context_destroy(&context);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 out:
 	kfree(scontext2);
 	kfree(str);
@@ -1666,7 +1666,7 @@ static int security_compute_sid(struct selinux_state *state,
 
 	context_init(&newcontext);
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	if (kern) {
 		tclass = unmap_class(&state->ss->active_set->map, orig_tclass);
@@ -1806,7 +1806,7 @@ static int security_compute_sid(struct selinux_state *state,
 	/* Obtain the sid for the context. */
 	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcontext);
 out:
 	return rc;
@@ -2166,14 +2166,14 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	if (rc)
 		goto pdcerr;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	old_set = state->ss->active_set;
 	rc = policydb_copy(&old_set->policydb, pdc, &storage, size);
 
 	/* save seq */
 	seqno = state->ss->latest_granting;
 
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	policydb_flattened_free(storage);
 
@@ -2232,16 +2232,18 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto maperr;
 	}
 
+
 	next_set->map.mapping = newmap.mapping;
 	next_set->map.size = newmap.size;
 
 	/* Install the new policydb and SID table. */
-	write_lock_irq(&state->ss->policy_rwlock);
-	if (seqno == state->ss->latest_granting) {
+	spin_lock_irq(&state->ss->policy_lock);
+	if (likely(seqno == state->ss->latest_granting)) {
 		security_load_policycaps(state, &next_set->policydb);
 		seqno = ++state->ss->latest_granting;
 		state->ss->active_set = next_set;
-		write_unlock_irq(&state->ss->policy_rwlock);
+		spin_unlock_irq(&state->ss->policy_lock);
+		synchronize_rcu();
 
 		avc_ss_reset(state->avc, seqno);
 		selnl_notify_policyload(seqno);
@@ -2260,7 +2262,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		rc = 0;
 		goto out;
 	} else {
-		write_unlock_irq(&state->ss->policy_rwlock);
+		spin_unlock_irq(&state->ss->policy_lock);
 		rc = -EAGAIN;
 	}
 maperr:
@@ -2285,9 +2287,9 @@ size_t security_policydb_len(struct selinux_state *state)
 	struct policydb *p = &state->ss->active_set->policydb;
 	size_t len;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	len = p->len;
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	return len;
 }
@@ -2306,7 +2308,7 @@ int security_port_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2334,7 +2336,7 @@ int security_port_sid(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2352,7 +2354,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2380,7 +2382,7 @@ int security_ib_pkey_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2398,7 +2400,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 	struct ocontext *c;
 	int rc = 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2427,7 +2429,7 @@ int security_ib_endport_sid(struct selinux_state *state,
 		*out_sid = SECINITSID_UNLABELED;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2444,7 +2446,7 @@ int security_netif_sid(struct selinux_state *state,
 	int rc = 0;
 	struct ocontext *c;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2474,7 +2476,7 @@ int security_netif_sid(struct selinux_state *state,
 		*if_sid = SECINITSID_NETIF;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2509,7 +2511,7 @@ int security_node_sid(struct selinux_state *state,
 	int rc;
 	struct ocontext *c;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2567,7 +2569,7 @@ int security_node_sid(struct selinux_state *state,
 
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2609,7 +2611,7 @@ int security_get_user_sids(struct selinux_state *state,
 	if (!state->initialized)
 		goto out;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2663,7 +2665,7 @@ int security_get_user_sids(struct selinux_state *state,
 	}
 	rc = 0;
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	if (rc || !mynel) {
 		kfree(mysids);
 		goto out;
@@ -2705,7 +2707,7 @@ int security_get_user_sids(struct selinux_state *state,
  * cannot support xattr or use a fixed labeling behavior like
  * transition SIDs or task SIDs.
  *
- * The caller must acquire the policy_rwlock before calling this function.
+ * The caller must acquire the policy_lock before calling this function.
  */
 static inline int __security_genfs_sid(struct selinux_state *state,
 				       const char *fstype,
@@ -2767,7 +2769,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
  * @sclass: file security class
  * @sid: SID for path
  *
- * Acquire policy_rwlock before calling __security_genfs_sid() and release
+ * Acquire policy_lock before calling __security_genfs_sid() and release
  * it afterward.
  */
 int security_genfs_sid(struct selinux_state *state,
@@ -2778,9 +2780,9 @@ int security_genfs_sid(struct selinux_state *state,
 {
 	int retval;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	retval = __security_genfs_sid(state, fstype, path, orig_sclass, sid);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return retval;
 }
 
@@ -2797,7 +2799,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 	sidtab = state->ss->active_set->sidtab;
@@ -2830,7 +2832,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2847,7 +2849,7 @@ int security_get_bools(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 
@@ -2880,7 +2882,7 @@ int security_get_bools(struct selinux_state *state,
 	}
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 err:
 	if (*names) {
@@ -2914,13 +2916,14 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 		goto errout;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	old_set = state->ss->active_set;
 	seqno = state->ss->latest_granting;
 	memcpy(next_set, old_set, sizeof(struct selinux_ruleset));
 	rc = policydb_copy(&old_set->policydb, &next_set->policydb,
 			   &storage, size);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
+
 	if (rc)
 		goto out;
 
@@ -2956,12 +2959,13 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 	rc = 0;
 out:
 	if (!rc) {
-		write_lock_irq(&state->ss->policy_rwlock);
+		spin_lock_irq(&state->ss->policy_lock);
 		if (seqno == state->ss->latest_granting) {
 			seqno = ++state->ss->latest_granting;
 			state->ss->active_set = next_set;
 			rc = 0;
-			write_unlock_irq(&state->ss->policy_rwlock);
+			spin_unlock_irq(&state->ss->policy_lock);
+			synchronize_rcu();
 			avc_ss_reset(state->avc, seqno);
 			selnl_notify_policyload(seqno);
 			selinux_status_update_policyload(state, seqno);
@@ -2970,7 +2974,7 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 			kfree(old_set);
 		} else {
 			rc = -ENOMEM;
-			write_unlock_irq(&state->ss->policy_rwlock);
+			spin_unlock_irq(&state->ss->policy_lock);
 			printk(KERN_ERR "SELinux: %s failed in seqno %d\n",
 			       __func__, rc);
 			policydb_destroy(&next_set->policydb);
@@ -2994,7 +2998,7 @@ int security_get_bool_value(struct selinux_state *state,
 	int rc;
 	int len;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	policydb = &state->ss->active_set->policydb;
 
@@ -3005,7 +3009,7 @@ int security_get_bool_value(struct selinux_state *state,
 
 	rc = policydb->bool_val_to_struct[index]->state;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3065,7 +3069,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	context_init(&newcon);
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	context1 = sidtab_search(sidtab, sid);
@@ -3108,7 +3112,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 
 	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
 out_unlock:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	context_destroy(&newcon);
 out:
 	return rc;
@@ -3170,7 +3174,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	if (!policydb->mls_enabled)
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
@@ -3197,7 +3201,7 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	 * expressive */
 	*peer_sid = xfrm_sid;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3226,7 +3230,7 @@ int security_get_classes(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	rc = -ENOMEM;
 	*nclasses = policydb->p_classes.nprim;
@@ -3244,7 +3248,7 @@ int security_get_classes(struct selinux_state *state,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3268,7 +3272,7 @@ int security_get_permissions(struct selinux_state *state,
 	int rc, i;
 	struct class_datum *match;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	rc = -EINVAL;
 	match = hashtab_search(policydb->p_classes.table, class);
@@ -3297,11 +3301,11 @@ int security_get_permissions(struct selinux_state *state,
 		goto err;
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 
 err:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	for (i = 0; i < *nperms; i++)
 		kfree((*perms)[i]);
 	kfree(*perms);
@@ -3334,9 +3338,9 @@ int security_policycap_supported(struct selinux_state *state,
 	struct policydb *policydb = &state->ss->active_set->policydb;
 	int rc;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	rc = ebitmap_get_bit(&policydb->policycaps, req_cap);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	return rc;
 }
@@ -3402,7 +3406,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 
 	context_init(&tmprule->au_ctxt);
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	tmprule->au_seqno = state->ss->latest_granting;
 
@@ -3443,7 +3447,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	}
 	rc = 0;
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc) {
 		selinux_audit_rule_free(tmprule);
@@ -3494,7 +3498,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		return -ENOENT;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	if (rule->au_seqno < state->ss->latest_granting) {
 		match = -ESTALE;
@@ -3585,7 +3589,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 	}
 
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return match;
 }
 
@@ -3674,7 +3678,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 		return 0;
 	}
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
@@ -3710,12 +3714,12 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	} else
 		*sid = SECSID_NULL;
 
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return 0;
 out_free:
 	ebitmap_destroy(&ctx_new.range.level[0].cat);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -3739,7 +3743,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (!state->initialized)
 		return 0;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 
 	rc = -ENOENT;
 	ctx = sidtab_search(state->ss->active_set->sidtab, sid);
@@ -3757,7 +3761,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
 out:
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
@@ -3787,9 +3791,9 @@ int security_read_policy(struct selinux_state *state,
 	fp.data = *data;
 	fp.len = *len;
 
-	read_lock(&state->ss->policy_rwlock);
+	rcu_read_lock();
 	rc = policydb_write(policydb, &fp);
-	read_unlock(&state->ss->policy_rwlock);
+	rcu_read_unlock();
 
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 9219649c70ed..84cbcf226551 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -33,7 +33,7 @@ struct selinux_ruleset {
 };
 struct selinux_ss {
 	struct selinux_ruleset *active_set; /* rcu pointer */
-	rwlock_t policy_rwlock;
+	spinlock_t policy_lock;
 	u32 latest_granting;
 	struct page *status_page;
 	struct mutex status_lock;
-- 
2.15.1

