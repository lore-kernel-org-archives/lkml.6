Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324475-2-6009275479207481418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324474; b=pwhDR5Xqp56YS/ByzmWA4ao5jWPylYKHGM9WuWBUZdxq9WB
    i9X1wVSB+D9TUJhvj3B36MUNA5krPdDISWDcCFBKBj2l5O3IXGXnnVkR9pabHtcL
    6yE3QFUannpILkGdqDxPFpHGRLXDoQx7ZjbcdlcFsqhP6NOgni6qD1wjbWk1t8WX
    RnyZ9qUUQHLc9SGQ3sARXvRikLyf74cCb12ulN/ltiuCHoHoIq3hYy/9ButOVLUG
    lQkEWYyhh0SVXxyIWesvQOwxtAD/pBjfQTF0CezKzKHPoq1LOaFf+OYRJZ6xQ+18
    WI4FrTQca+2SarvTwnOywrfRdQbZ/A3iafPRaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324474; bh=Gp5KUfZgO0S9O19g6RA
    DOe0nmtneTrD0ytMSNkSKVT8=; b=D/6STzo4CbYb3eC4BxkTsk0PXl8oa7K0jhk
    PXjZUaF1toJmFBU3f64De7JXMVzKRHKfT3EPvHRQR98ukHwZbeUubmZoEJqMgBo0
    LSdVlUxLW78fuTlKImZfYXGNCtpD9zm12EbCjkUw36lcahnZHM4ofFhUtGrmY7mj
    rdZt+6jFp4gN2L2DfwdsqZWCpSeYjEzOHSBmIx3kUaMvOHmxWAfZX9eWFx0wr6up
    l8PJTKu71xwtuQ0/Er/cDgOLLMlge9TAkkymQOFas2JZOtwz54AvYuZoWNZpiUbF
    oF/u9io2Co458W6z5siy0fchpmAuNCZe7I3liazSia0unc9Mweg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeBKErs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41812 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752837AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John Johansen" <john.johansen@canonical.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.242496982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/136] apparmor: ensure that undecidable profile
 attachments fail
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 844b8292b6311ecd30ae63db1471edb26e01d895 upstream.

Profiles that have an undecidable overlap in their attachments are
being incorrectly handled. Instead of failing to attach the first one
encountered is being used.

eg.
  profile A /** { .. }
  profile B /*foo { .. }

have an unresolvable longest left attachment, they both have an exact
match on / and then have an overlapping expression that has no clear
winner.

Currently the winner will be the profile that is loaded first which
can result in non-deterministic behavior. Instead in this situation
the exec should fail.

Fixes: 898127c34ec0 ("AppArmor: functions for domain transitions")
Signed-off-by: John Johansen <john.johansen@canonical.com>
[bwh: Backported to 3.16:
 - Add 'info' parameter to x_to_profile(), done upstream in commit
   93c98a484c49 "apparmor: move exec domain mediation to using labels"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/apparmor/domain.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -126,6 +126,7 @@ static struct file_perms change_profile_
  * __attach_match_ - find an attachment match
  * @name - to match against  (NOT NULL)
  * @head - profile list to walk  (NOT NULL)
+ * @info - info message if there was an error (NOT NULL)
  *
  * Do a linear search on the profiles in the list.  There is a matching
  * preference where an exact match is preferred over a name which uses
@@ -137,28 +138,44 @@ static struct file_perms change_profile_
  * Returns: profile or NULL if no match found
  */
 static struct aa_profile *__attach_match(const char *name,
-					 struct list_head *head)
+					 struct list_head *head,
+					 const char **info)
 {
 	int len = 0;
+	bool conflict = false;
 	struct aa_profile *profile, *candidate = NULL;
 
 	list_for_each_entry_rcu(profile, head, base.list) {
 		if (profile->flags & PFLAG_NULL)
 			continue;
-		if (profile->xmatch && profile->xmatch_len > len) {
-			unsigned int state = aa_dfa_match(profile->xmatch,
-							  DFA_START, name);
-			u32 perm = dfa_user_allow(profile->xmatch, state);
-			/* any accepting state means a valid match. */
-			if (perm & MAY_EXEC) {
-				candidate = profile;
-				len = profile->xmatch_len;
+		if (profile->xmatch) {
+			if (profile->xmatch_len == len) {
+				conflict = true;
+				continue;
+			} else if (profile->xmatch_len > len) {
+				unsigned int state;
+				u32 perm;
+
+				state = aa_dfa_match(profile->xmatch,
+						     DFA_START, name);
+				perm = dfa_user_allow(profile->xmatch, state);
+				/* any accepting state means a valid match. */
+				if (perm & MAY_EXEC) {
+					candidate = profile;
+					len = profile->xmatch_len;
+					conflict = false;
+				}
 			}
 		} else if (!strcmp(profile->base.name, name))
 			/* exact non-re match, no more searching required */
 			return profile;
 	}
 
+	if (conflict) {
+		*info = "conflicting profile attachments";
+		return NULL;
+	}
+
 	return candidate;
 }
 
@@ -167,16 +184,18 @@ static struct aa_profile *__attach_match
  * @ns: the current namespace  (NOT NULL)
  * @list: list to search  (NOT NULL)
  * @name: the executable name to match against  (NOT NULL)
+ * @info: info message if there was an error
  *
  * Returns: profile or NULL if no match found
  */
 static struct aa_profile *find_attach(struct aa_namespace *ns,
-				      struct list_head *list, const char *name)
+				      struct list_head *list, const char *name,
+				      const char **info)
 {
 	struct aa_profile *profile;
 
 	rcu_read_lock();
-	profile = aa_get_profile(__attach_match(name, list));
+	profile = aa_get_profile(__attach_match(name, list, info));
 	rcu_read_unlock();
 
 	return profile;
@@ -298,7 +317,8 @@ static struct aa_profile *x_table_lookup
  * Returns: refcounted profile or NULL if not found available
  */
 static struct aa_profile *x_to_profile(struct aa_profile *profile,
-				       const char *name, u32 xindex)
+				       const char *name, u32 xindex,
+				       const char **info)
 {
 	struct aa_profile *new_profile = NULL;
 	struct aa_namespace *ns = profile->ns;
@@ -312,11 +332,11 @@ static struct aa_profile *x_to_profile(s
 		if (xindex & AA_X_CHILD)
 			/* released by caller */
 			new_profile = find_attach(ns, &profile->base.profiles,
-						  name);
+						  name, info);
 		else
 			/* released by caller */
 			new_profile = find_attach(ns, &ns->base.profiles,
-						  name);
+						  name, info);
 		break;
 	case AA_X_TABLE:
 		/* released by caller */
@@ -385,7 +405,8 @@ int apparmor_bprm_set_creds(struct linux
 			/* change_profile on exec already been granted */
 			new_profile = aa_get_profile(cxt->onexec);
 		else
-			new_profile = find_attach(ns, &ns->base.profiles, name);
+			new_profile = find_attach(ns, &ns->base.profiles, name,
+						  &info);
 		if (!new_profile)
 			goto cleanup;
 		/*
@@ -421,7 +442,7 @@ int apparmor_bprm_set_creds(struct linux
 
 	if (perms.allow & MAY_EXEC) {
 		/* exec permission determine how to transition */
-		new_profile = x_to_profile(profile, name, perms.xindex);
+		new_profile = x_to_profile(profile, name, perms.xindex, &info);
 		if (!new_profile) {
 			if (perms.xindex & AA_X_INHERIT) {
 				/* (p|c|n)ix - don't change profile but do
