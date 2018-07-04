Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E63C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF120844
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDF120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeGDEid (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:38:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:18552 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932582AbeGDEhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:37:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 21:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="68502094"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 03 Jul 2018 21:37:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 04 Jul 2018 07:37:08 +0300
Date:   Wed, 4 Jul 2018 07:37:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 0/5] thunderbolt: Add support for runtime PM
Message-ID: <20180704043708.GX2534@lahna.fi.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:07:26PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> In recent PCs such as Lenovo X1 Carbon 6th generation the Thunderbolt
> controller is in RTD3 mode (Runtime D3). This is different from the
> previous modes because now the controller is present most of the time (it
> still will be hot-removed/hot-added during NVM firmware upgrade). Because
> of that we need to dynamically power it down whenever possible to save some
> power.
> 
> This patch series adds Linux runtime PM support for the Thunderbolt host
> controller driver using ICM firmware but it should be generic enough for
> future additions to allow similar functionality for the older Apple
> hardware as well (even though those system do not support full RTD3, it
> still makes it possible for the host controller to go to low power state if
> cable is not connected).
> 
> With these patches the driver automatically runtime suspends the host
> controller after being idle for 15s. The connected Thunderbolt devices (if
> any) need to support RTD3 mode as well. Typically all 3rd generation
> devices (Alpine Ridge, Titan Ridge) support this.
> 
> However, while this provides some power savings, there is more work to do
> in order to allow powering down the PCIe root port leading to the
> Thunderbolt PCIe hierarchy. This work is still in progress.
> 
> Mika Westerberg (5):
>   thunderbolt: Use 64-bit DMA mask if supported by the platform
>   thunderbolt: Do not unnecessarily call ICM get route
>   thunderbolt: No need to take tb->lock in domain suspend/complete
>   thunderbolt: Use correct ICM commands in system suspend
>   thunderbolt: Add support for runtime PM

All applied to thunderbolt.git/next.
