Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0xzgG5YYG1vkPwAAmS7hNA
	; Sat, 09 Jun 2018 00:08:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 139B4608B8; Sat,  9 Jun 2018 00:08:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B662607A4;
	Sat,  9 Jun 2018 00:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B662607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeFIAId (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:08:33 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60560 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753026AbeFIAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:08:27 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQd-00043m-2R; Fri, 08 Jun 2018 18:08:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQb-0003cl-Cz; Fri, 08 Jun 2018 18:08:21 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:10 -0600
Message-Id: <20180609000819.13883-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here are all the fixes required to get ntb_test on switchtec working
again after the multi-port test patches were merged.

I'd appreciate it if future changes can be a) more careful about
not breaking things, b) communicated more clearly so that better
review can be done, and c) not merged until sufficient review actually
is done.

Note, I sent the first patch in this series earlier; please disregard
the earlier one.

Thanks,

Logan

Logan Gunthorpe (8):
  NTB: ntb_tool: reading the link file should not end in a NULL byte
  NTB: Setup the DMA mask globally for all drivers
  NTB: Fix the default port and peer numbers for legacy drivers
  NTB: ntb_pingpong: Choose doorbells based on port number
  NTB: perf: Don't require one more memory window than number of peers
  NTB: perf: Fix support for hardware that doesn't have port numbers
  NTB: perf: Fix race condition when run with ntb_test
  NTB: ntb_test: Fix bug when counting remote files

 drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
 drivers/ntb/hw/intel/ntb_hw_intel.c     |  4 ----
 drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
 drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
 drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
 drivers/ntb/test/ntb_tool.c             |  3 +--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 8 files changed, 41 insertions(+), 36 deletions(-)

--
2.11.0
