Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3089FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90124105
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="apBX1ofb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE90124105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeGENFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38053 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753941AbeGENE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:04:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id j33-v6so1134865wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LXX/ik0JkRnznqqUV0oWx0cz3AIfUo8AKWWvUP8EOTs=;
        b=apBX1ofbMYcrRRdwM+CdrZbHfZgT6F6Pg5ulsEfrjhJCGzGtvY3apAyup7MbwKc1Aj
         uKapwcbqSXyXHENKzWVo7T8WvSw1Gfq+QQ+CYGuDDp4GdoaddxCetOnEgMoQpqzPqV1W
         8eJ2miT+xJR1X7B50uflNi/7aIqeN3ueU1M2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LXX/ik0JkRnznqqUV0oWx0cz3AIfUo8AKWWvUP8EOTs=;
        b=O9DIM/l6RUGbYMac8kYOxQRjYeLsKRM4JxG/z/N6xZHyPao8r0K1TUAoVNM9eiG8F3
         XoXtRzTi3iIqWHfQCKm3ClZQFnouu9KOQjiIJ559cW/wE7gBemfnBj6T2e1cufNSsplo
         Qk2RtxfsE65yuvolVW+RzVL9JuZs80p+Kw0GAbpyzd94/DORfD7cV/XdDU97ZE7QawPh
         Q7vjyrprmvrIr21v8FiNebQbD+Vp4MG6GzrQLUwDz7NBM7Gx4tO0Dpybk362AK1JC+gk
         /f82XxtEZJfAybsQw126YyjlsCSSptpo2/HF/+y0AcGWQurE8kOjC+QYPFD6y5OArwXb
         z3BQ==
X-Gm-Message-State: APt69E3FUonA5+0cudEg6U2fBLbjHjF2RFmuDL5ShXGyFpLUZI/qbnp9
        rfKQezQxmeeoRL3jiwpBIuz95Q==
X-Google-Smtp-Source: AAOMgpf5+Evn+Fev4G0waqogLB9MOii5XQMVlixN2f6EpSCyaBJaV8bz7O97G7lpxcZFWbmko1s16Q==
X-Received: by 2002:adf:c844:: with SMTP id e4-v6mr4427370wrh.236.1530795898728;
        Thu, 05 Jul 2018 06:04:58 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:04:58 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 00/27] Venus updates
Date:   Thu,  5 Jul 2018 16:03:34 +0300
Message-Id: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v4:
 * 02/27 re-write intbufs_alloc as suggested by Alex, and
   moved new structures in 03/27 where they are used
 * 11/27 exit early if error occur in vdec_runtime_suspend
   venc_runtime_suspend and avoid ORing ret variable
 * 12/27 fixed typo in patch description
 * added a const when declare ptype variable

Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404

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
 drivers/media/platform/qcom/venus/helpers.c        | 568 +++++++++++++++++++--
 drivers/media/platform/qcom/venus/helpers.h        |  23 +-
 drivers/media/platform/qcom/venus/hfi.c            |  12 +-
 drivers/media/platform/qcom/venus/hfi.h            |  10 +
 drivers/media/platform/qcom/venus/hfi_cmds.c       |  62 ++-
 drivers/media/platform/qcom/venus/hfi_helper.h     | 112 +++-
 drivers/media/platform/qcom/venus/hfi_msgs.c       | 407 +++------------
 drivers/media/platform/qcom/venus/hfi_parser.c     | 278 ++++++++++
 drivers/media/platform/qcom/venus/hfi_parser.h     |  45 ++
 drivers/media/platform/qcom/venus/hfi_venus.c      | 108 +++-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |  10 +
 drivers/media/platform/qcom/venus/vdec.c           | 326 +++++++-----
 drivers/media/platform/qcom/venus/venc.c           | 220 ++++----
 17 files changed, 1702 insertions(+), 690 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
 create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h

-- 
2.14.1

