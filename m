Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C61120862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C61120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeHBE5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:57:17 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:60886
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbeHBE5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:57:17 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id l3xQff6paVktnl3xQfqigO; Wed, 01 Aug 2018 20:07:20 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fl3xP-0002nQ-U1; Wed, 01 Aug 2018 20:07:19 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/3] Drivers: hv: vmbus: Miscellaneous fixes 
Date:   Thu,  2 Aug 2018 03:07:18 +0000
Message-Id: <20180802030718.10708-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGY7Pyyaynv2IHshvXtrI1iZI32aDGXeu0ALrC//hiMfVazNLaRJFRbccmPRN7lynCJQt1Elm5wMJynyFh1ymGLDKHV0ZYdQc1lc33AXEm8mZvNCIaBB
 oe64ZDPU2O1J5OzO8Q/7xBTsLmCfwtwq8VitA+9AAtSGBeHdNZq8e/prYuj9oG2bMoAPNoiGZrYReYOb0+HE4WBFxvVLDOen1wI9WCMo4+bVgdM3CukRNjTO
 xXP9pkNmq4vmzd7UnFt+9DLntRlK7mMTQ1PDc7WsPn9A6sJoxzhsVcK54MWI30YtuJ7ltxHx57c+sRw+JGwiBNVD9ylFTO0SzTUdLmBb+AsdKLNuOsZ10chi
 EFsGitXJn7BmhlkWkO/Ra0uXMR3tgJm6tyqB+Ny2GxjGcUcawbKyswzov4gCuSHyT8HI97RcUxSFkGXjgpYqaLbHNx0RBdktBxjRAk36jLvA3xoGDo/Jh7i1
 UGHL66RV72g+4qH7CfaGptgOz01fqOrqprzBev51ptP6ENVZHnfyEDbDhlJwDh1c/yAD+m09sfpCppX5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

Dexuan Cui (1):
  Drivers: hv: vmbus: Reset the channel callback in
    vmbus_onoffer_rescind()

Michael Kelley (2):
  Drivers: hv: vmbus: Remove use of slow_virt_to_phys()
  Drivers: hv: vmbus: Cleanup synic memory free path

 drivers/hv/channel.c      | 67 +++++++++++++++++++++++++--------------
 drivers/hv/channel_mgmt.c |  6 ++++
 drivers/hv/hv.c           | 14 ++++----
 include/linux/hyperv.h    |  2 ++
 4 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.17.1

