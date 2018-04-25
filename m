Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524671487-2-11590712018809357197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671486; b=LNgiFH1A67pAiadquBooRK5/WNIDqCXbH/kFD4N2gJSbnQeypW
    +g0LpN5zPCq1V6SfBs7kSUYMiRg6Y31P0J9vHX9wEWVDLkRx2C19OU+i+doVSsdY
    4tzxK9KcKCYSsyVbEzm/x0aXPQB0P+rMqI+UiOqSF1WRRixXnaDM434uXGtXsIRQ
    sZR4uOOaV4ozgY8ciCmBk/AUhCcWnS5svpT3acaiq8z1g7km2ypvpCq5zpQr9lRj
    hDWC86+m9vSfpqlghfsLA3RjiSSq1RzV0meFk9l3s2waTgyu2dbmxV5FwD3cq8Lh
    1VXTkclTzCvH77PlPaXJkfwP72GcICRXZpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671486; bh=EnKEP
    BOJrxyQ5Q/HZwvbSMaxcL/Z51KIgsSpN2c7xpI=; b=D1eFj+iaI165SyZE+Rkql
    Q9mZZSnKB7PyQGf4L0SaczhVh1i4HnJtC0UM3QzE2rdA0ISFrBhC0PnQpM6qyo8c
    4G21gYzTR28UwD5Kvs1lVDV9ccDBrWx+rhqZkzisgg0P4kWsNQtM0Wl9669mujZr
    Z5yK9A8H/1OXtYAfWlsadJuTeE8ipaLj6NZEGC2XBcNJ/kX560n8tfG4taL2cZE6
    2q0GNpg+R4WsRujuqLizvi1yVYcPD0s7FlWVvwUWTrZrtyCPr8A0UHpIyLoG8lhX
    xsTnYp98noRhFd1ovml5/6ddoEeLSe+aUCmRkG09x9gwjwGWFMfrlDtN4wHF3vx5
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=UCPJnZTA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=UCPJnZTA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfKA9JbGFyxT1DgJpOGGygf7stoEA+57A2lAc6sLlf8f/72TIZ1EccizIYEFAWETrLdJ7oxsGTi6M1bOY+wQbdku0IJIPfZuxebs7JmWQ30FQMDhBgUiL
    O5USLocsYUMntz/Tjgr0NGS0lysLVoE6mwhgLnZ86L1+hGR/84ZywUJCa5Pf9vozvJ93v9jFLA1lqB2ogXmmP9wWkgNsGRuPnNMzBiswJ82qDJKYyDC2a5Uh
    zGpEuREXbKG7mHJK/ylgeA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=TCsHB-DreQICuqE0vTcA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 32/40] netfilter/x_tables: switch to proc_create_seq_private
Date: Wed, 25 Apr 2018 17:48:19 +0200
Message-Id: <20180425154827.32251-33-hch@lst.de>
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

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 344dd01a5027..0e314f95a4a3 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1648,22 +1648,6 @@ static const struct seq_operations xt_match_seq_ops = {
 	.show	= xt_match_seq_show,
 };
 
-static int xt_match_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_match_ops = {
-	.open	 = xt_match_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 static void *xt_target_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	return xt_mttg_seq_start(seq, pos, true);
@@ -1698,22 +1682,6 @@ static const struct seq_operations xt_target_seq_ops = {
 	.show	= xt_target_seq_show,
 };
 
-static int xt_target_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_target_ops = {
-	.open	 = xt_target_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 #define FORMAT_TABLES	"_tables_names"
 #define	FORMAT_MATCHES	"_tables_matches"
 #define FORMAT_TARGETS 	"_tables_targets"
@@ -1787,8 +1755,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_match_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
+			(void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_tables;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
@@ -1796,8 +1765,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_target_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
+			 (void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_matches;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
