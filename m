Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626D320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zh73tZIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626D320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeINWtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:49:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeINWtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:49:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so4615575pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uKrHSqJF5GmVchmILU7FoFaNpjsphYMiZhLz6V+5dX0=;
        b=Zh73tZIYLYgJnUZuQeHT+UrOQShk2EORGdLVi+NVc2DIjNCcjq+epWBbV1k4uvMtFu
         Ar2m86fbICS5EDmQTMBKY6oYSy36mGzTueneJJyZSl/mFaACzaAbMWnZMO6TFmNW94vh
         3HbhgrMvkjArHrzr1sHLt/SgxDG6O/VOSCdEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uKrHSqJF5GmVchmILU7FoFaNpjsphYMiZhLz6V+5dX0=;
        b=Wor8D9ql+fxbQTd2hUV2cdlmIEeR36bUfJGrQ1Wpjm6x/6n++sTAZdVP8TWwEnfg7Y
         uqyvv1nOyucanzVsn122to11IdnWvJbXxBTKCrOBJ5FiUzyB5GFOETg+r6uSmy6yGKWx
         JyGmY2SVrkUyECvblYXucUYLdAuhKV/7/SCsiQWwuk9tz2m0UMT9DiiiflT2icf1ps4o
         EZdcT/5JwtUkFivQSTswG7I95wBw50Nwhvmzr/VCiiTYlTdC3c+HWoVdFjEbD2PI3SJa
         535vD22+32/cQbyDQ4voaTiyz7lVNOfb4XhOVRZy1Wut3gXchMfpFfgP9E0xvY73U6Zo
         ETgA==
X-Gm-Message-State: APzg51DNv8xvd6+lI6VO1KG4SkJdP87BM21arey42ja2Khvr/sKhHJMc
        STI/3/jbZhiW3NzX0BUBsoZu0A==
X-Google-Smtp-Source: ANB0VdZZSE+qjVt/euFjkRHakugwzlKnQ+Q3fAxrtJhU1Kn3pS68BBvAbMl6U2iWti/TZhG3HP37ng==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr12758284pgb.274.1536946425074;
        Fri, 14 Sep 2018 10:33:45 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d81-v6sm12531759pfj.122.2018.09.14.10.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:33:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2 0/2] remoteproc: qcom: Rename adsp and mss drivers
Date:   Fri, 14 Sep 2018 10:35:50 -0700
Message-Id: <20180914173552.20370-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're introducing a non-TZ based remoteproc driver for the ADSP in SDM845
the current naming scheme becomes cumbersome. Rename the existing drivers in
order to allow for the following:

qcom_q6v5_adsp - handle the non-TZ adsp subsystem
qcom_q6v5_mss - handles the self-authenticated modem
qcom_q6v5_pas - handles all TZ based "standard" subsystems
qcom_q6v5_wcss - handles the non-TZ wireless subsystem

Bjorn Andersson (2):
  remoteproc: qcom: Rename Hexagon v5 PAS driver
  remoteproc: qcom: Rename Hexagon v5 modem driver

 drivers/remoteproc/Kconfig                    | 35 ++++++++++---------
 drivers/remoteproc/Makefile                   |  4 +--
 .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}      |  0
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
 4 files changed, 22 insertions(+), 21 deletions(-)
 rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (100%)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

-- 
2.18.0

