Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFFFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A122B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A122B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbeGLOVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:21:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:62688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732302AbeGLOUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="57137137"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 07:11:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/3] mei: more type conversion issues.
Date:   Thu, 12 Jul 2018 17:10:07 +0300
Message-Id: <20180712141010.11277-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more type conversion issues.
The first one in also address the type promotion bug,
as reported by Dan Carpenter. The particular error should
not really happen unless something is completely wrong, so no urge
to merging them into stable.

Tomas Winkler (3):
  mei: check for error returned from mei_hbuf_empty_slots()
  mei: use correct type for counter variable in for loops
  mei: fix ssize_t to int assignment in read and write ops.

 drivers/misc/mei/bus-fixup.c |  2 +-
 drivers/misc/mei/client.c    | 44 +++++++++++++++++++++++++++-----------------
 drivers/misc/mei/client.h    |  2 +-
 drivers/misc/mei/hw-me.c     |  7 +++++--
 drivers/misc/mei/hw-txe.c    |  4 ++--
 drivers/misc/mei/interrupt.c | 15 +++++++++++----
 drivers/misc/mei/main.c      | 10 +++++-----
 7 files changed, 52 insertions(+), 32 deletions(-)

-- 
2.14.4

