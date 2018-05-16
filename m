Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-62429-1526464013-2-14871860390836184980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464012; b=FYbyPkXIVZiPiBLiUQ5b3FtfVuklhESRpAiGoKKbKv+1722a/2
    Bv2czAovufQPClqOTTa99dbNTYpiZqpU27hR/QONckdpyChVmw8sS4yglu7tUn9n
    Ki6P73SdWCBhxMJY9fzIga1m1mTlK+7Q4y9C2grayBBMKSLQdCm8XAgq/0Zy6gUA
    07UnSOW8dW69BcUi0RJsmILwktOoaIJvSzKbSTCCxJxpyVIwMXZaAoS7I7dMw2m/
    4NWDs3BB8EBSBrMHQaZd8DVXEgh6LrZzMKfYn/M45HF7uGnCuBdFI4J1izrY7B4y
    LOOY8MuDCVUd9f4aQ9reH4hYgihibcrsEFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464012; bh=aFUBL
    lOckY2HDOa9L8WAcrQn4t9HLBA7NhllyKNVtBk=; b=AtRLjPthLKJJmD/6a4SAA
    SeTXQ8IaAX2Oj2aRMDXw5/CeqIFyhY4rrmHLVSVmnpNVVio+C+AXVN9eRc3el024
    k3ds2Jwcqlh5MOj1xzCqnXcNq3RF207+Sa19L7aCo/vstjTntgnqn4tOFydRAxUt
    k9cXTzGJrD8Y4HzqBO68mez+c+WK/U3aiULyC/NGXCszNscm1JSliz+yq4mIF2W7
    +/z53dJWL8JqZqs2EX4e+fXBfIeODADaGGzbNFf2C+mOBAgzuyFa6MtSch959fg6
    0+HfnvMejbfc7tYI9F0Se4+DbtlHkUljgnDQMqIx9sy4yAMn8fksIcQ4NyLtTjiR
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=a6ZnYFs/
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=a6ZnYFs/
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
X-CM-Envelope: MS4wfFckTQst3cUKELyW2YCofOxw3KQFgrEV3oVZv+QDIpIALz009nnp+n4CI4RKICLLeXRTCcQqnoNFWXiff4XPTbFA3rmGCG8siARi8aulloj/SyIjQZaH
    /95eRXqqt073gRSavKbCgHCzEVS9/RBKOQLwYgAUnmMQX3ofjd7UIjI+QW0mydNXDqEu5MQRhpYV+DgZ0MYuxGAj+4ss2PeQSm9nEROnqOUoycZ9teWRe+Lg
    eFVctXmobGMxWB2wbAw2/Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=P-IC7800AAAA:8 a=DDOyTI_5AAAA:8
    a=easfzybDChy4AbOaNI4A:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 29/42] rtc/proc: switch to proc_create_single_data
Date: Wed, 16 May 2018 11:43:33 +0200
Message-Id: <20180516094346.20506-30-hch@lst.de>
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

And stop trying to get a reference on the submodule, procfs code deals
with release after an unloaded module and thus removed proc entry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-proc.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index 31e7e23cc5be..a9dd9218fae2 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int rtc_proc_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	if (!try_module_get(rtc->owner))
-		return -ENODEV;
-
-	ret = single_open(file, rtc_proc_show, rtc);
-	if (ret)
-		module_put(rtc->owner);
-	return ret;
-}
-
-static int rtc_proc_release(struct inode *inode, struct file *file)
-{
-	int res = single_release(inode, file);
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	module_put(rtc->owner);
-	return res;
-}
-
-static const struct file_operations rtc_proc_fops = {
-	.open		= rtc_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= rtc_proc_release,
-};
-
 void rtc_proc_add_device(struct rtc_device *rtc)
 {
 	if (is_rtc_hctosys(rtc))
-		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
+		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
+				rtc);
 }
 
 void rtc_proc_del_device(struct rtc_device *rtc)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
