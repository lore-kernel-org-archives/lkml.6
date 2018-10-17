Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063F3214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063F3214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJQLHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:07:16 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:47546
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeJQLHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:07:15 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcGJgcMmgwkZtCcGJgMpVN; Tue, 16 Oct 2018 20:12:44 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcGJ-0000BV-IT; Tue, 16 Oct 2018 20:12:43 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/5] Drivers: hv: Miscellaneous fixes 
Date:   Wed, 17 Oct 2018 03:12:41 +0000
Message-Id: <20181017031241.669-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfG+dFiewjG+HkcyZI8e068gzGiwykLEjVZQ50VtAB9E2m4efU4BgMukdFKeErGh/DGly1ZoXXZpr/6ucMaFwZIGI8rLABRyjhkDpYy6xfDn6D4ATjOTb
 STj7hNdyyrsjyf2DJ/Eb1pjt/xRFLOadavqOhzIHy2DDe1H/3io/ny7Zrc6Pf/5+hN+l6Lu4c8RRlLO5XF7SdVtSuDi/QOVQWeME/WvDBVFlD8M5O1YNfPU8
 R0OCQlECgdr5zdaSu+bBtf7UimE1a8fl6Glj4K8Ni5JF6pgfJob9P9gbKOxvmoJqyRsz3H5KkxkBDF/Ho5FK6qiT5txKmOGcN0Q6zRZ/cnvo8KzR9G/qIWbA
 /iNzxQfJtnnp59uk5+0HNM0JCP99/yLrVQEDgV92gBMG6bp0H7U6ziQXSSN+waf/cgd06up7hJKCSt1u0HskhqS9Pxp6GDdZSeNfTuGfpwscP5BOmRbrdWPL
 o9fxXACZz8YkCydXuDbafdp9Xj/2tUngCruBfJeSG7tpvKtTqOY62B6mPirfNyRxWmBS45SdrxJxYYWf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.

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
 tools/hv/hv_kvp_daemon.c  |  2 +-
 5 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.18.0

