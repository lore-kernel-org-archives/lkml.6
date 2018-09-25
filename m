Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0512086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0512086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIZBpT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:45:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:44090 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeIZBpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:45:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 12:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="73643796"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2018 12:36:04 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 25 Sep 2018 12:36:04 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.194]) with mapi id 14.03.0319.002;
 Tue, 25 Sep 2018 12:36:04 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL v2] libnvdimm/dax fixes for 4.19-rc6
Thread-Topic: [GIT PULL v2] libnvdimm/dax fixes for 4.19-rc6
Thread-Index: AQHUVQb+3cyEGrg4AkWhSrBxy+A4FQ==
Date:   Tue, 25 Sep 2018 19:36:03 +0000
Message-ID: <1537904158.7585.65.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.22.212]
Content-Type: text/plain; charset="utf-7"
Content-ID: <5DCFF9D4061504428054504D696DB72D@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, please pull from...

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc6

...to receive a regression fix and 2 other fixes. Details are in the
tag message. Arguably only the 'address+AF8-space+AF8-operations' fix is urgent
for -rc6, the others can reasonably wait, but I see no reason to hold
them back. This has all appeared in -next with no reported issues.

---

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc6

for you to fetch changes up to 41c9b1be335b5afc3b5fb71c5d16f9d5939cd13f:

  device-dax: Add missing address+AF8-space+AF8-operations (2018-09-22 09:07:33 -0700)

----------------------------------------------------------------
libnvdimm/dax for 4.19-rc6

+ACo- (2) fixes for the dax error handling updates that were merged for
v4.19-rc1. My mails to Al have been bouncing recently, so I do not have
his ack but the uaccess change is of the trivial / obviously correct
variety. The address+AF8-space+AF8-operations fixes a regression.

+ACo- A filesystem-dax fix to correct the zero page lookup to be compatible
 with non-x86 (mips and s390) architectures.

----------------------------------------------------------------
Dave Jiang (2):
      uaccess: Fix is+AF8-source param for check+AF8-copy+AF8-size() in copy+AF8-to+AF8-iter+AF8-mcsafe()
      device-dax: Add missing address+AF8-space+AF8-operations

Matthew Wilcox (1):
      filesystem-dax: Fix use of zero page

 drivers/dax/device.c +AHw-  6 +-+-+-+-+-+-
 fs/dax.c             +AHw- 13 +-+------------
 include/linux/uio.h  +AHw-  2 +--
 3 files changed, 9 insertions(+-), 12 deletions(-)
