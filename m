Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36842206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fwCDqgLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36842206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeH2MeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:34:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55419 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeH2MeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:34:08 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so6515358itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=182bCAwLW7DxDTF1rR6Dspz4T83b2XPwfnwy25YwwGc=;
        b=fwCDqgLO2JkSD5MlAzg10pQ6kanKmlGTnMeJ5yuQtg9CPdqM2qhgm64uzRq+jqxBAF
         L5u+CFrp6JVRx3E4D5Ho+0+I9RV1FWp5W58KKSNewuWF29STOfVetiAhoTKD7ACZlrpK
         Ob9WnqB0xj6UB5qjCEdaDZueE8PAxRxlhzVMN93K2DM8MxNU7YfhYNOHYVrg3TC8j/Ga
         K3VwW1DODSaEgA8zflOfRo+UZVB6iOyqOgjAv1bXCIqagTZCB2vy3kALy5dYlmmHUVF3
         5Bwyps1sj3pt/VQhWOfPZqFOZLM4Bz7llZUOOEc2OJ8jlcyb4/8BFslOE/ZCuZtJK7wG
         G8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=182bCAwLW7DxDTF1rR6Dspz4T83b2XPwfnwy25YwwGc=;
        b=PuHFFrsPi0gNqawMvV8nRyzyGQuE4TvagHKE+KkPtmlPmYVdAXNAiJZvBPE1L4cGKZ
         vRFgFedH++z2Lp1+3a6Swn65V/4thwkaYg+qYZx8vhxyZAGpM/sO6NNWKz8jvo4NlNMz
         W2EsgRuTp/PhnqJBWcGKHp5izgiJp2wCTYXEOL9S9BlcpmEGyxIynAzn896bxmxw2sed
         MC7I4vtQW8wnCPEMeRn04Lf46cTh6P7usUbW6MuOhybhSQFaOloXUA3r6PbmP7TVfc6F
         nAgxwkKm0ede6XgS7XsCQz1p8qKqK3G9lVN8MYh+rvLlX91al9U/zP4JnyiN1jdRbjql
         8xBA==
X-Gm-Message-State: APzg51Bu/B5sq2Ieo2/pq9suh2ObL+HfUsWkBpB2wC/ENNjfxi+j+ngV
        GyJ+cKLrNc8NYD6phOnMR7SAehAYe5Q=
X-Google-Smtp-Source: ANB0VdYEWqmCEC25+PfOfRWpS2sFF6vXWXVslpAPW+juPhULlaTM3LSh10J54X/hIQKZIzCzK4fDqA==
X-Received: by 2002:a24:2206:: with SMTP id o6-v6mr4392026ito.112.1535531899436;
        Wed, 29 Aug 2018 01:38:19 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1926598ita.29.2018.08.29.01.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 01:38:19 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add helpers for chunk addresses
Date:   Wed, 29 Aug 2018 10:37:51 +0200
Message-Id: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement helpers to go from ppas to a chunk within a line and an
address within a chunk.

These helpers will be used on the patches adding trace support in pblk,
which will be sent in this window.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index be67bbfa3d0a..1bfbd3315598 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1034,6 +1034,37 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 	return ppa;
 }
 
+static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	int pos = pblk_ppa_to_pos(geo, p);
+
+	return &line->chks[pos];
+}
+
+static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	u64 caddr;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)&pblk->addrf;
+
+		caddr = (u64)p.g.pg << ppaf->pg_offset;
+		caddr |= (u64)p.g.pl << ppaf->pln_offset;
+		caddr |= (u64)p.g.sec << ppaf->sec_offset;
+	} else {
+		caddr = p.m.sec;
+	}
+
+	return caddr;
+}
+
 static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
-- 
2.7.4

