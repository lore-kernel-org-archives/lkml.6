Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D111C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D074218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0atfTZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D074218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeHRApf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:45:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46950 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeHRApe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:45:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so4018466pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SH7SU68bJ3aykT9kkPdjdUqn5j5c3dYXqR5XQuZQ6ow=;
        b=S0atfTZRkDOsifs7mc+lT9PRSZkFyxKDgbh6HPrlRCJZYKLF2ZYiUdhGit9uX81j/w
         79PBiJ2qXzFtHLlYk1569hJ1L8BWDklHzWgJ6DR4QqB2hJhF1hUz/h3Vtoa3whGz2gqr
         neUAs9lq6jJEcpEl4jQDjTPHaTYgpZ68QKumo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SH7SU68bJ3aykT9kkPdjdUqn5j5c3dYXqR5XQuZQ6ow=;
        b=IhOYcIp2NcSEVr73HzfRb8SyMF1/cRIkJOhQX8PED0evAE9CHDiyIgrNy1Yq83rKr3
         1SMCqaAveSQN8g/0s/yFliQp3TGPTw5kQ2zvYNhpe77v3fyU/P8q/Q4uQqQ7PniI6Juc
         a3FFWsFU5BAya3FSBXu4cnURAvAzn8OrObWZ9Pgs8cBGOVgUA6cvfKKKgCyNdDyLY8Q+
         ZQmQJbA3f9OlvrpOB6RBOCm6FruTWPVGA1C70C0eSUU6KOLGgdnpZkrVRjYz/DCYZEJh
         tGP2iBN36TW6/v4NBmVACp4CGyJ0M6BRhp2Mddh5f/5TZZ9xiJEMMOrbT0GskkXCGeHV
         iEZQ==
X-Gm-Message-State: AOUpUlE6my7QjBux6L55vuDgdtPdLyk33m3S9FQWXc5jJNOsUVbWA3yp
        C/R5OgLPQaGCMakyI/dS3yeMug==
X-Google-Smtp-Source: AA+uWPx0svfWUWinW5v+tZKu6E9NBKBLU/sEvQvw9xdRKf2Kgf8m4U/OaI0Vj55VtLe7kTkUusGdbQ==
X-Received: by 2002:a63:3246:: with SMTP id y67-v6mr34212903pgy.399.1534542032380;
        Fri, 17 Aug 2018 14:40:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s85-v6sm5181045pfa.116.2018.08.17.14.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 14:40:31 -0700 (PDT)
Date:   Fri, 17 Aug 2018 14:44:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Loic Pallardy <loic.pallardy@st.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Suman Anna <s-anna@ti.com>, Alex Elder <elder@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [GIT PULL] remoteproc updates for v4.19
Message-ID: <20180817214422.GA3941@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v4.19

for you to fetch changes up to b2201ee554a5811f569f31280b0079e7d6177606:

  remoteproc/davinci: use the reset framework (2018-08-16 17:39:55 -0700)

----------------------------------------------------------------
remoteproc updates for v4.19

This adds support for pre-start and post-shutdown hooks for remoteproc
subdevices, refactors the Qualcomm Hexagon support to allow reuse
between several drivers, makes authentication in the MDT file loader
optional, migrates a few format strings to use %pK and migrates the
Davinci driver to use the reset framework.

----------------------------------------------------------------
Alex Elder (1):
      remoteproc: rename subdev probe and remove functions

Arnd Bergmann (2):
      remoteproc: qcom q6v5: fix modular build
      remoteproc: qcom: fix Q6V5_WCSS dependencies

Bartosz Golaszewski (1):
      remoteproc/davinci: use the reset framework

Bjorn Andersson (7):
      remoteproc: q6v5: Extract common resource handling
      remoteproc: qcom: adsp: Use common q6v5 helpers
      remoteproc: qcom: q6v5-pil: Use common q6v5 helpers
      remoteproc: Rename subdev functions to start/stop
      remoteproc: Make start and stop in subdev optional
      remoteproc: Make client initialize ops in rproc_subdev
      remoteproc: Introduce prepare and unprepare for subdevices

Loic Pallardy (2):
      remoteproc: replace "%p" with "%pK"
      remoteproc: st_slim: replace "%p" with "%pK"

Sibi Sankar (1):
      remoteproc: qcom: q6v5-pil: fix modem hang on SDM845 after axis2 clk unvote

Sricharan R (2):
      remoteproc: qcom: mdt_loader: Make the firmware authentication optional
      remoteproc: qcom: Introduce Hexagon V5 based WCSS driver

Suman Anna (2):
      remoteproc: Reset table_ptr in rproc_start() failure paths
      remoteproc/davinci: Mark error recovery as disabled

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   7 +-
 drivers/remoteproc/Kconfig                         |  23 +
 drivers/remoteproc/Makefile                        |   2 +
 drivers/remoteproc/da8xx_remoteproc.c              |  37 +-
 drivers/remoteproc/qcom_adsp_pil.c                 | 156 +-----
 drivers/remoteproc/qcom_common.c                   |  26 +-
 drivers/remoteproc/qcom_q6v5.c                     | 252 +++++++++
 drivers/remoteproc/qcom_q6v5.h                     |  46 ++
 drivers/remoteproc/qcom_q6v5_pil.c                 | 158 +-----
 drivers/remoteproc/qcom_q6v5_wcss.c                | 601 +++++++++++++++++++++
 drivers/remoteproc/qcom_sysmon.c                   |   5 +-
 drivers/remoteproc/remoteproc_core.c               | 117 ++--
 drivers/remoteproc/remoteproc_debugfs.c            |   4 +-
 drivers/remoteproc/remoteproc_virtio.c             |   2 +-
 drivers/remoteproc/st_slim_rproc.c                 |   3 +-
 drivers/soc/qcom/mdt_loader.c                      |  87 ++-
 include/linux/remoteproc.h                         |  19 +-
 include/linux/soc/qcom/mdt_loader.h                |   4 +
 18 files changed, 1188 insertions(+), 361 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_q6v5.c
 create mode 100644 drivers/remoteproc/qcom_q6v5.h
 create mode 100644 drivers/remoteproc/qcom_q6v5_wcss.c
