Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CAC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE4206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqOtdihF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBE4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeI2MRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38240 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeI2MRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so5897406pgr.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ipu0OKiVTAGWTLE4fg/nM2ymSy+8y5EVSd0lvjhlhp8=;
        b=YqOtdihFkLN2j80Ggp47W6x2EUCNJKJd/quxmLhMX+oR42FFg7B4fxe0615eAXeWi5
         HhSIDrOdGDmTKgjwroJ+6xo2GueD3HAG/8OgW8BJSQGodsehaqMRWy5Uy4QooYl74Qaq
         7D2+jDJPkJWbqk/6HBNOk3C7tAmrgbG4EAYUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ipu0OKiVTAGWTLE4fg/nM2ymSy+8y5EVSd0lvjhlhp8=;
        b=jXsyRibr4Cpm0ely4hCLZmO/TauCxb/ycD775woOo1K4ko01KT6nFzvfz9wJ2FOtP6
         R7DVbl8YPfEuqQovV988qP+O/MBtbSHbGHi5AmHMfhVxWMg/9WekwcBSDWu0Vc3spHaF
         1r+Y8ggme4c/pMx/RaogBuSn4ZIIaulVml41xsuHB0V7mR+VNmlAnfFRnDp2v4eVv+p7
         rZJi3uV8Oiz3T/I3FX4UQVpOrJ/YhT9H2IZtr0/FoMTyyMU36Ts+jZP3u1jY5G5+g1Mm
         px/Quv1mFf4FcAdhSZwuDygAiqioG5XcH3I1iBB4kC3MhjYCaONqz2OqQQHssFZ/iSb9
         d2/Q==
X-Gm-Message-State: ABuFfoh0a4waDbaMZsiDxxKqsDGM8qcYC0s8vxq8lxVSdOo/6yiSiV95
        XS3WV8orAYGxlugO/K0GirxRZg==
X-Google-Smtp-Source: ACcGV63pv1dqyvWBPMPKI3lGYcudnq3PmhlPxU230Vdmb3ZFbYCG8OfXSE7wQFHgfHDg4/27lJdchQ==
X-Received: by 2002:a63:745e:: with SMTP id e30-v6mr1601662pgn.446.1538200209055;
        Fri, 28 Sep 2018 22:50:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dmaengine: sprd: Fix the last link-list configuration
Date:   Sat, 29 Sep 2018 13:49:01 +0800
Message-Id: <9735715d9e9fb4e6fbbe19643db1ce80ef51d37a.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

We will pass sglen as 0 configure the last link-list configuration
when filling the descriptor, which will cause the incorrect link-list
configuration. Thus we should check if the sglen is 0 to configure
the correct link-list configuration.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 4f3587b..e6a74dc 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -697,7 +697,8 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		hw->cfg |= SPRD_DMA_LINKLIST_EN;
 
 		/* link-list index */
-		temp = (sg_index + 1) % sglen;
+		temp = sglen ? (sg_index + 1) % sglen : 0;
+
 		/* Next link-list configuration's physical address offset */
 		temp = temp * sizeof(*hw) + SPRD_DMA_CHN_SRC_ADDR;
 		/*
-- 
1.7.9.5

