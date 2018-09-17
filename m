Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA997ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A11420684
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A11420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:40:32 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:41848
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeIQJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:40:32 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 1kv8gSGk8nFs21kv8gjcTf; Sun, 16 Sep 2018 21:13:59 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g1kv8-0002yd-Ea; Sun, 16 Sep 2018 21:13:58 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/2] Drivers: hv: Miscellaneous fixes 
Date:   Mon, 17 Sep 2018 04:13:52 +0000
Message-Id: <20180917041352.11402-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfEgp5FimPV9Yv9XOIwfWQfPHaaZOfdvM/LpXveBiRW7OW1z+lgiekWG9ZqXfqmOFeGW8xjAQQIKNCLQN4Z+MnUamHgV8wkY/l+p1QJ/PwLWRbAzeRGkx
 uvlclJHJSX16gy5Iyo2bdjCGCUK+6oHgsc8UJ5GcODNbL4RvGmcFYPPgAW2xmPVtasaE46o/xjizv9HGb/YreAuAQxW9RTKBstQMtd1khOc2GuuIYAt7PvMG
 R1vJwyJClWyGQfXcVHwDy9qG5vG3l/J2x9UtxTFZa45VZWRbCgVyaM+CwCl6CgXw5x5v9sxUwis0l92IDylzSJraiGFTVSON0bhytLUciZ+3MRl9VgoNht7S
 QuzQNLBpyRxAc86nctCoaPpweBXhHOSKP1aqk4XsqSX7jsO6wCWKKf0A3RzxrLaqB0zRYz1NjAXMXo73hT2VXC3wfRP9UcZvV1l9ZTiGNzaNhUWogoPnDRqt
 e9ZDzvHUgG+JnbNaeBotfbIKL6yhiJ4FHhXDBvrzKxu6mX7FQEBS8jvmoyevDtPdRaWIQ5J9BSlokQ8a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Some miscellaneous fixes.

Dexuan Cui (1):
  Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Vitaly Kuznetsov (1):
  tools: hv: fcopy: set 'error' in case an unknown operation was
    requested

 drivers/hv/connection.c    | 8 +++++---
 tools/hv/hv_fcopy_daemon.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.18.0

