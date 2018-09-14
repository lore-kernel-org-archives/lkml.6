Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A5C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925C320861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925C320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeINNF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:05:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:45570 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbeINNF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:05:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 00:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="70782153"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 14 Sep 2018 00:52:11 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Sep 2018 10:52:11 +0300
Date:   Fri, 14 Sep 2018 10:52:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] thunderbolt: Do not handle ICM events after domain
 is stopped
Message-ID: <20180914075211.GP14465@lahna.fi.intel.com>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:20:11PM +0300, Mika Westerberg wrote:
> If there is a long chain of devices connected when the driver is loaded
> ICM sends device connected event for each and those are put to tb->wq
> for later processing. Now if the driver gets unloaded in the middle, so
> that the work queue is not yet empty it gets flushed by tb_domain_stop().
> However, by that time the root switch is already removed so the driver
> crashes when it tries to dereference it in ICM event handling callbacks.
> 
> Fix this by checking whether the root switch is already removed. If it
> is we know that the domain is stopped and we should merely skip handling
> the event.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to thunderbolt.git/fixes.
