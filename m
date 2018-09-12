Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9ED204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1PqOoAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9ED204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeILO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37572 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeILO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so1266774edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jx4ZTRxUlsnlRS61zHUJKPUod3bZiEIHV2ciGsOaGK4=;
        b=I1PqOoAxjwuP4DEt5rN9fBRHJvjzx2+TUq/Abj8mJLl579ej1lwaaDoB5Wgv6yqvZc
         +rzhi/A/c92D/pRt/zfvr3Pux1vVNf7lki471t0o1qdvYJHPmMO1wb0Or81olGmkDgwl
         OO8UH7oVBgihmq7eZhc+Mdf83Dvr+wP+SScfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jx4ZTRxUlsnlRS61zHUJKPUod3bZiEIHV2ciGsOaGK4=;
        b=nNlbQJ5ILV09Sah4vDFiv8AMOIpCn0nbO+l6VOha6tSbfAT8dysB0QDgUAJJqlNpCW
         FY5Kpccg9Wm0/h+1p6weedSSP3zIwkOc1xXx2Oygt0Z7y69ROjDVUhZlnbyO347Eritp
         WlyD2585yTl8lGQJ7zbLojQJMpQfxsLCfcP7qxFs4TQNHh5uaqq/6Ej+grGnN9XVvlbF
         ypo7VyRHRU0hbPQgitYqHRbkPasKIMLX9sKmwssT1L9WXMO86TB4h9THynRQ6O6E71aF
         hxz+bzcwN9LL0Pa7ZGNEsaW64rj7PQGotunHmgtdTQqjtpChQKczCBfxFNPT78kKvnhR
         eGQg==
X-Gm-Message-State: APzg51AgYg4H8Aql9Gp8V7kFWtY1MGyarDYStwvE7Y9OWXPeluu1lEzH
        q2LyirB/E+9Qn3Bi3eseDNjUicXuGHY=
X-Google-Smtp-Source: ANB0Vdb1D3MiTKC7x6ECW4/ZDv2vpIfELis/ma+ddayrAET9wM5XItxSemQ671NMBLNRWyCPnLgJWw==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr1858837edd.120.1536746048171;
        Wed, 12 Sep 2018 02:54:08 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id m35-v6sm345268ede.14.2018.09.12.02.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:07 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 06/16] MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
Date:   Wed, 12 Sep 2018 15:22:51 +0530
Message-Id: <1a671f3acaa95e53371243f66c93d7508bf7f529.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an entry for the TSENS drivers and mark them as maintained

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..df6c5ce18b03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12076,6 +12076,13 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/qcom_iommu.c
 
+QUALCOMM TSENS THERMAL DRIVER
+M:	Amit Kucheria <amit.kucheria@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/qcom/
+
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

