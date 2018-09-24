Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B29C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E10A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mxb8QEu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E10A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeIYFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:47:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIYFrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:47:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so2451629pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2EBLWtNvuldbU04viYVr0klB7QzFxqNQz5mupO4IqVE=;
        b=Mxb8QEu554BrJCly00yE3rS/B7ywLqvtoTS3m6KqdtrK1bfqKwBeL2RtLLich4ELRc
         XVUnZDkj+AE/MOdrXfunyR1l6PZ3iTNDi2e/PSPywQ3sdlqcIvQ88MlKbCRPmFTeCrug
         dwbcRfiUM3pZaXkwIb0YWo/8+zTJYr35FYquA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2EBLWtNvuldbU04viYVr0klB7QzFxqNQz5mupO4IqVE=;
        b=HzMVMkiqwt8Q9njQBrqKPU5sFDIp58C0lJUm/+oDx6txH6rlejqv0N5EAu4+1771hn
         eh+WNVkgzBfFGG825/mukRDGx13vTtS3ZlQheAjlqd5Ep99jqOnPUGlsNQbaq9+Rhy88
         fw5qvphAN7nU1PaJiB7ELCWZlGD0F5/G8C4FwE7M2ls05LJ9PsHMG9uL26ejeN/aQQJE
         RBiJS0uX6nmP7pw4trCYfI3AFf56IGcnJugWEiLjiOuFT/5E1FwBqyw7f12lNoyS97ll
         ltdue7fUPKYZkUzj7KEO2uduIU4n3w3oIbZzsmOgPPvitA1BZqaxmuOaLKXU7hZ/U9LH
         S9gg==
X-Gm-Message-State: ABuFfog935d6ONncNUf60rqtABa89L1phbnmi+A604VRJdVZJbkstNzW
        BAlo33ARPYS99tAd+PjwTz/RDo/2Xok6Pg==
X-Google-Smtp-Source: ACcGV63RZZvSZb7xIoMm2tcFlcjGoVEJ1EMuLtsfCy96J4a8U2nyQzFvrbVZd0V59PyZJsNWoPuBkg==
X-Received: by 2002:a17:902:8605:: with SMTP id f5-v6mr826557plo.271.1537832580524;
        Mon, 24 Sep 2018 16:43:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d12-v6sm467110pfn.118.2018.09.24.16.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:42:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v3 0/2] remoteproc: qcom: Rename adsp and mss drivers
Date:   Mon, 24 Sep 2018 16:45:24 -0700
Message-Id: <20180924234526.22916-1-bjorn.andersson@linaro.org>
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
 .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}      |  6 ++--
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
 4 files changed, 25 insertions(+), 24 deletions(-)
 rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (99%)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

-- 
2.18.0

