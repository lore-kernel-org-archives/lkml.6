Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE6C9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AE208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG62z0Ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6AE208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeFLMm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:42:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40046 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeFLMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:42:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so35777340lfc.7;
        Tue, 12 Jun 2018 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oViq59vPotECR3ZPUf9zXySicgJKCAvGP6TUhvcq0H4=;
        b=mG62z0Ks3KOrF39szhZSgLll9s802iexXqxcGOFodfGTuHV89GEdaK2O2s6KtDa+4O
         S/k7uABK36jQCHpeRTt8/llmNfGyjzES8McpohmUAF7NNsfnW46xJofZEds+gZwqwcLn
         havFUtd1sS1/5ccvsO+HMdZpykfHbm0olvdEoBZyWw+ZtJm0NixUokivtXlet3Lpo1AG
         ziWg4MPOhF2OWd/Y66YLgwg0+2ixEyV6ujW+knh/+Lmh+avXNUvlYG+x5Ac2TB1HGDy3
         OsbIwp/hkMs6z/sHkpZgQ0yamfTm1tp8s1zJJ+3+2NBjsYGTfHvKYqbbKZ25ub1BcvKD
         M+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oViq59vPotECR3ZPUf9zXySicgJKCAvGP6TUhvcq0H4=;
        b=LNVf9aexmiqX72gZHkCYOcyXxBptEel0Dt2pac7jFyZHMZQeEgQfNB2mlkV0keHoZ3
         1YzEMnzT8skaVUsUFIeo0Gbg5exA3Qu9aQdum1ElRT05IpGzRxdA5reQfntrUCrFMfQy
         BhkMf+p8AWNH4UzkYs7PLunfJDOtceV9SLx7+dp1d04owIcVWpEsAtkFihxHmWMb93HJ
         /i+tGWOVTB5hKJk2emQCtPmwH4IrGF6MulfcBPVhlOvp7z3ack35WeRh1ldgylal/YUj
         LH1C06bJ7d8LqpiYH3XbYaYZ9jCUUzeSw0gSfBsXk8y1xe07dZjesjQjgvdtDdzh+Nfy
         TfqQ==
X-Gm-Message-State: APt69E0SSWXGXtQJai8Nf4uASLpzb1Gqhb24JH6fDeQ2QreSeRaYf181
        SG52ErfpzsehsFMi92d6zag=
X-Google-Smtp-Source: ADUXVKLdXfLxFmAKoKtmy8Lxrw1wYfc2iMIpX/Ky0K7Tvi3Ou5D4ZblOSqucDe/i8IMDzf9nDYShyA==
X-Received: by 2002:a19:7b0c:: with SMTP id w12-v6mr153599lfc.22.1528807373631;
        Tue, 12 Jun 2018 05:42:53 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j7-v6sm19198ljg.48.2018.06.12.05.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:42:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@xi.terra>)
        id 1fSid4-0001eu-Jr; Tue, 12 Jun 2018 14:42:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] soc: qcom: rmtfs-mem: fix memleak in probe error paths
Date:   Tue, 12 Jun 2018 14:41:41 +0200
Message-Id: <20180612124141.6307-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to set the mem device release callback before calling
put_device() in a couple of probe error paths so that the containing
object also gets freed.

Fixes: d1de6d6c639b ("soc: qcom: Remote filesystem memory driver")
Cc: stable <stable@vger.kernel.org>     # 4.15
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index c8999e38b005..8a3678c2e83c 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -184,6 +184,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	device_initialize(&rmtfs_mem->dev);
 	rmtfs_mem->dev.parent = &pdev->dev;
 	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
+	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
 
 	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
 					rmtfs_mem->size, MEMREMAP_WC);
@@ -206,8 +207,6 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
-	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
-
 	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
-- 
2.17.1

