Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526463997-2-13527659660786491221
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
    1526463996; b=gorP2m4a3AkoYxk6LllDPKFZOa2Kyi29BAzyz3FxdrXkuFKU8F
    XkFgAWebDCTXvPaSiG/W9rgzKsV8Ibl/aYHCFtxvCyf52ksReagrcajBz0jhrw16
    EkYdsqDUJ1r1owyF8usB9FG1xmBG9FmfZsXnNL1cmx8mcpp60nyFoNUqVtgUWll0
    STQIXvbxf8CdVJSTxj7imFi2aIcTdbzQn3UsF4gRlaEDylI0jws6nHnOVB1ikZMs
    BSDGGwqBJyfaBe7hsAKNyuiPXcP8BNBs67iFVs+uJe8N6W/Yfm8zidzt5i5Fds5R
    9g965JxRmz5xe1G2kzhVnH5hGSaO+dOJSl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463996; bh=8jcSK
    xji4w5LCOLUM326mocz8+mNYQDqIgF16xtisGM=; b=J7dAnWQnQFgRn9oMlVXHR
    ZrCvy6eLA4JZ4eUXaFHx3GhXTWtJC0ZNLX40QJ6/zkKJxftLdZSh3Rsp6UMZnZdj
    Y+/jj5t0v5wu8etVAXgc4yQTXC3DJroOixzS1T1puRHAPAguj2t391a/qGiipp6X
    jPpgjU2jgFFwCbgBK54LiA4Oxxlgbnc8araGZVPvioX7NqeOe4wTPSWGe4Z1VARk
    B3ODE2jQwMRNveXzivUJbP0z/Kml2JmN3yqKCq+PryYXcI9h84C+3UL3rVonnqWz
    o78BQj/97qD+w9bNnWq/pOtpuG+IitNnbpGXfg8Ja9jh7k5UCvpDY2r0ZkvHvgbU
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=IE5rz4Er
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
      header.d=infradead.org header.i=@infradead.org header.b=IE5rz4Er
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
X-CM-Envelope: MS4wfFI5xw12gtjeBhTeNo/zxQFLkUtltJBeBxVnT2LmHvbo3QkqIoZCbRwspSsCsyIC2Z4G8mn/SiagWo38VBhq4Xqid55oCkm6Pc4u5WWoA+svsACnOdgU
    YzSc3/RP54puzdK/erWYswz8865HgVtp1akI2CFQ0PIDfR2RyKwDh5212SFFte96gPGXWmnantZI2ii4IdMuZMb2SJyMGQDCOk7QBJqEQ49n3pu/lLjiDnr5
    WnwAWGiGLTYprMNMD3mHJQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=nnAUT0DM3jf9yUwnRPkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 31/42] hostap: switch to proc_create_{seq,single}_data
Date: Wed, 16 May 2018 11:43:35 +0200
Message-Id: <20180516094346.20506-32-hch@lst.de>
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

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../net/wireless/intersil/hostap/hostap_ap.c  |  70 ++-------
 .../net/wireless/intersil/hostap/hostap_hw.c  |  17 +--
 .../wireless/intersil/hostap/hostap_proc.c    | 143 +++---------------
 3 files changed, 39 insertions(+), 191 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index 4f76f81dd3af..d1884b8913e7 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -69,7 +69,7 @@ static void prism2_send_mgmt(struct net_device *dev,
 #ifndef PRISM2_NO_PROCFS_DEBUG
 static int ap_debug_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 
 	seq_printf(m, "BridgedUnicastFrames=%u\n", ap->bridged_unicast);
 	seq_printf(m, "BridgedMulticastFrames=%u\n", ap->bridged_multicast);
@@ -81,18 +81,6 @@ static int ap_debug_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "tx_drop_nonassoc=%u\n", ap->tx_drop_nonassoc);
 	return 0;
 }
-
-static int ap_debug_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ap_debug_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ap_debug_proc_fops = {
-	.open		= ap_debug_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -333,7 +321,7 @@ void hostap_deauth_all_stas(struct net_device *dev, struct ap_data *ap,
 
 static int ap_control_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	char *policy_txt;
 	struct mac_entry *entry;
 
@@ -365,20 +353,20 @@ static int ap_control_proc_show(struct seq_file *m, void *v)
 
 static void *ap_control_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&ap->mac_restrictions.lock);
 	return seq_list_start_head(&ap->mac_restrictions.mac_list, *_pos);
 }
 
 static void *ap_control_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &ap->mac_restrictions.mac_list, _pos);
 }
 
 static void ap_control_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&ap->mac_restrictions.lock);
 }
 
