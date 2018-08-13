Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE29B2177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE29B2177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeHMJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:28:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:14040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHMJ2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:28:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2018 23:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,232,1531810800"; 
   d="scan'208";a="65678858"
Received: from anshuma1-pnp-server.iind.intel.com ([10.223.107.119])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2018 23:48:00 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
Subject: [Query] USB device autosuspend and its runtime usage count.
Date:   Mon, 13 Aug 2018 12:15:58 +0530
Message-Id: <1534142758-387-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
I need to test a functionality with USB autosuspend with latest kernel          
Linux 4.18-rc8. I am trying to autosuspend a USB key board, i enabled       
its autosuspend by doing echo "auto" to its "control" attributes.
I am expecting USB keyboard to go to autosuspend after autosuspend_delay_ms.
But USB key board is not going to autosuspend because its runtime usage
count is not equal to zero.

Below are the log snippets:

root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_enabled
enabled
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/control
auto
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/autosuspend_delay_ms
2000
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_status
active
root@intel-Kabylake-Client-platform:# cat /sys/bus/usb/devices/1-5/power/runtime_usage
1
root@intel-Kabylake-Client-platform:# sleep 60; cat /sys/bus/usb/devices/1-5/power/runtime_usage
1

My USB keyboard runtime usage reference count is not decreasing to zero.
Here am i missing something regarding runtime usage count or is it some issue with
my kernel or OS?

Thanks,
Anshuman Gupta.
