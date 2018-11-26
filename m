Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3287C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKZNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:22:01 -0500
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:44378
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbeKZNWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:22:01 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id R6dLg6hHcvsMIR6dLgBQQq; Sun, 25 Nov 2018 19:28:23 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gR6dL-0002wS-6Z; Sun, 25 Nov 2018 19:28:23 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous fixes 
Date:   Mon, 26 Nov 2018 02:28:21 +0000
Message-Id: <20181126022821.11269-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBbgQaewNdlakNpmXYFq8Mwjl7wXkixebBYyB2iFbOXdfTrA8vjKv/LlE5KHrEarqIpN7VZNKZbNNv6jabB6GWD974cMGNHHfYqN6HF+3bMEAV6c2LEd
 La9SdX3tFwyiVTnQybt9PWdzv3O2hTeYiZYrMPXXaosb4Gb0DAC5nQzWyftRhgS8i4Q0p07RlC3TfVpyqlWpXgeOCrNJNDW1NQw+VwsdacwxAO7F+HXQMSPJ
 8QbsOf+PnQQgxw7q2/1Ty2U1XRQnThF95pZn9x15vUhgMznkpxGEACMaRSBylJwE7n1U2xk9ohiqY2IJcC1L64lLjBgBpyNa8XsWKwlJ2QYVTMf09hStOvKx
 mVhNDHawS8pIUSXgCSrwE9f68anxkONpN5zVvw6jnK1ne93WEE6qD21iCU48E4qtqvzdKclP0iUgfv0b9puLj58hfms2743g7PCeVaBcX1eRtRaNpdEX3Jle
 w8BGiO0YuSeDj0TYdXDEr4ol3H3jUnm1RW+YSlPbO1i7+1LfNOcPc6p7M2fxIr1RoeKsNRk5a93EXbqy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

Dexuan Cui (2):
  Drivers: hv: vmbus: check the creation_status in
    vmbus_establish_gpadl()
  Drivers: hv: vmbus: offload the handling of channels to two workqueues

 drivers/hv/channel.c      |   8 ++
 drivers/hv/channel_mgmt.c | 188 +++++++++++++++++++++++++-------------
 drivers/hv/connection.c   |  24 ++++-
 drivers/hv/hyperv_vmbus.h |   7 ++
 include/linux/hyperv.h    |   7 ++
 5 files changed, 169 insertions(+), 65 deletions(-)

-- 
2.19.1

