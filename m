Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B1C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079062089A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079062089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbeG1XZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:25:30 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:46292
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731319AbeG1XZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:25:30 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id jXCSfr7ipdH2EjXCSfTBt2; Sat, 28 Jul 2018 14:56:32 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fjXCR-0003Zs-Vs; Sat, 28 Jul 2018 14:56:32 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/4] Drivers: hv: vmbus: Miscellaneous fixes/enhancements 
Date:   Sat, 28 Jul 2018 21:56:30 +0000
Message-Id: <20180728215630.13712-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHXg6Nom4fEmmXXGNPXQvpqIi4HZTfP8+lgyh29ACpHtClwwfMq9kZItLTp/S8s1bKjN7ibz0u42tSke6r9+Q6i6spMJoRZpxTTd6gaxZzBq8tFnzTuT
 0/DWFR1Z03AWMoJZ2XR4GyKPoRLWt4JNb396SuVOG8eIsoEdK6maPX4hIBU8hTBWODmp3pzW+LeBaBH1MvKNdTz9IANbCdevz6Zc1423uZQo+gmBLvZz0ybQ
 h//HnpM4WyF2jPjWTJ7FOHBg6YJ6bRQVGN1MRHYRo8+/OHqs6WCTRmmaED6xcrWfh7EJWKeeTFWp6cVE6waiPc8labjPE5kSTu5Ws8C46JncA18HQygY7LJt
 DtS7tnGxRBiQLL3XKiJ3N08B6LVHa4CpchAmlorDK0TdDedh1HqA5xNGkrJ0IUrMWPNPgvF23sDd0pG7T49Qup+AO2XohA9HkNFpjSuTIylMJ5C6ZYarX5Lu
 uCvnP0DLodEz8y7PuYbgHqKkP/AfuH4RW1qil4O2FP3B4aPk0yXbaCFs2e5dgjU19APPEirjDUPsTeqV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes/enhancements

Stephen Hemminger (1):
  Drivers: hv: vmbus: add numa_node to sysfs

Sunil Muthuswamy (3):
  Drivers: hv: vmus: Fix the check for return value from kmsg get dump
    buffer
  Drivers: hv: vmbus: Fix the issue with freeing up hv_ctl_table_hdr
  Drivers: hv: vmbus: Get rid of MSR access from vmbus_drv.c

 Documentation/ABI/stable/sysfs-bus-vmbus |  7 ++++
 arch/x86/include/asm/mshyperv.h          |  3 ++
 drivers/hv/vmbus_drv.c                   | 44 ++++++++++++++----------
 3 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.17.1

