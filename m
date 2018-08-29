Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7824C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3D62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeH2Qt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:49:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:52170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeH2Qt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:49:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 05:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68763153"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 05:51:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fuzwJ-00029k-UI; Wed, 29 Aug 2018 20:51:15 +0800
Date:   Wed, 29 Aug 2018 20:50:52 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@01.org, tglx@linutronix.de, y2038@lists.linaro.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        deepa.kernel@gmail.com, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH] y2038: __get_old_timespec32() can be static
Message-ID: <20180829125052.GA114325@lkp-g5>
References: <20180827194531.3796559-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827194531.3796559-4-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: ee16c8f415e4 ("y2038: Globally rename compat_time to old_time32")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index f1983f4..e3a7f7f 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -863,7 +863,7 @@ int put_timespec64(const struct timespec64 *ts,
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
 
-int __get_old_timespec32(struct timespec64 *ts64,
+static int __get_old_timespec32(struct timespec64 *ts64,
 				   const struct old_timespec32 __user *cts)
 {
 	struct old_timespec32 ts;
@@ -879,7 +879,7 @@ int __get_old_timespec32(struct timespec64 *ts64,
 	return 0;
 }
 
-int __put_old_timespec32(const struct timespec64 *ts64,
+static int __put_old_timespec32(const struct timespec64 *ts64,
 				   struct old_timespec32 __user *cts)
 {
 	struct old_timespec32 ts = {
