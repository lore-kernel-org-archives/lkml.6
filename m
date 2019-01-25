Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F42C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE07218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SP9JulM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfAYHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:11:33 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:52955 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfAYHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:11:33 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0P79684005418;
        Fri, 25 Jan 2019 16:09:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0P79684005418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548400148;
        bh=BBGdleYzecY8x+xlGbFcTsrDcwqsS07r3fQaHXaP1Iw=;
        h=From:To:Cc:Subject:Date:From;
        b=SP9JulM3EoDcgUDOSHTwE5k1998xlj4WdIuUiNnt5MBVpQZNjM1selbEhqMgZdqGC
         e5rz6vHAeOahS7K8S7bkLu762v07h1h3JmiyWC6PzNdAV9qcjcDTgXSyRFTb3Wy4yv
         Xgn9aUoECWf1+6LN1TNmoJBrq6yXVkalhDBm6m9XjFn6jprfr6ZaFbxyfHsoi4fIe/
         OcpfI6aR062n9yJcilsa8VLqzaXPpCRT85WCJWyOB44fQm1heDVtJ5oZC+6XBSVH1Y
         gB8TP8uYwwwuQn5VJrEEDT5ftL1o5UyjqdfeFLaim4OhQX8Wey4PYDeyiOskykErD6
         4Ay3MearTxMnQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Don Brace <don.brace@microsemi.com>,
        esc.storagedev@microsemi.com, Hannes Reinecke <hare@suse.com>,
        linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 0/2] scsi: trivial header search path fixups
Date:   Fri, 25 Jan 2019 16:09:02 +0900
Message-Id: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to do as many treewide cleanups as possible.

The full work of this is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test



Masahiro Yamada (2):
  scsi: remove unneeded header search paths
  scsi: prefix header search paths with $(srctree)/

 drivers/scsi/aacraid/Makefile  | 2 --
 drivers/scsi/aic7xxx/Makefile  | 1 -
 drivers/scsi/cxgbi/Makefile    | 2 +-
 drivers/scsi/pcmcia/Makefile   | 2 +-
 drivers/scsi/smartpqi/Makefile | 1 -
 5 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.7.4

