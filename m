Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA18B2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA18B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeIFAJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38208 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeIFAJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so15934019oix.5;
        Wed, 05 Sep 2018 12:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cs4PYL4EAbXhqa1/+qufL34SyOAY8TU08a3FgFNoxjw=;
        b=NlR3W54sTK8/O9n3dOhM3yPvMPjexCEXfeoNeqRVI5HY+48hUXGG7fwlC9V8YCfJkE
         IjgAxQMUZ34bRe6NERQoxkoeD+ZoEbOcBR0c++BWd4Hp6IrGj7n/VaANL+d0LsydZUmj
         4+wr1mV9/qM4ZYHSu6Fb1wo2zB8W/brapm5fBOLUib5uLIeswy2y17cwf/7LjN7rt1sp
         jRkbaG7t54ZzHmGvMV9DkMGCC/j9N4GZwUdfq42coo2mHeJB3aSo6tl5kKE4vIgZh/2w
         kP4bxyr7PpXxOyPAFt6dhmjB+rPgFyeOGpBp3GyM8cAyMoSORCNF91+U8f+JyAeOCpkc
         XYzw==
X-Gm-Message-State: APzg51DUurTojTThhXdAOkxy1lIoOGTT7wCFAxKgQ/wBOKP7+xigVcLe
        95cTeBqLzf3gmdEVp6AphImvT7E=
X-Google-Smtp-Source: ANB0VdY5gE1cyv7RJu0K5E+9crs4Jzg5R50ysAb5v5WPEYsUpObhubDdQz6uC1bDUhkzwoq0fUe4ew==
X-Received: by 2002:aca:b904:: with SMTP id j4-v6mr33255174oif.89.1536176284356;
        Wed, 05 Sep 2018 12:38:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:38:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Timur Tabi <timur@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 21/21] fbdev: fsl-diu: get cpu node with of_get_cpu_node
Date:   Wed,  5 Sep 2018 14:37:38 -0500
Message-Id: <20180905193738.19325-22-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Cc: Timur Tabi <timur@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index bc9eb8afc313..332a56b6811f 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1925,7 +1925,7 @@ static int __init fsl_diu_init(void)
 	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");

 #ifdef CONFIG_NOT_COHERENT_CACHE
-	np = of_find_node_by_type(NULL, "cpu");
+	np = of_get_cpu_node(0, NULL);
 	if (!np) {
 		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
 		return -ENODEV;
--
2.17.1
