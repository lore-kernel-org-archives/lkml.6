Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC6CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DB42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FytjVv8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DB42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeHaRm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:42:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35783 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHaRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so9075152edq.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeVoWunn1GoX5AS4UMZwj6764iD7cwd2XPgPSEMctSs=;
        b=FytjVv8DJ2/kNdFHQIIvM/x6XvpuE9KtLcjiqFoarJDntjwDoDLPznrJtjsM3UFot/
         OBIbKjZc751IxVp4N0meQ4ciZowyKygu9KIJN/lXMGaOQ2BBt83JtqA7VWP7hmgI/6kf
         65Tsz5sBIUL4lG8Y6abPMsnpVMllzzbSTPoHIj9cnbTIXw5VRXcwGWTOt8CFmVsQApSb
         rQh8epwIuKnd2Ier33buTNN91F1uG6LePQX3043XoyO+ndJgQhhJiMu09xsDxaaGx0hw
         MR7dFMsw5qBTQn0R242bnXp1YfbYIWA0w8z28F8WfuuploOtlufwSFIWTdfasYb3i2/c
         FxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeVoWunn1GoX5AS4UMZwj6764iD7cwd2XPgPSEMctSs=;
        b=RzAJ8n+rmtxphYkRsebUf1TaBmLgTqE97xTKPtGSAcYRZm940TFGvMW/mGHNHZW5NB
         uZiiXuNs6D+EuOivAj1agtSygQYLU/nGCq3bZhk/t9EczbsCxmh5/fRL8/Dkw/8p9EAp
         1EymuI5UvX7lyzM1oUb1ePcmnp8M1ZigCQkfttKwDCOHdrsrjhm+XFGrtuQTsiSB3C1x
         byjKTT6mWu/xkv0A3ME2Dc8BWixnu2AdFewCismIHUs6V2zz6VWejdWEAFWMiHWdG+pC
         oQOua+TIBtPuRZD6Vl1oLrW1e4eEJjf3pT594br4BIxRspJZiXKLzfmoxq5xhZYkLKmu
         eCow==
X-Gm-Message-State: APzg51CcWA/UawzwRvqNJMPDJTMA4WNKYELhcaYU/k9U7/otgLr19AyI
        1uNymkjRpc3QTNCr7x1EkEwOuQ==
X-Google-Smtp-Source: ANB0VdY/iMlgkPBYqw5qfE3O+D0LalkYRAvpcwsdf5qMjykvritjq+ywgWWRefYeVMm8p1bZUUFWWw==
X-Received: by 2002:a05:6402:1251:: with SMTP id l17mr16177614edw.42.1535722488277;
        Fri, 31 Aug 2018 06:34:48 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i19-v6sm1937851edg.64.2018.08.31.06.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 06:34:47 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: add helper for printing chunk state
Date:   Fri, 31 Aug 2018 15:34:36 +0200
Message-Id: <1535722477-31288-4-git-send-email-javier@cnexlabs.com>
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

Implement pblk helper for printing chunk state.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bc852bb9e3f0..5c35dcd57395 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1239,6 +1239,15 @@ static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
 	return !(nr_secs % pblk->min_write_pgs);
 }
 
+static inline void print_chunk(struct pblk *pblk, struct nvm_chk_meta *chk,
+			       char *msg, int error)
+{
+	pblk_err(pblk, "chunk: (%s: %x) s:%d,t:%d,wi:%d,slba:%llu,cnlb:%llu,wp:%llu\n",
+			msg, error,
+			chk->state, chk->type, chk->wi,
+			chk->slba, chk->cnlb, chk->wp);
+}
+
 #ifdef CONFIG_NVM_PBLK_DEBUG
 static inline void print_ppa(struct pblk *pblk, struct ppa_addr *p,
 			     char *msg, int error)
-- 
2.7.4

