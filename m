Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907AEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED9208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED9208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934324AbeGJPku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:40:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeGJPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:40:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C75080D;
        Tue, 10 Jul 2018 08:40:49 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219723F589;
        Tue, 10 Jul 2018 08:40:47 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Minor thermal_hwmon cleanups
Date:   Tue, 10 Jul 2018 16:40:33 +0100
Message-Id: <20180710154035.26828-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches address a couple of minor issues I noticed while
hacking on a Chromebook (Google kevin platform).

The first one converts the device name passed to hwmon to containing
'_' instead of '-' (which hwmon barfs at).

The second one passes the thermal zone device to the hwmon subsystem,
making sure that messages from hwmon are not completely misleading,
and placing the related hwmon device at the correct spot in the
hierarchy.

Thanks,

	M.

Marc Zyngier (2):
  thermal_hwmon: Sanitize attribute name passed to hwmon
  thermal_hwmon: Pass the originating device down to
    hwmon_device_register_with_info

 drivers/thermal/thermal_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.18.0

