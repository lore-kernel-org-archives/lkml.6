Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826710-2-3184784185214938065
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826709; b=LWMiFlKrn1aTnKbhAuvV2hb4A+PkFQREWuqzJ9hmILITOHd
    c2fQUdxkK3Pnt8qELkIQFjIqtWe0ufZA7pMDypitbvLsbM+WsGe7aLpZM5fE8RC6
    Q/GD94akHwJPR5xGXmRj4gH+8dbK64lDjosJ6e047nbWkUBFeMHOs83/JSfX2age
    cuUYgBYu8XfeqmK6GVS7xV6bmdYU2mC3tfygdWhFG7CTRvQLeulwfbPS5iZcdULf
    gKsbF/R//mnH6iAjp4J711FlGkO4tbkkw++U0d7qUMNpMSCBTGH8qyAcY9Peqs/v
    gSgDmeqCVZocVO6Yx/zswZmcEj26AuvZ5REnnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826709; bh=roCigd+l/ZjrXFr8rbS
    ZwJYC22XPyi2M5oOM/YPEKF8=; b=EQrPSNAjbwiDBOkI82klo/LL0fvy5fnwPVV
    arym2aBP/Ef5OmNBqTol2J/hw5ffsri9J53RFcS5S1zQvCsfKqaOySyk5sWEEoFA
    9jgKFB8uVyIN9EcqFRXwI6JHcnD/9Eqb248r9OU/696FH/AL+aO2RFWuT+eayCZC
    C09iKkHzB3rAdmE1T6fYMr0ElOf+Vh/ID3C9EJitzc0ZBpvrTsMfUhPq0q4L+LA0
    gE1ko8jBoR8kgnscaTN0D8MVro7ggXJZqH3YCRWqdS5OBCgZRSJLdw/DgCPPDuli
    xWKpnFuZfp3N3ql6cOvfSnwjzGnRpLaF7tzTXbQxzftV5woCIBw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S933485AbeCLDud (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:50:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41052 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932588AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Oberparleiter" <peter.oberparleiter@de.ibm.com>,
        "Jan Stancek" <jstancek@redhat.com>,
        "Rusty Russell" <rusty@rustcorp.com.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Frantisek Hrbata" <fhrbata@redhat.com>,
        "Andy Gospodarek" <agospoda@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.818201849@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 014/104] gcov: move gcov structs definitions to a gcc
 version specific file
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

From: Frantisek Hrbata <fhrbata@redhat.com>

commit 8cbce376e3fdf4a21f59365aefbb52eac3c2e312 upstream.

Since also the gcov structures(gcov_info, gcov_fn_info, gcov_ctr_info) can
change between gcc releases, as shown in gcc 4.7, they cannot be defined
in a common header and need to be moved to a specific gcc implemention
file.  This also requires to make the gcov_info structure opaque for the
common code and to introduce simple helpers for accessing data inside
gcov_info.

Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gospodarek <agospoda@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/gcov/base.c    |  26 ++++++------
 kernel/gcov/fs.c      |  27 ++++++------
 kernel/gcov/gcc_3_4.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h    |  65 +++++-----------------------
 4 files changed, 153 insertions(+), 80 deletions(-)

--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include "gcov.h"
 
-static struct gcov_info *gcov_info_head;
 static int gcov_events_enabled;
 static DEFINE_MUTEX(gcov_lock);
 
