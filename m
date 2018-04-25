Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671521-2-8732093684056368952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671521; b=TKIYLNNX/ar10fTdpDSEhZCrpVkpnlPNWU0ennyOnbhredCe6Q
    pnUjZ4ezD2csh2ctpa5GEi5k0B0s8ewq1psv2MEf2CLmKAHMF5qjCu/5MD7KzUk8
    qCPxqo5T04RHezD7X0JdMKCSlXfe/ror2MGHVsddNvDGsKexJ7K+wBCsYIa7JW3n
    Q9blW8TC9+MPMPyW2h7VCZw1imeRWsfDO+b2PdyQuMFk/6JgXWWx7vf93svHFSzW
    Q2GhZkmZjw0kXthe+vlhnXx7IuqNOvP47M0LWAXoWDPtN2nI9nhwR1hzgdm1nZfu
    moMaTBrlpaGODLv5smHx/+kaFKGl7MgbKKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671521; bh=+nvMY
    A5CDqzxB+hdKvRnHuebCs0lTitvFX8zYMSZ6u8=; b=vrMAUP9UCxbwkZnryprLe
    +xGvEcDH0sYbsD0Rnu0NRgwuDxBDTaoLH1M5l4gwtZ4/FBb1pALj9aakTbLFh27t
    HHscrs2zXcA2L0zOJWfWCiYJCQarui5U5FWxpHGxyPL/KA2m/R3lUl1ftNnbpl+Q
    TJx1W4P1jMpHOyRK2Xzp+3KTB5UPd+Mnax7+lB68jGSD6EozoXbGxp7mB0LNrb/4
    eUlzz3/2U9xFV3ChntTBQLAViL40WXoP5D+1tCQ4bFVBY+twBA1WGzj3MoAd2ui3
    vdiTeE8UGNA5GNzWks77r0hu1GIQOzmVM18DQYDraWnSIP5UZ642ca5iId/RLonc
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Om0VAQZn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Om0VAQZn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrexC7nNFlkAWdFGeUgyb8WK4Lhv8MORxCXyQnoBre4E+zJ7eKXhFgHVVOjdLcIXYAAnmbDcuvGANLWqMXq6We9SDayszZ1MGHhaGyKNLkKmr43OBiw
    PiqZpFNrOjok2MwAKH9O/GiIp5SnaLHc/02Zk8Brh6fIYTbvHmKva4WqUsoJPnSqVdzps1lCyKApYokFixadnb3CnEb+2Qqa3pB7+FQARQWjG0C5ue0YByv+
    7YaQRLmBWzx9ZE00jOaHtw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=YMBgog7T_lIm86Di9T4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 38/40] ide: remove ide_driver_proc_write
Date: Wed, 25 Apr 2018 17:48:25 +0200
Message-Id: <20180425154827.32251-39-hch@lst.de>
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

The driver proc file hasn't been writeable for a long time, so this is
just dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-proc.c | 46 ------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 863db44c7916..b3b8b8822d6a 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -528,58 +528,12 @@ static int ide_driver_proc_open(struct inode *inode, struct file *file)
 	return single_open(file, ide_driver_proc_show, PDE_DATA(inode));
 }
 
-static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
-{
-	struct device *dev = &drive->gendev;
-	int ret = 1;
-	int err;
-
-	device_release_driver(dev);
-	/* FIXME: device can still be in use by previous driver */
-	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
-	err = device_attach(dev);
-	if (err < 0)
-		printk(KERN_WARNING "IDE: %s: device_attach error: %d\n",
-			__func__, err);
-	drive->driver_req[0] = 0;
-	if (dev->driver == NULL) {
-		err = device_attach(dev);
-		if (err < 0)
-			printk(KERN_WARNING
-				"IDE: %s: device_attach(2) error: %d\n",
-				__func__, err);
-	}
-	if (dev->driver && !strcmp(dev->driver->name, driver))
-		ret = 0;
-
-	return ret;
-}
-
-static ssize_t ide_driver_proc_write(struct file *file, const char __user *buffer,
-				     size_t count, loff_t *pos)
-{
-	ide_drive_t	*drive = PDE_DATA(file_inode(file));
-	char name[32];
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (count > 31)
-		count = 31;
-	if (copy_from_user(name, buffer, count))
-		return -EFAULT;
-	name[count] = '\0';
-	if (ide_replace_subdriver(drive, name))
-		return -EINVAL;
-	return count;
-}
-
 static const struct file_operations ide_driver_proc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ide_driver_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
-	.write		= ide_driver_proc_write,
 };
 
 static int ide_media_proc_show(struct seq_file *m, void *v)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
