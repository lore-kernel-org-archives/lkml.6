Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C54ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5A20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeGWS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:27:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:57265 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbeGWS1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:27:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 10:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="77142371"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2018 10:24:59 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 0769920A00; Mon, 23 Jul 2018 20:24:59 +0300 (EEST)
Date:   Mon, 23 Jul 2018 20:24:58 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/17] media: v4l2: async: Remove notifier subdevs
 array
Message-ID: <20180723172458.iejfac4pamev25sw@paasikivi.fi.intel.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
 <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
 <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:44:57AM -0700, Steve Longerbeam wrote:
> 
> 
> On 07/23/2018 05:35 AM, Sakari Ailus wrote:
> > Hi Steve,
> > 
> > Thanks for the update.
> > 
> > On Mon, Jul 09, 2018 at 03:39:16PM -0700, Steve Longerbeam wrote:
> > > All platform drivers have been converted to use
> > > v4l2_async_notifier_add_subdev(), in place of adding
> > > asd's to the notifier subdevs array. So the subdevs
> > > array can now be removed from struct v4l2_async_notifier,
> > > and remove the backward compatibility support for that
> > > array in v4l2-async.c.
> > > 
> > > Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> > This set removes the subdevs and num_subdevs fieldsfrom the notifier (as
> > discussed previously) but it doesn't include the corresponding
> > driver changes. Is there a patch missing from the set?
> 
> Hi Sakari, yes somehow patch 15/17 (the large patch to all drivers)
> got dropped by the ML, maybe because the cc-list was too big?
> 
> I will resend with only linux-media and cc: you.

I noticed the patch in my inbox and I re-pushed my v4l2-fwnode branch,
including that patch. Please still resend to the list. Thanks.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
