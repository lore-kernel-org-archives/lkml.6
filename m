Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C7B0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AE420020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AE420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935604AbeFMM6f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:58:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:33538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935364AbeFMM6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:58:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 05:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,218,1526367600"; 
   d="scan'208";a="62812700"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 13 Jun 2018 05:58:28 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 Jun 2018 15:58:27 +0300
Date:   Wed, 13 Jun 2018 15:58:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
Message-ID: <20180613125827.GZ2384@lahna.fi.intel.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
 <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
 <1568228.RgPNub1osy@aspire.rjw.lan>
 <6a387b8b67497fa4a656c252a010d6d4e72e7774.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a387b8b67497fa4a656c252a010d6d4e72e7774.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 03:53:07PM +0300, Andy Shevchenko wrote:
> On Wed, 2018-06-13 at 13:17 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> > runtime PM and system sleep handling) introduced a system suspend
> > regression on some machines, but the only functional change made by
> > it was to cause the PM quirks in the LPSS to also be used during
> > system suspend and resume.  While that should always work for
> > suspend-to-idle, it turns out to be problematic for S3
> > (suspend-to-RAM).
> > 
> > To address that issue restore the previous S3 suspend and resume
> > behavior of the LPSS to avoid applying PM quirks then.
> > 
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Also,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
