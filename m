Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F0C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1BF20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1BF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJNBDY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 21:03:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:57194 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeJNBDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 21:03:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2018 10:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,377,1534834800"; 
   d="scan'208";a="77798138"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 13 Oct 2018 10:25:22 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 13 Oct 2018 10:25:22 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.58]) with mapi id 14.03.0319.002;
 Sat, 13 Oct 2018 10:25:22 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL] dax fixes for 4.19-rc8
Thread-Topic: [GIT PULL] dax fixes for 4.19-rc8
Thread-Index: AQHUYxm35lwvUI/D2E6/HfmGYjPZGg==
Date:   Sat, 13 Oct 2018 17:25:21 +0000
Message-ID: <8f47e3ce3cbe6e165701dbf665bb1770ca13d907.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.9.138]
Content-Type: text/plain; charset="utf-7"
Content-ID: <9D8F3DFE51B5FC4AA2AA7296A322A211@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc8

...to receive (2) urgent dax fixes for 4.19-rc8. They have appeared in
a -next release.

However, note that commit d7782145e1ad (+ACI-filesystem-dax: Fix
dax+AF8-layout+AF8-busy+AF8-page() livelock+ACI-) is immediately replaced with the
Xarray conversion targeting 4.20, so d7782145e1ad is the backport
suitable fix for the livelock for v4.19 and earlier.

Please pull, thanks+ACE-

---

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc8

for you to fetch changes up to 4628a64591e6cee181237060961e98c615c33966:

  mm: Preserve +AF8-PAGE+AF8-DEVMAP across mprotect() calls (2018-10-09 11:44:58 -0700)

----------------------------------------------------------------
libnvdimm/dax 4.19-rc8

+ACo- Fix a livelock in dax+AF8-layout+AF8-busy+AF8-page() present since v4.18. The
  lockup triggers when truncating an actively mapped huge page out of a
  mapping pinned for direct-I/O.

+ACo- Fix mprotect() clobbers of +AF8-PAGE+AF8-DEVMAP. Broken since v4.5 mprotect()
  clears this flag that is needed to communicate the liveness of device
  pages to the get+AF8-user+AF8-pages() path.

----------------------------------------------------------------
Dan Williams (1):
      filesystem-dax: Fix dax+AF8-layout+AF8-busy+AF8-page() livelock

Jan Kara (1):
      mm: Preserve +AF8-PAGE+AF8-DEVMAP across mprotect() calls

 arch/powerpc/include/asm/book3s/64/pgtable.h +AHw-  4 +-+---
 arch/x86/include/asm/pgtable+AF8-types.h         +AHw-  2 +--
 fs/dax.c                                     +AHw- 13 +-+-+-+-+-+-+-+-+-+-+---
 3 files changed, 14 insertions(+-), 5 deletions(-)
