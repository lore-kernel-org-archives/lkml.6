Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELuNwujEPBIUzamdjwmS5OXLVV095v9y60zgY7F+aEt0Qi0k9IOey938I0uoa+sdVkVDr1s9
ARC-Seal: i=1; a=rsa-sha256; t=1521238119; cv=none;
        d=google.com; s=arc-20160816;
        b=v8Chv8X0C+jdYLucWWOFI1nsprSER5/TdKRUzpaYv3GLwuhTwmn65I58/bmBqplPR8
         0RSkOPuOoZNrLgxWlOkWDYMswrBrXHSySIZ2tlY1xwYtp4VZj1C4au0/1iZgr795x2rm
         hOcDdfyW5UH8/x5KpzTGvS2F1Km9BhovxZ9Ua3HoVAlBrWqxHKt7/Rx/Jvq/TG2oVG/0
         d5Hg3w9kNAVubFdbyJj4I18+SjLejkOCS/qZ9CovRyZCawwd5pfSVfoHn0tr5o33r8v4
         R6CjtVl2/WjGniwDdB1pRyTsNRlGWKHiTtWUCilh5/Q/tNrZ+6ijFRbw4+qBxTQVvfZL
         1L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=85MVZ1nvu5Cl7nkAMKYu3qfCxv4FUsnN2W03S4ypBzM=;
        b=Q/dvtBsJ4uAn47Z7Fb/8Igggmwqyq53cAplz4ZHKEKrCTj3Kt9a4ave2ZwMeOHaHEX
         BHKqmlXnSdR60xpIBeoZfZZCiefzQKm0YSP8dBF5xhba+Pdi0za+hIusViZESiok83MJ
         Y2otdeW56ugEc17LSD8+i5GYdoNpkzKjERKWAcfUVm6z7Iwa3twhSSx1zQin4l0oK4hJ
         VngAq6vZEZdBre0ARkfc7LeV/oK5aYQFP8NISLgz8TXG+8lOq2mfkjbehHphIDwZ1iwY
         stlVxhHcBezTqPEulukX+r1nV4MIiXPaSy4PaWJ6zr/yZ7U5urlfnj/gv7TEwlcu/yX/
         JMJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=TGmwke0e;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=TGmwke0e;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
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
Subject: [PATCH v2 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Fri, 16 Mar 2018 17:08:34 -0500
Message-ID: <20180316220835.30006-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180316220835.30006-1-grygorii.strashko@ti.com>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595133781788624576?=
X-GMAIL-MSGID: =?utf-8?q?1595133781788624576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sysfs_create_link_nowarn() is going to be used in phylib framework in
subsequent patch which can be built as module. Hence, export
sysfs_create_link_nowarn() to avoid build errors.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
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
