Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D9C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0B02081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0B02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJaKUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:20:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:54379 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbeJaKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:20:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 18:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="82852405"
Received: from lifengji-mobl.ccr.corp.intel.com ([10.255.29.174])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2018 18:24:44 -0700
Message-ID: <1540949083.2254.62.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.20-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Oct 2018 09:24:43 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal management updates for v4.20-rc1 with
top-most commit c2b59d279dbbac750958f6a1bc4841e431d934e3:

  thermal: core: using power_efficient_wq for thermal worker (2018-10-
10 21:48:50 +0800)

on top of commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

Specifics:
- Fix a use-after-free issue when unregistering a thermal cooling
device.(Dmitry Osipenko)

- use power_efficient_wq for thermal worker to save more power. (Jeson
Gao)

thanks,
rui

----------------------------------------------------------------
Dmitry Osipenko (1):
      thermal: core: Fix use-after-free in
thermal_cooling_device_destroy_sysfs

Jeson Gao (1):
      thermal: core: using power_efficient_wq for thermal worker

 drivers/thermal/thermal_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
