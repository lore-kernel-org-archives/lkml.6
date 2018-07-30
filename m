Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEDFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CAA20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CAA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeG3I6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:58:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:25957 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeG3I6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:58:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 00:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="249487003"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2018 00:24:46 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 8637320790; Mon, 30 Jul 2018 10:24:45 +0300 (EEST)
Date:   Mon, 30 Jul 2018 10:24:45 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: linux-next: build warning after merge of the pm tree
Message-ID: <20180730072445.kt2yxxifx4i7y3fr@paasikivi.fi.intel.com>
References: <20180730120053.62732d27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730120053.62732d27@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Mon, Jul 30, 2018 at 12:00:53PM +1000, Stephen Rothwell wrote:
> Hi Rafael,
> 
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/media/i2c/mt9v111.c: In function 'mt9v111_set_format':
> drivers/media/i2c/mt9v111.c:887:15: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   unsigned int idx;
>                ^~~
> 
> Introduced by commit
> 
>   aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
> 
> Looks like a false positive, but not something that gcc can easily see.

This must be coming from a new driver merged to media tree recently. Thanks
for reporting this.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
