Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE31C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3120658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJVQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:15:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:31935 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeJVQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:15:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 00:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="101308790"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 22 Oct 2018 00:58:01 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 10:58:00 +0300
Date:   Mon, 22 Oct 2018 10:58:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
Message-ID: <20181022075800.GJ2302@lahna.fi.intel.com>
References: <1539784829-1159-1-git-send-email-wang6495@umn.edu>
 <20181018091319.GT2302@lahna.fi.intel.com>
 <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 04:25:01PM -0500, Wenwen Wang wrote:
> Hi Mika,

Hi,

> Thanks for your response. The current version of the code assumes that
> the Thunderbolt controller behaves as expected, e.g., the host
> controller should not touch the data after it is marked ready.
> However, it is not impossible that the controller is exploited by an
> attacker through a security vulnerability, even though it is soldered
> on the motherboard. In that case, the controller may behave in an
> unexpected way and this bug will offer more opportunities for the
> attacker.

That would require the attacker to dissassemble the laptop case or
similar in case of desktop system. That's already something we cannot
protect against.

Furthermore this would apply to all DMA capable devices such as the xHCI
controller typically part of the Thunderbolt host router or every single
network card but I have not seen fixes like this on network side
(probably because there is really no need).

If the attacker could somehow say, replace the firmware on the
Thunderbolt host router then I suppose they could just go and overwrite
the extra protection you did in this patch (or probably do something
worse since they can access all the system memory).

So all in all I don't think this is something we would need to deal
with.

Situation is totally different if you manage to connecte external
devices that can do DMA (which is pretty much what Thunderbolt for
example allows) but for those we already have security of some sort
implemented.

Thanks!
