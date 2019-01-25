Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B849C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6C218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xwPjnjNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfAYEko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:40:44 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:52671 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfAYEko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:40:44 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0P4dtwX005225;
        Fri, 25 Jan 2019 13:39:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0P4dtwX005225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548391197;
        bh=l2QkZoUINJcHwTUjAs2NF9C9FJvAyTfR0K8RqgdK+gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwPjnjNLbpVsuV0jOh0DTqCMNwYvKff4Zl2s+YW6aWZG2i4rofOMCCithEYnXFw6w
         2r051qgqR9xXxheVKZt1KIZoXrZEQk15ct1NJD6UoniyDya9d6jgKZVrbgmedGujiJ
         cAo4IaNBBzx6dq3cvSGMJwF3dJSoHPp1K80bSFV1WRZZHZHX9uCPbr5CcYuuhV5mF4
         l3B/jbGs35TRq8dpRnLck4uUgQFLMDN6HYTWsQ/hCEPlleH6A8jLy7gUusaKAuUmGR
         Vnsa4aWw6BNbOt1mmOQDOWN7TOSPQDv5UbLNtL7/HfBOBDvXTWqH6Mm3pcXRPJS45J
         2/b/bZGB9LFlQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        target-devel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] infiniband: remove unneeded header search paths
Date:   Fri, 25 Jan 2019 13:39:30 +0900
Message-Id: <1548391171-6407-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The included headers are located in include/target/. I was able to
build these drivers without the extra header search paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/infiniband/ulp/isert/Makefile | 1 -
 drivers/infiniband/ulp/srpt/Makefile  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/Makefile b/drivers/infiniband/ulp/isert/Makefile
index c8bf242..a4a4766 100644
--- a/drivers/infiniband/ulp/isert/Makefile
+++ b/drivers/infiniband/ulp/isert/Makefile
@@ -1,2 +1 @@
-ccflags-y		:= -Idrivers/target -Idrivers/target/iscsi
 obj-$(CONFIG_INFINIBAND_ISERT)	+= ib_isert.o
diff --git a/drivers/infiniband/ulp/srpt/Makefile b/drivers/infiniband/ulp/srpt/Makefile
index e3ee4bd..43fbde4 100644
--- a/drivers/infiniband/ulp/srpt/Makefile
+++ b/drivers/infiniband/ulp/srpt/Makefile
@@ -1,2 +1 @@
-ccflags-y			:= -Idrivers/target
 obj-$(CONFIG_INFINIBAND_SRPT)	+= ib_srpt.o
-- 
2.7.4

