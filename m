Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELtqrIE81TyYx2umK30/HYxybnavHZKvyKcsk4JtMw2nkTUdHpBAQBwzbHaGHwXwFJJFMfwz
ARC-Seal: i=1; a=rsa-sha256; t=1521066391; cv=none;
        d=google.com; s=arc-20160816;
        b=MoLPVuUJJNLdr+jWlqw+Y/BSiImdO8ISCdf3gmJ6K0Fsbro4LZixtjyfdIFk5Hfhf7
         VCwzvinWP2lr+yvZrbzOpCNT9X/nycRigcY/TeRuwzTFGEVL/MHm7oP+rL9auXPUEtv7
         scb3OyASdXn7on9cZ0jSXtu/LW7ZKxnjgPVwOxhFAy61xUB+emTfiF04UgmxCjBm0qgS
         icbtfmml1uhwHzUoDW1t27gF/bPmk8O1Nr7Iq3HnfSP3L5dcD+RFdPbXwioO3CvfI1t8
         lS2ZPx+plC/pz5TmMKQAEzwL7HpUD3XMoDAim+tuYVaWR0mejTrc4s3H+amzYFkE+Ueh
         Q9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=fjapjUZm7qmxwJPBHsGDDFoofAIXKBFbWiWt9v3WnDE=;
        b=kek85uPDkDI7bWQ6g/ix7V5rwFrT/f1eE5cGMWGVRdafD/QEk8B+pdS85M0Xq0a5KG
         pycXuv5gvupTb+MAiDZZIqxU0JDl02SwcoxiLplsrAKqCK7/Q1ipsHBojwUJfxX4z7j5
         URMyrECa2rZ5+gDlH3YOwlYe4j/H8RjtyAAOaKeyM3/rmgzPv5fU8SoBeNWhkImVUgJ1
         VWw5DrWX2EaJ0+1/g2XRAAnYnrKmxnjb6lfUQfZwvtremBcw2hbbmZI7mWIZ9mZA0Qkv
         lz9q5ZYfbzUWZLnoR2rpLPOf5Ok/5EXxJ6gbSrqVPw/w8bXMfE1TimeQDOOSk5mLJxhT
         70MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Q+xsWkK7;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Q+xsWkK7;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Wed, 14 Mar 2018 17:26:23 -0500
Message-ID: <20180314222624.12744-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180314222624.12744-1-grygorii.strashko@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953712390716409?=
X-GMAIL-MSGID: =?utf-8?q?1594953712390716409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sysfs_create_link_nowarn() is going to be used in phylib framework in
suseuent patch which can be built as module. Hence, export
sysfs_create_link_nowarn() to avoid build errors.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
"Fixes" added as there is dependency this and subsequent patch.
 fs/sysfs/symlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index 8664db2..215c225 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -106,6 +106,7 @@ int sysfs_create_link_nowarn(struct kobject *kobj, struct kobject *target,
 {
 	return sysfs_do_create_link(kobj, target, name, 0);
 }
+EXPORT_SYMBOL_GPL(sysfs_create_link_nowarn);
 
 /**
  *	sysfs_delete_link - remove symlink in object's directory.
-- 
2.10.5
