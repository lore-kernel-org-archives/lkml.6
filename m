Return-Path: <minhnpq16@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522405045; cv=none;
        d=google.com; s=arc-20160816;
        b=o9p7jWtxC/jzQcxn7ZAXQfjhjBeYoGWcYWJBnyW+CmFxWFG+hLyNmIfJPop2TgswI/
         quw4etR6jmQU7GoqpQYRib9Hf3Fggpto3thI9n9Erz+fbNbGrYRZWpF8OK4bWhW3vZyo
         1agC3PfuI8htIjzsOknSPDgLp4O+05ZtIoUmZUbCqfUursaCO2yvO7MoQfduDDrHSb7O
         3JE8DyI+iJ5ZjKEjs3hDW9+gcL5h35retF0RaOBiOoDmVF1wWNGD+TOew7SO1UKAwDy/
         RQk3cX576lig/2kUGRTAxUC5EFZXeD9HzRDAEP841rcPytccMXypvykf7nnToR4y1enn
         sicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=1uQrfsaOpG3iSFl2R23BM9AOO09al4bw4qVstBLpMS0=;
        b=zWN7L8uSj/FzGOS9XVsF9yso/eXjgGZ7k/FJc5jobMXci4Tl+puEjbUB7L4/7JuRJg
         JYWxErcSpt+QunD29ANEuCswKY7WB8h23M0K5QFko2AaE8IBeDCtoVmpPB/CGPLKXi/p
         1Lrhhup9OeC3d4+vXmtiaDtK2jJ+04kE4oLcuhHxjFgyQSTtGITJ4BWN3ml2YzHY5Pfs
         FW1oTLj1EoWXFl8wO8QH/0ABqKplRoFMlw+B2+UsYiI1RLp3SUwzwaaYRLiCX4FSR31G
         zkpnbijvg3KqNjEz0zD+nuT08gEpBlkFjrkMKb2w2JvEZiAoU4k/jXbNmsdTbzZQxSvl
         G+Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Me8ggwM4;
       spf=pass (google.com: domain of minhnpq16@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minhnpq16@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Me8ggwM4;
       spf=pass (google.com: domain of minhnpq16@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minhnpq16@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49mg4A9Zm/OWCF5lOugWCaudb7eXGK+WlXysgz3ymCjuztaSX0QhjUBcAZSXB/IOoPIZYqfwQ==
Date: Fri, 30 Mar 2018 12:17:23 +0200
From: Nguyen Phan Quang Minh <minhnpq16@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: fsl-dpaa2/ethsw: Remove unused variable irq
Message-ID: <20180330101723.GA10648@minhnpqrs-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596357393227856444?=
X-GMAIL-MSGID: =?utf-8?q?1596357393227856444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Local variable irq is not used. Remove it.

Signed-off-by: Nguyen Phan Quang Minh<minhnpq16@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c723a04bc3d6..a698498b8537 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -616,10 +616,8 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	struct fsl_mc_device_irq *irq;
 	int err;
 
-	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
 	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DPSW_IRQ_INDEX_IF, 0);
 	if (err)
-- 
2.15.1
