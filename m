Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032884; cv=none;
        d=google.com; s=arc-20160816;
        b=vleLggZx9s/ZsvZwv0OXVLwqJVCSIVuDb1FgcxQ1PPNxSLcymqO7LrVFJrc2QOypvG
         60StR0Aws5HV8zbCDSb1tELDz3GG7M1LLFlvtag4kbqI4pLwdZBfvx48/tVRTeCrELp+
         2HAXo5pj7bdHXGWPZJQU8EjdB+uh+4d+gZ0TOSWi9SeHkaZU3HLUu2yi5KB4du9SR7dQ
         ULaNBR7l0Vv9UfE4mFWJN0u6O+vNheH+xlkL/v13rqG3bZcuHislNXQGSIjxb64QpHy1
         EULuf+gbdxqDCQ64JCrUDIpbfuKfCiv3cpT4qnaDJ85uF/oxlWcfE/2Zq45LaRprvkQZ
         HMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=nb2A/dT/tXpeCYGwvSDZSXnPiDiwWJUO/DrbyEhm9bU=;
        b=WBeQvxn3UptZ8sUkrFrmBUftg0bnpVm01mjvYWYAJQaN++XcemV94RAamqADp57B7E
         89qmUt/pztjJqkZMRoqVbfHDLBLhPnVxbri5ZUF/dVZdQbQ6qNSEPBPMfDtpTuzV4gBZ
         ksZdVlXOA3dChBW2n0wB2LqWi9TcHAv/UHaWnwnrVocIoXAaYHVG7G7YBSO+CRmb4Xjj
         IMkn3QrxKEe/crjTm2s8WpGn/X8e3oruTiV7rRwQYsSgvJzMIrtLs2ilRhxKKhjOnEhA
         CqPOweEl/t+9qHLye92VbzWCB3cn+Ugf5wcZVv6kEr0GXs56KtBH4bfX3nwNCYnSHVFa
         J8wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W+rYYJGC;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W+rYYJGC;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225bBHN7vUG3upFgl2CN6mQAgPg/ZrjM2Qe4lAql99LpCOGH/7fjLC0DWoFldl87NLgUOmUrMA==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 02/12] parport: ax88796: Improve a size determination in parport_ax88796_probe()
Date: Wed,  7 Feb 2018 19:47:49 +0000
Message-Id: <1518032879-5844-2-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772850001438918?=
X-GMAIL-MSGID: =?utf-8?q?1591772850001438918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_ax88796.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_ax88796.c b/drivers/parport/parport_ax88796.c
index ef0aec4..09788d8 100644
--- a/drivers/parport/parport_ax88796.c
+++ b/drivers/parport/parport_ax88796.c
@@ -280,7 +280,7 @@ static int parport_ax88796_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	dd = kzalloc(sizeof(struct ax_drvdata), GFP_KERNEL);
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
 	if (!dd)
 		return -ENOMEM;
 
-- 
2.7.4
