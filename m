Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B62C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0C2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA0C2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeILEqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeILEqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208213"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/9] HID: intel ISH: Cleanup patches
Date:   Tue, 11 Sep 2018 16:44:12 -0700
Message-Id: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a cleanup series only and help to abstract client API.

There are no functional changes.

Even Xu (6):
  hid: intel-ish-hid: ishtp: add helper function for driver data get/set
  hid: intel-ish-hid: use helper function for private driver data
    set/get
  hid: intel-ish-hid: ishtp: add helper functions for client buffer
    operation
  hid: intel-ish-hid: use helper function to access client buffer
  hid: intel-ish-hid: ishtp: add helper function for client search
  hid: intel-ish-hid: use helper function to search client id

Hong Liu (2):
  HID: intel-ish-hid: use resource-managed api
  HID: intel-ish-hid: using list_head for ipc write queue

Srinivas Pandruvada (1):
  HID: intel_ish-hid: Enhance API to get ring buffer sizes

 drivers/hid/intel-ish-hid/ipc/ipc.c           | 32 ++++----
 drivers/hid/intel-ish-hid/ipc/pci-ish.c       | 75 ++++++-------------
 drivers/hid/intel-ish-hid/ishtp-hid-client.c  | 41 ++++------
 drivers/hid/intel-ish-hid/ishtp/bus.c         | 52 +++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h         |  5 ++
 .../hid/intel-ish-hid/ishtp/client-buffers.c  | 49 ++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.c      | 24 ++++++
 drivers/hid/intel-ish-hid/ishtp/client.h      |  5 ++
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h   |  2 +-
 9 files changed, 188 insertions(+), 97 deletions(-)

-- 
2.17.1

