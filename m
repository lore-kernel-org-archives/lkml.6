Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/xsxMDGYV+vH0TuwDABpRQv74O/LBN/76cNhPmMKdUqVYKW4M7kUaIpvMeuPsOhc0mnM5A
ARC-Seal: i=1; a=rsa-sha256; t=1524141838; cv=none;
        d=google.com; s=arc-20160816;
        b=S1GQVKOUI66uNZs6STI3JcX+JvjehMm0ZQv4wxQbtflrKia3HIkd3BYs21S9LFjCMw
         /v85SDVJqnv8tY4j5yzLU6IaUF6ywCrFFslf7zTThs0sbNQoQ7qx7uctwGiE+s6B+0Oe
         CK4/yiPfy7DmQDh3ANOw0Ridjc4FaVIydBHqUnGOF4PnHwyaMMImGz2/ar5m8nq6C4yG
         8nLXuX9HvuJpy4tOIwtezIi8gdeiBwL9/K5YLjC9/8uBUcLNVpL7kxpjKHZpGrbFkswO
         Gzw+Pp3car47Wn5SsL1yCMiGw7GFPmaMphJpYEnl7jDV858nAxI5x4pg7hRIXrUMEaLq
         tVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=cBbdKHM7GeinFPesJMhJAN7DykfH1UqJGpgBtKiAIiw=;
        b=tLoQnv9pyMKZMmyZGMutIuMqjCK9mmcqTadyh+kKjN6NpxBXSvl43wDnR6iWt3sx5/
         NKu4gzFeeC9UQRbi1aT7qojNDWCZboGDE2CstJGyrsW7vowZ1nXmy7HgBWm6h5QgFwva
         b+dg0Na6tnXqPCyBP0GJWvNT5uvHHmHvbnhYI5v+goRQcKGjhHPURaBaAczXK6lOIeRB
         iBB0K092CTh1evkplLRLztmjnU8tU2I9nrj8nLLmmcAhHrtwTVRuNXocxUYM1Ce9EYZL
         hYSR+V/NzsgIcFho6zMYCbPek3uhX5eQrLRx8MXpRVL9gnUTkXUPMd9m4qV1FpNNoUxO
         /1DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UI7xAj+l;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UI7xAj+l;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/39] ide: remove ide_driver_proc_write
Date: Thu, 19 Apr 2018 14:41:38 +0200
Message-Id: <20180419124140.9309-38-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178552039344534?=
X-GMAIL-MSGID: =?utf-8?q?1598178552039344534?=
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