@@ -389,24 +377,6 @@ static const struct seq_operations ap_control_proc_seqops = {
 	.show	= ap_control_proc_show,
 };
 
-static int ap_control_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &ap_control_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations ap_control_proc_fops = {
-	.open		= ap_control_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 int ap_control_add_mac(struct mac_restrictions *mac_restrictions, u8 *mac)
 {
 	struct mac_entry *entry;
@@ -585,20 +555,20 @@ static int prism2_ap_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_ap_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&ap->sta_table_lock);
 	return seq_list_start_head(&ap->sta_list, *_pos);
 }
 
 static void *prism2_ap_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &ap->sta_list, _pos);
 }
 
 static void prism2_ap_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = m->private;
+	struct ap_data *ap = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&ap->sta_table_lock);
 }
 
@@ -608,23 +578,6 @@ static const struct seq_operations prism2_ap_proc_seqops = {
 	.stop	= prism2_ap_proc_stop,
 	.show	= prism2_ap_proc_show,
 };
-
-static int prism2_ap_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_ap_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_ap_proc_fops = {
-	.open		= prism2_ap_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 
@@ -896,12 +849,13 @@ void hostap_init_ap_proc(local_info_t *local)
 		return;
 
 #ifndef PRISM2_NO_PROCFS_DEBUG
-	proc_create_data("ap_debug", 0, ap->proc, &ap_debug_proc_fops, ap);
+	proc_create_single_data("ap_debug", 0, ap->proc, ap_debug_proc_show, ap);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 #ifndef PRISM2_NO_KERNEL_IEEE80211_MGMT
-	proc_create_data("ap_control", 0, ap->proc, &ap_control_proc_fops, ap);
-	proc_create_data("ap", 0, ap->proc, &prism2_ap_proc_fops, ap);
+	proc_create_seq_data("ap_control", 0, ap->proc, &ap_control_proc_seqops,
+			ap);
+	proc_create_seq_data("ap", 0, ap->proc, &prism2_ap_proc_seqops, ap);
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 5c4a17a18968..2720aa39f530 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -2951,19 +2951,6 @@ static int prism2_registers_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int prism2_registers_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_registers_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_registers_proc_fops = {
-	.open		= prism2_registers_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -3279,8 +3266,8 @@ static int hostap_hw_ready(struct net_device *dev)
 		}
 		hostap_init_proc(local);
 #ifndef PRISM2_NO_PROCFS_DEBUG
-		proc_create_data("registers", 0, local->proc,
-				 &prism2_registers_proc_fops, local);
+		proc_create_single_data("registers", 0, local->proc,
+				 prism2_registers_proc_show, local);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 		hostap_init_ap_proc(local);
 		return 0;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/net/wireless/intersil/hostap/hostap_proc.c
index d234231bf532..5b33ccab9188 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -43,18 +43,6 @@ static int prism2_debug_proc_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int prism2_debug_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_debug_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_debug_proc_fops = {
-	.open		= prism2_debug_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
 #endif /* PRISM2_NO_PROCFS_DEBUG */
 
 
@@ -95,19 +83,6 @@ static int prism2_stats_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int prism2_stats_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_stats_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_stats_proc_fops = {
-	.open		= prism2_stats_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-
 static int prism2_wds_proc_show(struct seq_file *m, void *v)
 {
 	struct list_head *ptr = v;
@@ -122,20 +97,20 @@ static int prism2_wds_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_wds_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	read_lock_bh(&local->iface_lock);
 	return seq_list_start(&local->hostap_interfaces, *_pos);
 }
 
 static void *prism2_wds_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &local->hostap_interfaces, _pos);
 }
 
 static void prism2_wds_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	read_unlock_bh(&local->iface_lock);
 }
 
@@ -146,27 +121,9 @@ static const struct seq_operations prism2_wds_proc_seqops = {
 	.show	= prism2_wds_proc_show,
 };
 
-static int prism2_wds_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_wds_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_wds_proc_fops = {
-	.open		= prism2_wds_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	struct list_head *ptr = v;
 	struct hostap_bss_info *bss;
 
@@ -193,20 +150,20 @@ static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_bss_list_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 	return seq_list_start_head(&local->bss_list, *_pos);
 }
 
 static void *prism2_bss_list_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	return seq_list_next(v, &local->bss_list, _pos);
 }
 
 static void prism2_bss_list_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
