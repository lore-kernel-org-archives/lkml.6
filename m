Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757775AbeDXMo6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:44:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39610 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeDXMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:44:55 -0400
X-Google-Smtp-Source: AIpwx49MLYWN0N/pxFCZz0Lecg12WkvR24QlPzZ/GoStUbsYlv+fwtQdQJWKESt7jRYMsAiJrpp3PA==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 00/28] Venus updates
Date: Tue, 24 Apr 2018 15:44:08 +0300
Message-Id: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch set aims to:

* add initial support for Venus version 4xx (found on sdm845).

* introduce a common capability parser to enumerate better
  supported uncompressed formats, capabilities by codec,
  supported codecs and so on.

* also contains various cleanups, readability improvements
  and fixes.

* adds HEVC codec support for the Venus versions which has
  support for it.

* add multi-stream support (secondary decoder output), which
  will give as an opportunity to use UBWC compressed formats
  to optimize internal interconnect bandwidth on higher
  resolutions.

Comments are welcome!

regards,
Stan

Stanimir Varbanov (28):
  venus: hfi_msgs: correct pointer increment
  venus: hfi: preparation to support venus 4xx
  venus: hfi: update sequence event to handle more properties
  venus: hfi_cmds: add set_properties for 4xx version
  venus: hfi: support session continue for 4xx version
  venus: hfi: handle buffer output2 type as well
  venus: hfi_venus: add halt AXI support for Venus 4xx
  venus: hfi_venus: add suspend function for 4xx version
  venus: venc,vdec: adds clocks needed for venus 4xx
  venus: vdec: call session_continue in insufficient event
  venus: add common capability parser
  venus: helpers: make a commmon function for power_enable
  venus: core: delete not used flag for buffer mode
  venus: helpers: rename a helper function and use buffer mode from caps
  venus: add a helper function to set dynamic buffer mode
  venus: add helper function to set actual buffer size
  venus: delete no longer used bufmode flag from instance
  venus: helpers: add buffer type argument to a helper
  venus: helpers: add a new helper to set raw format
  venus: helpers,vdec,venc: add helpers to set work mode and core usage
  venus: helpers: extend set_num_bufs helper with one more argument
  venus: helpers: add a helper to return opb buffer sizes
  venus: vdec: get required input buffers as well
  venus: vdec: new function for output configuration
  venus: move frame size calculations in common place
  venus: implementing multi-stream support
  venus: add sdm845 compatible and resource data
  venus: add HEVC codec support

 .../devicetree/bindings/media/qcom,venus.txt       |   1 +
 drivers/media/platform/qcom/venus/Makefile         |   3 +-
 drivers/media/platform/qcom/venus/core.c           | 102 ++++
 drivers/media/platform/qcom/venus/core.h           |  91 ++--
 drivers/media/platform/qcom/venus/helpers.c        | 558 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/helpers.h        |  23 +-
 drivers/media/platform/qcom/venus/hfi.c            |  12 +-
 drivers/media/platform/qcom/venus/hfi.h            |   9 +
 drivers/media/platform/qcom/venus/hfi_cmds.c       |  64 ++-
 drivers/media/platform/qcom/venus/hfi_helper.h     | 112 ++++-
 drivers/media/platform/qcom/venus/hfi_msgs.c       | 401 +++------------
 drivers/media/platform/qcom/venus/hfi_parser.c     | 290 +++++++++++
 drivers/media/platform/qcom/venus/hfi_parser.h     |  45 ++
 drivers/media/platform/qcom/venus/hfi_venus.c      |  69 +++
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |  24 +
 drivers/media/platform/qcom/venus/vdec.c           | 324 +++++++-----
 drivers/media/platform/qcom/venus/venc.c           | 166 +++---
 17 files changed, 1641 insertions(+), 653 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h

-- 
2.14.1
