Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56624D9F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC56624D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeGCFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:23:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:41902 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753888AbeGCFXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:23:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w635Ml1S025102;
        Tue, 3 Jul 2018 00:22:48 -0500
Message-ID: <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Tue, 03 Jul 2018 15:22:47 +1000
In-Reply-To: <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
         <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
         <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
         <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
         <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
         <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
         <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
         <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
         <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 12:39 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-02 at 19:26 -0700, Linus Torvalds wrote:
> > On Mon, Jul 2, 2018 at 7:15 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > 
> > > It's whitespace-damaged on purpose. It's probably broken shit. DO NOT
> > > USE UNDER ANY CIRCUMSTANCES.  Think of it more as a "something like
> > > this might work, but probably doesn't". Maybe it gives you an idea,
> > > although that idea might be "Linus has finally lost it".
> > 
> > Even if it were to work, it should probably just be done inside kernfs
> > and exposed as some kind of "kernfs_remove_if_empty()" function.
> 
> That would be harder, we'd have to expose it via a
> kobject_del_if_empty() then.
> 
> Since we control completely when things are added/removed from the
> gluedir and have a big fat mutex for it, I don't think locking is much
> of an issue. At least in that specific case.

Ok, kernfs was a tad tougher to crack than I hoped but here's a
prototype lightly tested.

Tejun, Greg, does it look reasonable to you ?

Cheers,
Ben.

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..9166f68276c6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1570,6 +1570,8 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 		return;
 
 	mutex_lock(&gdp_mutex);
+	if (!kobject_has_children(glue_dir))
+		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
 }
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc19340b..e4bec09bc602 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1251,6 +1251,29 @@ void kernfs_activate(struct kernfs_node *kn)
 	mutex_unlock(&kernfs_mutex);
 }
 
+bool kernfs_has_children(struct kernfs_node *kn)
+{
+	bool has_children = false;
+	struct kernfs_node *pos;
+
+	/* Lockless shortcut */
+	if (RB_EMPTY_NODE(&kn->rb))
+		return false;
+
+	/* Now check for active children */
+	mutex_lock(&kernfs_mutex);
+	pos = NULL;
+	while ((pos = kernfs_next_descendant_post(pos, kn)) && pos != kn) {
+		if (kernfs_active(pos)) {
+			has_children = true;
+			break;
+		}
+	}
+	mutex_unlock(&kernfs_mutex);
+
+	return has_children;
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index ab25c8b6d9e3..776350ac1cbc 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -300,6 +300,12 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 	return kn->flags & KERNFS_NS;
 }
 
+/**
+ * kernfs_has_children - Returns whether a kernfs node has children.
+ * @kn: the node to test
+ */
+bool kernfs_has_children(struct kernfs_node *kn);
+
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
 int kernfs_path_from_node(struct kernfs_node *root_kn, struct kernfs_node *kn,
 			  char *buf, size_t buflen);
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..1e3294ab95f0 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -116,6 +116,17 @@ extern void kobject_put(struct kobject *kobj);
 extern const void *kobject_namespace(struct kobject *kobj);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
+/**
+ * kobject_has_children - Returns whether a kobject has children.
+ * @kobj: the object to test
+ */
+static inline bool kobject_has_children(struct kobject *kobj)
+{
+	WARN_ON_ONCE(kref_read(&kobj->kref) == 0);
+
+	return kobj->sd && kernfs_has_children(kobj->sd);
+}
+
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;