@@ -34,7 +33,7 @@ void __gcov_init(struct gcov_info *info)
 
 	mutex_lock(&gcov_lock);
 	if (gcov_version == 0) {
-		gcov_version = info->version;
+		gcov_version = gcov_info_version(info);
 		/*
 		 * Printing gcc's version magic may prove useful for debugging
 		 * incompatibility reports.
@@ -45,8 +44,7 @@ void __gcov_init(struct gcov_info *info)
 	 * Add new profiling data structure to list and inform event
 	 * listener.
 	 */
-	info->next = gcov_info_head;
-	gcov_info_head = info;
+	gcov_info_link(info);
 	if (gcov_events_enabled)
 		gcov_event(GCOV_ADD, info);
 	mutex_unlock(&gcov_lock);
@@ -91,13 +89,15 @@ EXPORT_SYMBOL(__gcov_merge_delta);
  */
 void gcov_enable_events(void)
 {
-	struct gcov_info *info;
+	struct gcov_info *info = NULL;
 
 	mutex_lock(&gcov_lock);
 	gcov_events_enabled = 1;
+
 	/* Perform event callback for previously registered entries. */
-	for (info = gcov_info_head; info; info = info->next)
+	while ((info = gcov_info_next(info)))
 		gcov_event(GCOV_ADD, info);
+
 	mutex_unlock(&gcov_lock);
 }
 
@@ -112,25 +112,23 @@ static int gcov_module_notifier(struct n
 				void *data)
 {
 	struct module *mod = data;
-	struct gcov_info *info;
-	struct gcov_info *prev;
+	struct gcov_info *info = NULL;
+	struct gcov_info *prev = NULL;
 
 	if (event != MODULE_STATE_GOING)
 		return NOTIFY_OK;
 	mutex_lock(&gcov_lock);
-	prev = NULL;
+
 	/* Remove entries located in module from linked list. */
-	for (info = gcov_info_head; info; info = info->next) {
+	while ((info = gcov_info_next(info))) {
 		if (within(info, mod->module_core, mod->core_size)) {
-			if (prev)
-				prev->next = info->next;
-			else
-				gcov_info_head = info->next;
+			gcov_info_unlink(prev, info);
 			if (gcov_events_enabled)
 				gcov_event(GCOV_REMOVE, info);
 		} else
 			prev = info;
 	}
+
 	mutex_unlock(&gcov_lock);
 
 	return NOTIFY_OK;
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -242,7 +242,7 @@ static struct gcov_node *get_node_by_nam
 
 	list_for_each_entry(node, &all_head, all) {
 		info = get_node_info(node);
-		if (info && (strcmp(info->filename, name) == 0))
+		if (info && (strcmp(gcov_info_filename(info), name) == 0))
 			return node;
 	}
 
@@ -279,7 +279,7 @@ static ssize_t gcov_seq_write(struct fil
 	seq = file->private_data;
 	info = gcov_iter_get_info(seq->private);
 	mutex_lock(&node_lock);
-	node = get_node_by_name(info->filename);
+	node = get_node_by_name(gcov_info_filename(info));
 	if (node) {
 		/* Reset counts or remove node for unloaded modules. */
 		if (node->num_loaded == 0)
@@ -376,8 +376,9 @@ static void add_links(struct gcov_node *
 	if (!node->links)
 		return;
 	for (i = 0; i < num; i++) {
-		target = get_link_target(get_node_info(node)->filename,
-					 &gcov_link[i]);
+		target = get_link_target(
+				gcov_info_filename(get_node_info(node)),
+				&gcov_link[i]);
 		if (!target)
 			goto out_err;
 		basename = strrchr(target, '/');
@@ -576,7 +577,7 @@ static void add_node(struct gcov_info *i
 	struct gcov_node *parent;
 	struct gcov_node *node;
 
-	filename = kstrdup(info->filename, GFP_KERNEL);
+	filename = kstrdup(gcov_info_filename(info), GFP_KERNEL);
 	if (!filename)
 		return;
 	parent = &root_node;
@@ -631,7 +632,7 @@ static void add_info(struct gcov_node *n
 	loaded_info = kcalloc(num + 1, sizeof(struct gcov_info *), GFP_KERNEL);
 	if (!loaded_info) {
 		pr_warning("could not add '%s' (out of memory)\n",
-			   info->filename);
+			   gcov_info_filename(info));
 		return;
 	}
 	memcpy(loaded_info, node->loaded_info,
@@ -645,7 +646,8 @@ static void add_info(struct gcov_node *n
 		 */
 		if (!gcov_info_is_compatible(node->unloaded_info, info)) {
 			pr_warning("discarding saved data for %s "
-				   "(incompatible version)\n", info->filename);
+				   "(incompatible version)\n",
+				   gcov_info_filename(info));
 			gcov_info_free(node->unloaded_info);
 			node->unloaded_info = NULL;
 		}
@@ -656,7 +658,7 @@ static void add_info(struct gcov_node *n
 		 */
 		if (!gcov_info_is_compatible(node->loaded_info[0], info)) {
 			pr_warning("could not add '%s' (incompatible "
-				   "version)\n", info->filename);
+				   "version)\n", gcov_info_filename(info));
 			kfree(loaded_info);
 			return;
 		}
@@ -692,7 +694,8 @@ static void save_info(struct gcov_node *
 		node->unloaded_info = gcov_info_dup(info);
 		if (!node->unloaded_info) {
 			pr_warning("could not save data for '%s' "
-				   "(out of memory)\n", info->filename);
+				   "(out of memory)\n",
+				   gcov_info_filename(info));
 		}
 	}
 }
@@ -708,7 +711,7 @@ static void remove_info(struct gcov_node
 	i = get_info_index(node, info);
 	if (i < 0) {
 		pr_warning("could not remove '%s' (not found)\n",
-			   info->filename);
+			   gcov_info_filename(info));
 		return;
 	}
 	if (gcov_persist)
@@ -735,7 +738,7 @@ void gcov_event(enum gcov_action action,
 	struct gcov_node *node;
 
 	mutex_lock(&node_lock);
-	node = get_node_by_name(info->filename);
+	node = get_node_by_name(gcov_info_filename(info));
 	switch (action) {
 	case GCOV_ADD:
 		if (node)
@@ -748,7 +751,7 @@ void gcov_event(enum gcov_action action,
 			remove_info(node, info);
 		else {
 			pr_warning("could not remove '%s' (not found)\n",
-				   info->filename);
+				   gcov_info_filename(info));
 		}
 		break;
 	}
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -21,6 +21,121 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"
 
+#define GCOV_COUNTERS		5
+
+static struct gcov_info *gcov_info_head;
+
+/**
+ * struct gcov_fn_info - profiling meta data per function
+ * @ident: object file-unique function identifier
+ * @checksum: function checksum
+ * @n_ctrs: number of values per counter type belonging to this function
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time.
+ */
+struct gcov_fn_info {
+	unsigned int ident;
+	unsigned int checksum;
+	unsigned int n_ctrs[0];
+};
+
+/**
+ * struct gcov_ctr_info - profiling data per counter type
+ * @num: number of counter values for this type
+ * @values: array of counter values for this type
+ * @merge: merge function for counter values of this type (unused)
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the values array.
+ */
+struct gcov_ctr_info {
+	unsigned int	num;
+	gcov_type	*values;
+	void		(*merge)(gcov_type *, unsigned int);
+};
+
+/**
+ * struct gcov_info - profiling data per object file
+ * @version: gcov version magic indicating the gcc version used for compilation
+ * @next: list head for a singly-linked list
+ * @stamp: time stamp
+ * @filename: name of the associated gcov data file
+ * @n_functions: number of instrumented functions
+ * @functions: function data
+ * @ctr_mask: mask specifying which counter types are active
+ * @counts: counter data per counter type
+ *
+ * This data is generated by gcc during compilation and doesn't change
+ * at run-time with the exception of the next pointer.
+ */
+struct gcov_info {
+	unsigned int			version;
+	struct gcov_info		*next;
+	unsigned int			stamp;
+	const char			*filename;
+	unsigned int			n_functions;
+	const struct gcov_fn_info	*functions;
+	unsigned int			ctr_mask;
+	struct gcov_ctr_info		counts[0];
+};
+
+/**
+ * gcov_info_filename - return info filename
+ * @info: profiling data set
+ */
+const char *gcov_info_filename(struct gcov_info *info)
+{
+	return info->filename;
+}
+
+/**
+ * gcov_info_version - return info version
+ * @info: profiling data set
+ */
+unsigned int gcov_info_version(struct gcov_info *info)
+{
+	return info->version;
+}
+
+/**
+ * gcov_info_next - return next profiling data set
+ * @info: profiling data set
+ *
+ * Returns next gcov_info following @info or first gcov_info in the chain if
+ * @info is %NULL.
+ */
+struct gcov_info *gcov_info_next(struct gcov_info *info)
+{
+	if (!info)
+		return gcov_info_head;
+
+	return info->next;
+}
+
+/**
+ * gcov_info_link - link/add profiling data set to the list
+ * @info: profiling data set
+ */
+void gcov_info_link(struct gcov_info *info)
+{
+	info->next = gcov_info_head;
+	gcov_info_head = info;
+}
+
+/**
+ * gcov_info_unlink - unlink/remove profiling data set from the list
+ * @prev: previous profiling data set
+ * @info: profiling data set
+ */
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
+{
+	if (prev)
+		prev->next = info->next;
+	else
+		gcov_info_head = info->next;
+}
+
 /* Symbolic links to be created for each profiling data file. */
 const struct gcov_link gcov_link[] = {
 	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -21,7 +21,6 @@
  * gcc and need to be kept as close to the original definition as possible to
  * remain compatible.
  */
-#define GCOV_COUNTERS		5
 #define GCOV_DATA_MAGIC		((unsigned int) 0x67636461)
 #define GCOV_TAG_FUNCTION	((unsigned int) 0x01000000)
 #define GCOV_TAG_COUNTER_BASE	((unsigned int) 0x01a10000)
@@ -34,60 +33,18 @@ typedef long gcov_type;
 typedef long long gcov_type;
 #endif
 
-/**
- * struct gcov_fn_info - profiling meta data per function
- * @ident: object file-unique function identifier
- * @checksum: function checksum
- * @n_ctrs: number of values per counter type belonging to this function
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time.
- */
-struct gcov_fn_info {
-	unsigned int ident;
-	unsigned int checksum;
-	unsigned int n_ctrs[0];
-};
-
-/**
- * struct gcov_ctr_info - profiling data per counter type
- * @num: number of counter values for this type
- * @values: array of counter values for this type
- * @merge: merge function for counter values of this type (unused)
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the values array.
- */
-struct gcov_ctr_info {
-	unsigned int	num;
-	gcov_type	*values;
-	void		(*merge)(gcov_type *, unsigned int);
-};
+/* Opaque gcov_info. The gcov structures can change as for example in gcc 4.7 so
+ * we cannot use full definition here and they need to be placed in gcc specific
+ * implementation of gcov. This also means no direct access to the members in
+ * generic code and usage of the interface below.*/
+struct gcov_info;
 
-/**
- * struct gcov_info - profiling data per object file
- * @version: gcov version magic indicating the gcc version used for compilation
- * @next: list head for a singly-linked list
- * @stamp: time stamp
- * @filename: name of the associated gcov data file
- * @n_functions: number of instrumented functions
- * @functions: function data
- * @ctr_mask: mask specifying which counter types are active
- * @counts: counter data per counter type
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the next pointer.
- */
-struct gcov_info {
-	unsigned int			version;
-	struct gcov_info		*next;
-	unsigned int			stamp;
-	const char			*filename;
-	unsigned int			n_functions;
-	const struct gcov_fn_info	*functions;
-	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[0];
-};
+/* Interface to access gcov_info data  */
+const char *gcov_info_filename(struct gcov_info *info);
+unsigned int gcov_info_version(struct gcov_info *info);
+struct gcov_info *gcov_info_next(struct gcov_info *info);
+void gcov_info_link(struct gcov_info *info);
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
 
 /* Base interface. */
 enum gcov_action {
