Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED95C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8DE20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPI3eFFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfAQQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:20:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35025 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfAQQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:20:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so11701274wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SZPWiMzkYQD8+oxvshJBz9hzwglolbWb6IRgEa3k59Y=;
        b=SPI3eFFJgx/z42h5zJaxY2nlYW/iuC0sW+x6i1HlkE8pumnA8a60BKtL52R/852Iso
         bsXuBajn/JZGtnVh9b3ttKPpk5pkVbTH8rXZdXgs80j2mb1CZmO8HQLnoV1JhdH17MvP
         fCAImpHEX6OGMK7QJBpalbEbd0AmYockz8CrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZPWiMzkYQD8+oxvshJBz9hzwglolbWb6IRgEa3k59Y=;
        b=TkwQyQ+JajaqJR0Hyz5ob38VUnnS1Fq/t/VTdxqVNclFcdwg6M0Ulm9ygPSNdf+tT0
         J0pAOiyQo8y2rrsB7QycfNdjinKrV+tI919DEMKP8SNafZn7oVgCWKTijI6biAFnG4wN
         IDpEqEESZuJngzPOfXCQELTjwGrdjI2dqSCALEMKeZq/diDHsjv7GZcUJPOmV3BWtOaY
         TJYlGyBTTYAMWxyimi7b+yO7bsJ5/lm7+Opd8wsldgwaA2eaa+U96ZTNg2dYQmqOGQUR
         KhxpyL7Bt+TioRJkpMlbcZKjFrMDoy4Ika1lRon+2Z5WlFcwyJxRjm+nlMpiQrLHWM+o
         xCZQ==
X-Gm-Message-State: AJcUukeajgr0wiRoEay2ZEf0ijd5LFV8a4TDuO1W5Pxt6ny1fn8LaNr3
        v86W+uLanQpOGJtOKrjLsUvWqiTH79c=
X-Google-Smtp-Source: ALg8bN7FM/onezXqw1stKJLhrLxBnKwuXK0/kefci7FpdKOMYZRdeUtHVFDpGKi3Ql+vlibpBWwSnw==
X-Received: by 2002:adf:94e4:: with SMTP id 91mr13271459wrr.322.1547742045914;
        Thu, 17 Jan 2019 08:20:45 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id v133sm31124734wmf.19.2019.01.17.08.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:20:45 -0800 (PST)
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
Subject: [PATCH 00/10] Venus stateful Codec API
Date:   Thu, 17 Jan 2019 18:19:58 +0200
Message-Id: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This aims to make Venus decoder compliant with stateful Codec API [1].
The patches 1-9 are preparation for the cherry on the cake patch 10
which implements the decoder state machine similar to the one in the
stateful codec API documentation.

There few things which are still TODO:
 - V4L2_DEC_CMD_START implementation as per decoder documentation.
 - Dynamic resolution change V4L2_BUF_FLAG_LAST for the last buffer
   before the resolution change.

The patches are tested with chromium VDA unittests at [2].

Note that the patchset depends on Venus various fixes at [3].

Comments are welcome!

regards,
Stan

[1] https://patchwork.kernel.org/patch/10652199/
[2] https://chromium.googlesource.com/chromium/src/+/lkgr/docs/media/gpu/vdatest_usage.md
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1894510.html

Stanimir Varbanov (10):
  venus: hfi_cmds: add more not-implemented properties
  venus: helpers: fix dynamic buffer mode for v4
  venus: helpers: export few helper functions
  venus: hfi: add type argument to hfi flush function
  venus: hfi: export few HFI functions
  venus: hfi: return an error if session_init is already called
  venus: helpers: add three more helper functions
  venus: vdec_ctrls: get real minimum buffers for capture
  venus: vdec: allow bigger sizeimage set by clients
  venus: dec: make decoder compliant with stateful codec API

 drivers/media/platform/qcom/venus/core.h      |  20 +-
 drivers/media/platform/qcom/venus/helpers.c   | 141 +++++-
 drivers/media/platform/qcom/venus/helpers.h   |  14 +
 drivers/media/platform/qcom/venus/hfi.c       |  11 +-
 drivers/media/platform/qcom/venus/hfi.h       |   2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c  |   2 +
 drivers/media/platform/qcom/venus/vdec.c      | 467 ++++++++++++++----
 .../media/platform/qcom/venus/vdec_ctrls.c    |   7 +-
 8 files changed, 535 insertions(+), 129 deletions(-)

-- 
2.17.1

