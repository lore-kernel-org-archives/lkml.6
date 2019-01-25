Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AEDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C11218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hpafh3fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfAYElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:41:11 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53533 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfAYElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:41:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0P4dtwW005225;
        Fri, 25 Jan 2019 13:39:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0P4dtwW005225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548391197;
        bh=TYzdMtaElxEvjE4XJy8WUhE/OSL0V4BiPYumJ9K6zgE=;
        h=From:To:Cc:Subject:Date:From;
        b=hpafh3fPF4mOWvHb6+03MYdR3kM3h0OJi9/PLxWjsMFpLRdrLOZdHcC7648Au/I5+
         eyV3Z4woRNun6AtqaBojBsyGota0gF6TNfFUqlX96WMgrpv8eKAe/xa/9QBPP1QXhw
         PPdvotVBCUa0RwQbpkrlzc5bdrdL10oxQpWmqubCUnjfSU676ZIEQCXnXksp5cMl5J
         qmI6vPHzVFMLbjNObsickTWXl8PZo1n3D3rxuvU8nDgCSSy37hJ4tgV6CtRnQBc7i5
         zX/uc4p/GtgLhqQTj1vBkTN2kkuhvWTKUdvwOTN0DT3wqRuuXEhzAI6FtNGJ/+TCO5
         3Uf/pJzJoX7QA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nelson Escobar <neescoba@cisco.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        linux-kernel@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Steve Wise <swise@chelsio.com>, target-devel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH 0/2] infiniband: trivial header search path fixups
Date:   Fri, 25 Jan 2019 13:39:29 +0900
Message-Id: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to do as many treewide cleanups as possible.

If you are interested in the big picture of this work,
the full patch set is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test



Masahiro Yamada (2):
  infiniband: remove unneeded header search paths
  infiniband: prefix header search paths with $(srctree)/

 drivers/infiniband/hw/bnxt_re/Makefile | 2 +-
 drivers/infiniband/hw/cxgb3/Makefile   | 2 +-
 drivers/infiniband/hw/cxgb4/Makefile   | 4 ++--
 drivers/infiniband/hw/hns/Makefile     | 2 +-
 drivers/infiniband/hw/i40iw/Makefile   | 2 +-
 drivers/infiniband/hw/ocrdma/Makefile  | 2 +-
 drivers/infiniband/hw/usnic/Makefile   | 2 +-
 drivers/infiniband/ulp/isert/Makefile  | 1 -
 drivers/infiniband/ulp/srpt/Makefile   | 1 -
 9 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.7.4

