Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71939C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128D121A53
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LortvkA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128D121A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932777AbeGDJv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:51:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32870 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932531AbeGDJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so12628945wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+bZATuXdbF5QBNji17l+vemIMZdLqRzFIpCl4e5n7IM=;
        b=LortvkA8cb8AMGPZHvN9cLU3+/evYyqm5HcwYVifokPzdXSHnFUPMZ7MI7F7beCiK/
         YfB15/kjw5Kugh2B6x4tmXlPzWycPOLCQ6CuC2dixJWWTQoGVM9BpeUBSfIKwHzkhHY1
         gMRlLDpZyNAvs9FYG7fxlzUkZ+5m59tMEd874=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+bZATuXdbF5QBNji17l+vemIMZdLqRzFIpCl4e5n7IM=;
        b=EVXZuCpucuDBYU+48JIFivAWtbKAusVWGkEoou21wzPYckSbvBML0yTiQ32wdN4wik
         AtR38khsoFHLV8cTEn3hMnQw7mgJwfgiMzGoLhstjy2ENrYFVn5rPZFCytQoV8zTuNTN
         KU0QVeh/5b62FbZ79n1h5MAaVTa5RszhfNghfbM3nhPgOb6ozuUUXTlo6e6b5UR5qG0Q
         uOl7Fa7+p3NgQfef+08uA9r3WiuGM19qMWPFdxMOybiYTATuvl3bRpDlWNYq6MoxaQPm
         MAjlkDm/nB8lRu8A9fOOqO/TW1jInPaRQI75jOS4CunoGLtEqr6VTFBsMJGDM4j9fiY+
         2wWQ==
X-Gm-Message-State: APt69E3uSHTIsT+Ha3RtuJpjzbSjgmEQQFhRlushERgqdyVzKiS2F3Jv
        yODPI1eQ7vcKMZLvI4SW41V7PBERDI4=
X-Google-Smtp-Source: AAOMgpc9aHE/8SUheZC8djLobpDUYhHlw4N3xrKWGloCePGP64VHbU9qt4RcngSvWlmiaEOtpxqccQ==
X-Received: by 2002:a1c:be10:: with SMTP id o16-v6mr1057129wmf.132.1530697912949;
        Wed, 04 Jul 2018 02:51:52 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] ASoC: qdsp6: Add missing slimbus capture support
Date:   Wed,  4 Jul 2018 10:49:38 +0100
Message-Id: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to slimbus tx ports plus 3 trival fixes
to do with closing port when its not really open.
slim tx support invoving add dais and routing, rest of the dsp
configuration commands are already available in mainline.

slim tx is verified with wcd9335 codec on DB820c.

Thanks,
srini

Srinivas Kandagatla (6):
  ASoC: qdsp6: q6afe: Add missing slimbus capture ports
  ASoC: qdsp6: q6afe-dai: add support to slim tx dais
  ASoC: qdsp6: q6routing: add slim rx routings
  ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels
  ASoC: qdsp6: q6afe-dai: do not close port if its not opened
  ASoC: qdsp6: q6asm-dai: do not close port if its not opened

 sound/soc/qcom/qdsp6/q6afe-dai.c | 179 +++++++++++++++++++++++++++++++++++----
 sound/soc/qcom/qdsp6/q6afe.c     |  21 +++++
 sound/soc/qcom/qdsp6/q6asm-dai.c |   4 +-
 sound/soc/qcom/qdsp6/q6routing.c |  28 ++++++
 4 files changed, 216 insertions(+), 16 deletions(-)

-- 
2.16.2

