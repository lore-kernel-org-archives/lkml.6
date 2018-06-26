Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E639B267C8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJNvtGLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E639B267C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeFZJW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:22:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32856 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so14761080wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TZ6cUfKXefN+TcVs0TvWgag07nTtV4/QmuUGNuFfdG8=;
        b=TJNvtGLVUbjQSe3SuHYNOxRhcUBtZQxtn2MqV6w10QJE56znw8MTirL14cE9Sg84JC
         vu0NE70jCQg/J21Rbnq5rLI4NCMZtZp1F963W+UWj9bV8/ZP7D23plStOWnuYQ06iPwm
         uYaGBvFdU1Lor+UKq8s6ZgfcMFQcj/4uNElZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TZ6cUfKXefN+TcVs0TvWgag07nTtV4/QmuUGNuFfdG8=;
        b=kTylGqvLhqHUOmIl2HIufJLjxXaUjd5nLutqkUIKLvrALMV52mtRTyKFO5m4qxMe/6
         0te7/Haom0+v86BI+mLIAoAWq9Os7lSIOP+qwEyL2NqaTleSTCi0wU69bitOF+rbTUPj
         JrhzAF7EkeqrBt4AXFevm0DzL2Ipcjpok/E3HYAfB8T/MKDERHm0KUVmb+blunsShZcv
         3ue+w3OjPBkgYNuDd9FTNnvJyYrYSsb2kn0WeTsowE0vGFiuvISCL8FXwYcu/WXsvKRs
         h0DDQd6CFRwE/XjOCS1zsoHgT4/mf179PN00cjlLSJZJx6qTFIXI/1/nmlfVuejhqcce
         dgLg==
X-Gm-Message-State: APt69E0APPQvE0LuQ5+HUBkLl+7JJfmrTLnOZEseQ4oKb1ruJghodT1p
        s8EH+lG4urkv3NnQK3M2xqGlqg==
X-Google-Smtp-Source: AAOMgpcWpImQcR6dKhHjgQzqvG324TQ39J0K/a9ReO6JEl7nh3OudcFxwIF1GxvikGCKxqhWtlc8DA==
X-Received: by 2002:a1c:3e94:: with SMTP id l142-v6mr950601wma.120.1530004942722;
        Tue, 26 Jun 2018 02:22:22 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/12] ASoC: qdsp6: Fix dt based module loading and minor fixes
Date:   Tue, 26 Jun 2018 10:20:04 +0100
Message-Id: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent discussion on https://lkml.org/lkml/2018/6/18/1282 suggested
that qdsp6 code is using less common of_platform apis which would
not give dt based module loading support.

Suggestion from Rob was to add compatible strings to the dais nodes
This patchset adds this. Also this patchset has 3 trivial fixes which
is removing redundant owner, remove unused struct member and fix a
error check in q6routing.

Changes since v1:
- Addressed few trivial comments from Niklas

Thanks,
srini

Srinivas Kandagatla (12):
  ASoC: q6adm: dt-bindings: add compatible string to routing
  ASoC: q6asm: dt-bindings: add compatible string to dais
  ASoC: q6afe: dt-bindings: add compatible string to dais
  ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
  ASoC: qdsp6: q6afe-dai: support dt based module loading
  ASoC: qdsp6: q6asm-dai: support dt based module loading
  ASoC: qdsp6: q6routing: support dt based module loading
  ASoC: qcom: apq8096: remove redundant owner assignment
  ASoC: qdsp6: q6routing: add proper error check
  ASoC: qdsp6: q6asm: remove unused struct q6asm member

 Documentation/devicetree/bindings/sound/qcom,q6adm.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt |  6 ++++++
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt |  6 ++++++
 sound/soc/qcom/apq8096.c                               |  1 -
 sound/soc/qcom/qdsp6/q6adm.c                           | 16 ++--------------
 sound/soc/qcom/qdsp6/q6afe-dai.c                       |  7 +++++++
 sound/soc/qcom/qdsp6/q6afe.c                           | 16 ++--------------
 sound/soc/qcom/qdsp6/q6asm-dai.c                       |  7 +++++++
 sound/soc/qcom/qdsp6/q6asm.c                           | 17 ++---------------
 sound/soc/qcom/qdsp6/q6routing.c                       |  9 ++++++++-
 10 files changed, 46 insertions(+), 45 deletions(-)

-- 
2.16.2

