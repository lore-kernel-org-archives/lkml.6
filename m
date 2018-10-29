Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3513EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C82082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab5nKApg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5C82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeJ3IUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:20:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45850 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3IUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:20:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id u4-v6so2433239pfh.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QQln21pT/FJiXd3CvWGnCgvbBviEehqc5USvtIkiPZw=;
        b=Ab5nKApgTi5mmM1Lro2GizrsxKnYUgyW0JaekE/3zmw/u2xu1ep3NxIu1p7uVOnkt7
         eLyPr/kxAZqsJu22wWRmOjey2mQFphx6R9TgKTY0tDkxkOafhDiGD1LlKQ+hIQrevbq8
         YkJsgQ+hasS31gnbj+WgnyN24GoIUkk/MCZ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QQln21pT/FJiXd3CvWGnCgvbBviEehqc5USvtIkiPZw=;
        b=hmhqYoDgDGIOG7u/9RuAHnYnxyzBLrWpPgBlP7BxOKFwt22jpOgoY2Qu0YGsJfn3fb
         yJRw1eFI/Ff9YhGSS0W4q+XoHoB/sAcGW4LQ6OWedVAEEYER+qmX5w6OPvw3L6uo3tj9
         Ei0Ag5BIFd5mo+0Py9dAZYD4DkyX91B5fY+6D3F2pXwelH6dYq6aYaerep06dAi2tDrN
         zsGkoAu7uxUZlg1Tru8KpEmAs9k4y7E2cpAX8pcqr2MCWAoppCXc1CC9KWQ5ksIoDIA7
         g5ZVxUHSjY3T8Uf0uyHqyINxFgkgWF1cwxXH5UAvyCaE7KOF0JEIiwv9JKz5zSFxU6Ec
         L6bw==
X-Gm-Message-State: AGRZ1gIqW0cDa7/PsxKb2N1p2AB4VGyOh5DMVvp1OGhW2agCfmCOM8yW
        W0mVCRftyrknEhQFLxWCRUg/xw==
X-Google-Smtp-Source: AJdET5fM59UmE4C46oJyzJT+ZHTZK8mq14Y+3SzJVFEd53a50wj2HhA2SAfuzax0ebrEkgp2gjGCVw==
X-Received: by 2002:a63:ef53:: with SMTP id c19-v6mr15732207pgk.386.1540855759917;
        Mon, 29 Oct 2018 16:29:19 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s30-v6sm15192812pga.57.2018.10.29.16.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 16:29:19 -0700 (PDT)
Date:   Mon, 29 Oct 2018 16:32:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Suman Anna <s-anna@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [GIT PULL] remoteproc updates for v4.20
Message-ID: <20181029233247.GV12063@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v4.20

for you to fetch changes up to f18b7e914fd2ed5e8b5733644cefcf62f7582679:

  remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump (2018-10-19 12:54:03 -0700)

----------------------------------------------------------------
remoteproc updates for v4.20

This contains a series of patches that reworks the memory carveout
handling in remoteproc, in order to allow this to be reused for
statically allocated memory regions to be used for e.g. firmware.

It adds support for audio DSP (both TZ-assisted and non-TZ assisted) and
compute DSP on Qualcomm SDM845, TZ-assisted audio DSP, compute DSP and
WiFi processor on Qualcomm QCS404 and through some renaming of the
drivers cleans up the naming situation.

Finally support for custom coreudmp segment handlers is added and
is used in the Qualcomm modem remoteproc driver to gather memory dumps
of the firmware.

----------------------------------------------------------------
Bjorn Andersson (6):
      remoteproc/davinci: Use %zx for formating size_t
      remoteproc: qcom: adsp: Add SDM845 ADSP and CDSP support
      remoteproc: qcom: q6v5: Propagate EPROBE_DEFER
      remoteproc: qcom: Rename Hexagon v5 PAS driver
      remoteproc: qcom: Rename Hexagon v5 modem driver
      remoteproc: qcom: pas: Add QCS404 remoteprocs

Brian Norris (2):
      remoteproc: qcom: q6v5-mss: add SCM probe dependency
      remoteproc: qcom: q6v5: shore up resource probe handling

Loic Pallardy (12):
      remoteproc: configure IOMMU only if device address requested
      remoteproc: add rproc_va_to_pa function
      remoteproc: add release ops in rproc_mem_entry struct
      remoteproc: add name in rproc_mem_entry struct
      remoteproc: add helper function to allocate and init rproc_mem_entry struct
      remoteproc: introduce rproc_add_carveout function
      remoteproc: introduce rproc_find_carveout_by_name function
      remoteproc: add alloc ops in rproc_mem_entry struct
      remoteproc: add helper function to allocate rproc_mem_entry from reserved memory
      remoteproc: add helper function to check carveout device address
      remoteproc: modify rproc_handle_carveout to support pre-registered region
      remoteproc: modify vring allocation to rely on centralized carveout allocator

Rohit kumar (2):
      dt-binding: remoteproc: Add QTI ADSP PIL bindings
      remoteproc: qcom: Introduce Non-PAS ADSP PIL driver

Sibi Sankar (11):
      dt-bindings: remoteproc: qcom: Remove additional definition tag
      dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
      remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
      remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs
      remoteproc: qcom: q6v5: Fix a race condition on fatal crash
      remoteproc: qcom: q6v5-pil: Assign the relocated address
      remoteproc: Introduce custom dump function for each remoteproc segment
      remoteproc: Add mechanism for custom dump function assignment
      remoteproc: qcom: q6v5-mss: Refactor mba load/unload sequence
      remoteproc: qcom: q6v5-mss: Add custom dump function for modem
      remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump

Suman Anna (2):
      remoteproc: Check for NULL firmwares in sysfs interface
      remoteproc: Add missing kernel-doc comment for auto-boot

Wei Yongjun (1):
      remoteproc: qcom: qcom_q6v5_adsp: Fix some return value check

 .../bindings/remoteproc/qcom,adsp-pil.txt          | 126 +++++
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   |   5 +
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   8 +-
 drivers/remoteproc/Kconfig                         |  46 +-
 drivers/remoteproc/Makefile                        |   5 +-
 drivers/remoteproc/da8xx_remoteproc.c              |   2 +-
 drivers/remoteproc/qcom_q6v5.c                     |  43 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                | 497 +++++++++++++++++
 .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}           | 420 ++++++++++-----
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}           |  28 +-
 drivers/remoteproc/remoteproc_core.c               | 595 +++++++++++++++++----
 drivers/remoteproc/remoteproc_debugfs.c            |   1 +
 drivers/remoteproc/remoteproc_internal.h           |   2 +
 drivers/remoteproc/remoteproc_sysfs.c              |   5 +
 drivers/remoteproc/remoteproc_virtio.c             |  14 +-
 include/linux/remoteproc.h                         |  47 +-
 16 files changed, 1557 insertions(+), 287 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
 create mode 100644 drivers/remoteproc/qcom_q6v5_adsp.c
 rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (90%)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (90%)
