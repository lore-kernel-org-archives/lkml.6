Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-62429-1526464004-2-17242029381780868312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464004; b=hEGJetukonwxfHV7aXHwDHhHpVKJwpQAUojWILc/9ZQZ/YNvLc
    O/icWCJO9q0qwQ/zLyFjN3Ds7YyANcjnKCh62AWesv1bC/DkPcEM2YSB9117rMTK
    gGuv7C/dNpeggSDfXUf6J6Q/PgQygMRV3n26uSgyiYqP6FrzrfppRILgi5Gft6y5
    ux80wFJOrroGU6+IhAr5jyy7q0hrcTuv/KI/gH+vNTT22xDZIHZn/HcVUXnDRvzC
    xuV2SjBLo5+6clL7RWEMUxiGx83xjbZsKU5aW9v0DajMNznWblHSvKRcnB2FOFrk
    Thtubnb67J01MCsatjS7zdjFOSv7/T6Fft/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464004; bh=gEv/D
    X7blcCQedEq3A9TzmwmUcSN9D/7c3ANHzel2T0=; b=UWBrfjVE5wSiVzaLb6iTF
    RZfDjRndSwGqR9DBzi9AxOdD7SIJVVG9m4S4Ftt9qpFO21qMAPAtgtLX2c4QyB7u
    aLhg/oyL2rytHaYJu9WxvKea4qLCswB8ZS/9J0KLyz0fhPm1dWhei9sJovtCCqxM
    4FUFtrpXDK/cgU06vX9KQTBQqhawavLwf3lxhA4ymHMyZ+B1nxhHiiwavuBJ9R+G
    ZCmSJ+QvbighPpvV8Ri8FL8K6cJKabgqTBLxztef6uhnuksKr8zU6mlj+NauJ0/j
    chvnPTjCwx0nYFZGh0GKQIbhGG9SBvTn1c4m7+oEbfO6fZEeaZFB8nvwhQ1ltCyG
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=RIzlItAp
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=RIzlItAp
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJU8+yeul3LZC4uGzP5NENH7miJZzsMXhnir+z4OMSzPReR3TIRunziyXwhyZcmiLADcqg4oKzXnQU8Tn7P4iT61fwrY0quLv8LMTKGfKHhM5EV9uyqt
    uWD3Rf5neAmYPUhF8ZpHlCmqwa/7vW/njcaBK9J+MX8cD9jkXo+UEpkVdHev8Tlu134SStzOXm9uSuVv1MepjxFJH4+euRx7RZrxG5EOkNY+me/BLoxesD5n
    gczxsjO2ndnNMwiPQWRqwg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=rWzh_GOCPHhTbuqNOS8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 26/42] staging/rtl8192u: simplify procfs code
Date: Wed, 16 May 2018 11:43:30 +0200
Message-Id: <20180516094346.20506-27-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
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

Unwind the registration loop into individual calls.  Switch to use
proc_create_single where applicable.

Also don't bother handling proc_create* failures - the driver works
perfectly fine without the proc files, and the cleanup will handle
missing files gracefully.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/rtl8192u/r8192U_core.c | 67 ++++++--------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d607c59761cf..7a0dbc0fa18e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -646,64 +646,25 @@ static void rtl8192_proc_module_init(void)
 	rtl8192_proc = proc_mkdir(RTL819xU_MODULE_NAME, init_net.proc_net);
 }
 
-/*
- * seq_file wrappers for procfile show routines.
- */
-static int rtl8192_proc_open(struct inode *inode, struct file *file)
-{
-	struct net_device *dev = proc_get_parent_data(inode);
-	int (*show)(struct seq_file *, void *) = PDE_DATA(inode);
-
-	return single_open(file, show, dev);
-}
-
-static const struct file_operations rtl8192_proc_fops = {
-	.open		= rtl8192_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-/*
- * Table of proc files we need to create.
- */
-struct rtl8192_proc_file {
-	char name[12];
-	int (*show)(struct seq_file *, void *);
-};
-
-static const struct rtl8192_proc_file rtl8192_proc_files[] = {
-	{ "stats-rx",	&proc_get_stats_rx },
-	{ "stats-tx",	&proc_get_stats_tx },
-	{ "stats-ap",	&proc_get_stats_ap },
-	{ "registers",	&proc_get_registers },
-	{ "" }
-};
-
 static void rtl8192_proc_init_one(struct net_device *dev)
 {
-	const struct rtl8192_proc_file *f;
 	struct proc_dir_entry *dir;
 
-	if (rtl8192_proc) {
-		dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
-		if (!dir) {
-			RT_TRACE(COMP_ERR,
-				 "Unable to initialize /proc/net/rtl8192/%s\n",
-				 dev->name);
-			return;
-		}
+	if (!rtl8192_proc)
+		return;
 
-		for (f = rtl8192_proc_files; f->name[0]; f++) {
-			if (!proc_create_data(f->name, S_IFREG | S_IRUGO, dir,
-					      &rtl8192_proc_fops, f->show)) {
-				RT_TRACE(COMP_ERR,
-					 "Unable to initialize /proc/net/rtl8192/%s/%s\n",
-					 dev->name, f->name);
-				return;
-			}
-		}
-	}
+	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
+	if (!dir)
+		return;
+
+	proc_create_single("stats-rx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_rx);
+	proc_create_single("stats-tx", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_tx);
+	proc_create_single("stats-ap", S_IFREG | S_IRUGO, dir,
+			proc_get_stats_ap);
+	proc_create_single("registers", S_IFREG | S_IRUGO, dir,
+			proc_get_registers);
 }
 
 static void rtl8192_proc_remove_one(struct net_device *dev)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
