Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826629-2-2691387134051623371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826628; b=jLRDt/zmGP1kGlgy0yqlfjF2lYrA3roKctA2JeKfTVJo5x0
    IYBB4ii6RUTJ82j1Ewo9TuUDtMCDKFsByy280tbXC8OpEMWBN2WN1Gj1B4PEktxj
    nRxL6aPbHnDASge16D6hMP0OMn9e2ShTz/jzBMTR3jlKoauQAhhU27eRk/ItTPm2
    MbdoodULMTnpNE6/BfeQDTVRA8RBt5F5+Z3sgJj8YQcWt9R+bY+4jI0H8Bh0fE/G
    T2AIVIjpCtwPl5SghkX+s38hCVCQJcMPLdVz1aU8v0Op98dt0mffH6KwpFwvlsrQ
    zcKbgxixhy/UjNKU2xpqgnLHxBRDRLU6FJb2r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826628; bh=1a3QzKnaikh2RzKF1LN
    aBYlMzT900pZC/V6wtvAw/Yw=; b=Ed++HDZiF2B+qWFfJzAb9wSUyCKI7dc/Asa
    /u2eEqPocBp71MpJB51HrQ5rpQoaE5G5rjbEELIjXeTpVhXUphczZejmFrI0q5vj
    zifEHg2vYrnN8NPd3nCHOlh3BiKwClQWegXLOxfYciyrdssS8txYKK33cNHV8eB5
    /YDaby9dKYk75D+zcqrdyuAH4HYW5ywpHZ18YjQ9TRm/YwpE7CsLm5p9DVa78dLN
    nAQiUrH0UhNAaKqv3lfwALK/jwc4mVVb4UKPtshOpOhe0pFHlkNQoJ8dzlNGkQyZ
    DYhD0h1Zh0FDTk1u69IvbYDtX7PuAqAyhVQKlcz6OrfiueB0NoQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932682AbeCLDuP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:50:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41070 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932606AbeCLDHk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:40 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paul Moore" <pmoore@redhat.com>,
        "Tim Gardner" <tim.gardner@canonical.com>,
        "Eric Paris" <eparis@parisplace.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "James Morris" <james.l.morris@oracle.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.464390522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 017/104] SELinux: security_load_policy: Silence
 frame-larger-than warning
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Gardner <tim.gardner@canonical.com>

commit b5495b4217d3fa64deac479db83dbede149af7d8 upstream.

Dynamically allocate a couple of the larger stack variables in order to
reduce the stack footprint below 1024. gcc-4.8

security/selinux/ss/services.c: In function 'security_load_policy':
security/selinux/ss/services.c:1964:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 }

Also silence a couple of checkpatch warnings at the same time.

WARNING: sizeof policydb should be sizeof(policydb)
+	memcpy(oldpolicydb, &policydb, sizeof policydb);

WARNING: sizeof policydb should be sizeof(policydb)
+	memcpy(&policydb, newpolicydb, sizeof policydb);

Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Eric Paris <eparis@parisplace.org>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Paul Moore <pmoore@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/selinux/ss/services.c | 54 +++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1806,7 +1806,7 @@ static int security_preserve_bools(struc
  */
 int security_load_policy(void *data, size_t len)
 {
-	struct policydb oldpolicydb, newpolicydb;
+	struct policydb *oldpolicydb, *newpolicydb;
 	struct sidtab oldsidtab, newsidtab;
 	struct selinux_mapping *oldmap, *map = NULL;
 	struct convert_context_args args;
@@ -1815,12 +1815,19 @@ int security_load_policy(void *data, siz
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
+	oldpolicydb = kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
+	if (!oldpolicydb) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	newpolicydb = oldpolicydb + 1;
+
 	if (!ss_initialized) {
 		avtab_cache_init();
 		rc = policydb_read(&policydb, fp);
 		if (rc) {
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
 
 		policydb.len = len;
@@ -1830,14 +1837,14 @@ int security_load_policy(void *data, siz
 		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
 
 		rc = policydb_load_isids(&policydb, &sidtab);
 		if (rc) {
 			policydb_destroy(&policydb);
 			avtab_cache_destroy();
-			return rc;
+			goto out;
 		}
 
 		security_load_policycaps();
@@ -1849,36 +1856,36 @@ int security_load_policy(void *data, siz
 		selinux_status_update_policyload(seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
-		return 0;
+		goto out;
 	}
 
 #if 0
 	sidtab_hash_eval(&sidtab, "sids");
 #endif
 
-	rc = policydb_read(&newpolicydb, fp);
+	rc = policydb_read(newpolicydb, fp);
 	if (rc)
-		return rc;
+		goto out;
 
-	newpolicydb.len = len;
+	newpolicydb->len = len;
 	/* If switching between different policy types, log MLS status */
-	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
+	if (policydb.mls_enabled && !newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!policydb.mls_enabled && newpolicydb.mls_enabled)
+	else if (!policydb.mls_enabled && newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
 
-	rc = policydb_load_isids(&newpolicydb, &newsidtab);
+	rc = policydb_load_isids(newpolicydb, &newsidtab);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
-		policydb_destroy(&newpolicydb);
-		return rc;
+		policydb_destroy(newpolicydb);
+		goto out;
 	}
 
-	rc = selinux_set_mapping(&newpolicydb, secclass_map, &map, &map_size);
+	rc = selinux_set_mapping(newpolicydb, secclass_map, &map, &map_size);
 	if (rc)
 		goto err;
 
-	rc = security_preserve_bools(&newpolicydb);
+	rc = security_preserve_bools(newpolicydb);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
 		goto err;
@@ -1896,7 +1903,7 @@ int security_load_policy(void *data, siz
 	 * in the new SID table.
 	 */
 	args.oldp = &policydb;
-	args.newp = &newpolicydb;
+	args.newp = newpolicydb;
 	rc = sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to convert the internal"
@@ -1906,12 +1913,12 @@ int security_load_policy(void *data, siz
 	}
 
 	/* Save the old policydb and SID table to free later. */
-	memcpy(&oldpolicydb, &policydb, sizeof policydb);
+	memcpy(oldpolicydb, &policydb, sizeof(policydb));
 	sidtab_set(&oldsidtab, &sidtab);
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&policy_rwlock);
-	memcpy(&policydb, &newpolicydb, sizeof policydb);
+	memcpy(&policydb, newpolicydb, sizeof(policydb));
 	sidtab_set(&sidtab, &newsidtab);
 	security_load_policycaps();
 	oldmap = current_mapping;
@@ -1921,7 +1928,7 @@ int security_load_policy(void *data, siz
 	write_unlock_irq(&policy_rwlock);
 
 	/* Free the old policydb and SID table. */
-	policydb_destroy(&oldpolicydb);
+	policydb_destroy(oldpolicydb);
 	sidtab_destroy(&oldsidtab);
 	kfree(oldmap);
 
@@ -1931,14 +1938,17 @@ int security_load_policy(void *data, siz
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
 
-	return 0;
+	rc = 0;
+	goto out;
 
 err:
 	kfree(map);
 	sidtab_destroy(&newsidtab);
-	policydb_destroy(&newpolicydb);
-	return rc;
+	policydb_destroy(newpolicydb);
 
+out:
+	kfree(oldpolicydb);
+	return rc;
 }
 
 size_t security_policydb_len(void)
