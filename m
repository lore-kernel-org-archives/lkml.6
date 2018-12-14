Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED22FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BC9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeLNPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:54:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:15172 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeLNPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:54:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 07:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,353,1539673200"; 
   d="scan'208";a="283601999"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2018 07:54:11 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/3] stm class/intel_th: Fixes for v4.20
Date:   Fri, 14 Dec 2018 17:53:44 +0200
Message-Id: <20181214155347.75722-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I have 3 fixes for STM Class and Intel TH. Two things that I introduced in
v4.20-rc1 and one long-standing bug since v4.4. As usual, there is a signed
tag ready for pulling and individual patches follow. Please consider pulling
or applying. Thanks!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20181214

for you to fetch changes up to ac83e602f95cd472062ea7d813086722fb59c496:

  intel_th: msu: Fix an off-by-one in attribute store (2018-12-14 17:39:33 +0200)

----------------------------------------------------------------
stm class/intel_th: Fixes for v4.20

These are:
 * module refcount leak in stm class, introduced in v4.20-rc1
 * documentation fix
 * string parsing off-by-one in intel_th, also for -stable

----------------------------------------------------------------
Alexander Shishkin (3):
      stm class: Fix a module refcount leak in policy creation error path
      stm class: Add a reference to the SyS-T document
      intel_th: msu: Fix an off-by-one in attribute store

 Documentation/trace/index.rst    |  1 +
 drivers/hwtracing/intel_th/msu.c |  3 ++-
 drivers/hwtracing/stm/policy.c   | 12 +++++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.19.2

