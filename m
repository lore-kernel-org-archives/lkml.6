Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C6FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FUMU9fdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeHaRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:42:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40770 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeHaRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so4478834edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tWNKICi8xEYyitKBHU+AqktEA0d1iN4FXEMVBa5bqs=;
        b=FUMU9fdGnxex4ds3UKNsyBmMUPog51+HBD42jmBuI49q4TTR4j4ydqsv/johisI1yK
         cDoYlJqzdoSSxRVILJ2vDgop8IuLAxhwPGkq6hqf/7ZoMe0NzL4yXXZLkHmiccAIx9SN
         NbINaEtNetE+SGMUmPbh0rTiFUW45EqDU+p0PKj+kueMhYU1/+Fxwy66h/sKappSJfil
         CatXQ/CeVmvwNgFpPuae7j6jdVeuvF2oYN3qW4yuJKlWjPkTmMv8mJJjDz0yl0y0uQvz
         ZWF0vafo4e5lkEF2tgpKKpVmuRvmlUnQtNw1joE+lawyhnErc0FqUZzQqvk9EGRf1LqP
         RsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tWNKICi8xEYyitKBHU+AqktEA0d1iN4FXEMVBa5bqs=;
        b=WMWAMqJ0tLDuwMshF5kQ+zBvt4tZ/nkFRnh8ESo9Mz+kx5VOoHxL1UW5Yp3CphNu5G
         TczxtM2WjONNq5oQO2w+/Pb4Ch+8CtmE2UsWnbDPaVHMlvHtUX5iQoPz5RDDFtrHXfZB
         rh2NFq2sJPD4VgM0NalG9Zztv0Z7NactzjUMt1jks/Dzef4hXStbDOep3dfH+2JeOgQn
         NZ8Af46ljB0vIkTh6qdpdVXFqFpXHRH5w9zikSP7QrBYkpBWCppNtlbwCqLBYTJG/30J
         yOrciohb37uCzBnAIO5nmb2OAteLnYdmN7+PxCc6j+InMqUnDH6ADtT0rIcXOhBvNUOF
         YPhw==
X-Gm-Message-State: APzg51CXT7n2AYlzmqzHj4ymip3ZDmsvL0vZZQJBgHbf88RNnwg/Kz9H
        NZXBvNX/IL9eAYIfCxSZWgocVQ==
X-Google-Smtp-Source: ANB0VdZLaQJAOYYvwqSVqtWlpP+NA9WT4W2LZd0b2rkkrecNsXbycn0/JaXxvsPCIm6vAg+Ly//66w==
X-Received: by 2002:a50:b158:: with SMTP id l24-v6mr18178848edd.31.1535722487455;
        Fri, 31 Aug 2018 06:34:47 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i19-v6sm1937851edg.64.2018.08.31.06.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 06:34:47 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: assign block address before slba
Date:   Fri, 31 Aug 2018 15:34:35 +0200
Message-Id: <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 1.2, the chunk slba is set to the physical representation of the
block. Thus, assigning the block to the ppa must occur before the slba
is assign.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index e9f14c67f4f3..efb976a863d2 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -945,6 +945,8 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
 			}
 		}
 
+		ppa.g.blk = blk;
+
 		meta->wp = 0;
 		meta->type = NVM_CHK_TP_W_SEQ;
 		meta->wi = 0;
@@ -952,7 +954,6 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
 		meta->cnlb = dev->geo.clba;
 
 		if (blktype == NVM_BLK_T_FREE) {
-			ppa.a.blk = blk;
 			ret = nvm_bb_chunk_scan(dev, ppa, meta);
 			if (ret)
 				return ret;
-- 
2.7.4

