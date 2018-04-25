Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671353-2-13651051665963365701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671352; b=U6bun2231G1bJKuZsYHvGfIsAEd8hqqk87Z5MvTKHLtnuOOXBP
    Qy6CmKk3cUY3hxhjnPS4xj8HPKfO0etp/HVJt1k2PIaQlqFaxKWg8VF+Kae1T0gH
    MY5w8dd1WggDgwZxl+pUPOVC93EHUgbd+fg7oN+y0CdK5+sSrPVe8JMN+4lpc7yE
    NVr7dtsj9klk46c7x4obe8ggPLqiKlkWwlMCqHzl3GoNoE5PMxwIZURbwFmnS5/0
    0RAhPSJTeffIaS1oIwueyVR9jsOH4f7q33AJ1xrORDnbkoA5uVuvV6TJwagLymMv
    Dr7CuBSXBCEBEwbQ4KjGQ6eCnzD0OB4XewEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671352; bh=BvMPL
    mR0W2vQ6MY0qXHLC0iXYlpSm2EApPj51q1EnJ8=; b=jOSV2EC+pyd0ovVdzqZV/
    BoclvNR2POEwmKxfgz5H30+KTQJw/ITpBhdRdPeqjtOfKDayZm9f0msMgCN1b488
    cEahfRS28MgPDIISP1Rxbnn4n4vJOKX5smgRGGrug3yl8ZIYPIWmKT9zGogId9ri
    REizcRWDl5H9mOWktzMZjdcH+gJxoqBvp+dsEFOX6UXB6NRqE9c8MwyOkRuhSWM4
    6B3KNC4nYAFXf9YoyVvwroKXBiBZIsxFnXKsxYhYMDMxzxa/rgkYSa/4DlV+G3F8
    vZl6Zi7Cfj8JUwa7uOxUwinjoOFeEz5DD5MluOfGQornr1edJhuKyRAk2i+BfIr8
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=CAl4awwZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=CAl4awwZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPbSgnxNZn0dxjNuC7ZOjpq2ww+nVkU2vfesx6B9ZMziTiKTXbIM1hyOjF0Ox5BI+c9kWj4bVrdTDczzu59xC70x8xusUNrhCEI8OpMaSKyqK2StyB0h
    KkEagkExxHWp6bLjETzuEB6sMV93NRpVG5VNJfK6sFiJfB6xCf4VmzqFKfRToVp+I9pmWRzEUY3Fp9sbaMycwNNPf0buH+TJrEf7vk53vSCYc+dAaL6FaJII
    XRLa9snQg2pMQp6OT89Svw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=X-rrlB1Z6MHfIvBpCwAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/40] proc: simplify proc_register calling conventions
Date: Wed, 25 Apr 2018 17:47:49 +0200
Message-Id: <20180425154827.32251-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Return registered entry on success, return NULL on failure and free the
passed in entry.  Also expose it in internal.h as we'll start using it
in proc_net.c soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c  | 44 ++++++++++++++++++--------------------------
 fs/proc/internal.h |  2 ++
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2078e70e1595..bd8480ff0d35 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -346,13 +346,12 @@ static const struct inode_operations proc_dir_inode_operations = {
 	.setattr	= proc_notify_change,
 };
 
-static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
+/* returns the registered entry, or frees dp and returns NULL on failure */
+struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
+		struct proc_dir_entry *dp)
 {
-	int ret;
-
-	ret = proc_alloc_inum(&dp->low_ino);
-	if (ret)
-		return ret;
+	if (proc_alloc_inum(&dp->low_ino))
+		goto out_free_entry;
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
@@ -360,12 +359,16 @@ static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp
 		WARN(1, "proc_dir_entry '%s/%s' already registered\n",
 		     dir->name, dp->name);
 		write_unlock(&proc_subdir_lock);
-		proc_free_inum(dp->low_ino);
-		return -EEXIST;
+		goto out_free_inum;
 	}
 	write_unlock(&proc_subdir_lock);
 
-	return 0;
+	return dp;
+out_free_inum:
+	proc_free_inum(dp->low_ino);
+out_free_entry:
+	pde_free(dp);
+	return NULL;
 }
 
 static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
@@ -443,10 +446,7 @@ struct proc_dir_entry *proc_symlink(const char *name,
 		if (ent->data) {
 			strcpy((char*)ent->data,dest);
 			ent->proc_iops = &proc_link_inode_operations;
-			if (proc_register(parent, ent) < 0) {
-				pde_free(ent);
-				ent = NULL;
-			}
+			ent = proc_register(parent, ent);
 		} else {
 			pde_free(ent);
 			ent = NULL;
@@ -470,11 +470,9 @@ struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
 		ent->proc_fops = &proc_dir_operations;
 		ent->proc_iops = &proc_dir_inode_operations;
 		parent->nlink++;
-		if (proc_register(parent, ent) < 0) {
-			pde_free(ent);
+		ent = proc_register(parent, ent);
+		if (!ent)
 			parent->nlink--;
-			ent = NULL;
-		}
 	}
 	return ent;
 }
@@ -505,11 +503,9 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 		ent->proc_fops = NULL;
 		ent->proc_iops = NULL;
 		parent->nlink++;
-		if (proc_register(parent, ent) < 0) {
-			pde_free(ent);
+		ent = proc_register(parent, ent);
+		if (!ent)
 			parent->nlink--;
-			ent = NULL;
-		}
 	}
 	return ent;
 }
@@ -539,11 +535,7 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	pde->proc_fops = proc_fops;
 	pde->data = data;
 	pde->proc_iops = &proc_file_inode_operations;
-	if (proc_register(parent, pde) < 0)
-		goto out_free;
-	return pde;
-out_free:
-	pde_free(pde);
+	return proc_register(parent, pde);
 out:
 	return NULL;
 }
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0f1692e63cb6..488e67490312 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,6 +162,8 @@ extern bool proc_fill_cache(struct file *, struct dir_context *, const char *, i
 /*
  * generic.c
  */
+struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
+		struct proc_dir_entry *dp);
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
 struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
 extern int proc_readdir(struct file *, struct dir_context *);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
