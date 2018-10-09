Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E355BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00582214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHuALDot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00582214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJIXq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36908 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so2686510wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=clz9bGcjtvJjYCkrdeVQS7ILo4c8Hn9yml6uUo1semc=;
        b=aHuALDotyg8fPV8vYfBjtdQZ2SWn2+lQmsm6GEzD2uRUNRcWTgtsG/1fjR7pOixyAG
         n8hvGn2iki6BoN27zojDoxbJpb/f4M0sBay2I50DI8H4+mwqpmLkh4YnicwdF5/iloNG
         yDRra2VSxJQi7joMRaukkUtU0D4fdYyMdri0lI7e38X2yn87hZzSIhH9yd+tT1pomv6a
         qjRQv3BkYiMF3d8Q5PWYGBLEQfn/0EGLpUxmJNbLIAiZ+M7haJLG4e6r8/wbS0Ri0wHi
         9SG/ULXirpLf0QYlg/aSNsFUFQ+JErq4zVUIGfvP4wSFWYu+lqT3Fyj9nsefUKQvg28V
         /Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=clz9bGcjtvJjYCkrdeVQS7ILo4c8Hn9yml6uUo1semc=;
        b=IR7v18GREvY1ykiTutzdc0QcxxB95PZ7w6pSx/lF8KettB6C9IPHkAqsB5mR6UdWqW
         uv0Y8n9fISixYbjagEWQd0m8D38UYZKDTdA74tRK9itDuNn1HfxK0jitcx0yFCnppSch
         8bouKtKigQlYyxH1qkzrj9xZYKebvEScLv0sdxsF5glYwum+xZ3Wvd620+0tHgsrT4IN
         GmwiHLBJ9gypSJhvlfPPVyfngBpu+DkIIlL7hA1v00tF6xG2MTNW3DmzzOK0qdXcTH4M
         onub6kB27TyjwS3IJtOxrdYosL8balDIqXHjkO35BLZUBx5CirJpYhD7+ws4EnME40E7
         f28w==
X-Gm-Message-State: ABuFfojQrNkGDbx+Itdi1h8LAno1p0mqp0jeYbK4HmzoVNQ2D8Rpftm/
        YfwbntY22YXQXylmEQmDXc4=
X-Google-Smtp-Source: ACcGV61CAM70H/lu7/TQrdy71/jQc0dxHLeZsutqkIuVLc2yr8BBu5CQQujgArIXSFz1bSjOlKeYwg==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr2593968wmf.109.1539102522497;
        Tue, 09 Oct 2018 09:28:42 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:28:42 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 00/18] RDMA: Add support for ib_device_ops
Date:   Tue,  9 Oct 2018 19:27:59 +0300
Message-Id: <20181009162817.4635-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduce a new structure that will contain all the
infiniband device operations, the structure will be used by the
providers to initialize their supported operations. This patchset also
includes the required changes in the core and ulps to start using it.

Thanks,
Kamal

Kamal Heib (18):
  RDMA/core: Introduce ib_device_ops
  RDMA/bnxt_re: Initialize ib_device_ops struct
  RDMA/cxgb3: Initialize ib_device_ops struct
  RDMA/cxgb4: Initialize ib_device_ops struct
  RDMA/hfi1: Initialize ib_device_ops struct
  RDMA/hns: Initialize ib_device_ops struct
  RDMA/i40iw: Initialize ib_device_ops struct
  RDMA/mlx4: Initialize ib_device_ops struct
  RDMA/mlx5: Initialize ib_device_ops struct
  RDMA/mthca: Initialize ib_device_ops struct
  RDMA/nes: Initialize ib_device_ops struct
  RDMA/ocrdma: Initialize ib_device_ops struct
  RDMA/qedr: Initialize ib_device_ops struct
  RDMA/qib: Initialize ib_device_ops struct
  RDMA/usnic: Initialize ib_device_ops struct
  RDMA/vmw_pvrdma: Initialize ib_device_ops struct
  RDMA/rxe: Initialize ib_device_ops struct
  RDMA: Start use ib_device_ops

 drivers/infiniband/core/cache.c                    |  12 +-
 drivers/infiniband/core/core_priv.h                |  12 +-
 drivers/infiniband/core/cq.c                       |   6 +-
 drivers/infiniband/core/device.c                   | 136 +++++++++++--
 drivers/infiniband/core/fmr_pool.c                 |   4 +-
 drivers/infiniband/core/mad.c                      |  24 +--
 drivers/infiniband/core/nldev.c                    |   4 +-
 drivers/infiniband/core/opa_smi.h                  |   4 +-
 drivers/infiniband/core/rdma_core.c                |   6 +-
 drivers/infiniband/core/security.c                 |   8 +-
 drivers/infiniband/core/smi.h                      |   4 +-
 drivers/infiniband/core/sysfs.c                    |  26 +--
 drivers/infiniband/core/uverbs_cmd.c               |  64 +++---
 drivers/infiniband/core/uverbs_main.c              |  14 +-
 drivers/infiniband/core/uverbs_std_types.c         |   2 +-
 .../infiniband/core/uverbs_std_types_counters.c    |  10 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   4 +-
 drivers/infiniband/core/uverbs_std_types_dm.c      |   6 +-
 .../infiniband/core/uverbs_std_types_flow_action.c |  14 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |   4 +-
 drivers/infiniband/core/verbs.c                    | 149 +++++++-------
 drivers/infiniband/hw/bnxt_re/main.c               |  97 +++++----
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |  64 +++---
 drivers/infiniband/hw/cxgb4/provider.c             |  74 +++----
 drivers/infiniband/hw/hfi1/verbs.c                 |  19 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  11 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  11 ++
 drivers/infiniband/hw/hns/hns_roce_main.c          |  91 ++++-----
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  66 ++++---
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  | 166 +++++++++-------
 drivers/infiniband/hw/mlx5/main.c                  | 220 ++++++++++++---------
 drivers/infiniband/hw/mthca/mthca_provider.c       | 139 ++++++++-----
 drivers/infiniband/hw/nes/nes_cm.c                 |   2 +-
 drivers/infiniband/hw/nes/nes_verbs.c              |  66 ++++---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |  92 ++++-----
 drivers/infiniband/hw/qedr/main.c                  | 103 +++++-----
 drivers/infiniband/hw/qib/qib_verbs.c              |   8 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |  61 +++---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |  82 ++++----
 drivers/infiniband/sw/rdmavt/vt.c                  |  90 ++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  90 +++++----
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  12 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |   4 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |   8 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 include/rdma/ib_verbs.h                            | 212 ++++++++------------
 net/sunrpc/xprtrdma/fmr_ops.c                      |   2 +-
 50 files changed, 1257 insertions(+), 1057 deletions(-)

-- 
2.14.4

