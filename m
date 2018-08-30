Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF54DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR7BZzaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeHaCj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34527 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so8571783ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0zmoBAJ0A3Gx+YDb/TCVvHPQO/4qNnwcFIHAZAkEU8=;
        b=OR7BZzafNnLLto3lJdy5xe5PU6VTD9B7TO9EpDT9MbX2KuobLTEXSyVChvIl6/AdZx
         f9JQcXOpaOjf+oWD9blFisRzzTpFhaYnMe3V1ooRFNpfWhc01m/DTmJ02tZnEjNAfv1M
         ua6120YRi4CxUF1an8OXoYaXHFOUEEbzBDlwZngljRzq7u7NJCG8VU9+WTGyBI9kfV10
         JwWex8O38lCBkqlzw5nJlhKqvdHKTzxKg8Y7s1oZU4MYEUhOdbwgA+IGEzkFdPjRlIlh
         GEV8QUkScJSBTsL7ZY28+vYkFpW861hfMETQGovW3rmACm4IxuETjw5+md4qrJ0jq9dI
         eR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q0zmoBAJ0A3Gx+YDb/TCVvHPQO/4qNnwcFIHAZAkEU8=;
        b=RdUj7kt7rnnnEp1GMUCxIK8ZeDh7oioAPEN2o+qfbAOiRLqzvvP+E2FPGNAJYYD0kY
         IUpg8qRH26jBHNn0ZpIez3VsqRG5RuIHS9Is36nKs5/qQEiWTyAK2nvlXe+8nGNBEuag
         PRJKlOkbJSukikYbFot6E42m9J1dXA0eR0YXyyuH+Tm/0qJbv10m90wljlD5AQg212mX
         MsbGBv5ai0vzwxp3KVZPLnOaK8rEkjtCORFiOr41EMQpINWgyS2xQO/wVPKLFLQJia87
         UTHduznf5Ah6P+jxzz4c72D9XggGDYJL/cLaPYE0YGTW6kCA8kAlzavuhYdAZPCVecwH
         Nqfg==
X-Gm-Message-State: APzg51Dm3Ld8YkCzr1sooCb/1U3OqdqolY04uEDAc2WwmrOnr3HVOsKl
        3CbKNOzGP+9690SbeWx6QS1v65Nkl6s=
X-Google-Smtp-Source: ANB0VdbD9ZpVlkXyZxoku72FNM7ItliBBrThN6knbKLOnzkTTMArgMtgmzHhYxnf2Welkh3cKHucOg==
X-Received: by 2002:a2e:2bd3:: with SMTP id r80-v6mr8924447ljr.57.1535668532707;
        Thu, 30 Aug 2018 15:35:32 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:32 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Stephane Viau <sviau@codeaurora.org>
Subject: [PATCH 08/23] drm: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:14 +0300
Message-Id: <20180830223429.30051-9-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Stephane Viau <sviau@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c | 4 ++--
 drivers/gpu/drm/msm/disp/mdp_format.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
index f93d5681267c..9e0b3730536d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
@@ -261,7 +261,7 @@ int mdp5_ctl_set_cursor(struct mdp5_ctl *ctl, struct mdp5_pipeline *pipeline,
 	u32 blend_cfg;
 	struct mdp5_hw_mixer *mixer = pipeline->mixer;
 
-	if (unlikely(WARN_ON(!mixer))) {
+	if (WARN_ON(!mixer)) {
 		dev_err(ctl_mgr->dev->dev, "CTL %d cannot find LM",
 			ctl->id);
 		return -EINVAL;
@@ -703,7 +703,7 @@ struct mdp5_ctl_manager *mdp5_ctlm_init(struct drm_device *dev,
 		goto fail;
 	}
 
-	if (unlikely(WARN_ON(ctl_cfg->count > MAX_CTL))) {
+	if (WARN_ON(ctl_cfg->count > MAX_CTL)) {
 		dev_err(dev->dev, "Increase static pool size to at least %d\n",
 				ctl_cfg->count);
 		ret = -ENOSPC;
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 005760bee708..005f24dcfbdd 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -185,7 +185,7 @@ const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,
 
 struct csc_cfg *mdp_get_default_csc_cfg(enum csc_type type)
 {
-	if (unlikely(WARN_ON(type >= CSC_MAX)))
+	if (WARN_ON(type >= CSC_MAX))
 		return NULL;
 
 	return &csc_convert[type];
-- 
2.17.1

