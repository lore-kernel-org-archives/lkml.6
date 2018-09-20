Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93191C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D982147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6PF2w0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D982147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeIUELJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:11:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:11:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207-v6so1102854wme.5;
        Thu, 20 Sep 2018 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xz1ojDlbk5c1+6N64TtVDkYUYOmlExGBv1LSVHIi5Nw=;
        b=m6PF2w0uwdwEfvx1RzuFWSwsDR/eXiia7AwQLJBRqr3RDUYBNXBVVpln7dszSV64L9
         7JfLtnZGMPceL7lXytm5YZKAZmHRCLQlrzhK9vMU49BFRHjhc0BeTS4sBFIfwADT1Uxz
         BZysVSDwlat7eyBFXMHbVH1Sd2XoLNjcpY3Y9PdiMymwluEs4qOSp1IJviijo8BTldNl
         K1aHMugny0b9u+VA7OQtPcJAHy5/sGLfA7hQ4YJmfZRt09TJObIs87iK4XBeYOZtN2u8
         afDx0NbblHn/3iLnYPYn1kpXUVKAFELT+t+pGbGcjyZQ8LgYsJalB8f2KaWgNdwSSOMi
         jADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xz1ojDlbk5c1+6N64TtVDkYUYOmlExGBv1LSVHIi5Nw=;
        b=FIPWuiKoWFtJnTPmHNuj3wwQnqeQOLK0j3YtnR93LadCW2gLvI4KPNEGsgjEw/8nm1
         dSFOZwzez+6qyz8iQbryCFBt9riSx98SLJsn/2+Q8QI6WU6AmodmN0knOO/hAR4MKakk
         juIM7o0ePGds6akjTnGmg2Z2/IEQGLGXCv/ARJLJu6sfWFvO1oVr4h4P6L/TimJG0Kir
         46kVkV+snQT7v5XM7BHSMzTrumyyJ2tXstfDa35hIVGVGAv6HzCmNL+k88RrFwsxLJD7
         EhzE59Py1dYopP/JpXmZDXvmqRzD7e7eV67CzhIyQlK/PHb7U4RqRcWRuonRF/OrX3Xx
         2D0g==
X-Gm-Message-State: APzg51CbPTRE5N1OqH7g9mzuAiTm3BuadiLlDiddY4b5XCC7n7jtlh1d
        XaREvC4ptfVr3QOHhTpij5Hd0h9M+ARjow==
X-Google-Smtp-Source: ANB0Vdb/bmG4Q0Phg5RjtNOV94eRBnGzpr1rQF+rN9CltZm6gP+A7kHWhDqRGL8NjOf1ww4MQ8F83Q==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr4772493wmr.75.1537482325691;
        Thu, 20 Sep 2018 15:25:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2170698wmf.34.2018.09.20.15.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:25:24 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rasesh Mody <rasesh.mody@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] bna: Remove unnecessary self assignment
Date:   Thu, 20 Sep 2018 15:24:59 -0700
Message-Id: <20180920222458.9475-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/net/ethernet/brocade/bna/bna_enet.c:1800:9: warning: explicitly
assigning value of variable of type 'int' to itself [-Wself-assign]
        for (i = i; i < (bna->ioceth.attr.num_ucmac * 2); i++)
             ~ ^ ~
drivers/net/ethernet/brocade/bna/bna_enet.c:1835:9: warning: explicitly
assigning value of variable of type 'int' to itself [-Wself-assign]
        for (i = i; i < (bna->ioceth.attr.num_mcmac * 2); i++)
             ~ ^ ~
2 warnings generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/110
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bna_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bna_enet.c b/drivers/net/ethernet/brocade/bna/bna_enet.c
index bba81735ce87..6d2d4527357c 100644
--- a/drivers/net/ethernet/brocade/bna/bna_enet.c
+++ b/drivers/net/ethernet/brocade/bna/bna_enet.c
@@ -1797,7 +1797,7 @@ bna_ucam_mod_init(struct bna_ucam_mod *ucam_mod, struct bna *bna,
 
 	/* A separate queue to allow synchronous setting of a list of MACs */
 	INIT_LIST_HEAD(&ucam_mod->del_q);
-	for (i = i; i < (bna->ioceth.attr.num_ucmac * 2); i++)
+	for (; i < (bna->ioceth.attr.num_ucmac * 2); i++)
 		list_add_tail(&ucam_mod->ucmac[i].qe, &ucam_mod->del_q);
 
 	ucam_mod->bna = bna;
@@ -1832,7 +1832,7 @@ bna_mcam_mod_init(struct bna_mcam_mod *mcam_mod, struct bna *bna,
 
 	/* A separate queue to allow synchronous setting of a list of MACs */
 	INIT_LIST_HEAD(&mcam_mod->del_q);
-	for (i = i; i < (bna->ioceth.attr.num_mcmac * 2); i++)
+	for (; i < (bna->ioceth.attr.num_mcmac * 2); i++)
 		list_add_tail(&mcam_mod->mcmac[i].qe, &mcam_mod->del_q);
 
 	mcam_mod->bna = bna;
-- 
2.19.0

