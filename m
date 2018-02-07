Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032885; cv=none;
        d=google.com; s=arc-20160816;
        b=gFpRwy0Pwh7F0t+76XPq+BSGzJ5vGqCChsPv1SdftCHLNabaFeMNYEq6io/hjKNJfg
         0zmpK3TVrssvplZrKIUU/hPeRyD7I2aU0OYJgUxlNgimLHHNOwemJplR1C0PYstXy5k0
         KpWkzoVOG0nTpB/ApQ7tTQUrDFg8S8J/9gsEUvh9k2Ou1scYGesFI74lMt+aID0sxMWF
         MTgqBk9KhiOCNncWsl4s/MzqzyETPsB5X93ZWEDl8Y5D3+KJi0kT8jWN8pVDL3r7joD1
         rMRCq1U8YWzZ5OGcrjqL0l5JYHgJBxgX56gfzkFZi0ozYw+bucRyNtWXy7inok3u3yOp
         nUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CRREP+lWDem2J0PAn2vKwLEZMkzr2clR7OzvABHcfTQ=;
        b=IHaOTLiMgHewD/oB86Zvl1Uo31QKKJhPRr+gcEdNjRldHEDc4MB+VA2O9mC203NLq6
         xQlzYy99a8IkAV4g89kaF26CcH+kBihwlJe+x5EY3DVJlCtmn/czhA6rVzKvT2ZD+mgq
         JK0XLYqjWYjnbECOQX45ygAS6s1a509kMJnS+Yz2R7v3v/yY7MZSFFZN4ENLmdvT8LCG
         eHyZR2Q5xzxEHj7T7JMoRs7UHYNmHQFIs2DFNW5bac/A39ojoniqESN+dPIp42UeTEUl
         f139Y7VgBkWr71kIi4eNLKO3G0HXFKjAU4m8LPZgmHeKoaBkzO8u65oU3wceEH92Kc/j
         fEmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rbtt5GbE;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rbtt5GbE;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224IQZukB4juTTce6CsQRZnfEyn4RHtV2LFI79GkNpOQ6s7Oquvwvf+rbWTBbEXn852YIvdYRw==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 03/12] parport: ax88796: Delete an unnecessary variable initialisation in parport_ax88796_probe()
Date: Wed,  7 Feb 2018 19:47:50 +0000
Message-Id: <1518032879-5844-3-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772850397939970?=
X-GMAIL-MSGID: =?utf-8?q?1591772850397939970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>

The local variable "pp" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_ax88796.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_ax88796.c b/drivers/parport/parport_ax88796.c
index 09788d8..bfe97c2 100644
--- a/drivers/parport/parport_ax88796.c
+++ b/drivers/parport/parport_ax88796.c
@@ -273,7 +273,7 @@ static int parport_ax88796_probe(struct platform_device *pdev)
 {
 	struct device *_dev = &pdev->dev;
 	struct ax_drvdata *dd;
-	struct parport *pp = NULL;
+	struct parport *pp;
 	struct resource *res;
 	unsigned long size;
 	int spacing;
-- 
2.7.4
