Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AH8x225MpH6RwMwk1gJEJ5HedzOaAWZk6YYK1vsZi6G4V6syEj3VmY2jJv6uS+EqzsyDFSJH3BfD
ARC-Seal: i=1; a=rsa-sha256; t=1518167648; cv=none;
        d=google.com; s=arc-20160816;
        b=SeJgjAKOoMlT7TcKiSWo5ios5vliYYyWyq4AZAo0wUmQbDNQ/WXH1gZkF3DZj7LUj7
         rO9jKfYLbZ4NQA44uSNSenTkCNMA6I+7NYOoNjGxqSdyGHggatdU9hDCU1L0Nw69t2C6
         6MwD5aSy421x81a4bqO3xNJ341bELd9hDoXUvsNEDnb7110D2XHZRAqEAHsJVb71zhve
         9C0A7dqvq1P8npvLfGT+IH3Shk/md5y1e22qWeCTvDDRCIX5PPkAS+bT5zGKASmzOMDc
         Ot4T2KPHRde5pE6b9wm3mlpDY8wXikGlPCC6Riy08n41kWTHSoKeZopWGsEJ7lo+e/4e
         njaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=35ZyHp6Ga7AGGg2ukxVVjelIxb+clD6TzPfNJVoDz7I=;
        b=bHYcUdbWj4q3D7bbyu7+7Y2A2oFajNYF38tEtirfUfIcQ4yLfBVoJ0DRrU9er3rJxb
         9j50rBcpKATNUH9iQNjd9x3ukFjCxncRBMGoAPUsvd1VWxCG0UdDQYd0+IInJ1+a4Fb+
         3a3+XrNDOqjktcb+FnQU42iD28K3pGlKhdWod8HvwLGYF7ZobXcfwFem7NcVRJreT5/M
         HJN8pM8sNNBpOXp1tRSoJYkPZd7h3QCCXDJBbZ4WfHv486iEn5ITtU1+5wSrfiKS2qpO
         2HpEOAUDMIUFFGHwm5DW1M39feF8OAUd8vsNwX4k76m/R5WULhFfRldxRzA9VBvZPrXM
         m5QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Arend van Spriel <aspriel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Arend van Spriel <aspriel@gmail.com>
Subject: [PATCH] drivers: base: add description for .coredump() callback
Date: Fri,  9 Feb 2018 10:13:57 +0100
Message-Id: <1518167637-1948-1-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914160440023159?=
X-GMAIL-MSGID: =?utf-8?q?1591914160440023159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 3c47d19ff4dc ("drivers: base: add coredump driver ops") added
a new callback in struct device_driver, but not a kerneldoc description
so here it is.

Fixes: 3c47d19ff4dc ("drivers: base: add coredump driver ops")
Signed-off-by: Arend van Spriel <aspriel@gmail.com>
---
 include/linux/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index b093405..0b32a42 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -256,6 +256,7 @@ enum probe_type {
  *		automatically.
  * @pm:		Power management operations of the device which matched
  *		this driver.
+ * @coredump:	Called through sysfs to initiate a device coredump.
  * @p:		Driver core's private data, no one other than the driver
  *		core can touch this.
  *
-- 
1.9.1
