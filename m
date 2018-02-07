Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032890; cv=none;
        d=google.com; s=arc-20160816;
        b=HHB0J5FH+1bUQijTMIjBiCBGA6DS1/X0vr48h7cGWOoMV514+4gGEbVV1qV5lif5zC
         ExrWN+IWBFM493O4Y9pSbwaaQptpFdYsMmakHN7zGmT37AgxOugMdqXTDB4HC9FSOcSQ
         63fIvekUU3hiic4YD9Pa5ZXoCKY9iPVcmhoHxXb9bUXUS+AOFgcgDN9lWwNOOV8mryvZ
         oW2+/qi70kBoiOQJtNxrGG+8lr7lh68y++Lv5afp2jSjSG7mjeO6FMPMIuoRAJk0yrfn
         MPr2CVu3iWuKr3rnEyFj7gSYkH0IBmWTfTNZQ0YDzEIzGIGMscNIj5DVsqXY9B//Uwp/
         C+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=UdmXLzRcdR+FFI8q7c/xB+S09EZYOIqkFlqSQLzXvtc=;
        b=Mc0id3khN8el8Ch7LXW4HjdLJo0EhyLuClvVSZ0a7omI6/+HHdLBs/6WG/PGsveofN
         JLt7GIBlVP0XsSevNuBZBxRh6JW7fwv3p3iW8xfEQtSF0K7JijMoew8m6mpYaaYWMxW3
         8bRrKvtsL69u1uQpLyrlW2tRqNcmMMopIP9uH2xZMBiGKK177JlLgc+nDyGDTua28JmQ
         RoUojWeUAJPh30obvSKZvDrqq1rt5K7CMXTx7SafhL64kAwOWIGGY7IOQtGgKWbZ0Us9
         kPCwSXdWv1wIkts6YuiY4J5yhdQAAwtyyBmCLpVqghyY/7jZdnvbKqFRS/S9pDHJR4z3
         6rpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t8mPPPSe;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t8mPPPSe;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224cWd+4eNCcwvIBwPdlVklHHoocNGZhwK93BMHYCcjnqPBMITW8oKEcqMnLa8snxUpBh646Yg==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 08/12] parport: Convert printk(KERN_WARN) to dev_warn()
Date: Wed,  7 Feb 2018 19:47:55 +0000
Message-Id: <1518032879-5844-8-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772855968393730?=
X-GMAIL-MSGID: =?utf-8?q?1591772855968393730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

dev_warn() will print device name with associated driver,
no need to keep this open coded.

While here, adjust indentation in the rest of dev_dbg() calls.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index c222698..c56bb06 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -571,10 +571,9 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 		int irq;
 
 		if (priv->num_par == ARRAY_SIZE (priv->port)) {
-			printk (KERN_WARNING
-				"parport_serial: %s: only %zu parallel ports "
-				"supported (%d reported)\n", pci_name (dev),
-				ARRAY_SIZE(priv->port), card->numports);
+			dev_warn(&dev->dev,
+				 "only %zu parallel ports supported (%d reported)\n",
+				 ARRAY_SIZE(priv->port), card->numports);
 			break;
 		}
 
@@ -590,12 +589,12 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 		irq = dev->irq;
 		if (irq == IRQ_NONE) {
 			dev_dbg(&dev->dev,
-			"PCI parallel port detected: I/O at %#lx(%#lx)\n",
+				"PCI parallel port detected: I/O at %#lx(%#lx)\n",
 				io_lo, io_hi);
 			irq = PARPORT_IRQ_NONE;
 		} else {
 			dev_dbg(&dev->dev,
-		"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
+				"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
 				io_lo, io_hi, irq);
 		}
 		port = parport_pc_probe_port (io_lo, io_hi, irq,
-- 
2.7.4
