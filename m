Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519884008; cv=none;
        d=google.com; s=arc-20160816;
        b=xIBtksCSTHa1yE7xXcuhKS2aeW6yenvVjXJs8TEQirKOBrC7mI8l+yfJOczmwrtE1B
         AaoOwQPWlu/rS3Jb7A+VCs+tWhUfBVKV69qNaNdn5oT+RbQ1bFzgqKkrT4u8a+Pzhx6r
         i2GnmMFQ4Or4HeWFqEol3wDH9/1EqU9KUl0C75IvtibJslnTj8UA/DtpTM6x81kZoJU0
         hJ+5Ql2zL5e8ab3yVcnAjNLnAtmhCsTpOompw1sQBhh5/dncOSMLZ4j6fKy0cBpw9Jdp
         gbX62aJY/F7K4/c+jopNVxH3GLFNu4kZlE9Nc1CrB/UlHTqxW44m7zLO9BedI5+WvjTE
         KhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=uHZ1UVH8Es+jklasoc2wXBIuW61dI5APZzRYB2GXwK8=;
        b=0z2FePmMbHTqubDeVRmSgIB8l1hjWfZ5MlsSE64++yqQcVLZFEWT8VrDFJInyylVYM
         M9rLVq5WLQmi+8OBEwxKmH7qU+gMSfYO1v4+9lkOioRPYaW4rm0Us/dITOisX1HY/RIY
         jyh0sV/HPOLYpTxkxE68cbrGyhgqqBmxsjbUZI7TvEgpDojr0TDj8juSL2hiZPA8D5cH
         bawOfcRAp+B3I6CTZEMm8+dfQTcxnP6hIUtAK6Trr6vYeV/dqazDpx2UoPa3nPatX5Wz
         mql+QWc+DszerNTTpCPVCk1oOKS+1B10wHlX578/05kaqHT5VVUW+GRWhK/GnJRR2m5W
         FytA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AzGBN2kw;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AzGBN2kw;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuMGX6dmo8RxH1Rsyf0b3CeJAd2KhNP3IUWinvsJhsGoTy/8K3wC+yPpGyS/xwSoV2FdhwTfg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Free memory obtained by kzalloc
Date: Thu,  1 Mar 2018 11:29:29 +0530
Message-Id: <55b8ad8c5e7ad38403c34a5d30d49f8aaba37156.1519883835.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593713894002392634?=
X-GMAIL-MSGID: =?utf-8?q?1593713894002392634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Here kfree() is taking NULL. So moving 'dev = NULL' after kfree().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef61833..ccb64a0 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1170,9 +1170,9 @@ static int subsys_register(struct bus_type *subsys,
 
 err_dev_reg:
 	put_device(dev);
-	dev = NULL;
 err_name:
 	kfree(dev);
+	dev = NULL;
 err_dev:
 	bus_unregister(subsys);
 	return err;
-- 
1.9.1
