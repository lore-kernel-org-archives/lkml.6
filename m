Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77466C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444B720820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444B720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409409AbeKWVZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:25:33 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:13399
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390243AbeKWVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:25:32 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AbAACP2Pdb/7650XYNVRwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVMFAQELAYgLlGEBAQEBAQEGhHeFV44igXqEdAMChDc2Bw0BAwEBAQE?=
 =?us-ascii?q?BAQKGVCdWKAEMAiYCSRaFKaY7cIEvGol9gQuBc4kieIEHjCWCVwKIfySGOTO?=
 =?us-ascii?q?PcwmRRwoCiWkDhxCZfQ2BeU0uCoMokGaODQEB?=
X-IPAS-Result: =?us-ascii?q?A2AbAACP2Pdb/7650XYNVRwBAQEEAQEHBAEBgVMFAQELA?=
 =?us-ascii?q?YgLlGEBAQEBAQEGhHeFV44igXqEdAMChDc2Bw0BAwEBAQEBAQKGVCdWKAEMA?=
 =?us-ascii?q?iYCSRaFKaY7cIEvGol9gQuBc4kieIEHjCWCVwKIfySGOTOPcwmRRwoCiWkDh?=
 =?us-ascii?q?xCZfQ2BeU0uCoMokGaODQEB?=
X-IronPort-AV: E=Sophos;i="5.56,269,1539619200"; 
   d="scan'208";a="122563320"
Received: from unknown (HELO [192.168.1.28]) ([118.209.185.190])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 23 Nov 2018 18:41:44 +0800
Subject: [PATCH v2 0/5] autofs updates
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:41:41 +0800
Message-ID: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- improve file system verification for ioctl case.
- fix potential inode leak in mount code.
- add "strictexpire" autofs mount option.

v2 changes:
- fix compile error.
- deffer some of the mount option re-factoring to try and
  avoid any conflicts with linux-next.

---

Ian Kent (5):
      autofs - improve ioctl sbi checks
      autofs - fix possible inode leak in autofs_fill_super()
      autofs - simplify parse_options() function call
      autofs - change catatonic setting to a bit flag
      autofs - add strictexpire mount option


 fs/autofs/autofs_i.h         |   11 ++++--
 fs/autofs/dev-ioctl.c        |   29 +++++-----------
 fs/autofs/init.c             |    2 +
 fs/autofs/inode.c            |   75 +++++++++++++++++++++++++-----------------
 fs/autofs/root.c             |   16 ++++++---
 fs/autofs/waitq.c            |   10 +++---
 include/uapi/linux/auto_fs.h |    2 +
 7 files changed, 78 insertions(+), 67 deletions(-)

--
Ian
