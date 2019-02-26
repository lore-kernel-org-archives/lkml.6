Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EB72184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cklsu23B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfBZPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:10:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37173 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551193836; x=1582729836;
  h=from:to:cc:subject:date:message-id;
  bh=0wzQ1v2y1vObejlpEt3X3iB+iw201UjwSxrZASF8EUQ=;
  b=cklsu23BLhIXtI9iRlJM53U7cjGtGvOhQEOEwcmsykkd1Oim5Hg6bcYK
   oBRPNK0s6WuY/HAGPTK72rLo/WuBIZ4jfeL3suOa9YTmLZkPdMgI2hz5F
   AK2qJLGGb+rOd3BZuT09875+iwlTaVnf6+J/TdUgBKX3d2kIeYXspije3
   0XwXyhh6bul2KDi0WfrTKWSMMogziXatiPqk7zKMTSRjLBvZnzfrTwoSl
   L7jonWkmPbT2nBo+Wz9cDTpjycGLuVozYGSi8RbYGi7KKgMkcFjS3g7U3
   pnW+GeHa8EtyuvGxrr6S+GIpdiclDZcBdfBLWkUzgsO0jkH/OzXxE7Fg2
   A==;
X-IronPort-AV: E=Sophos;i="5.58,416,1544457600"; 
   d="scan'208";a="103943145"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 23:10:36 +0800
IronPort-SDR: 6l7HOTtck6GH5TbR+DOB2T6FAZZhjq4SDLWRB+/rdIu1N5fkgCa0ekE57Ne+QqddnCjPMmNUQ8
 PZyBa6JYnXv4Io4KhsElOS/X3wtdpjCwCzyB/RrFf08PQ0zHTQW25vmlL1smEZ0Fj/+C0/uyAK
 xoz6CnrrTkV/RO0/p1S7PAX/g73Cu874cU83Cs3WGdNy5XRSAhL2fHw7cVCpeNmAWKkoQCUBBv
 /zL5I/vq5P/tUGH/Ug/CYO0AfyRc5c/CGs7aWOFAzLcGBJdErou7GbzYjboUIvcgQ32VVH0zCb
 tKbGCvaW74jVWTKTtbopIoYD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Feb 2019 06:48:48 -0800
IronPort-SDR: 6Bvrm3wjHCjsijQP+mlcHt6NqAc8nvTuV92FO6TZ8vxrn/OgtHxYX9h/lkNVvA1B+7Y5BdFzVR
 /O7RAlp1uUNSjf0Ob0GdOxb6RJrurUmx4KMYQCcE+vRRX2ZkX+dPYDaJo6ZEmoaL3JKveoLBsx
 J6+LU0YbwM4JtfiA7mlJ9zzn0b80pb011FWq42zHtvJ3ObvkWzwGJbOaFJEDtxtw+ctmHTJNFp
 rA7D94JQmeAmJ4Y/i+dP8byNdpSpc6iN2eyaZ1EVRekBUbNDgpS6ZMJVhBVwQxj10p1E7bgfZK
 fPU=
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2019 07:10:33 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/2] mmc: core: Add SD Discard support
Date:   Tue, 26 Feb 2019 17:10:23 +0200
Message-Id: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands matches those
in eMMC, Which leaves to set the appropriate discard arg in CMD38 if
DISCARD_SUPPORT (b313) is set in the SD_STATUS register.

We set this arg on card init: not in mmc_init_erase as one might expect
but arbitrarily once the card indicated its discard support.  This is
because unlike erase, it doesn't really involve any logic, and we want
to avoid the unnecessary complication.

V2->v3:
The first 2 patches in the series got accepted.
Elaborate the changelog of some of the differences between discard and
erase. Clean some inconsistency in arg checking in mmc_erase().
Add a patch to set the timeout for sd discard.

V1->v2:
In the first patch, assign the discard arg for SD cards as well to keep
the code consistent. Rename "discard_arg" to "erase_arg", and elaborate
the change log.


Avri Altman (2):
  mmc: core: Add discard support to sd
  mmc: core: Add sd discard timeout

 drivers/mmc/core/core.c | 15 +++++++++++----
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.9.1

