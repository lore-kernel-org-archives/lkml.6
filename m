Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86AFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9538C2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeLQQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:50:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:28160 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeLQQu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:50:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 08:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="110136637"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 17 Dec 2018 08:50:26 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Dec 2018 18:50:25 +0200
Date:   Mon, 17 Dec 2018 18:50:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFT][PATCH 0/2] ACPI / PM: Avoid spurious wakeups from
 non-wakeup GPEs in suspend-to-idle
Message-ID: <20181217165025.GA2469@lahna.fi.intel.com>
References: <4307523.O7RPX2KSmk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:19:27PM +0100, Rafael J. Wysocki wrote:
> Hi All,

Hi Rafael,

> It turns out that on some systems non-wakeup GPEs cause trouble (see the
> changelog of patch [1/2]), so they better should be disabled during
> suspend-to-idle (at least before entering the main loop of it).  This
> is done in patch [1/2].
> 
> Patch [2/2] is just a folllow-up.

I tested both patches on Lenovo Carbon X1 6th generation and one new
Dell system. Both default to s2idle. I did not see any issues around
s2idle with the two patches applied.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
