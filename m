Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9939D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeGZLPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:15:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:11408 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbeGZLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:15:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 02:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="59628395"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 26 Jul 2018 02:59:24 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 26 Jul 2018 12:59:25 +0300
Date:   Thu, 26 Jul 2018 12:59:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 hibernation
Message-ID: <20180726095925.GU2534@lahna.fi.intel.com>
References: <1645662.bYMTJFObNO@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645662.bYMTJFObNO@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:58:20AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and
> resume from S3) modified the ACPI driver for Intel SoCs (LPSS) to
> avoid applying PM quirks on suspend and resume from S3 to address
> system-wide suspend and resume problems on some systems, but it is
> reported that the same issue also affects hibernation, so extend
> the approach used by that commit to cover hibernation as well.
> 
> Fixes: a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and resume from S3)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
