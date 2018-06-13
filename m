Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4C14C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913E6208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMmeh/EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913E6208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935876AbeFMPIo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:08:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36987 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:08:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so3150869wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i/HHA4PkKB3hJI7sKtzDILXhHsJaabk1eD6PHzj9G9s=;
        b=hMmeh/EWHOnKGyMcIIVtDdB+gOT1KakhfkguwjxCIeLUJXgx1ru04cYwrctUbjR0lR
         ijXs6vgINz2cSy6ED4gUrCQrXq5U5LcZlYszp1hPdWJ4ich5WJBg+zaJfWk+6zA7ajjJ
         XDx8v8cj3asV7eIXzUPIJu+Mu5v5dthrQu2Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i/HHA4PkKB3hJI7sKtzDILXhHsJaabk1eD6PHzj9G9s=;
        b=FfwsZzyKfap3xrsQxjGeRSBX7wtts8GPKNitOa19YIAZkA3YWXR3wwbYiJeORAM5Ff
         OylABJlAH9P6viNm80niB4RHi9+ecRpqRtG2A3jvQkITsXbX6FQAkPSkZrLoyVAh08ho
         OFrlOdlwLkRRGP72dYbHVnoqa7HNHuiqvJxFmLTZh/yivf1+lSOJVmJUcsHOFwREnj/g
         TRPdrqt/W8+xMQDjpaDOPJ537699pwEN0LLzPCIrN0IL9AeKSAwRoZeYBDIwr6bN80r5
         HCr8cA5qyiqjCD8JTHoltnXgKlUY/zcbtQkM2XEKc2f4oP3IBY8I+XaD8fgUEo2xE7Dt
         slQQ==
X-Gm-Message-State: APt69E3pPm24nJJ0pHOiRMK/p3HfnQr3cJ9oKq6sp3TtNbJld7Sjykt7
        3iU1zPHigwTQaiLiSzzEXB0lvQ==
X-Google-Smtp-Source: ADUXVKI/14XcYAQ1anD16mWGoKKB+jbnoWPltWUP7yo6hD5bsd37N4OoOvg6JRzzdlnphfq3iHhu/g==
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr4644894wrf.36.1528902520651;
        Wed, 13 Jun 2018 08:08:40 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:08:39 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 00/27] Venus updates
Date:   Wed, 13 Jun 2018 18:07:34 +0300
Message-Id: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a new version of the patch-set which addressing most of review
comments made by Tomasz. The changes are:

* added Reviewed-by tags
* in 02/29 dropped vcodec noc error registers for now,
* in 03/29 added a comment for new properties and drop entropy_mode local
  variable.
* in 04/29 drop ret local variable and call pkt_session_set_property_3xx
  directly from switch default.
* in 07/29 added defines for register bits.
* in 08/29 added venus_cpu_and_video_core_idle and
  venus_cpu_idle_and_pc_ready and use readx_poll_timeout.
* squashed v2's 11/29 and 13/29 and reworked error handling in vdec/venc
  suspend/resume
* in 12/29 
  - switched to for_each_set_bit when init codecs capability structure
  - added a define for MAX_ALLOC_MODE_ENTRIES, now
  - fill profile/level capabilities in capabilities structure.
  - announce data argument as const in callback function.
  - dropped some not needed loops.
* squashed v2's 14/29 and 18/29
* in 15/29 make is_dynamic_bufmode bool and drop inline.

v2 can found at https://lkml.org/lkml/2018/5/15/190

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

