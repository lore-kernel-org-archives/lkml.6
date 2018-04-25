Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671346-2-12381600819394012959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671345; b=PtY7njQ3CbOb9Xex61iXANXtED25myEemc6Tp901QuKe/ecx/b
    J9DHbNjB8TY3MTagrKHC8Cav2el7o2uW/IYqVeg4ct/vbalQ+92begAnnfWkdTxu
    Ly2AKmTE02hn05GRI3IianrSF+S7QcSFexQ3a/agmq5PlaXSTEsVZ8zv6wRpXBZB
    wcXQxvpOuTCYGCW9C6PYrxmVMHwVSE/iWEBwJ56qslZyrRbon2ljhyi0YV1yVm0J
    +HOEUHKMOZZhGhQvs8IjM5SSwW2vYjcUMFo/vQJE+FFkQqPEUbHly+M/UxVkhmK2
    eJx7XzCTflCzbGb5VFh2VMMEZsZlANy4JZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671345; bh=v7fq1
    OwdYKQIa3NjlNITYkg1N3bHxcaWEdTGS+N8rTo=; b=uozAcftFps+NDu0SSMLNu
    U96jyzIt1bAfvis6RodBKZzJxMSvHZbuCyW01hNSFcNMrY3D8P49qeN8xdKCcI9r
    XhZiIdQWU5pYiFNm+hxFCksVY9yxds/0ayyThqsThiYBn0njab8NIbMNPcP/DC5w
    ojtCa9jiDbKiKWDNMebOl+U4E1R8owmhG1l1f2msoBCgpTVEHvD4831NEMo8CC+d
    ylZ3wqm1XgTDQwTh9G5vty5D9aA2DB2Q2e5gDVqNSVlt4OPPTJNqJc9sigFHfKuI
    n/GVD2MC0FmVwLkPLhCHBdCFii1c+V/HFRdTC9bunlGBwe9ytiZQFFDUbH7nEM2k
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B3GQrbha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B3GQrbha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNIbCNmiPypbFDjgHxsumcQpG2kKmee/8HFVN89vWY8lf88hfZ4FrkeVrnJ4Ysxg8FkYdMqf/6zMRw53gwlUvPKf9dEhMj4mBrj4jykHX7b1/a/JhCM
    CMDP0rwLcTq9I2M4ePj7M0dPJJtDRiicFeuzO3sf+s+tUg4GLL6E3pZy8N2kIZCuLbvoycoYANJel3KTbs6WTYpQFVcbkmkDp6bgXOC0eXKRuBqB/+7TSq5h
    C75jFyD+qaYyvOZcdqFgsg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=ylCQlRw3xye7oqRy6kcA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/40] net/can: single_open_net needs to be paired with
 single_release_net
Date: Wed, 25 Apr 2018 17:47:48 +0200
Message-Id: <20180425154827.32251-2-hch@lst.de>
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

Otherwise we will leak a reference to the network namespace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/can/bcm.c  | 2 +-
 net/can/proc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index ac5e5e34fee3..8073fa14e143 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -249,7 +249,7 @@ static const struct file_operations bcm_proc_fops = {
 	.open		= bcm_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 #endif /* CONFIG_PROC_FS */
 
diff --git a/net/can/proc.c b/net/can/proc.c
index fdf704e9bb8c..fde2fd55b826 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -279,7 +279,7 @@ static const struct file_operations can_stats_proc_fops = {
 	.open		= can_stats_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
@@ -449,7 +449,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 	.open		= can_rcvlist_sff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 
@@ -492,7 +492,7 @@ static const struct file_operations can_rcvlist_eff_proc_fops = {
 	.open		= can_rcvlist_eff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 /*
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
