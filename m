Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671518-2-8174364473446255945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671518; b=tolri/g+T+4r/05iRsfgiMyrLj7kr7Kx9CRcQnWfg/8VXB2frP
    kkeUwQpIXIgwh6CX5wR+L75yDbRkOTlRBVKuYFp9HU7PcwS3bZp6VP5BHDTFAhJx
    iULMMWaExykGJq5NVXWTqoZLiPLQ4W5VyB3SpbGCWyh0qKPBAyX4Y/gh5iTFDXIf
    A3YD0+Ysla6XpJXt0kdfkXkn0Q4AziH3V512bX9NTVhR3nQdhw518AdrPbS+meHV
    R/SO5d3k+M0g1P/wSqgCFsDkpOS4LP1zxlcg+e1ga5iDH/S0llKMGFGcF8wi7KYV
    WWn5PpzmrlvYbUMaIcSPfwiPlfjuvylX0aMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671518; bh=8OQn9
    bRGYaqICM3b8BlVo2NIyNo9Fu698OsDXsHjMiU=; b=b0yrmxkuoen7lYIp3EAUi
    x5glEL7cPV/BgYHcsmVWLPdIcu0LeOQLse0hKQwTL59Grg7gzx7m0vBmCxxjVZaj
    yeWzmGIEnWV8euIqjZtmwh+6libvbnh+EbwvKpvgx2fr1mnhb4LeetZV8e4P+tHX
    RTxB4uxQRgDxiuqnAaixfDPStHQXzOlM4VRBY2dgP27UBhnYNgezxKjR3mH+4gnP
    uqvomwj6zy9IZhR/D+cieQHI3GCXxus12+qD76uadG61GU0lI6GBihystEpM6/E9
    uSNtWZeIN/t7jf/UMza321B1PJxAqRrToPc0vgtOANxP0zrIZ9mtqBAtqg2l1iyk
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rWwi1TJ4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rWwi1TJ4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJKSZuS5aC/ED/VT5QTBfKdfY2NOZeTR37K/z8BJrYlp/amaHgc0Ju7OibhDO9+Wt5nmzEmgS2NwnYOnXjCHyWlU1PG5mk7U+wGR7CMhoRCM/OiZ6brQ
    CggZbww9ReN+tCe0GlublUQf2LbiUP9wMcBCIzgOg6+ugll6P6rD2nHDl/6XvD8vnX0FUgzW0c1BT8q5rTAgc81CbpD8Cuq/EEhtsotMvNbVLbhlc3ooe+zp
    HXyjb4KjsESgaFb/xMHk/Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=9zO1jEDizw8zC72M9E0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 37/40] proc: don't detour through seq->private to get the inode
Date: Wed, 25 Apr 2018 17:48:24 +0200
Message-Id: <20180425154827.32251-38-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/array.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ae2c807fd719..b34796b562ef 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -677,7 +677,7 @@ get_children_pid(struct inode *inode, struct pid *pid_prev, loff_t pos)
 
 static int children_seq_show(struct seq_file *seq, void *v)
 {
-	struct inode *inode = seq->private;
+	struct inode *inode = file_inode(seq->file);
 	pid_t pid;
 
 	pid = pid_nr_ns(v, inode->i_sb->s_fs_info);
@@ -688,14 +688,14 @@ static int children_seq_show(struct seq_file *seq, void *v)
 
 static void *children_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return get_children_pid(seq->private, NULL, *pos);
+	return get_children_pid(file_inode(seq->file), NULL, *pos);
 }
 
 static void *children_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct pid *pid;
 
-	pid = get_children_pid(seq->private, v, *pos + 1);
+	pid = get_children_pid(file_inode(seq->file), v, *pos + 1);
 	put_pid(v);
 
 	++*pos;
@@ -716,17 +716,7 @@ static const struct seq_operations children_seq_ops = {
 
 static int children_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, &children_seq_ops);
-	if (ret)
-		return ret;
-
-	m = file->private_data;
-	m->private = inode;
-
-	return ret;
+	return seq_open(file, &children_seq_ops);
 }
 
 const struct file_operations proc_tid_children_operations = {
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
