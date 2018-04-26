Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1636228-1524705533-2-8290562180657075959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524705532; b=ODJ1P1X3m221tS2/hYkkx1Zl/CXaxXDGTDMGmGhfg5CULNY8HY
    dLr97U64eHFl4n+T+fn6mvdRf9+bhW6qNUm6fbY61yVuHJ3Vzysh+CDUoScdm0ar
    eS0gOv/ZVPw4qYekiyIjTJF55Vz+Ya8Vwpz9AgrHDRUsdeZa6yOXMTSI08qzo4Rl
    xrSCcEjT2znl4Wlu7fdLMIKFqLTAr0LNMPszTpgFy6Es6gyMJvsM/aV7uETv9Uyn
    ZmI6BrJokLjuIPio0uE6aIlWvAPeJdGqU8MxPcyn+46c6VR6n3mOGqMMh30FCa6g
    mdBf+hLz1xWihJAGorkK3HvLO6dqnhwGP95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1524705532; bh=rYhijJLKaxr7+qoue0lPRV2X82jU9ngu8wS1pIM9CGw=; b=n
    4TXhDBxp/Kw4KmPJzh43mSUCyo0pXzxm2TBS5HHm6o7Yhzq28QYxa6BYr9wIHO53
    T/7WOL/CGTMAMO5YsP4EZOgyqL3CRhLwob6L9Aj8196Az3oMCcRLAKUzCvDU0aIh
    RbuqJskX5nT3Ucrsq6LQ44Mj38sQ0GkEsnuo/zfcxNHiUlXP3g7Yw4RSfrIIvaMi
    JrO/fSpt07owGeaRhexXnHiHKN+MtFM0mWJuvJbFeau6Av8TYEBNnWl1mjjxDoSU
    n32xxRj22KhPpHZomXljLgeHabjNh7nnh92SkHSDcOp3YVmlVGgj0eBJgqbcUorK
    W8//DpeD/R0uic3BSO5rA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gF3JTg0g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fdREH4yr;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gF3JTg0g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fdREH4yr;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDVCgXDWIgXCJ1hdXoGVRdk40D9OCwY+XqeX8DsZ6K9jTZ2BMaNOvFUuAIhLGKQraz+fOhmww2iSZ2lNEKF0iEB16epNfJDS0caQUJ32s3Lol+Av3qDc
    XhQQkd2CrCAw+19zmDUcd6KBNFCBRbbFC44NcCZRCNt/jFFv+fL8QNjCgdhw+XfP/OuY+warzwtkr1a7IYrLZgHIUbUgmw478fifOZTwmwO3H9ztmnbZevn5
    /ADRZUyxjm6xwJx5b8puJQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=x42tTbUH5sAA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=xfq7aEqWmQcA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=uZp0osLj_e6nfmojaNIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=EuMvGzoevXUWrpekGtjw:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/FSF6CxG1+Rapa0SjggkEXF1+y+btOIGa7A+X6q1HRRajEI34+ZTPWUd+smJkN00mS7dtq1w==
Date: Thu, 26 Apr 2018 09:18:37 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180426011837.GA79340@WeideMacBook-Pro.local>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419001848.3041-2-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: nicolas.pitre@linaro.org, Brijesh Singh <brijesh.singh@amd.com>,
 devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, dan.j.williams@intel.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, josh@joshtriplett.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, robh+dt@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
>The struct resource uses singly linked list to link siblings. It's not
>easy to do reverse iteration on sibling list. So replace it with list_head.
>

Hi, Baoquan

Besides changing the data structure, I have another proposal to do the reverse
iteration. Which means it would not affect other users, if you just want a
reverse iteration.

BTW, I don't think Andrew suggest to use linked-list directly. What he wants
is a better solution to your first proposal in
https://patchwork.kernel.org/patch/10300819/.

Below is my proposal of resource reverse iteration without changing current
design.

