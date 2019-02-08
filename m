Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0634C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4ED20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLQew3c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfBHRV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:21:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54150 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:21:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so4269792wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knS4i6xgOZz/mz8J43X7M1/Qd3FKTH7ujh7tUYXNntY=;
        b=jLQew3c45KYmBgVsAuVYVMiGF20EenaPxST1N6IErKjLVqzDDkQDu1tyrmdfzFv7Yr
         A8wUw/Hk0v+GNyxvtsH8EL/WcTP89V5/LovXQpEYLP8FC9U3c69nYipJg8Zlk3MCUB15
         Ug7bm2zOM8ZmxsUzNuaeAi057fOee8TqJ0mEVh9BV8m3r695gCN2rhN5HjSk9RxATK1r
         /iIh6PBTQ77VSPq5yy4wqzZxD4AJZKamHLtfDt866SPjVK8hLxBO4m5SWs8rnbk5sNLi
         MoNKWbO7lycOsN4EvNx0xHvxtc4ELuW8SRN3kVogVN7WHxguAhFTr6rr3ccdxvOX15TL
         joCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knS4i6xgOZz/mz8J43X7M1/Qd3FKTH7ujh7tUYXNntY=;
        b=Zm3lvGTJhBZjMdWYiqbZJQmM97Ru74gaa7+/l3ogjsL4tSkYsBqDpCa5Ht5gvqHU26
         lJt6ksBvdhUja38V3D9/BqbV2u4Ol7vcSMFvW0a/ZixWk9eT4UkQ05QU/OBxU/XdgCAW
         H4rs9fM2GJoeBBHZZOSsHG0hyGPIz1hujZ7gxau8KhxWrfYhLxNcbkRmongwvSeiAhaC
         NTpYnqxsOcXJu7s02uEIchKP0J6AL51Bqw31S/SoFbZPRxQlZ/i0whnguUGW85GymFdV
         YeYhieg4tDce6crG9eJq03o7RbNaNiuCKp/j1sedlDkk/czuLGu0m22diJZYUnnet2wA
         J5Bg==
X-Gm-Message-State: AHQUAuawhz3jtnaqPcp2gCcRaHy1xg8JeM1t/kOB1E1yqP2yBMbeapH2
        LF273OKfw5trj7Gi7UIrwOaRfg==
X-Google-Smtp-Source: AHgI3IbSkxE70hvE6hEsTR0dsK+wCs+VlcnFHXDYH5GnybORz2T0MG58aGjYmCf/4I4RpIKys9BUkQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr17136749wrh.250.1549646514707;
        Fri, 08 Feb 2019 09:21:54 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k23sm4097150wmj.32.2019.02.08.09.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 09:21:53 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        evgreen@chromium.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, mturquette@baylibre.com,
        abailon@baylibre.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v1 0/2] interconnect: Add path tagging support
Date:   Fri,  8 Feb 2019 19:21:50 +0200
Message-Id: <20190208172152.1807-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (1):
  interconnect: Add support for path tags

 drivers/interconnect/core.c           |  27 ++++++-
 drivers/interconnect/qcom/sdm845.c    | 103 +++++++++++++++++++-------
 include/linux/interconnect-provider.h |   4 +-
 include/linux/interconnect.h          |   5 ++
 4 files changed, 106 insertions(+), 33 deletions(-)

