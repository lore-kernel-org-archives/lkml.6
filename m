Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2526024
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLtqn75+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2526024
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeF0P1s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:27:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbeF0P1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:27:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so18348255wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s19uCGzEfa7voWyvPVHuhU3QK17HgjxH2UZRNOcdec0=;
        b=aLtqn75+VAecDqqvbrJ7Lcm0RrLD8sRkJ8jiFUxolIxOELbGVHDMrtx4GvcNej2TBT
         dPq56OxDvfdW8FnzVcVDl072ZXv8RFKlneE7uJe8U2K5POzjKEhdy/D0LS+wpL1bfpLJ
         l3d5ITIVQ6qejIHuO/YJ5sRvqOKu/gLhtm7T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s19uCGzEfa7voWyvPVHuhU3QK17HgjxH2UZRNOcdec0=;
        b=UsbPC/sMyOp6owF1aoQgFa9oOnK3oOqqsgUwdVfBdwNHnhf1PN33StAiJK+asb1bGQ
         2O2o39OZcD2j1qEC2j4o3AR5sQ37BcflJYT0Hn6SZhuq6dXfLU2+o9fMx3x0Thk+e4lK
         +M0v0R+gnyxo1Bf+KEgfCzbCZfZMzmnOkCrZSU3q7l7ZXYdMydJiZj5QajZNeJlWLkru
         7/M7t6X/wv3gAL8Yo4nbYsCuhzo7+3L2oIyYLkvWNCcTTvJN4TqYuu3IrF85BryJcq35
         8UsaykFBganR+b67oCWvBZVLEiu9twaSRkwMWIwOzKN++UILaD4spNAOt13/t3H3M376
         nCNg==
X-Gm-Message-State: APt69E25WFvHb/nMYz4VKApYbGm30hTdBPsl2DOaPzaWxyAe0D9fFthj
        t1qkRcZCdl8ULJhYQllx7DyKVQ==
X-Google-Smtp-Source: AAOMgpfpq3PovrLKbWAOvNkvKRSuzptRW1TaqQ9UI5E2z0qTTW2Q1fVGdqgI4fA5PdKA/HmnJrYXbA==
X-Received: by 2002:a1c:ce0c:: with SMTP id e12-v6mr5042548wmg.86.1530113263606;
        Wed, 27 Jun 2018 08:27:43 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:27:42 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 00/27] Venus updates
Date:   Wed, 27 Jun 2018 18:26:58 +0300
Message-Id: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v4 with following changes:

- fixed kbuild test robot in 12/27.
- fixed destination of memcpy in fill_xxx functions.

v3 can be found at https://lkml.org/lkml/2018/6/13/464

regards,
Stan

Stanimir Varbanov (27):
  venus: hfi_msgs: correct pointer increment
  venus: hfi: preparation to support venus 4xx
  venus: hfi: update sequence event to handle more properties
  venus: hfi_cmds: add set_properties for 4xx version
  venus: hfi: support session continue for 4xx version
  venus: hfi: handle buffer output2 type as well
  venus: hfi_venus: add halt AXI support for Venus 4xx
  venus: hfi_venus: fix suspend function for venus 3xx versions
  venus: hfi_venus: move set of default properties to core init
  venus: hfi_venus: add suspend functionality for Venus 4xx
  venus: core,helpers: add two more clocks found in Venus 4xx
  venus: hfi_parser: add common capability parser
  venus: helpers: rename a helper function and use buffer mode from caps
  venus: helpers: add a helper function to set dynamic buffer mode
  venus: helpers: add helper function to set actual buffer size
  venus: core: delete not used buffer mode flags
  venus: helpers: add buffer type argument to a helper
  venus: helpers: add a new helper to set raw format
  venus: helpers,vdec,venc: add helpers to set work mode and core usage
  venus: helpers: extend set_num_bufs helper with one more argument
  venus: helpers: add a helper to return opb buffer sizes
  venus: vdec: get required input buffers as well
  venus: vdec: a new function for output configuration
  venus: helpers: move frame size calculations on common place
  venus: implementing multi-stream support
  venus: core: add sdm845 DT compatible and resource data
  venus: add HEVC codec support

 .../devicetree/bindings/media/qcom,venus.txt       |   1 +
 drivers/media/platform/qcom/venus/Makefile         |   3 +-
 drivers/media/platform/qcom/venus/core.c           | 107 ++++
 drivers/media/platform/qcom/venus/core.h           | 100 ++--
 drivers/media/platform/qcom/venus/helpers.c        | 555 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/helpers.h        |  23 +-
 drivers/media/platform/qcom/venus/hfi.c            |  12 +-
 drivers/media/platform/qcom/venus/hfi.h            |  10 +
 drivers/media/platform/qcom/venus/hfi_cmds.c       |  62 ++-
 drivers/media/platform/qcom/venus/hfi_helper.h     | 112 ++++-
 drivers/media/platform/qcom/venus/hfi_msgs.c       | 399 +++------------
 drivers/media/platform/qcom/venus/hfi_parser.c     | 278 +++++++++++
 drivers/media/platform/qcom/venus/hfi_parser.h     |  45 ++
 drivers/media/platform/qcom/venus/hfi_venus.c      | 109 +++-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |  10 +
 drivers/media/platform/qcom/venus/vdec.c           | 326 +++++++-----
 drivers/media/platform/qcom/venus/venc.c           | 220 ++++----
 17 files changed, 1694 insertions(+), 678 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h

-- 
2.14.1

