Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA0BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED13208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED13208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJRNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:20:05 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:49668
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbeJRNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:20:04 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 09:20:04 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id D0Y1gQ5KMCT0vD0Y1g5fEH; Wed, 17 Oct 2018 22:08:37 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gD0Y1-0007FY-BK; Wed, 17 Oct 2018 22:08:37 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 0/5] Drivers: hv: Miscellaneous fixes
Date:   Thu, 18 Oct 2018 05:08:35 +0000
Message-Id: <20181018050835.27828-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGj3tXCk3cM95HDxa4kPdfJvApKFX1Bb6pvbr1WDLbkmb+AH/XFr2HQuDxqFPXCIerzJYV7vt3EEUDtcUQlZ/wgCBJY0hTnADRvKNZH/W9Jf6Zc6sRTz
 Gn2JIuf2E7nOZjuaGjiZ0G37v62yKntE5/3jS38ssaa/EtyQrttc1IFXFGzkFHCXFWulpZrdJMQFsm5pm8qpnB081Hmo+Lpx+iz+qmbJK5tIh2FFU4541Tqw
 M4d5BXFh6wjLw2rcnkZ3Ye7C0UUNBOJas5HRd7mxUN82Mh2wvx0LluvnfJWS+cauLZ/pd8jPy4BXG75rr9XmNDsv6nhJmjuS1daJijk9GTd/AN465Pu5JrHX
 08zxCDvwBZP+kzMFpMuIOdJe+0e91TLOVz3l4TArgRuNvoj0Jcl99iwl1Ubqfm+fEy6a9Lk28FoC6psGuGU+N5su5axgRtzlJjEJzGlUdLbtspivLsuq2TAR
 agC4RBw0jf9LkOZmWl9ksarm3J01eXU7Ur8WE+RhjWJuBhmiRI3snBs5xqaQnjr5MHQOxwmWSVZ//Epm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

V2: Addressed comments from Greg.

Dexuan Cui (3):
  Drivers: hv: kvp: Fix the recent regression caused by incorrect
    clean-up
  Drivers: hv: kvp: Use %u to print U32
  Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1

Haiyang Zhang (1):
  hv_utils: update name in struct hv_driver util_drv

K. Y. Srinivasan (1):
  Drivers: hv: vmbus: Get rid of unnecessary state in hv_context

 drivers/hv/hv.c           | 10 +++-------
 drivers/hv/hv_kvp.c       | 28 +++++++++++++++++++++++-----
 drivers/hv/hv_util.c      |  2 +-
 drivers/hv/hyperv_vmbus.h |  2 --
 tools/hv/hv_kvp_daemon.c  | 15 +++++++++++++--
 5 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.18.0

