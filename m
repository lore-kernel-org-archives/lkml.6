Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47351219F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQJj12PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47351219F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeHFMXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeHFMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id f12-v6so11775313wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6BFxT3HUlqs48KV5Ge1nJdb2chJNfGKDdPOPTZU1F7w=;
        b=hQJj12PDmagnTISMN0WUUy4kOVZITDTjugajFoXw6KmmX9K10ZM5oOcK904Rf3lcjF
         WsHpACSHW4OHYf2+sNELQXXu+NAr8aiNVYBzZ5Sbnu35GLxbPlJXK4OSI6Zvp4MBBLfE
         u6R8GA6TUDidkcvmszy0gotPJWfA+rZpBI8Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6BFxT3HUlqs48KV5Ge1nJdb2chJNfGKDdPOPTZU1F7w=;
        b=VkWN4+fqP8Wlf22KEixIkaTAmT2SLikiLOnXF9Aqa1pjxNsKKbkP/ru6hEKOn5S/3/
         QO3uXoVckVHZKFbcVtmfBul3luEDjsUcXFwHN32db4QLEvru+FDfqTY7TJZFBRu2vjgT
         LCep2SE5XE5OJFjvDJxNi4I9h5BTTKgnNcDw4GQ4oO+hKhxb4yW9KE888qmIe3FvJbIa
         3egwMaRiyMnpjfMBHPIE6AY/kYlyMrz3YR9m/tH/1AqbETct/sRFeXPUX0PuQItLHv7Z
         yBnZY5Gs5ZE6b0G4EaFS3ZffsS6OSrfkCk/H194f9HcIs1XKdIrxmgQi+uW4Taj54tEm
         Jgyg==
X-Gm-Message-State: AOUpUlEl/2Lg8PNmKEMDCQ3i14hGWPYAxCc9CfYXvNFzxEw/SboKjKuu
        jM2yPWOMJNDf6HEP0mZKAH6U9g==
X-Google-Smtp-Source: AAOMgpfWRaF0eGlDev1lFywO58mzlcW8J+LhJN5NjPpLCBh3BOkRWlyKaiPU1M6/vgbnRio3upeD/Q==
X-Received: by 2002:adf:9996:: with SMTP id y22-v6mr9682329wrb.69.1533550482082;
        Mon, 06 Aug 2018 03:14:42 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] ASoC: qcom: few trival fixes
Date:   Mon,  6 Aug 2018 11:12:04 +0100
Message-Id: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset have few trivial fixes, 3 of them to do with cleaning up the
unused header files, 1 patch is to do with fixing warning on common.c and
other is to add missing AIF_IN dapm for slim tx ports.

Thanks,
srini

Srinivas Kandagatla (5):
  ASoC: qcom: make common.c as proper module
  ASoC: apq8096: remove unused header files
  ASoC: sdm845: remove unused header files
  ASoC: qcom: remove unused header files from common.h
  ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm

 sound/soc/qcom/Kconfig           | 5 +++++
 sound/soc/qcom/Makefile          | 6 ++++--
 sound/soc/qcom/apq8096.c         | 2 --
 sound/soc/qcom/common.h          | 1 -
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 sound/soc/qcom/sdm845.c          | 2 --
 6 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.16.2

