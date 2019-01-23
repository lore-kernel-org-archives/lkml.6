Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FBC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0C2217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfAWCpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:45:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:20539 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfAWCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:45:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 18:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,509,1539673200"; 
   d="scan'208";a="136905109"
Received: from szhan10-mobl3.ccr.corp.intel.com ([10.249.172.83])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2019 18:45:22 -0800
Message-ID: <1548211521.4006.10.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.0-rc4
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Date:   Wed, 23 Jan 2019 10:45:21 +0800
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
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal management updates for v5.0-rc4 with
top-most commit 129699bb8c7572106b5bbb2407c2daee4727ccad:

  drivers: thermal: int340x_thermal: Fix sysfs race condition (2019-01-
18 15:23:04 +0800)

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

Specifics:

- Fix a race condition that sysfs could be accessed before necessary
initialization in int340x thermal driver. (Aaron Hill)

- Fix a NULL vs IS_ERR() check in int340x thermal driver. (Dan
Carpenter)

thanks,
rui

----------------------------------------------------------------
Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Dan Carpenter (1):
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check

 .../int340x_thermal/processor_thermal_device.c     | 30 ++++++++++++
----------
 1 file changed, 16 insertions(+), 14 deletions(-)
