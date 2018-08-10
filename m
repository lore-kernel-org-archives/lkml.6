Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002BAC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7504223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCF12waU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7504223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeHJFub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:50:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46949 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeHJFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so3417052ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsSwmirGathrCpPVQ9oknIBXK8RezGkbjyqa9xhm+Xs=;
        b=iCF12waUDsYxD3WdIguBu6zk1FDlRL+s2Hg7lZIeqfjzsXZEEI3kvYqC7ooBLROTDj
         iV0UzyAtw4VWexvVtPYptLS2cOzvqVKxUJwMpHICopWZs/WXUW2LWTjrO8DjX22gJVTm
         AdHn65+mRMV4jTuOpEEuLqf9XLdKRA3FsozS0DFBrUMgiN6PSQdSdAgcgBbTt3aGEDHV
         DowomWf+fmRpM2EOnuNQhbEMgk94dbeN2QYflhP8i7TZIh/ryAPx+9TLNh3FMerNe3js
         Kq4zXPCv4oJ9xftTxF5eIqpVrHaLFNsqEulYGdAueavwhm7U9Turm2McBJia02czuovI
         UFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsSwmirGathrCpPVQ9oknIBXK8RezGkbjyqa9xhm+Xs=;
        b=lryPSafFba2qMl6go/7sUc8+1eejn08r6HIVJdDXi2e5uTD1wO0SOUt4azfdXUzrF0
         0sTBDkiSmuB4FKhX6JI0U/byXjrjNbo+QJgO3eGD9fS8x4oGdTyKjI2NrxN2ZKI+fK/q
         25z1zYcIrDfcmB0551D70Cv4QD57vrG1Ltiygmvac0e6Eu2YjXa5nNj1zew3pNs8Mt28
         GxWDC/5I0jijsECYvW3TfhG16Z1GzOTuELK3xaO5lqSbhobe8uKKsUT7xd5lJjmVO0fz
         Pch7BViYdPFwlb6t5d3zJqRgDB659tjhgBySTBWVqm48+z6P+Y839RUKyrdIpGZv2hgq
         hJLw==
X-Gm-Message-State: AOUpUlGLsiu1hakf50ksYKBM9blAJFlav96imcaRWJF9aQujKqmfV7gf
        uFXT+AaTBqkdM4BYIJfMr7E=
X-Google-Smtp-Source: AA+uWPzGf4xkmWxG2mBTIpFsVWxc2xD3eUSSJw3kyLMBWtX4w0Lg+l7Ud8FWbhB9VCuhl80pIwTYBg==
X-Received: by 2002:a17:902:7898:: with SMTP id q24-v6mr4302597pll.222.1533871285846;
        Thu, 09 Aug 2018 20:21:25 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/16] staging: gasket: core: fix line continuation indent in gasket_alloc_dev
Date:   Thu,  9 Aug 2018 20:20:58 -0700
Message-Id: <20180810032111.197743-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Previous cleanups missed a case of multi-line function call with line
continuation parameters not aligned per kernel style.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 37d14e30ffa21..3fb805204d700 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -231,8 +231,9 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
 	dev_info->devt =
 		MKDEV(driver_desc->major, driver_desc->minor +
 		      gasket_dev->dev_idx);
-	dev_info->device = device_create(internal_desc->class, parent,
-		dev_info->devt, gasket_dev, dev_info->name);
+	dev_info->device =
+		device_create(internal_desc->class, parent, dev_info->devt,
+			      gasket_dev, dev_info->name);
 
 	/* cdev has not yet been added; cdev_added is 0 */
 	dev_info->gasket_dev_ptr = gasket_dev;
-- 
2.18.0.597.ga71716f1ad-goog

