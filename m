Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC1620823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBUPuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfBUPuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108109"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:20 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>
Subject: [GIT PULL v1 1/7] intel_th: Update ABI documentation
Date:   Thu, 21 Feb 2019 17:50:00 +0200
Message-Id: <20190221155006.76832-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a753bfcfdb1f3 ("intel_th: Make the switch allocate its subdevices")
changed the behavior so that the output port devices are created only for
the ports reported by the hardware and their initial state is "unassigned"
until a corresponding output port driver is loaded. Reflect this fact in
the ABI documentation.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reported-by: Ricardo Neri <ricardo.neri@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-intel_th-output-devices | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-output-devices b/Documentation/ABI/testing/sysfs-bus-intel_th-output-devices
index 4d48a9451866..d1f667104944 100644
--- a/Documentation/ABI/testing/sysfs-bus-intel_th-output-devices
+++ b/Documentation/ABI/testing/sysfs-bus-intel_th-output-devices
@@ -3,11 +3,13 @@ Date:		June 2015
 KernelVersion:	4.3
 Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 Description:	(RW) Writes of 1 or 0 enable or disable trace output to this
-		output device. Reads return current status.
+		output device. Reads return current status. Requires that the
+		correstponding output port driver be loaded.
 
 What:		/sys/bus/intel_th/devices/<intel_th_id>-msc<msc-id>/port
 Date:		June 2015
 KernelVersion:	4.3
 Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 Description:	(RO) Port number, corresponding to this output device on the
-		switch (GTH).
+		switch (GTH) or "unassigned" if the corresponding output
+		port driver is not loaded.
-- 
2.20.1

