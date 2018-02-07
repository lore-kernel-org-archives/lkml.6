Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032883; cv=none;
        d=google.com; s=arc-20160816;
        b=LgV+QH+3QyK5v5eFZZFGfYbPHhucg5UkWhy3OxqEzbq+4Qyz1bkPO1pr5hr5UAHeV3
         Fy07irrYxZ7rH6+rMSLPtJGlIQcwLUAD/fx+mE2Xob+VD3srreyUfvR4ty7W15X7Hnrs
         CdV38oykYQg+j1DueItzG0EAn3sVnPd0JlxLn2dU3KCIpgX7n90q70jXrC/vzEnCcj1W
         AdVsouCz7FwRJGKu8B9G03BEiM9lHLMQh5HDkDw4kigyPOEsL6QoVzWF7xp/PleGWChd
         6Wx6Xj+C2S2EC3Lef801wdnAIYmPVSJXtQyd6gYte6GCuFCG9HbCrLN/DgZT1Ofau16A
         /pgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hMZ2p5Ekwc1VML+KBNxmw+uLx1jGSmxpPXQz1UPAl/U=;
        b=lhX0qcnV53PKWla5p2cUQ00wkjq0GhAdBblP4Q72D7YrAZp5ZdeSnB2wrJ1fCyP33N
         YA0A5F87BVtS1LQaq8f3/f5TGPu14dvmfHQZERDva2JBexpXsqxLnpRMl3Iiqyrb94Gq
         6doznyEP2EVHgZMFeKJeYZRYRDLnMunlX5u7JdN7WfS1AtwpAD8Wr9/Hk+Lw70XCwX7e
         /h4ngHEcrZhDEBUUS/2wWOhi2GtlSka2kMWF0gUdQCoeiyr/APLwhb86pYF5h+5AhSZC
         GVHBfLQf6iaYeX/XtUOlKxlwhKZEkq8KfmORJ28hbxkGHXl6cJ60I+l3r/KQfrzxfCqp
         FcMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pzfnyfPH;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pzfnyfPH;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226BrrvuosP0QtR8sRnNqrDbwY2ef9EeMxBIzJoiqyPz2ER19qTR2epmpW66FG134kE3KGxiow==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 01/12] parport: ax88796: Delete an error message for a failed memory allocation in parport_ax88796_probe()
Date: Wed,  7 Feb 2018 19:47:48 +0000
Message-Id: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772848657448336?=
X-GMAIL-MSGID: =?utf-8?q?1591772848657448336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_ax88796.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/parport/parport_ax88796.c b/drivers/parport/parport_ax88796.c
index 2fc91ed..ef0aec4 100644
--- a/drivers/parport/parport_ax88796.c
+++ b/drivers/parport/parport_ax88796.c
@@ -281,10 +281,8 @@ static int parport_ax88796_probe(struct platform_device *pdev)
 	int ret;
 
 	dd = kzalloc(sizeof(struct ax_drvdata), GFP_KERNEL);
-	if (dd == NULL) {
-		dev_err(_dev, "no memory for private data\n");
+	if (!dd)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-- 
2.7.4
