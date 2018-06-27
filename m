Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D10C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3102F24491
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnltAuit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102F24491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeF0Pe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:34:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41856 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934862AbeF0P2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so2468380wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uzFPQjolv+jdPi2Rzia1jtwxKrkKgXp+JYTymg81g5w=;
        b=JnltAuitirgIaqipM2se+1wW3dps/iJYTdkVv4qb0qWUxT1EndUm8AAoV8nbADoGrC
         bKDbksHWCiJEGSQUbGSHGmVmlZ8ZZcO9775XaQjghcKXNOO2gR0E/DdTs+NDLSYGR2YV
         b46pwB+RAWziqSia40I4PLO3/EPBy1uRl7bnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uzFPQjolv+jdPi2Rzia1jtwxKrkKgXp+JYTymg81g5w=;
        b=I3laGMfNWm8iS+R9OliYC94YH/hvF8zS3HXpZMZRwfIavJXrcwZNeJ0iVEEfDM3w7x
         YxAMpcapopg6l570mwnNIqcd+a7lKeakPSIDIxOvEMjp18aRBNPqqp7tCATk5P0/XNw+
         w1XBuv0wvI/iEGrNCj1nenUQUwgCJLtjdqV4p5Ya2tPm88E8VoKvvygsyBVjmUNql3U/
         6TT1Qs9Xv5wXluZvqfW/twDKr+/DDYXKYt1hNNE1WPCpzTwsDp2Y9x+JQ4wIRtft1zfN
         7uB78bKn4pb4XjJsSHxtpLaoXNVXQBCyACdHulI0KCmid/dKTcQ7bnaa9c+XQeY6bb50
         wVQg==
X-Gm-Message-State: APt69E3FngW0L4ZvPF9d2zFMUoMPqDl1R2V+UtTDqlrShzYKoYKkOWUV
        riwwrgpYvITfYkEUFYAcAJwl1A==
X-Google-Smtp-Source: AAOMgpeNOiHc4AZUt2fNMauE7gOfFG2Eg1PdsUBak+1skIpQe6vOwoYu1ciXSl9z1RH366bBhAbN9w==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr5854279wrg.20.1530113289340;
        Wed, 27 Jun 2018 08:28:09 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:08 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 10/27] venus: hfi_venus: add suspend functionality for Venus 4xx
Date:   Wed, 27 Jun 2018 18:27:08 +0300
Message-Id: <20180627152725.9783-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds suspend (power collapse) functionality by reusing
the suspend function for Venus 3xx and also enables idle indicator
property for Venus 4xx (where it is disabled by default).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 7a83e967a8ea..9366dae16b0a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -879,6 +879,14 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
+	/*
+	 * Idle indicator is disabled by default on some 4xx firmware versions,
+	 * enable it explicitly in order to make suspend functional by checking
+	 * WFI (wait-for-interrupt) bit.
+	 */
+	if (IS_V4(hdev->core))
+		venus_sys_idle_indicator = true;
+
 	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
 	if (ret)
 		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
@@ -1533,7 +1541,8 @@ static int venus_suspend_3xx(struct venus_core *core)
 
 static int venus_suspend(struct venus_core *core)
 {
-	if (core->res->hfi_version == HFI_VERSION_3XX)
+	if (core->res->hfi_version == HFI_VERSION_3XX ||
+	    core->res->hfi_version == HFI_VERSION_4XX)
 		return venus_suspend_3xx(core);
 
 	return venus_suspend_1xx(core);
-- 
2.14.1