@@ -217,24 +174,6 @@ static const struct seq_operations prism2_bss_list_proc_seqops = {
 	.show	= prism2_bss_list_proc_show,
 };
 
-static int prism2_bss_list_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_bss_list_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_bss_list_proc_fops = {
-	.open		= prism2_bss_list_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 {
 	local_info_t *local = m->private;
@@ -252,19 +191,6 @@ static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int prism2_crypt_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prism2_crypt_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations prism2_crypt_proc_fops = {
-	.open		= prism2_crypt_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-
 static ssize_t prism2_pda_proc_read(struct file *file, char __user *buf,
 				    size_t count, loff_t *_pos)
 {
@@ -342,7 +268,7 @@ static int prism2_io_debug_proc_read(char *page, char **start, off_t off,
 #ifndef PRISM2_NO_STATION_MODES
 static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	unsigned long entry;
 	int i, len;
 	struct hfa384x_hostscan_result *scanres;
@@ -392,7 +318,7 @@ static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 
 	/* We have a header (pos 0) + N results to show (pos 1...N) */
@@ -403,7 +329,7 @@ static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 
 static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 
 	++*_pos;
 	if (*_pos > local->last_scan_results_count)
@@ -413,7 +339,7 @@ static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *
 
 static void prism2_scan_results_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = m->private;
+	local_info_t *local = PDE_DATA(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
@@ -423,25 +349,6 @@ static const struct seq_operations prism2_scan_results_proc_seqops = {
 	.stop	= prism2_scan_results_proc_stop,
 	.show	= prism2_scan_results_proc_show,
 };
-
-static int prism2_scan_results_proc_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &prism2_scan_results_proc_seqops);
-	if (ret == 0) {
-		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
-	}
-	return ret;
-}
-
-static const struct file_operations prism2_scan_results_proc_fops = {
-	.open		= prism2_scan_results_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-
 #endif /* PRISM2_NO_STATION_MODES */
 
 
@@ -463,29 +370,29 @@ void hostap_init_proc(local_info_t *local)
 	}
 
 #ifndef PRISM2_NO_PROCFS_DEBUG
-	proc_create_data("debug", 0, local->proc,
-			 &prism2_debug_proc_fops, local);
+	proc_create_single_data("debug", 0, local->proc,
+			prism2_debug_proc_show, local);
 #endif /* PRISM2_NO_PROCFS_DEBUG */
-	proc_create_data("stats", 0, local->proc,
-			 &prism2_stats_proc_fops, local);
-	proc_create_data("wds", 0, local->proc,
-			 &prism2_wds_proc_fops, local);
+	proc_create_single_data("stats", 0, local->proc, prism2_stats_proc_show,
+			local);
+	proc_create_seq_data("wds", 0, local->proc,
+			&prism2_wds_proc_seqops, local);
 	proc_create_data("pda", 0, local->proc,
 			 &prism2_pda_proc_fops, local);
 	proc_create_data("aux_dump", 0, local->proc,
 			 local->func->read_aux_fops ?: &prism2_aux_dump_proc_fops,
 			 local);
-	proc_create_data("bss_list", 0, local->proc,
-			 &prism2_bss_list_proc_fops, local);
-	proc_create_data("crypt", 0, local->proc,
-			 &prism2_crypt_proc_fops, local);
+	proc_create_seq_data("bss_list", 0, local->proc,
+			&prism2_bss_list_proc_seqops, local);
+	proc_create_single_data("crypt", 0, local->proc, prism2_crypt_proc_show,
+		local);
 #ifdef PRISM2_IO_DEBUG
-	proc_create_data("io_debug", 0, local->proc,
-			 &prism2_io_debug_proc_fops, local);
+	proc_create_single_data("io_debug", 0, local->proc,
+			prism2_debug_proc_show, local);
 #endif /* PRISM2_IO_DEBUG */
 #ifndef PRISM2_NO_STATION_MODES
-	proc_create_data("scan_results", 0, local->proc,
-			 &prism2_scan_results_proc_fops, local);
+	proc_create_seq_data("scan_results", 0, local->proc,
+			&prism2_scan_results_proc_seqops, local);
 #endif /* PRISM2_NO_STATION_MODES */
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