>From 5d7145d44fe48b98572a03884fa3a3aa82e3cef9 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Sat, 24 Mar 2018 23:25:46 +0800
Subject: [PATCH] kernel/resource: add walk_system_ram_res_rev()

As discussed on https://patchwork.kernel.org/patch/10300819/, this patch
comes up with a variant implementation of walk_system_ram_res_rev(), which
uses iteration instead of allocating array to store those resources.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/ioport.h |   3 ++
 kernel/resource.c      | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..473f1d9cb97e 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -277,6 +277,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+		    int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 769109f20fb7..d4ec5fbc6875 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -73,6 +73,38 @@ static struct resource *next_resource(struct resource *p, bool sibling_only)
 	return p->sibling;
 }
 
+static struct resource *prev_resource(struct resource *p, bool sibling_only)
+{
+	struct resource *prev;
+	if (NULL == iomem_resource.child)
+		return NULL;
+
+	if (p == NULL) {
+		prev = iomem_resource.child;
+		while (prev->sibling)
+			prev = prev->sibling;
+	} else {
+		if (p->parent->child == p) {
+			return p->parent;
+		}
+
+		for (prev = p->parent->child; prev->sibling != p;
+			prev = prev->sibling) {}
+	}
+
+	/* Caller wants to traverse through siblings only */
+	if (sibling_only)
+		return prev;
+
+	for (;prev->child;) {
+		prev = prev->child;
+
+		while (prev->sibling)
+			prev = prev->sibling;
+	}
+	return prev;
+}
+
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
@@ -401,6 +433,47 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 	return 0;
 }
 
+/*
+ * Finds the highest iomem resource existing within [res->start.res->end).
+ * The caller must specify res->start, res->end, res->flags, and optionally
+ * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
+ * This function walks the whole tree and not just first level children until
+ * and unless first_level_children_only is true.
+ */
+static int find_prev_iomem_res(struct resource *res, unsigned long desc,
+			       bool first_level_children_only)
+{
+	struct resource *p;
+
+	BUG_ON(!res);
+	BUG_ON(res->start >= res->end);
+
+	read_lock(&resource_lock);
+
+	for (p = prev_resource(NULL, first_level_children_only); p;
+		p = prev_resource(p, first_level_children_only)) {
+		if ((p->flags & res->flags) != res->flags)
+			continue;
+		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
+			continue;
+		if (p->end < res->start || p->child == iomem_resource.child) {
+			p = NULL;
+			break;
+		}
+		if ((p->end >= res->start) && (p->start < res->end))
+			break;
+	}
+
+	read_unlock(&resource_lock);
+	if (!p)
+		return -1;
+	/* copy data */
+	resource_clip(res, p->start, p->end);
+	res->flags = p->flags;
+	res->desc = p->desc;
+	return 0;
+}
+
 static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 				 bool first_level_children_only,
 				 void *arg,
@@ -422,6 +495,27 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
 	return ret;
 }
 
+static int __walk_iomem_res_rev_desc(struct resource *res, unsigned long desc,
+				 bool first_level_children_only,
+				 void *arg,
+				 int (*func)(struct resource *, void *))
+{
+	u64 orig_start = res->start;
+	int ret = -1;
+
+	while ((res->start < res->end) &&
+	       !find_prev_iomem_res(res, desc, first_level_children_only)) {
+		ret = (*func)(res, arg);
+		if (ret)
+			break;
+
+		res->end = res->start?(res->start - 1):0;
+		res->start = orig_start;
+	}
+
+	return ret;
+}
+
 /*
  * Walks through iomem resources and calls func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
@@ -468,6 +562,25 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     arg, func);
 }
 
+/*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	struct resource res;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return __walk_iomem_res_rev_desc(&res, IORES_DESC_NONE, true,
+				     arg, func);
+}
+
 /*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
-- 
2.15.1


-- 
Wei Yang
Help you, Help me
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
