Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EDD2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPiWS2MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfAIIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:46:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAIIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:46:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so7195458wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JVy9rLJK1wH8GJo67NVVXAN3d7xcFte20Fp4Qnn85fo=;
        b=MPiWS2MBeHIODDV+uJsBa3wrD2tUVziY2qsazfgicITBD9HIAvvn1jfwHgpM92yl2R
         5Kvm66vuGRNm03lPXXvs1U7f+pqt0T9SG0w7QSX5XrkKt/fi5zCo2hZRs7O8R04V38TB
         cJhMqeulyFiRL4QuPfy7aC2T3Q6P2IvEcXKq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JVy9rLJK1wH8GJo67NVVXAN3d7xcFte20Fp4Qnn85fo=;
        b=UtpAZJ0RH+l9Pg3mb7/h3AL88kHBiErhYVuEXbeQRaymMaB7pmf4ljobH2aJ0rErhu
         HRrZLDxlCEymKdGBC1G/zvT+Yg+ujUdf4R2KIzv/Rh2Yk1/1tMN9WO+qST2G05Bpe9Y9
         h99MBxdbL0i6fpvCQCAW43K7+JLKHEs0UidoQDkJPYy1FndEm8dN5lTGpfGoLIdRZSpy
         JrRxrJaHcUPzt2FkxQnWrgsPxIYx/fPhVqi/MQXKn/odt+B+8Hqyo+pqKZqD3VO6/IeQ
         TdYEoE7qQtXEEsXGXm8QPvU8MjhbLXfS144yUBTVMf+gqyypF1CBJufNmflr2n7n461f
         98Eg==
X-Gm-Message-State: AJcUukfxMU/TtfKwjkNzarg4ajDx87MVCbDpPQGeK4O03gL97JfZ1Je/
        Q4fiedc8EUeCpjz8V/4kiidkCg==
X-Google-Smtp-Source: ALg8bN6MIuM7WcHY1reYDYS60QyEhkRMZpK/jQ1Ae7MSSl86lFtX8sBDN3qFYcjDEXcPbSIIbhc47A==
X-Received: by 2002:a1c:8c13:: with SMTP id o19mr4432885wmd.56.1547023602995;
        Wed, 09 Jan 2019 00:46:42 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id n82sm12776455wma.42.2019.01.09.00.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 00:46:42 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 3/4] venus: core: correct frequency table for sdm845
Date:   Wed,  9 Jan 2019 10:46:15 +0200
Message-Id: <20190109084616.17162-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109084616.17162-1-stanimir.varbanov@linaro.org>
References: <20190109084616.17162-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This corrects clock frequency table rates to be in sync
with video clock controller frequency table.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index d95185ea32c3..739366744e0f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -465,10 +465,12 @@ static const struct venus_resources msm8996_res = {
 };
 
 static const struct freq_tbl sdm845_freq_table[] = {
-	{ 1944000, 380000000 },	/* 4k UHD @ 60 */
-	{  972000, 320000000 },	/* 4k UHD @ 30 */
-	{  489600, 200000000 },	/* 1080p @ 60 */
-	{  244800, 100000000 },	/* 1080p @ 30 */
+	{ 3110400, 533000000 },	/* 4096x2160@90 */
+	{ 2073600, 444000000 },	/* 4096x2160@60 */
+	{ 1944000, 404000000 },	/* 3840x2160@60 */
+	{  972000, 330000000 },	/* 3840x2160@30 */
+	{  489600, 200000000 },	/* 1920x1080@60 */
+	{  244800, 100000000 },	/* 1920x1080@30 */
 };
 
 static const struct venus_resources sdm845_res = {
-- 
2.17.1

