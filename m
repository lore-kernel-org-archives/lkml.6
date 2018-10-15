Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5005C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B9E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWZ4DlN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJOMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44721 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeJOMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so8657157pli.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7NPs3Jj5cvSoWv1E6myQiXuP13inIVj+GNvMFdSq4M=;
        b=CWZ4DlN945LK96hMu899d+uw3byz5jj7TU4ZYUE+9gpNNpcUA17SyCYdaecenKRxDm
         m/DWNk5OiK3XOkqZKlJRCH4kOCyeFunAxjzhY4hIQ263EgjrRlmaNn89CUbFk4OGfv7V
         dui05XBBtcP9QuQGcnefsEDkwivAe4PFaaOtynST1C5BtMGQCIhlAMue4zWnNyt/1rm+
         8L4UdVhiL4nsu2NBJExiBKpvc4/APLLrcfHUt4usjYkNU8SellDi0k79n/SsiB5h9Qkt
         ygFkbyTJB/DqUL6gQ2rkx8CtNNBhrLYYY3w4jZdsTtyfYtQiWiKFUYN+C3f8yUcBuW0j
         6QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7NPs3Jj5cvSoWv1E6myQiXuP13inIVj+GNvMFdSq4M=;
        b=railikD/Ox3hqKAvYIFfeU/NUJ2Y6xbaYa9EHxfzje7bOBWVidRw4WsavTNssYi+S+
         6csc97EOERAj4GPVtvLAK7zdeHJJyXeXhRmHJNn/Gcw4bb5JZNNHMVEuyW4ttGhZ13IG
         05nc8awqfoQ8n/U7uKUFev0cZZo9hONFXmfdJDSFVAaCbkRBktGTq11atpRt+5XRm6UL
         +exHGmOuKRkk6CngQRkCl/pVMP8DaSthPgw1CPGYXaDirvIrqKXXGBmZEYjgqj/y5ngf
         GXkjgnTulmYyTunUpEDbcCS2ZX5ONK1cG1jdFC2ISf2VqpOBrrDZHBb0f4bhi5BHIRQI
         /3YQ==
X-Gm-Message-State: ABuFfojBXnh+Sp3V6T0TqArZcx+x3ODBSePmXURkM4DfmLj2JOGMB9hO
        7wvZI0BgGrWuq9XlyIbApRM=
X-Google-Smtp-Source: ACcGV62tvwT4SeFZFxLJm0aV1ZCTEbv2tL9ZPEYqPNLBMhdQhv4Dd4W2uwYUysqC3uq3Y7hkOEod4g==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10-v6mr15698774plb.294.1539579603188;
        Sun, 14 Oct 2018 22:00:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.22.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/11] staging: gasket: apex: fix sysfs_show
Date:   Sun, 14 Oct 2018 21:59:25 -0700
Message-Id: <20181015045927.156790-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

sysfs_show was incorrectly extracting the sysfs_attribute_type from the
gasket_sysfs_attribute. This prevented dispatch from working properly.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 6dca3b177863c..3c7a13a4798ef 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -526,7 +526,7 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
 		return -ENODEV;
 	}
 
-	type = (enum sysfs_attribute_type)gasket_sysfs_get_attr(device, attr);
+	type = (enum sysfs_attribute_type)gasket_attr->data.attr_type;
 	switch (type) {
 	case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-- 
2.19.0.605.g01d371f741-goog

