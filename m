Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D251C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B84208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B84208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeFNOqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:46:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:57718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755092AbeFNOqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 07:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="208088552"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2018 07:46:36 -0700
Message-ID: <ad0415db268750c033499e2b3bd079ca2c9f099d.camel@linux.intel.com>
Subject: bitmap namespace conflict
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shaohua Li <shli@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, arnd@arndb.de,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jun 2018 17:46:36 +0300
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There is a potential name space collision with bitmap API vs. MD bitmaps
(whatever it is).

Since I'm about to submit some extension to bitmap API, I would like as
a preparatory patch to rename all bitmap_* in drivers/md to md_bitmap_*
to avoid real conflict with my patch series [1], i.e. bitmap_free().

Opinions?
Better proposals?

[1]: https://patchwork.kernel.org/patch/10442771/
Almost RFC version

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
